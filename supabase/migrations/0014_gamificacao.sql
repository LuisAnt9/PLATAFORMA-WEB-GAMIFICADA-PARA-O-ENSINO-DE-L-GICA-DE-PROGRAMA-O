-- E9: gamificação. O XP passa a ser calculado pelo banco (e não pelo navegador), com missões diárias,
-- bônus de conclusão de mundo, histórico de conquistas com data e ranking opcional restrito à turma.
-- Requer as migrations até a 0013.
--
-- Valores de XP (decisão D4): fácil 20, médio 35, difícil 50, desafio de lição 75 (exercício do
-- tipo "desafio"), conclusão de mundo 150, missão diária 30. Acertar de primeira soma 50% ao XP do exercício.
-- O XP já gravado NÃO é recalculado: os valores novos valem só para exercícios resolvidos depois desta migration.
-- O XP nunca libera conteúdo: a liberação das lições depende só do domínio (70% dos exercícios).

------------------------------------------------------------------------
-- 1. XP do exercício calculado no servidor
------------------------------------------------------------------------
alter table public.exercise_progress drop constraint if exists exercise_progress_xp_check;
alter table public.exercise_progress
  add constraint exercise_progress_xp_check check (xp between 0 and 200);

create function public.xp_base(p_difficulty text, p_kind text)
returns integer
language sql
immutable
set search_path = ''
as $$
  select case
    when p_kind = 'challenge' then 75
    when p_difficulty = 'dificil' then 50
    when p_difficulty = 'medio' then 35
    else 20
  end;
$$;

-- Ao resolver pela primeira vez, o banco define o XP e o instante da resolução, ignorando o que o
-- navegador enviou. Depois de resolvido, a linha fica travada (trigger lock_solved_progress, da 0001).
create function public.set_progress_xp()
returns trigger
language plpgsql
set search_path = ''
as $$
declare
  ex record;
  base integer;
begin
  if tg_op = 'UPDATE' and old.solved then
    return new; -- já resolvido: nada muda (XP repetido nunca é concedido)
  end if;
  if new.solved then
    select e.difficulty, e.kind into ex from public.exercises e where e.id = new.exercise_id;
    base := public.xp_base(ex.difficulty, ex.kind);
    new.xp := case when new.attempts <= 1 then round(base * 1.5)::integer else base end;
    new.solved_at := now();
  else
    new.xp := 0;
    new.solved_at := null;
  end if;
  return new;
end;
$$;

create trigger set_progress_xp
  before insert or update on public.exercise_progress
  for each row execute function public.set_progress_xp();

------------------------------------------------------------------------
-- 2. Missões diárias e bônus de mundo
------------------------------------------------------------------------
-- Dia de referência: horário de Fortaleza (o fuso do campus), calculado no servidor.
create function public.today_br()
returns date
language sql
stable
set search_path = ''
as $$ select (now() at time zone 'America/Fortaleza')::date; $$;

create table public.missions (
  id          text primary key check (id ~ '^[a-z0-9-]{1,60}$'),
  title       text not null,
  description text not null,
  kind        text not null check (kind in ('resolver', 'conceito_com_erro')),
  target      integer not null check (target > 0),
  xp          integer not null check (xp > 0),
  position    integer not null default 0
);

alter table public.missions enable row level security;
create policy "missões: todos leem" on public.missions for select to authenticated using (true);
grant select on public.missions to authenticated;

insert into public.missions (id, title, description, kind, target, xp, position) values
  ('resolver-2', 'Resolva 2 exercícios', 'Resolva 2 exercícios hoje.', 'resolver', 2, 30, 1),
  ('conceito-com-dificuldade', 'Volte a um conceito difícil',
   'Resolva hoje um exercício de um conceito em que você já errou antes.', 'conceito_com_erro', 1, 30, 2);

-- Cada missão concede XP no máximo uma vez por dia (a chave primária impede a repetição).
create table public.mission_claims (
  user_id    uuid not null references public.profiles (id) on delete cascade,
  mission_id text not null references public.missions (id),
  day        date not null,
  xp         integer not null check (xp > 0),
  claimed_at timestamptz not null default now(),
  primary key (user_id, mission_id, day)
);

alter table public.mission_claims enable row level security;
create policy "missões concluídas: o próprio" on public.mission_claims
  for select to authenticated using (user_id = (select auth.uid()));
grant select on public.mission_claims to authenticated;

-- Bônus único por mundo concluído.
create table public.world_bonuses (
  user_id    uuid not null references public.profiles (id) on delete cascade,
  world_id   text not null references public.worlds (id) on delete cascade,
  xp         integer not null check (xp > 0),
  claimed_at timestamptz not null default now(),
  primary key (user_id, world_id)
);

alter table public.world_bonuses enable row level security;
create policy "bônus de mundo: o próprio" on public.world_bonuses
  for select to authenticated using (user_id = (select auth.uid()));
grant select on public.world_bonuses to authenticated;

-- Histórico de conquistas, com data. O navegador avisa o que o aluno conquistou (medalhas não dão XP).
create table public.user_badges (
  user_id   uuid not null references public.profiles (id) on delete cascade,
  badge_id  text not null check (char_length(badge_id) between 1 and 80),
  earned_at timestamptz not null default now(),
  primary key (user_id, badge_id)
);

alter table public.user_badges enable row level security;
create policy "conquistas: ler as próprias" on public.user_badges
  for select to authenticated using (user_id = (select auth.uid()));
create policy "conquistas: registrar as próprias" on public.user_badges
  for insert to authenticated with check (user_id = (select auth.uid()));
grant select, insert on public.user_badges to authenticated;

-- Conclusão de mundo: todas as lições obrigatórias (não complementares) com pelo menos 70% dos
-- exercícios publicados resolvidos (a mesma regra de liberação das lições).
create function public.world_completed(p_user uuid, p_world text)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  with lessons as (
    select m.id,
           count(e.id)::integer as total,
           count(e.id) filter (where ep.solved)::integer as done
    from public.modules m
    join public.exercises e on e.module_id = m.id and e.published
    left join public.exercise_progress ep on ep.exercise_id = e.id and ep.user_id = p_user
    where m.world_id = p_world and not m.optional
    group by m.id
  )
  select exists (select 1 from lessons)
     and not exists (select 1 from lessons where done < ceil(total * 0.7));
$$;
revoke execute on function public.world_completed(uuid, text) from public, anon, authenticated;

-- Confere as missões e os mundos do aluno logado, concede o XP que for devido (uma vez) e devolve
-- o estado completo. Chamada depois de cada exercício resolvido e ao abrir o site.
create function public.sync_gamification()
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := (select auth.uid());
  today date := public.today_br();
  start_ts timestamptz;
  m record;
  w record;
  prog integer;
  missions jsonb := '[]'::jsonb;
  new_worlds jsonb := '[]'::jsonb;
  bonus integer;
begin
  if me is null then
    raise exception 'Não autenticado.';
  end if;
  start_ts := today::timestamp at time zone 'America/Fortaleza';

  -- bônus de mundo (150 XP, uma vez)
  for w in select id from public.worlds loop
    if public.world_completed(me, w.id) then
      insert into public.world_bonuses (user_id, world_id, xp) values (me, w.id, 150)
      on conflict do nothing;
      if found then new_worlds := new_worlds || to_jsonb(w.id); end if;
    end if;
  end loop;

  -- missões do dia
  for m in select * from public.missions order by position loop
    if m.kind = 'resolver' then
      select count(*)::integer into prog
      from public.exercise_progress ep
      where ep.user_id = me and ep.solved and ep.solved_at >= start_ts and ep.solved_at < start_ts + interval '1 day';
    else
      select count(*)::integer into prog
      from public.exercise_progress ep
      where ep.user_id = me and ep.solved and ep.solved_at >= start_ts and ep.solved_at < start_ts + interval '1 day'
        and exists (
          select 1
          from public.exercise_concepts c1
          join public.exercise_concepts c2 on c2.concept_id = c1.concept_id and c2.exercise_id <> c1.exercise_id
          join public.attempts a on a.exercise_id = c2.exercise_id
          where c1.exercise_id = ep.exercise_id and a.user_id = me and not a.passed and a.created_at < ep.solved_at
        );
    end if;
    if prog >= m.target then
      insert into public.mission_claims (user_id, mission_id, day, xp) values (me, m.id, today, m.xp)
      on conflict do nothing;
    end if;
    missions := missions || jsonb_build_object(
      'id', m.id, 'title', m.title, 'description', m.description, 'target', m.target, 'xp', m.xp,
      'progress', least(prog, m.target),
      'claimed', exists (select 1 from public.mission_claims x where x.user_id = me and x.mission_id = m.id and x.day = today)
    );
  end loop;

  select coalesce((select sum(xp) from public.mission_claims where user_id = me), 0)
       + coalesce((select sum(xp) from public.world_bonuses where user_id = me), 0)
    into bonus;

  return jsonb_build_object(
    'bonus_xp', bonus,
    'missions', missions,
    'new_worlds', new_worlds,
    'worlds_done', coalesce((select jsonb_agg(world_id) from public.world_bonuses where user_id = me), '[]'::jsonb)
  );
end;
$$;
revoke execute on function public.sync_gamification() from public, anon;
grant execute on function public.sync_gamification() to authenticated;

------------------------------------------------------------------------
-- 3. Ranking opcional, só da própria turma
------------------------------------------------------------------------
alter table public.profiles add column show_in_ranking boolean not null default false;
grant update (name, show_in_ranking) on public.profiles to authenticated;

-- Quem aparece: alunos que escolheram aparecer e que estão em alguma turma do solicitante
-- (como aluno ou como professor). O XP inclui os bônus de missão e de mundo.
create or replace function public.leaderboard(lim integer default 20)
returns table (pos bigint, display_name text, total_xp bigint, solved bigint, is_me boolean)
language sql
stable
security definer
set search_path = ''
as $$
  with my_classes as (
    select cm.class_id from public.class_members cm where cm.student_id = (select auth.uid())
    union
    select c.id from public.classes c where c.teacher_id = (select auth.uid())
  ),
  visible as (
    select distinct cm.student_id as id
    from public.class_members cm
    join my_classes mc on mc.class_id = cm.class_id
  ),
  scores as (
    select
      p.id,
      case
        when position(' ' in trim(p.name)) > 0 then
          split_part(trim(p.name), ' ', 1) || ' ' ||
          upper(left((regexp_split_to_array(trim(p.name), '\s+'))[array_length(regexp_split_to_array(trim(p.name), '\s+'), 1)], 1)) || '.'
        else trim(p.name)
      end as display_name,
      (coalesce((select sum(ep.xp) from public.exercise_progress ep where ep.user_id = p.id and ep.solved), 0)
       + coalesce((select sum(mc.xp) from public.mission_claims mc where mc.user_id = p.id), 0)
       + coalesce((select sum(wb.xp) from public.world_bonuses wb where wb.user_id = p.id), 0))::bigint as total_xp,
      (select count(*) from public.exercise_progress ep where ep.user_id = p.id and ep.solved)::bigint as solved
    from public.profiles p
    join visible v on v.id = p.id
    where p.role = 'aluno' and p.show_in_ranking
  ),
  ranked as (
    select s.*, rank() over (order by s.total_xp desc) as pos from scores s
  )
  select r.pos, r.display_name, r.total_xp, r.solved, (r.id = (select auth.uid())) as is_me
  from ranked r
  where r.pos <= greatest(least(lim, 100), 1) or r.id = (select auth.uid())
  order by r.pos, r.display_name;
$$;
revoke all on function public.leaderboard(integer) from public, anon;
grant execute on function public.leaderboard(integer) to authenticated;
