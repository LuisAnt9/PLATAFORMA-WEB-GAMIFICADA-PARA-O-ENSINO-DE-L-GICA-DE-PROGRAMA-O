-- GERADO por "npm run db:bundle" a partir de supabase/migrations. Não edite à mão.
-- Para um projeto que JÁ tem o banco até a migration 0009. Rode supabase/diagnostico.sql antes para conferir.
-- Roda tudo numa única transação: se algo falhar, nada é aplicado e você pode corrigir e tentar de novo.

-- ============================================================
-- 0010_fundacao_pedagogica.sql
-- ============================================================

-- Fundação pedagógica (etapa E1): hierarquia Mundo > Lição, conceitos e registro de cada tentativa.
-- Execute depois de 0009. O site funciona sem esta migration (apenas não registra tentativas).
--
-- Observação: a tabela `modules` continua existindo e representa a "lição" na interface.

------------------------------------------------------------------------
-- Mundos e campos novos da lição
------------------------------------------------------------------------
create table public.worlds (
  id        text primary key check (id ~ '^[a-z0-9-]{1,60}$'),
  title     text not null check (char_length(title) between 1 and 100),
  objective text not null default '' check (char_length(objective) <= 500),
  position  integer not null default 0
);

alter table public.worlds enable row level security;
create policy "mundos: todos leem" on public.worlds for select to authenticated using (true);
create policy "mundos: professor cria" on public.worlds for insert to authenticated with check (public.is_professor());
create policy "mundos: professor edita" on public.worlds for update to authenticated
  using (public.is_professor()) with check (public.is_professor());
grant select, insert, update on public.worlds to authenticated;

alter table public.modules
  add column world_id text references public.worlds (id),
  add column example  text not null default '' check (char_length(example) <= 3000),
  add column review   text not null default '' check (char_length(review) <= 1500);

-- Mundo provisório: agrupa as lições que já existem até o currículo oficial chegar.
insert into public.worlds (id, title, objective, position)
values ('trilha-atual', 'Trilha atual', 'Lições criadas antes da divisão em mundos.', 0);
update public.modules set world_id = 'trilha-atual';

------------------------------------------------------------------------
-- Conceitos avaliados por cada exercício
------------------------------------------------------------------------
create table public.concepts (
  id          text primary key check (id ~ '^[a-z0-9-]{1,60}$'),
  title       text not null check (char_length(title) between 1 and 100),
  description text not null default '' check (char_length(description) <= 500),
  world_id    text references public.worlds (id),
  position    integer not null default 0
);

create table public.exercise_concepts (
  exercise_id text not null references public.exercises (id) on delete cascade,
  concept_id  text not null references public.concepts (id) on delete cascade,
  weight      smallint not null default 1 check (weight between 1 and 5),
  primary key (exercise_id, concept_id)
);

create index exercise_concepts_concept_idx on public.exercise_concepts (concept_id);

alter table public.concepts enable row level security;
alter table public.exercise_concepts enable row level security;

create policy "conceitos: todos leem" on public.concepts for select to authenticated using (true);
create policy "conceitos: professor cria" on public.concepts for insert to authenticated with check (public.is_professor());
create policy "conceitos: professor edita" on public.concepts for update to authenticated
  using (public.is_professor()) with check (public.is_professor());

-- A ligação segue a visibilidade do exercício (rascunhos não aparecem para alunos).
create policy "ligações: quem vê o exercício" on public.exercise_concepts for select to authenticated
  using (exists (select 1 from public.exercises e where e.id = exercise_id));
create policy "ligações: professor cria" on public.exercise_concepts for insert to authenticated with check (public.is_professor());
create policy "ligações: professor edita" on public.exercise_concepts for update to authenticated
  using (public.is_professor()) with check (public.is_professor());
create policy "ligações: professor remove" on public.exercise_concepts for delete to authenticated using (public.is_professor());

grant select, insert, update on public.concepts to authenticated;
grant select, insert, update, delete on public.exercise_concepts to authenticated;

------------------------------------------------------------------------
-- Tentativas: uma linha por envio, só inserção (sem UPDATE/DELETE)
------------------------------------------------------------------------
create table public.attempts (
  id             bigint generated always as identity primary key,
  user_id        uuid not null references public.profiles (id) on delete cascade,
  exercise_id    text not null references public.exercises (id) on delete cascade,
  created_at     timestamptz not null default now(),
  kind           text not null check (kind ~ '^[a-z_]{1,30}$'),
  passed         boolean not null,
  answer         text check (answer is null or char_length(answer) <= 4000),
  tests_passed   integer check (tests_passed is null or tests_passed >= 0),
  tests_total    integer check (tests_total is null or tests_total >= 0),
  error_category text check (error_category in
    ('sintaxe', 'execucao', 'tempo', 'saida_incorreta', 'escolha_incorreta', 'lacuna_incorreta')),
  misconception  text check (misconception is null or char_length(misconception) <= 200),
  duration_ms    integer check (duration_ms is null or duration_ms between 0 and 3600000),
  mode           text not null default 'livre' check (mode in ('livre', 'atividade', 'avaliacao')),
  assignment_id  bigint,
  check (not passed or error_category is null),
  check (tests_passed is null or tests_total is null or tests_passed <= tests_total)
);

create index attempts_user_exercise_idx on public.attempts (user_id, exercise_id, created_at);
create index attempts_exercise_idx on public.attempts (exercise_id, created_at);
create index attempts_created_idx on public.attempts (created_at);

alter table public.attempts enable row level security;

-- O aluno lê as próprias tentativas; o professor, as dos alunos das suas turmas.
create policy "tentativas: o próprio ou aluno de uma turma sua" on public.attempts
  for select to authenticated
  using (user_id = (select auth.uid()) or public.is_teacher_of_student(user_id));

-- Sem INSERT/UPDATE/DELETE direto: a escrita acontece só por record_attempt.
grant select on public.attempts to authenticated;

-- Registra uma tentativa do próprio aluno. Valida tudo no servidor:
--  * o tipo do exercício vem do banco (não do navegador);
--  * em múltipla escolha, o acerto e a "confusão" da alternativa são calculados aqui, a partir da
--    alternativa marcada (p_selected), e não confiados ao navegador;
--  * limite de 60 tentativas por minuto, para não encher o banco do plano gratuito.
create function public.record_attempt(
  p_exercise       text,
  p_passed         boolean,
  p_answer         text    default null,
  p_selected       integer default null,
  p_tests_passed   integer default null,
  p_tests_total    integer default null,
  p_error_category text    default null,
  p_duration_ms    integer default null,
  p_mode           text    default 'livre',
  p_assignment_id  bigint  default null
)
returns bigint
language plpgsql
security definer
set search_path = ''
as $$
declare
  uid        uuid := (select auth.uid());
  ex         record;
  opt        jsonb;
  passed     boolean := p_passed;
  category   text := p_error_category;
  miscon     text := null;
  new_id     bigint;
begin
  if uid is null then
    raise exception 'Não autenticado.';
  end if;
  if p_mode is null or p_mode not in ('livre', 'atividade', 'avaliacao') then
    raise exception 'Modalidade inválida.';
  end if;

  select e.kind, e.config, e.published into ex from public.exercises e where e.id = p_exercise;
  if not found or (not ex.published and not public.is_professor()) then
    raise exception 'Exercício não encontrado.';
  end if;

  if (select count(*) from public.attempts a
        where a.user_id = uid and a.created_at > now() - interval '1 minute') >= 60 then
    raise exception 'MUITAS_TENTATIVAS';
  end if;

  if ex.kind = 'choice' then
    if p_selected is null or p_selected < 0 or p_selected >= jsonb_array_length(ex.config -> 'options') then
      raise exception 'Alternativa inválida.';
    end if;
    passed := p_selected = (ex.config ->> 'correct')::integer;
    opt := ex.config -> 'options' -> p_selected;
    if not passed and jsonb_typeof(opt) = 'object' then
      miscon := left(opt ->> 'misconception', 200);
    end if;
    category := case when passed then null else 'escolha_incorreta' end;
  elsif ex.kind = 'blank' then
    category := case when passed then null else 'lacuna_incorreta' end;
  else
    if passed then
      category := null;
    elsif category is null then
      category := 'saida_incorreta';
    end if;
  end if;

  insert into public.attempts
    (user_id, exercise_id, kind, passed, answer, tests_passed, tests_total,
     error_category, misconception, duration_ms, mode, assignment_id)
  values
    (uid, p_exercise, ex.kind, passed, left(p_answer, 4000), p_tests_passed, p_tests_total,
     category, miscon, p_duration_ms, p_mode, p_assignment_id)
  returning id into new_id;
  return new_id;
end;
$$;

revoke execute on function public.record_attempt(text, boolean, text, integer, integer, integer, text, integer, text, bigint) from public, anon;
grant execute on function public.record_attempt(text, boolean, text, integer, integer, integer, text, integer, text, bigint) to authenticated;

-- ============================================================
-- 0011_origem_do_conteudo.sql
-- ============================================================

-- Origem do conteúdo (etapa E2): distingue o que veio dos arquivos em `content/` do que o professor
-- criou ou editou no painel, para o importador nunca sobrescrever edições feitas à mão.
-- Execute depois de 0010. O site funciona sem esta migration.

alter table public.exercises
  add column origem text not null default 'painel' check (origem in ('painel', 'arquivo'));
alter table public.modules
  add column origem text not null default 'painel' check (origem in ('painel', 'arquivo'));

-- Exercícios criados pelas migrations (sem autor) e as 7 lições de exemplo vêm dos arquivos.
update public.exercises set origem = 'arquivo' where created_by is null;
update public.modules set origem = 'arquivo'
  where id in ('primeiros-passos', 'fundamentos', 'condicionais', 'repeticao', 'vetores', 'funcoes', 'textos');

-- Quando o professor altera o conteúdo pelo painel (papel "authenticated"), a linha passa a ser
-- dele: o importador não mexe mais nela. Publicar, despublicar e reordenar NÃO contam como edição.
-- O SQL Editor e as migrations rodam como outro papel e, por isso, não disparam isso.
create function public.mark_panel_edit()
returns trigger
language plpgsql
as $$
declare
  ignored text[] := array['origem', 'published', 'position', 'updated_at', 'created_at', 'created_by'];
begin
  if current_user in ('authenticated', 'anon')
     and old.origem = 'arquivo'
     and new.origem = 'arquivo'
     and (to_jsonb(new) - ignored) is distinct from (to_jsonb(old) - ignored) then
    new.origem := 'painel';
  end if;
  return new;
end;
$$;

create trigger exercises_mark_panel_edit before update on public.exercises
  for each row execute function public.mark_panel_edit();
create trigger modules_mark_panel_edit before update on public.modules
  for each row execute function public.mark_panel_edit();

-- ============================================================
-- 0012_tipos_de_exercicio.sql
-- ============================================================

-- Novos tipos de exercício (etapa E3): interpretação de código, ordenação, corrigir erro e desafio,
-- dicas em níveis registradas nas tentativas e solução comentada liberada só depois de acertar.
-- Execute depois de 0011. O site funciona sem esta migration (só não mostra os tipos novos).
--
-- Observação: assim como nos outros tipos, as respostas de ordenação e interpretação ficam legíveis
-- no registro do exercício. As SOLUÇÕES de código ficam em tabela própria, sem leitura para alunos.

------------------------------------------------------------------------
-- Tipos de exercício
------------------------------------------------------------------------
alter table public.exercises drop constraint exercises_kind_check;
alter table public.exercises drop constraint exercises_kind_fields_check;
alter table public.exercises drop constraint exercises_config_check;

alter table public.exercises add constraint exercises_kind_check
  check (kind in ('code', 'choice', 'blank', 'interpretation', 'order', 'fix', 'challenge'));

-- Tipos com código (code, fix, challenge) têm função e testes; os demais não.
-- Atenção: um CHECK que resulta em NULL é aprovado pelo Postgres; por isso o coalesce(..., false).
alter table public.exercises add constraint exercises_kind_fields_check check (
  coalesce(case
    when kind in ('code', 'fix', 'challenge') then
      function_name is not null
      and function_name ~ '^[A-Za-z_$][A-Za-z0-9_$]{0,39}$'
      and jsonb_typeof(tests) = 'array'
      and jsonb_array_length(tests) between 1 and 30
    else
      function_name is null
      and jsonb_typeof(tests) = 'array'
      and jsonb_array_length(tests) = 0
  end, false)
);

alter table public.exercises add constraint exercises_config_check check (
  coalesce(case
    when kind in ('code', 'fix', 'challenge') then true
    when kind in ('choice', 'interpretation') then
      jsonb_typeof(config -> 'options') = 'array'
      and jsonb_array_length(config -> 'options') between 2 and 6
      and jsonb_typeof(config -> 'correct') = 'number'
      and (config ->> 'correct')::numeric >= 0
      and (config ->> 'correct')::numeric < jsonb_array_length(config -> 'options')
      and (kind = 'choice'
           or (jsonb_typeof(config -> 'code') = 'string'
               and char_length(config ->> 'code') between 1 and 2000))
    when kind = 'blank' then
      jsonb_typeof(config -> 'template') = 'string'
      and char_length(config ->> 'template') between 1 and 2000
      and jsonb_typeof(config -> 'blanks') = 'array'
      and jsonb_array_length(config -> 'blanks') between 1 and 10
    when kind = 'order' then
      jsonb_typeof(config -> 'items') = 'array'
      and jsonb_array_length(config -> 'items') between 2 and 10
  end, false)
);

------------------------------------------------------------------------
-- Tentativas: categoria da ordenação e nível de dica usado
------------------------------------------------------------------------
alter table public.attempts drop constraint attempts_error_category_check;
alter table public.attempts add constraint attempts_error_category_check check (error_category in
  ('sintaxe', 'execucao', 'tempo', 'saida_incorreta', 'escolha_incorreta', 'lacuna_incorreta', 'ordem_incorreta'));
alter table public.attempts add column hint_level smallint not null default 0
  check (hint_level between 0 and 3);

-- Nova versão de record_attempt (mais um parâmetro e os tipos novos).
drop function public.record_attempt(text, boolean, text, integer, integer, integer, text, integer, text, bigint);

-- Em múltipla escolha/interpretação e em ordenação, o acerto é calculado aqui (não confiado ao navegador).
create function public.record_attempt(
  p_exercise       text,
  p_passed         boolean,
  p_answer         text     default null,
  p_selected       integer  default null,
  p_tests_passed   integer  default null,
  p_tests_total    integer  default null,
  p_error_category text     default null,
  p_duration_ms    integer  default null,
  p_mode           text     default 'livre',
  p_assignment_id  bigint   default null,
  p_hint_level     integer  default 0
)
returns bigint
language plpgsql
security definer
set search_path = ''
as $$
declare
  uid        uuid := (select auth.uid());
  ex         record;
  opt        jsonb;
  given      jsonb;
  passed     boolean := p_passed;
  category   text := p_error_category;
  miscon     text := null;
  new_id     bigint;
begin
  if uid is null then
    raise exception 'Não autenticado.';
  end if;
  if p_mode is null or p_mode not in ('livre', 'atividade', 'avaliacao') then
    raise exception 'Modalidade inválida.';
  end if;
  if p_hint_level is null or p_hint_level < 0 or p_hint_level > 3 then
    raise exception 'Nível de dica inválido.';
  end if;

  select e.kind, e.config, e.published into ex from public.exercises e where e.id = p_exercise;
  if not found or (not ex.published and not public.is_professor()) then
    raise exception 'Exercício não encontrado.';
  end if;

  if (select count(*) from public.attempts a
        where a.user_id = uid and a.created_at > now() - interval '1 minute') >= 60 then
    raise exception 'MUITAS_TENTATIVAS';
  end if;

  if ex.kind in ('choice', 'interpretation') then
    if p_selected is null or p_selected < 0 or p_selected >= jsonb_array_length(ex.config -> 'options') then
      raise exception 'Alternativa inválida.';
    end if;
    passed := p_selected = (ex.config ->> 'correct')::integer;
    opt := ex.config -> 'options' -> p_selected;
    if not passed and jsonb_typeof(opt) = 'object' then
      miscon := left(opt ->> 'misconception', 200);
    end if;
    category := case when passed then null else 'escolha_incorreta' end;
  elsif ex.kind = 'order' then
    begin
      given := p_answer::jsonb;
    exception when others then
      raise exception 'Resposta inválida.';
    end;
    if given is null or jsonb_typeof(given) <> 'array' then
      raise exception 'Resposta inválida.';
    end if;
    passed := given = (ex.config -> 'items');
    category := case when passed then null else 'ordem_incorreta' end;
  elsif ex.kind = 'blank' then
    category := case when passed then null else 'lacuna_incorreta' end;
  else
    if passed then
      category := null;
    elsif category is null then
      category := 'saida_incorreta';
    end if;
  end if;

  insert into public.attempts
    (user_id, exercise_id, kind, passed, answer, tests_passed, tests_total,
     error_category, misconception, duration_ms, mode, assignment_id, hint_level)
  values
    (uid, p_exercise, ex.kind, passed, left(p_answer, 4000), p_tests_passed, p_tests_total,
     category, miscon, p_duration_ms, p_mode, p_assignment_id, p_hint_level)
  returning id into new_id;
  return new_id;
end;
$$;

revoke execute on function public.record_attempt(text, boolean, text, integer, integer, integer, text, integer, text, bigint, integer) from public, anon;
grant execute on function public.record_attempt(text, boolean, text, integer, integer, integer, text, integer, text, bigint, integer) to authenticated;

------------------------------------------------------------------------
-- Solução comentada: sem leitura direta; liberada por função depois de acertar
------------------------------------------------------------------------
create table public.exercise_solutions (
  exercise_id text primary key references public.exercises (id) on delete cascade,
  solution    text not null check (char_length(solution) between 1 and 4000),
  commentary  text not null default '' check (char_length(commentary) <= 2000)
);

alter table public.exercise_solutions enable row level security;

-- Só professores leem e escrevem a tabela; alunos recebem a solução apenas por get_solution.
create policy "soluções: professor lê" on public.exercise_solutions for select to authenticated using (public.is_professor());
create policy "soluções: professor cria" on public.exercise_solutions for insert to authenticated with check (public.is_professor());
create policy "soluções: professor edita" on public.exercise_solutions for update to authenticated
  using (public.is_professor()) with check (public.is_professor());
grant select, insert, update on public.exercise_solutions to authenticated;

-- Devolve a solução comentada se o usuário já acertou o exercício (ou é professor).
create function public.get_solution(p_exercise text)
returns table (solution text, commentary text)
language plpgsql
security definer
set search_path = ''
as $$
declare
  uid uuid := (select auth.uid());
begin
  if uid is null then
    raise exception 'Não autenticado.';
  end if;
  if not public.is_professor() and not exists (
    select 1 from public.attempts a
    where a.user_id = uid and a.exercise_id = p_exercise and a.passed
  ) then
    raise exception 'ACERTE_PRIMEIRO';
  end if;
  return query
    select s.solution, s.commentary from public.exercise_solutions s where s.exercise_id = p_exercise;
end;
$$;

revoke execute on function public.get_solution(text) from public, anon;
grant execute on function public.get_solution(text) to authenticated;

-- ============================================================
-- 0013_licao_complementar.sql
-- ============================================================

-- Lição complementar (etapa E7): conteúdo que enriquece, mas não trava a trilha.
-- No modo aprendizado, a lição seguinte libera sem esperar a conclusão de uma lição complementar.
-- Execute depois de 0012. O site funciona sem esta migration (nenhuma lição é complementar).

alter table public.modules
  add column optional boolean not null default false;

-- ============================================================
-- 0014_gamificacao.sql
-- ============================================================

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

-- ============================================================
-- 0015_atividades_e_avaliacoes.sql
-- ============================================================

-- E10: ambiente do professor. Atividades para casa, avaliações com nota corrigidas no banco e
-- acompanhamento das entregas. Requer as migrations até a 0014.
--
-- Três modalidades, sempre separadas nas tentativas (attempts.mode):
--   livre      — prática do aluno por conta própria;
--   atividade  — exercícios atribuídos pelo professor a uma turma (sem nota; prazo e situação);
--   avaliacao  — questões com nota, entregues uma única vez e corrigidas pelo banco, com o gabarito
--                guardado em uma tabela que o aluno não consegue ler.

------------------------------------------------------------------------
-- 1. Turmas arquivadas
------------------------------------------------------------------------
alter table public.classes add column archived boolean not null default false;
grant update (name, archived) on public.classes to authenticated;

------------------------------------------------------------------------
-- 2. Atividades e avaliações
------------------------------------------------------------------------
create table public.assignments (
  id             bigint generated always as identity primary key,
  class_id       uuid not null references public.classes (id) on delete cascade,
  teacher_id     uuid not null references public.profiles (id) on delete cascade,
  kind           text not null check (kind in ('atividade', 'avaliacao')),
  title          text not null check (char_length(title) between 2 and 120),
  instructions   text not null default '' check (char_length(instructions) <= 2000),
  available_from timestamptz not null default now(),
  due_at         timestamptz not null,
  required       boolean not null default true,
  -- Só para avaliação: o que o aluno vê depois de entregar.
  result_rule    text not null default 'so_nota'
                 check (result_rule in ('so_nota', 'nota_e_gabarito', 'gabarito_apos_prazo')),
  archived       boolean not null default false,
  created_at     timestamptz not null default now(),
  check (due_at > available_from)
);
create index assignments_class_idx on public.assignments (class_id, due_at);

-- Exercícios de uma atividade (para avaliação, a origem das questões copiadas abaixo).
create table public.assignment_items (
  assignment_id bigint not null references public.assignments (id) on delete cascade,
  exercise_id   text not null references public.exercises (id) on delete cascade,
  position      integer not null default 0,
  points        integer not null default 1 check (points between 1 and 100),
  primary key (assignment_id, exercise_id)
);

-- Questões de uma avaliação: cópia do exercício SEM a resposta (o aluno lê esta tabela).
create table public.assessment_questions (
  id                 bigint generated always as identity primary key,
  assignment_id      bigint not null references public.assignments (id) on delete cascade,
  source_exercise_id text not null references public.exercises (id) on delete cascade,
  position           integer not null,
  kind               text not null check (kind in ('choice', 'interpretation', 'blank', 'order')),
  title              text not null,
  statement          text not null,
  payload            jsonb not null,
  points             integer not null check (points between 1 and 100)
);
create index assessment_questions_assignment_idx on public.assessment_questions (assignment_id, position);

-- Gabarito: nenhuma política de leitura para alunos (RLS ligada e sem acesso). Só o professor da turma lê.
create table public.assessment_keys (
  question_id bigint primary key references public.assessment_questions (id) on delete cascade,
  answer      jsonb not null
);

create table public.assessment_submissions (
  id            bigint generated always as identity primary key,
  assignment_id bigint not null references public.assignments (id) on delete cascade,
  user_id       uuid not null references public.profiles (id) on delete cascade,
  submitted_at  timestamptz not null default now(),
  answers       jsonb not null,
  details       jsonb not null,
  score         integer not null,
  max_score     integer not null,
  unique (assignment_id, user_id) -- uma entrega só
);

alter table public.attempts
  add constraint attempts_assignment_fk foreign key (assignment_id)
  references public.assignments (id) on delete set null;

alter table public.assignments enable row level security;
alter table public.assignment_items enable row level security;
alter table public.assessment_questions enable row level security;
alter table public.assessment_keys enable row level security;
alter table public.assessment_submissions enable row level security;

-- Atividade visível: ao professor da turma; ao aluno da turma depois da data de disponibilização.
create policy "atividades: professor da turma ou aluno depois da liberação" on public.assignments
  for select to authenticated
  using (
    public.is_teacher_of_class(class_id)
    or (public.is_class_member(class_id) and available_from <= now() and not archived)
  );
create policy "atividades: professor apaga" on public.assignments
  for delete to authenticated using (public.is_teacher_of_class(class_id));
create policy "atividades: professor edita" on public.assignments
  for update to authenticated
  using (public.is_teacher_of_class(class_id)) with check (public.is_teacher_of_class(class_id));
grant select, delete on public.assignments to authenticated;
grant update (title, instructions, available_from, due_at, required, archived) on public.assignments to authenticated;

-- Em avaliação, só o professor vê quais exercícios do catálogo deram origem às questões
-- (o aluno poderia procurar a resposta na prática).
create policy "itens: professor, ou aluno em atividade" on public.assignment_items
  for select to authenticated
  using (exists (
    select 1 from public.assignments a
    where a.id = assignment_id and (public.is_teacher_of_class(a.class_id) or a.kind = 'atividade')
  ));
grant select on public.assignment_items to authenticated;

create policy "questões: quem vê a avaliação" on public.assessment_questions
  for select to authenticated
  using (exists (select 1 from public.assignments a where a.id = assignment_id));
-- O aluno não lê a coluna que aponta para o exercício de origem.
grant select (id, assignment_id, position, kind, title, statement, payload, points)
  on public.assessment_questions to authenticated;
grant select (source_exercise_id) on public.assessment_questions to authenticated;
revoke select (source_exercise_id) on public.assessment_questions from authenticated;

-- Só o professor dono lê o gabarito (a função de correção roda como SECURITY DEFINER).
create policy "gabarito: só o professor da turma" on public.assessment_keys
  for select to authenticated
  using (exists (
    select 1 from public.assessment_questions q
    join public.assignments a on a.id = q.assignment_id
    where q.id = question_id and public.is_teacher_of_class(a.class_id)
  ));
grant select on public.assessment_keys to authenticated;

create policy "entregas: o próprio aluno ou o professor da turma" on public.assessment_submissions
  for select to authenticated
  using (
    user_id = (select auth.uid())
    or exists (select 1 from public.assignments a where a.id = assignment_id and public.is_teacher_of_class(a.class_id))
  );
grant select on public.assessment_submissions to authenticated;

------------------------------------------------------------------------
-- 3. Criar atividade ou avaliação (só professor da turma)
------------------------------------------------------------------------
-- p_items: [{"exercise_id": "...", "points": 2}, ...] na ordem desejada.
create function public.create_assignment(
  p_class          uuid,
  p_kind           text,
  p_title          text,
  p_instructions   text,
  p_available_from timestamptz,
  p_due_at         timestamptz,
  p_required       boolean,
  p_result_rule    text,
  p_items          jsonb
)
returns bigint
language plpgsql
security definer
set search_path = ''
as $$
declare
  new_id bigint;
  item jsonb;
  ex record;
  pos integer := 0;
  qid bigint;
  payload jsonb;
  answer jsonb;
  pts integer;
begin
  if not public.is_teacher_of_class(p_class) then
    raise exception 'Apenas o professor da turma cria atividades.';
  end if;
  if exists (select 1 from public.classes c where c.id = p_class and c.archived) then
    raise exception 'A turma está arquivada.';
  end if;
  if p_kind not in ('atividade', 'avaliacao') then
    raise exception 'Tipo inválido.';
  end if;
  if p_items is null or jsonb_typeof(p_items) <> 'array' or jsonb_array_length(p_items) = 0
     or jsonb_array_length(p_items) > 50 then
    raise exception 'Escolha de 1 a 50 exercícios.';
  end if;
  if p_due_at is null or p_due_at <= coalesce(p_available_from, now()) then
    raise exception 'O prazo precisa ser depois da data de disponibilização.';
  end if;

  insert into public.assignments
    (class_id, teacher_id, kind, title, instructions, available_from, due_at, required, result_rule)
  values
    (p_class, (select auth.uid()), p_kind, trim(p_title), coalesce(p_instructions, ''),
     coalesce(p_available_from, now()), p_due_at, coalesce(p_required, true),
     coalesce(p_result_rule, 'so_nota'))
  returning id into new_id;

  for item in select * from jsonb_array_elements(p_items) loop
    pos := pos + 1;
    select e.id, e.kind, e.title, e.statement, e.config, e.published into ex
    from public.exercises e where e.id = item ->> 'exercise_id';
    if not found or not ex.published then
      raise exception 'Exercício não encontrado ou não publicado: %', item ->> 'exercise_id';
    end if;
    pts := coalesce((item ->> 'points')::integer, 1);

    insert into public.assignment_items (assignment_id, exercise_id, position, points)
    values (new_id, ex.id, pos, pts);

    if p_kind = 'avaliacao' then
      -- Avaliação com nota: só tipos que o banco corrige.
      if ex.kind not in ('choice', 'interpretation', 'blank', 'order') then
        raise exception 'Avaliações aceitam só questões corrigidas pelo banco (escolha, lacuna, interpretação e ordenação): %', ex.id;
      end if;
      if ex.kind in ('choice', 'interpretation') then
        payload := jsonb_build_object('options', (
          select jsonb_agg(case when jsonb_typeof(o) = 'object' then o -> 'text' else o end order by n)
          from jsonb_array_elements(ex.config -> 'options') with ordinality as t(o, n)
        ));
        if ex.kind = 'interpretation' then
          payload := payload || jsonb_build_object('code', ex.config -> 'code');
        end if;
        answer := jsonb_build_object('correct', ex.config -> 'correct');
      elsif ex.kind = 'blank' then
        payload := jsonb_build_object('template', ex.config -> 'template',
                                      'blanks', jsonb_array_length(ex.config -> 'blanks'));
        answer := jsonb_build_object('blanks', ex.config -> 'blanks');
      else -- order: o aluno recebe os passos embaralhados
        payload := jsonb_build_object('items', (
          select jsonb_agg(x order by random()) from jsonb_array_elements(ex.config -> 'items') as x
        ));
        answer := jsonb_build_object('items', ex.config -> 'items');
      end if;
      insert into public.assessment_questions
        (assignment_id, source_exercise_id, position, kind, title, statement, payload, points)
      values (new_id, ex.id, pos, ex.kind, 'Questão ' || pos, ex.statement, payload, pts)
      returning id into qid;
      insert into public.assessment_keys (question_id, answer) values (qid, answer);
    end if;
  end loop;
  return new_id;
end;
$$;
revoke execute on function public.create_assignment(uuid, text, text, text, timestamptz, timestamptz, boolean, text, jsonb) from public, anon;
grant execute on function public.create_assignment(uuid, text, text, text, timestamptz, timestamptz, boolean, text, jsonb) to authenticated;

------------------------------------------------------------------------
-- 4. Entregar a avaliação (correção no banco, prazo no servidor, uma única entrega)
------------------------------------------------------------------------
create function public.norm_answer(t text)
returns text
language sql
immutable
set search_path = ''
as $$ select regexp_replace(trim(coalesce(t, '')), '\s+', ' ', 'g'); $$;

-- Resultado que o aluno pode ver, conforme a regra escolhida pelo professor.
create function public.assessment_result(p_assignment bigint)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  me uuid := (select auth.uid());
  a record;
  s record;
  show_key boolean;
begin
  select * into a from public.assignments x where x.id = p_assignment and x.kind = 'avaliacao';
  if not found or not public.is_class_member(a.class_id) then
    raise exception 'Avaliação não encontrada.';
  end if;
  select * into s from public.assessment_submissions x where x.assignment_id = p_assignment and x.user_id = me;
  if not found then
    return null;
  end if;
  show_key := a.result_rule = 'nota_e_gabarito'
           or (a.result_rule = 'gabarito_apos_prazo' and now() > a.due_at);
  return jsonb_build_object(
    'score', s.score, 'max', s.max_score, 'submitted_at', s.submitted_at,
    'late', s.submitted_at > a.due_at,
    'details', case when show_key then s.details else null end
  );
end;
$$;
revoke execute on function public.assessment_result(bigint) from public, anon;
grant execute on function public.assessment_result(bigint) to authenticated;

-- p_answers: {"<id da questão>": <resposta>}  (escolha: número; lacuna e ordenação: lista de textos)
create function public.submit_assessment(p_assignment bigint, p_answers jsonb)
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := (select auth.uid());
  a record;
  q record;
  given jsonb;
  ok boolean;
  total integer := 0;
  got integer := 0;
  det jsonb := '[]'::jsonb;
  i integer;
  blank jsonb;
begin
  if me is null then raise exception 'Não autenticado.'; end if;
  select * into a from public.assignments x where x.id = p_assignment and x.kind = 'avaliacao' and not x.archived;
  if not found or not public.is_class_member(a.class_id) then
    raise exception 'Avaliação não encontrada.';
  end if;
  if now() < a.available_from then raise exception 'NAO_DISPONIVEL'; end if;
  if now() > a.due_at then raise exception 'FORA_DO_PRAZO'; end if;
  if exists (select 1 from public.assessment_submissions s where s.assignment_id = p_assignment and s.user_id = me) then
    raise exception 'JA_ENTREGUE';
  end if;
  if p_answers is null or jsonb_typeof(p_answers) <> 'object' then
    raise exception 'Respostas inválidas.';
  end if;

  for q in
    select qq.*, k.answer as key
    from public.assessment_questions qq
    join public.assessment_keys k on k.question_id = qq.id
    where qq.assignment_id = p_assignment
    order by qq.position
  loop
    given := p_answers -> (q.id::text);
    ok := false;
    if given is not null and jsonb_typeof(given) <> 'null' then
      if q.kind in ('choice', 'interpretation') then
        ok := jsonb_typeof(given) = 'number' and given = (q.key -> 'correct');
      elsif q.kind = 'order' then
        ok := jsonb_typeof(given) = 'array' and given = (q.key -> 'items');
      else -- blank
        ok := jsonb_typeof(given) = 'array'
          and jsonb_array_length(given) = jsonb_array_length(q.key -> 'blanks')
          and not exists (
            select 1
            from jsonb_array_elements(q.key -> 'blanks') with ordinality as b(spec, n)
            where public.norm_answer(given ->> ((n - 1)::integer)) = ''
               or not exists (
                    select 1 from jsonb_array_elements_text(spec -> 'answers') as ans
                    where public.norm_answer(ans) = public.norm_answer(given ->> ((n - 1)::integer))
                  )
          );
      end if;
    end if;
    total := total + q.points;
    if ok then got := got + q.points; end if;
    det := det || jsonb_build_object(
      'question_id', q.id, 'title', q.title, 'points', q.points, 'correct', ok,
      'given', given,
      'answer', case q.kind
        when 'order' then q.key -> 'items'
        when 'blank' then (select jsonb_agg(spec -> 'answers') from jsonb_array_elements(q.key -> 'blanks') spec)
        else q.key -> 'correct' end
    );
    -- cada questão vira uma tentativa na modalidade "avaliação"
    insert into public.attempts (user_id, exercise_id, kind, passed, answer, error_category, mode, assignment_id)
    values (me, q.source_exercise_id, q.kind, ok, left(given::text, 4000),
            case when ok then null else case q.kind
              when 'blank' then 'lacuna_incorreta' when 'order' then 'ordem_incorreta' else 'escolha_incorreta' end end,
            'avaliacao', p_assignment);
  end loop;
  if total = 0 then raise exception 'Avaliação sem questões.'; end if;

  insert into public.assessment_submissions (assignment_id, user_id, answers, details, score, max_score)
  values (p_assignment, me, p_answers, det, got, total);
  return public.assessment_result(p_assignment);
end;
$$;
revoke execute on function public.submit_assessment(bigint, jsonb) from public, anon;
grant execute on function public.submit_assessment(bigint, jsonb) to authenticated;

------------------------------------------------------------------------
-- 5. Tentativas de atividade: validadas no servidor
------------------------------------------------------------------------
-- Mesma assinatura da 0012; acrescenta a validação da modalidade e da atividade.
create or replace function public.record_attempt(
  p_exercise       text,
  p_passed         boolean,
  p_answer         text     default null,
  p_selected       integer  default null,
  p_tests_passed   integer  default null,
  p_tests_total    integer  default null,
  p_error_category text     default null,
  p_duration_ms    integer  default null,
  p_mode           text     default 'livre',
  p_assignment_id  bigint   default null,
  p_hint_level     integer  default 0
)
returns bigint
language plpgsql
security definer
set search_path = ''
as $$
declare
  uid        uuid := (select auth.uid());
  ex         record;
  opt        jsonb;
  given      jsonb;
  passed     boolean := p_passed;
  category   text := p_error_category;
  miscon     text := null;
  new_id     bigint;
begin
  if uid is null then
    raise exception 'Não autenticado.';
  end if;
  if p_mode is null or p_mode not in ('livre', 'atividade', 'avaliacao') then
    raise exception 'Modalidade inválida.';
  end if;
  if p_mode = 'avaliacao' then
    raise exception 'Avaliações são entregues pela própria avaliação.';
  end if;
  if (p_mode = 'atividade') <> (p_assignment_id is not null) then
    raise exception 'Atividade inválida.';
  end if;
  if p_mode = 'atividade' and not exists (
    select 1
    from public.assignments a
    join public.assignment_items i on i.assignment_id = a.id
    where a.id = p_assignment_id and a.kind = 'atividade' and not a.archived
      and a.available_from <= now()
      and i.exercise_id = p_exercise
      and public.is_class_member(a.class_id)
  ) then
    raise exception 'Atividade inválida.';
  end if;
  if p_hint_level is null or p_hint_level < 0 or p_hint_level > 3 then
    raise exception 'Nível de dica inválido.';
  end if;

  select e.kind, e.config, e.published into ex from public.exercises e where e.id = p_exercise;
  if not found or (not ex.published and not public.is_professor()) then
    raise exception 'Exercício não encontrado.';
  end if;

  if (select count(*) from public.attempts a
        where a.user_id = uid and a.created_at > now() - interval '1 minute') >= 60 then
    raise exception 'MUITAS_TENTATIVAS';
  end if;

  if ex.kind in ('choice', 'interpretation') then
    if p_selected is null or p_selected < 0 or p_selected >= jsonb_array_length(ex.config -> 'options') then
      raise exception 'Alternativa inválida.';
    end if;
    passed := p_selected = (ex.config ->> 'correct')::integer;
    opt := ex.config -> 'options' -> p_selected;
    if not passed and jsonb_typeof(opt) = 'object' then
      miscon := left(opt ->> 'misconception', 200);
    end if;
    category := case when passed then null else 'escolha_incorreta' end;
  elsif ex.kind = 'order' then
    begin
      given := p_answer::jsonb;
    exception when others then
      raise exception 'Resposta inválida.';
    end;
    if given is null or jsonb_typeof(given) <> 'array' then
      raise exception 'Resposta inválida.';
    end if;
    passed := given = (ex.config -> 'items');
    category := case when passed then null else 'ordem_incorreta' end;
  elsif ex.kind = 'blank' then
    category := case when passed then null else 'lacuna_incorreta' end;
  else
    if passed then
      category := null;
    elsif category is null then
      category := 'saida_incorreta';
    end if;
  end if;

  insert into public.attempts
    (user_id, exercise_id, kind, passed, answer, tests_passed, tests_total,
     error_category, misconception, duration_ms, mode, assignment_id, hint_level)
  values
    (uid, p_exercise, ex.kind, passed, left(p_answer, 4000), p_tests_passed, p_tests_total,
     category, miscon, p_duration_ms, p_mode, p_assignment_id, p_hint_level)
  returning id into new_id;
  return new_id;
end;
$$;

------------------------------------------------------------------------
-- 6. "Minhas atividades" (aluno)
------------------------------------------------------------------------
create function public.my_assignments()
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  with me as (select (select auth.uid()) as id),
  mine as (
    select a.*, c.name as class_name
    from public.assignments a
    join public.class_members cm on cm.class_id = a.class_id
    join public.classes c on c.id = a.class_id
    join me on cm.student_id = me.id
    where a.available_from <= now() and not a.archived
  ),
  stats as (
    select m.id,
      (select count(*) from public.assignment_items i where i.assignment_id = m.id)::integer as total,
      (select count(*) from public.assignment_items i
         join public.exercise_progress ep on ep.exercise_id = i.exercise_id and ep.user_id = (select id from me) and ep.solved
         where i.assignment_id = m.id)::integer as done,
      (select max(ep.solved_at) from public.assignment_items i
         join public.exercise_progress ep on ep.exercise_id = i.exercise_id and ep.user_id = (select id from me) and ep.solved
         where i.assignment_id = m.id) as last_solved,
      exists (select 1 from public.attempts t where t.assignment_id = m.id and t.user_id = (select id from me)) as started,
      (select s.score from public.assessment_submissions s where s.assignment_id = m.id and s.user_id = (select id from me)) as score,
      (select s.max_score from public.assessment_submissions s where s.assignment_id = m.id and s.user_id = (select id from me)) as max_score,
      (select s.submitted_at from public.assessment_submissions s where s.assignment_id = m.id and s.user_id = (select id from me)) as submitted_at,
      (select r.result_rule from public.assignments r where r.id = m.id) as rule
    from mine m
  )
  select coalesce(jsonb_agg(jsonb_build_object(
    'id', m.id, 'kind', m.kind, 'title', m.title, 'instructions', m.instructions,
    'class_name', m.class_name, 'available_from', m.available_from, 'due_at', m.due_at,
    'required', m.required, 'result_rule', m.result_rule,
    'items_total', s.total, 'items_done', s.done,
    'submitted_at', s.submitted_at,
    'score', s.score,
    'max_score', s.max_score,
    'status', case
      when m.kind = 'avaliacao' then
        case when s.submitted_at is not null then 'entregue'
             when now() > m.due_at then 'nao_entregue'
             else 'nao_iniciada' end
      else
        case when s.total > 0 and s.done = s.total then
               case when s.last_solved > m.due_at then 'concluida_atrasada' else 'concluida' end
             when now() > m.due_at then 'atrasada'
             when s.started or s.done > 0 then 'em_andamento'
             else 'nao_iniciada' end
    end
  ) order by m.due_at), '[]'::jsonb)
  from mine m join stats s on s.id = m.id;
$$;
revoke execute on function public.my_assignments() from public, anon;
grant execute on function public.my_assignments() to authenticated;

-- Questões da avaliação para o aluno (sem gabarito), só depois da liberação.
create function public.get_assessment(p_assignment bigint)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  a record;
begin
  select * into a from public.assignments x where x.id = p_assignment and x.kind = 'avaliacao' and not x.archived;
  if not found or not public.is_class_member(a.class_id) or now() < a.available_from then
    raise exception 'Avaliação não encontrada.';
  end if;
  return jsonb_build_object(
    'id', a.id, 'title', a.title, 'instructions', a.instructions, 'due_at', a.due_at,
    'result_rule', a.result_rule,
    'questions', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', q.id, 'kind', q.kind, 'title', q.title, 'statement', q.statement,
        'payload', q.payload, 'points', q.points) order by q.position)
      from public.assessment_questions q where q.assignment_id = a.id), '[]'::jsonb)
  );
end;
$$;
revoke execute on function public.get_assessment(bigint) from public, anon;
grant execute on function public.get_assessment(bigint) to authenticated;

------------------------------------------------------------------------
-- 7. Acompanhamento (professor)
------------------------------------------------------------------------
create function public.assignment_report(p_assignment bigint)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  a record;
  result jsonb;
begin
  select x.*, c.name as class_name into a
  from public.assignments x join public.classes c on c.id = x.class_id
  where x.id = p_assignment;
  if not found or not public.is_teacher_of_class(a.class_id) then
    raise exception 'Atividade não encontrada.';
  end if;

  with members as (
    select cm.student_id as id, p.name
    from public.class_members cm join public.profiles p on p.id = cm.student_id
    where cm.class_id = a.class_id
  ),
  items as (
    select i.exercise_id, i.points, e.title from public.assignment_items i
    join public.exercises e on e.id = i.exercise_id where i.assignment_id = a.id
  ),
  per_student as (
    select m.id, m.name,
      (select count(*) from items) as total,
      (select count(*) from items i join public.exercise_progress ep
         on ep.exercise_id = i.exercise_id and ep.user_id = m.id and ep.solved) as done,
      (select max(ep.solved_at) from items i join public.exercise_progress ep
         on ep.exercise_id = i.exercise_id and ep.user_id = m.id and ep.solved) as last_solved,
      (select count(*) from public.attempts t where t.assignment_id = a.id and t.user_id = m.id) as attempts,
      (select max(t.created_at) from public.attempts t where t.assignment_id = a.id and t.user_id = m.id) as last_attempt,
      (select coalesce(sum(t.duration_ms), 0) from public.attempts t where t.assignment_id = a.id and t.user_id = m.id) as duration_ms,
      s.score, s.max_score, s.submitted_at
    from members m
    left join public.assessment_submissions s on s.assignment_id = a.id and s.user_id = m.id
  )
  select jsonb_build_object(
    'assignment', jsonb_build_object(
      'id', a.id, 'kind', a.kind, 'title', a.title, 'instructions', a.instructions, 'class_id', a.class_id,
      'class_name', a.class_name, 'available_from', a.available_from, 'due_at', a.due_at,
      'required', a.required, 'result_rule', a.result_rule),
    'students', coalesce((select jsonb_agg(jsonb_build_object(
      'id', ps.id, 'name', ps.name, 'items_total', ps.total, 'items_done', ps.done,
      'attempts', ps.attempts, 'last_attempt', ps.last_attempt, 'duration_ms', ps.duration_ms,
      'score', ps.score, 'max_score', ps.max_score, 'submitted_at', ps.submitted_at,
      'status', case
        when a.kind = 'avaliacao' then
          case when ps.submitted_at is not null then 'entregue'
               when now() > a.due_at then 'nao_entregue' else 'nao_iniciada' end
        else
          case when ps.total > 0 and ps.done = ps.total then
                 case when ps.last_solved > a.due_at then 'concluida_atrasada' else 'concluida' end
               when now() > a.due_at then 'atrasada'
               when ps.attempts > 0 or ps.done > 0 then 'em_andamento'
               else 'nao_iniciada' end
      end) order by ps.name) from per_student ps), '[]'::jsonb),
    'exercises', coalesce((select jsonb_agg(jsonb_build_object(
      'exercise_id', i.exercise_id, 'title', i.title,
      'attempted', (select count(distinct t.user_id) from public.attempts t where t.assignment_id = a.id and t.exercise_id = i.exercise_id),
      'solved', (select count(distinct t.user_id) from public.attempts t where t.assignment_id = a.id and t.exercise_id = i.exercise_id and t.passed),
      'attempts', (select count(*) from public.attempts t where t.assignment_id = a.id and t.exercise_id = i.exercise_id)
    )) from items i), '[]'::jsonb),
    'concepts', coalesce((select jsonb_agg(jsonb_build_object(
      'concept_id', k.concept_id, 'title', k.title, 'attempts', k.n, 'wrong', k.wrong) order by k.wrong desc)
      from (
        select c.id as concept_id, c.title, count(*) as n, count(*) filter (where not t.passed) as wrong
        from public.attempts t
        join public.exercise_concepts ec on ec.exercise_id = t.exercise_id
        join public.concepts c on c.id = ec.concept_id
        where t.assignment_id = a.id
        group by c.id, c.title
      ) k), '[]'::jsonb)
  ) into result;
  return result;
end;
$$;
revoke execute on function public.assignment_report(bigint) from public, anon;
grant execute on function public.assignment_report(bigint) to authenticated;

-- Resumo para o painel do professor: uma linha por atividade das suas turmas.
create function public.teacher_assignment_summaries()
returns jsonb
language sql
stable
security definer
set search_path = ''
as $$
  select coalesce(jsonb_agg(jsonb_build_object(
    'id', a.id, 'kind', a.kind, 'title', a.title, 'class_id', c.id, 'class_name', c.name,
    'available_from', a.available_from, 'due_at', a.due_at, 'required', a.required, 'archived', a.archived,
    'students', (select count(*) from public.class_members cm where cm.class_id = c.id),
    'started', (select count(distinct t.user_id) from public.attempts t where t.assignment_id = a.id)
              + (select count(*) from public.assessment_submissions s where s.assignment_id = a.id
                   and not exists (select 1 from public.attempts t where t.assignment_id = a.id and t.user_id = s.user_id)),
    'completed', case when a.kind = 'avaliacao'
      then (select count(*) from public.assessment_submissions s where s.assignment_id = a.id)
      else (select count(*) from public.class_members cm where cm.class_id = c.id
              and (select count(*) from public.assignment_items i where i.assignment_id = a.id) > 0
              and (select count(*) from public.assignment_items i
                     join public.exercise_progress ep on ep.exercise_id = i.exercise_id and ep.user_id = cm.student_id and ep.solved
                     where i.assignment_id = a.id)
                  = (select count(*) from public.assignment_items i where i.assignment_id = a.id))
    end
  ) order by a.due_at desc), '[]'::jsonb)
  from public.assignments a
  join public.classes c on c.id = a.class_id
  where c.teacher_id = (select auth.uid());
$$;
revoke execute on function public.teacher_assignment_summaries() from public, anon;
grant execute on function public.teacher_assignment_summaries() to authenticated;

-- ============================================================
-- 0016_inteligencia_pedagogica.sql
-- ============================================================

-- E11: inteligência pedagógica. Relatório de dificuldades por conceito para o professor.
-- Requer as migrations até a 0015. A fórmula está documentada em docs/inteligencia-pedagogica.md e
-- é a mesma de src/lib/concept-analytics.ts (um teste confere que os dois dão o mesmo resultado).
--
-- Regras (decisões D7 e D8):
--   * só se afirma algo sobre um aluno em um conceito com 3 ou mais tentativas em 2 ou mais exercícios;
--   * o painel agregado da turma só afirma conclusões com 5 ou mais alunos na turma;
--   * os números vêm só de `attempts` (nada é inventado) e o professor só vê as próprias turmas.

create function public.concept_report(
  p_class  uuid,
  p_mode   text        default null,   -- 'livre' | 'atividade' | 'avaliacao' | null (todas)
  p_from   timestamptz default null,
  p_to     timestamptz default null,
  p_world  text        default null,   -- só tentativas de exercícios das lições deste mundo
  p_module text        default null    -- só tentativas de exercícios desta lição
)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  n_students integer;
  result jsonb;
begin
  if not public.is_teacher_of_class(p_class) then
    raise exception 'Turma não encontrada.';
  end if;
  if p_mode is not null and p_mode not in ('livre', 'atividade', 'avaliacao') then
    raise exception 'Modalidade inválida.';
  end if;
  select count(*)::integer into n_students from public.class_members where class_id = p_class;

  with base as (   -- tentativas da turma, com os filtros (menos a modalidade)
    select t.id, t.user_id, t.exercise_id, t.passed, t.created_at, t.mode, t.error_category, t.misconception
    from public.attempts t
    join public.class_members cm on cm.student_id = t.user_id and cm.class_id = p_class
    join public.exercises e on e.id = t.exercise_id
    join public.modules m on m.id = e.module_id
    where (p_from is null or t.created_at >= p_from)
      and (p_to is null or t.created_at < p_to)
      and (p_world is null or m.world_id = p_world)
      and (p_module is null or e.module_id = p_module)
  ),
  att as (select * from base where p_mode is null or mode = p_mode),
  linked as (      -- uma linha por (tentativa, conceito do exercício), com o peso da ligação
    select a.*, ec.concept_id, ec.weight
    from att a join public.exercise_concepts ec on ec.exercise_id = a.exercise_id
  ),
  ranked as (      -- as tentativas mais recentes do aluno no conceito pesam mais (0,8 por posição)
    select l.*, row_number() over (partition by l.user_id, l.concept_id order by l.created_at desc, l.id desc) as rn
    from linked l
  ),
  student_concept as (
    select user_id, concept_id,
           count(*)::integer as attempts,
           count(distinct exercise_id)::integer as exercises,
           sum(weight * power(0.8, rn - 1) * (case when passed then 0 else 1 end))::float8
             / sum(weight * power(0.8, rn - 1))::float8 as score
    from ranked group by user_id, concept_id
  ),
  leveled as (
    select sc.*,
      case when sc.attempts < 3 or sc.exercises < 2 then 'nao_avaliado'
           when sc.score <= 0.25 then 'bom'
           when sc.score <= 0.5 then 'em_desenvolvimento'
           else 'dificuldade' end as level
    from student_concept sc
  ),
  concept_class as (
    select concept_id,
           count(*)::integer as attempts,
           count(distinct exercise_id)::integer as exercises,
           count(distinct user_id)::integer as students,
           (sum(weight * (case when passed then 0 else 1 end))::float8 / sum(weight)::float8) as error_rate
    from linked group by concept_id
  ),
  concept_levels as (
    select concept_id,
           count(*) filter (where level = 'bom')::integer as bom,
           count(*) filter (where level = 'em_desenvolvimento')::integer as em_desenvolvimento,
           count(*) filter (where level = 'dificuldade')::integer as dificuldade,
           count(*) filter (where level = 'nao_avaliado')::integer as nao_avaliado
    from leveled group by concept_id
  )
  select jsonb_build_object(
    'students_total', n_students,
    'min_students', 5,
    'concepts', coalesce((
      select jsonb_agg(jsonb_build_object(
        'concept_id', c.id, 'title', c.title, 'world_id', c.world_id,
        'attempts', cc.attempts, 'exercises', cc.exercises, 'students', cc.students,
        'sufficient', (n_students >= 5 and cc.attempts >= 3 and cc.exercises >= 2),
        'error_rate', case when n_students >= 5 and cc.attempts >= 3 and cc.exercises >= 2 then cc.error_rate end,
        'bom', coalesce(cl.bom, 0), 'em_desenvolvimento', coalesce(cl.em_desenvolvimento, 0),
        'dificuldade', coalesce(cl.dificuldade, 0), 'nao_avaliado', coalesce(cl.nao_avaliado, 0)
      ) order by c.title)
      from concept_class cc
      join public.concepts c on c.id = cc.concept_id
      left join concept_levels cl on cl.concept_id = cc.concept_id), '[]'::jsonb),
    'student_concepts', coalesce((
      select jsonb_agg(jsonb_build_object(
        'student_id', l.user_id, 'name', p.name, 'concept_id', l.concept_id,
        'attempts', l.attempts, 'exercises', l.exercises, 'score', l.score, 'level', l.level
      ) order by p.name, l.concept_id)
      from leveled l join public.profiles p on p.id = l.user_id), '[]'::jsonb),
    'hardest_exercises', coalesce((
      select jsonb_agg(x order by (x ->> 'error_rate')::float8 desc, (x ->> 'errors')::int desc)
      from (
        select jsonb_build_object('exercise_id', e.id, 'title', e.title,
                 'attempts', count(*), 'errors', count(*) filter (where not a.passed),
                 'error_rate', (count(*) filter (where not a.passed))::float8 / count(*)::float8) as x
        from att a join public.exercises e on e.id = a.exercise_id
        group by e.id, e.title
        having count(*) >= 3 and count(*) filter (where not a.passed) > 0
        order by (count(*) filter (where not a.passed))::float8 / count(*)::float8 desc, count(*) desc
        limit 10
      ) h), '[]'::jsonb),
    'misconceptions', coalesce((
      select jsonb_agg(x order by (x ->> 'count')::int desc, x ->> 'text')
      from (
        select jsonb_build_object('text', a.misconception, 'count', count(*), 'students', count(distinct a.user_id)) as x
        from att a where not a.passed and a.misconception is not null
        group by a.misconception order by count(*) desc, a.misconception limit 10
      ) m), '[]'::jsonb),
    'error_categories', coalesce((
      select jsonb_agg(x order by (x ->> 'count')::int desc, x ->> 'category')
      from (
        select jsonb_build_object('category', a.error_category, 'count', count(*)) as x
        from att a where not a.passed and a.error_category is not null
        group by a.error_category
      ) k), '[]'::jsonb),
    'by_mode', coalesce((
      select jsonb_agg(jsonb_build_object('mode', b.mode, 'attempts', b.n, 'errors', b.errors) order by b.mode)
      from (select mode, count(*)::integer as n, (count(*) filter (where not passed))::integer as errors
            from base group by mode) b), '[]'::jsonb),
    'timeline', coalesce((
      select jsonb_agg(jsonb_build_object('day', d.day, 'attempts', d.n, 'errors', d.errors) order by d.day)
      from (select (a.created_at at time zone 'America/Fortaleza')::date as day, count(*)::integer as n,
                   (count(*) filter (where not a.passed))::integer as errors
            from att a group by 1) d), '[]'::jsonb)
  ) into result;
  return result;
end;
$$;
revoke execute on function public.concept_report(uuid, text, timestamptz, timestamptz, text, text) from public, anon;
grant execute on function public.concept_report(uuid, text, timestamptz, timestamptz, text, text) to authenticated;

-- ============================================================
-- 0017_privacidade_e_pesquisa.sql
-- ============================================================

-- E15: privacidade (LGPD) e avaliação do TCC. Requer as migrations até a 0016.
--
-- Privacidade: consentimento registrado no cadastro, escolha de desligar a dica com IA, exportação e
-- exclusão dos próprios dados.
-- Pesquisa: questionário SUS e escala Likert (anônimos ou identificados), exportação em CSV e
-- comparação agregada do uso da dica com IA.

------------------------------------------------------------------------
-- 1. Consentimento e preferências de privacidade
------------------------------------------------------------------------
alter table public.profiles
  add column consent_at       timestamptz,
  add column consent_version  text,
  add column over_18          boolean,
  add column ai_hints_enabled boolean not null default true;

grant update (name, show_in_ranking, ai_hints_enabled) on public.profiles to authenticated;

-- O cadastro envia a versão do termo e a declaração de idade nos metadados; o gatilho as registra.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v text := nullif(trim(new.raw_user_meta_data ->> 'consent_version'), '');
begin
  insert into public.profiles (id, name, consent_at, consent_version, over_18)
  values (
    new.id,
    coalesce(nullif(trim(new.raw_user_meta_data ->> 'name'), ''), split_part(new.email, '@', 1)),
    case when v is not null then now() end,
    left(v, 20),
    case when new.raw_user_meta_data ->> 'over_18' in ('true', 'false')
         then (new.raw_user_meta_data ->> 'over_18')::boolean end
  );
  return new;
end;
$$;

-- Quem já tinha conta antes do termo aceita (ou atualiza) pelo próprio site.
create function public.accept_terms(p_version text, p_over_18 boolean)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  if (select auth.uid()) is null then
    raise exception 'Não autenticado.';
  end if;
  if p_version is null or char_length(trim(p_version)) not between 1 and 20 then
    raise exception 'Versão do termo inválida.';
  end if;
  update public.profiles
     set consent_at = now(), consent_version = trim(p_version), over_18 = p_over_18
   where id = (select auth.uid());
end;
$$;
revoke execute on function public.accept_terms(text, boolean) from public, anon;
grant execute on function public.accept_terms(text, boolean) to authenticated;

-- A dica com IA respeita a escolha do aluno (o texto enviado ao Gemini sai do servidor do site).
create or replace function public.use_ai_hint(p_exercise text, p_limit integer default 10)
returns table (hint_id bigint, remaining integer)
language plpgsql
security definer
set search_path = ''
as $$
declare
  uid uuid := (select auth.uid());
  used integer;
  new_id bigint;
begin
  if uid is null then
    raise exception 'Não autenticado.';
  end if;
  if exists (select 1 from public.profiles p where p.id = uid and not p.ai_hints_enabled) then
    raise exception 'IA_DESLIGADA';
  end if;
  perform pg_advisory_xact_lock(hashtextextended(uid::text, 0));
  select count(*) into used from public.ai_hints where user_id = uid and day = current_date;
  if used >= p_limit then
    raise exception 'LIMITE_DIARIO';
  end if;
  insert into public.ai_hints (user_id, exercise_id) values (uid, p_exercise) returning id into new_id;
  return query select new_id, p_limit - used - 1;
end;
$$;

------------------------------------------------------------------------
-- 2. Exportar e excluir os próprios dados
------------------------------------------------------------------------
create function public.export_my_data()
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  me uuid := (select auth.uid());
begin
  if me is null then
    raise exception 'Não autenticado.';
  end if;
  return jsonb_build_object(
    'exportado_em', now(),
    'perfil', (select to_jsonb(p) from public.profiles p where p.id = me),
    'progresso', coalesce((select jsonb_agg(to_jsonb(x)) from public.exercise_progress x where x.user_id = me), '[]'::jsonb),
    'tentativas', coalesce((select jsonb_agg(to_jsonb(x) - 'user_id') from public.attempts x where x.user_id = me), '[]'::jsonb),
    'atividade_diaria', coalesce((select jsonb_agg(to_jsonb(x)) from public.daily_activity x where x.user_id = me), '[]'::jsonb),
    'conquistas', coalesce((select jsonb_agg(to_jsonb(x)) from public.user_badges x where x.user_id = me), '[]'::jsonb),
    'missoes_concluidas', coalesce((select jsonb_agg(to_jsonb(x)) from public.mission_claims x where x.user_id = me), '[]'::jsonb),
    'bonus_de_mundo', coalesce((select jsonb_agg(to_jsonb(x)) from public.world_bonuses x where x.user_id = me), '[]'::jsonb),
    'dicas_com_ia', coalesce((select jsonb_agg(to_jsonb(x)) from public.ai_hints x where x.user_id = me), '[]'::jsonb),
    'avaliacoes_entregues', coalesce((select jsonb_agg(to_jsonb(x)) from public.assessment_submissions x where x.user_id = me), '[]'::jsonb),
    'turmas', coalesce((select jsonb_agg(jsonb_build_object('turma', c.name, 'entrou_em', cm.joined_at))
                        from public.class_members cm join public.classes c on c.id = cm.class_id
                        where cm.student_id = me), '[]'::jsonb),
    'questionarios_respondidos', coalesce((select jsonb_agg(to_jsonb(x)) from public.survey_done x where x.user_id = me), '[]'::jsonb),
    'respostas_identificadas', coalesce((select jsonb_agg(to_jsonb(x) - 'user_id') from public.survey_responses x where x.user_id = me), '[]'::jsonb)
  );
end;
$$;
revoke execute on function public.export_my_data() from public, anon;
grant execute on function public.export_my_data() to authenticated;

-- Exclui a conta e, em cascata, tudo que é do usuário. Respostas anônimas de questionário não têm
-- ligação com ninguém e permanecem (não há como saber de quem são).
create function public.delete_my_account()
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := (select auth.uid());
begin
  if me is null then
    raise exception 'Não autenticado.';
  end if;
  delete from auth.users where id = me;
end;
$$;
revoke execute on function public.delete_my_account() from public, anon;
grant execute on function public.delete_my_account() to authenticated;

------------------------------------------------------------------------
-- 3. Questionários SUS e Likert
------------------------------------------------------------------------
create table public.survey_responses (
  id         bigint generated always as identity primary key,
  kind       text not null check (kind in ('sus', 'likert')),
  user_id    uuid references public.profiles (id) on delete cascade, -- nulo = anônima
  class_id   uuid references public.classes (id) on delete set null,
  anonymous  boolean not null,
  answers    jsonb not null,
  score      numeric(5, 1),                                          -- pontuação SUS (0 a 100)
  comment    text check (comment is null or char_length(comment) <= 1000),
  created_at timestamptz not null default now(),
  check (anonymous = (user_id is null))
);
create index survey_responses_class_idx on public.survey_responses (class_id, kind);

-- Controla "uma resposta por aluno e questionário" sem ligar a pessoa à resposta anônima.
create table public.survey_done (
  user_id uuid not null references public.profiles (id) on delete cascade,
  kind    text not null check (kind in ('sus', 'likert')),
  done_at timestamptz not null default now(),
  primary key (user_id, kind)
);

alter table public.survey_responses enable row level security;
alter table public.survey_done enable row level security;

create policy "pesquisa: o próprio aluno ou o professor da turma" on public.survey_responses
  for select to authenticated
  using (
    user_id = (select auth.uid())
    or (class_id is not null and public.is_teacher_of_class(class_id))
  );
create policy "pesquisa: o próprio aluno vê o que já respondeu" on public.survey_done
  for select to authenticated using (user_id = (select auth.uid()));
grant select on public.survey_responses, public.survey_done to authenticated;

-- Pontuação SUS: itens ímpares valem (resposta - 1), pares valem (5 - resposta); soma × 2,5.
create function public.sus_score(p_answers jsonb)
returns numeric
language sql
immutable
set search_path = ''
as $$
  select (sum(case when n % 2 = 1 then (p_answers ->> n::text)::int - 1
                   else 5 - (p_answers ->> n::text)::int end) * 2.5)::numeric(5, 1)
  from generate_series(1, 10) as n;
$$;

create function public.submit_survey(
  p_kind      text,
  p_answers   jsonb,
  p_comment   text    default null,
  p_anonymous boolean default true,
  p_class     uuid    default null
)
returns numeric
language plpgsql
security definer
set search_path = ''
as $$
declare
  me uuid := (select auth.uid());
  total integer;
  n integer;
  v text;
  score numeric;
begin
  if me is null then raise exception 'Não autenticado.'; end if;
  if not exists (select 1 from public.profiles p where p.id = me and p.role = 'aluno') then
    raise exception 'Só alunos respondem ao questionário.';
  end if;
  if p_kind not in ('sus', 'likert') then raise exception 'Questionário inválido.'; end if;
  total := case p_kind when 'sus' then 10 else 8 end;
  if p_answers is null or jsonb_typeof(p_answers) <> 'object' then
    raise exception 'Respostas inválidas.';
  end if;
  for n in 1..total loop
    v := p_answers ->> n::text;
    if v is null or v !~ '^[1-5]$' then
      raise exception 'Responda todas as afirmações com um valor de 1 a 5.';
    end if;
  end loop;
  if (select count(*) from jsonb_object_keys(p_answers)) <> total then
    raise exception 'Respostas inválidas.';
  end if;
  if p_class is not null and not public.is_class_member(p_class) then
    raise exception 'Turma inválida.';
  end if;

  insert into public.survey_done (user_id, kind) values (me, p_kind)
  on conflict do nothing;
  if not found then
    raise exception 'JA_RESPONDIDO';
  end if;

  score := case when p_kind = 'sus' then public.sus_score(p_answers) end;
  insert into public.survey_responses (kind, user_id, class_id, anonymous, answers, score, comment)
  values (p_kind, case when p_anonymous then null else me end, p_class, coalesce(p_anonymous, true),
          p_answers, score, nullif(left(trim(coalesce(p_comment, '')), 1000), ''));
  return score;
end;
$$;
revoke execute on function public.submit_survey(text, jsonb, text, boolean, uuid) from public, anon;
grant execute on function public.submit_survey(text, jsonb, text, boolean, uuid) to authenticated;

-- Campo de CSV: aspas duplicadas, e prefixo para o Excel não executar fórmulas ("=", "+", "-", "@").
create function public.csv_cell(p text)
returns text
language sql
immutable
set search_path = ''
as $$
  select '"' || replace(
    case when p ~ '^[=+\-@\t\r]' then '''' || p else coalesce(p, '') end,
    '"', '""') || '"';
$$;

-- CSV das respostas (só o professor, só das suas turmas). Respostas anônimas não trazem nome.
create function public.export_survey_csv(p_class uuid default null)
returns text
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  out text;
  header text;
begin
  if not public.is_professor() then
    raise exception 'Apenas professores exportam as respostas.';
  end if;
  header := 'id,data,questionario,modo,turma,nome,pontuacao_sus,'
         || (select string_agg('q' || n, ',' order by n) from generate_series(1, 10) n) || ',comentario';
  select header || coalesce(chr(10) || string_agg(line, chr(10) order by id), '') into out
  from (
    select r.id,
      concat_ws(',',
        r.id::text,
        public.csv_cell(to_char(r.created_at at time zone 'America/Fortaleza', 'YYYY-MM-DD HH24:MI')),
        r.kind,
        case when r.anonymous then 'anonima' else 'identificada' end,
        public.csv_cell(c.name),
        public.csv_cell(case when r.anonymous then null else p.name end),
        coalesce(r.score::text, ''),
        (select string_agg(coalesce(r.answers ->> n::text, ''), ',' order by n) from generate_series(1, 10) n),
        public.csv_cell(r.comment)
      ) as line
    from public.survey_responses r
    join public.classes c on c.id = r.class_id and c.teacher_id = (select auth.uid())
    left join public.profiles p on p.id = r.user_id
    where p_class is null or r.class_id = p_class
  ) t;
  return out;
end;
$$;
revoke execute on function public.export_survey_csv(uuid) from public, anon;
grant execute on function public.export_survey_csv(uuid) to authenticated;

-- Resumo agregado: com menos de 5 respostas por questionário, só a contagem (para não expor ninguém).
create function public.survey_summary(p_class uuid default null)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  result jsonb := '{}'::jsonb;
  k text;
  total integer;
begin
  if not public.is_professor() then
    raise exception 'Apenas professores veem o resumo.';
  end if;
  foreach k in array array['sus', 'likert'] loop
    select count(*) into total
    from public.survey_responses r
    join public.classes c on c.id = r.class_id and c.teacher_id = (select auth.uid())
    where r.kind = k and (p_class is null or r.class_id = p_class);
    result := result || jsonb_build_object(k,
      case when total < 5 then jsonb_build_object('n', total, 'sufficient', false)
      else jsonb_build_object(
        'n', total, 'sufficient', true,
        'mean_score', (select round(avg(r.score), 1) from public.survey_responses r
                       join public.classes c on c.id = r.class_id and c.teacher_id = (select auth.uid())
                       where r.kind = k and (p_class is null or r.class_id = p_class)),
        'item_means', (select jsonb_object_agg(n::text, m) from (
                         select n, round(avg((r.answers ->> n::text)::numeric), 2) as m
                         from public.survey_responses r
                         join public.classes c on c.id = r.class_id and c.teacher_id = (select auth.uid()),
                              generate_series(1, case k when 'sus' then 10 else 8 end) n
                         where r.kind = k and (p_class is null or r.class_id = p_class)
                         group by n) q),
        'anonymous', (select count(*) from public.survey_responses r
                      join public.classes c on c.id = r.class_id and c.teacher_id = (select auth.uid())
                      where r.kind = k and r.anonymous and (p_class is null or r.class_id = p_class))
      ) end);
  end loop;
  return result;
end;
$$;
revoke execute on function public.survey_summary(uuid) from public, anon;
grant execute on function public.survey_summary(uuid) to authenticated;

------------------------------------------------------------------------
-- 4. Dica com IA: comparação agregada (sem dados individuais)
------------------------------------------------------------------------
-- Compara alunos que usaram a dica com IA ao menos uma vez com os que nunca usaram. Só devolve números
-- quando os dois grupos têm 5 ou mais alunos. Não prova que a dica causa a diferença (os grupos podem
-- diferir por outros motivos); serve como indício para o texto do TCC.
create function public.ai_group_stats(p_class uuid)
returns table (grp text, students integer, attempts bigint, passed bigint, solved bigint)
language sql
stable
security definer
set search_path = ''
as $$
  select g.grp, count(*)::integer, sum(g.att)::bigint, sum(g.ok)::bigint, sum(g.sol)::bigint
  from (
    select s.id,
      case when exists (select 1 from public.ai_hints h where h.user_id = s.id) then 'com' else 'sem' end as grp,
      (select count(*) from public.attempts t where t.user_id = s.id) as att,
      (select count(*) from public.attempts t where t.user_id = s.id and t.passed) as ok,
      (select count(*) from public.exercise_progress ep where ep.user_id = s.id and ep.solved) as sol
    from (select distinct cm.student_id as id
          from public.class_members cm
          join public.classes c on c.id = cm.class_id and c.teacher_id = (select auth.uid())
          where p_class is null or cm.class_id = p_class) s
  ) g
  group by g.grp;
$$;
revoke execute on function public.ai_group_stats(uuid) from public, anon, authenticated;

create function public.ai_hint_comparison(p_class uuid default null)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  with_n integer;
  without_n integer;
begin
  if not public.is_professor() then
    raise exception 'Apenas professores veem a comparação.';
  end if;
  select coalesce(max(students) filter (where grp = 'com'), 0),
         coalesce(max(students) filter (where grp = 'sem'), 0)
    into with_n, without_n
  from public.ai_group_stats(p_class);
  if with_n < 5 or without_n < 5 then
    return jsonb_build_object('sufficient', false, 'com_ia', with_n, 'sem_ia', without_n, 'min', 5);
  end if;
  return (
    select jsonb_build_object('sufficient', true, 'min', 5,
      'grupos', jsonb_agg(jsonb_build_object(
        'grupo', grp, 'alunos', students,
        'tentativas_por_aluno', round(attempts::numeric / students, 1),
        'taxa_de_acerto', round(passed::numeric / nullif(attempts, 0), 3),
        'exercicios_resolvidos_por_aluno', round(solved::numeric / students, 1)) order by grp))
    from public.ai_group_stats(p_class));
end;
$$;
revoke execute on function public.ai_hint_comparison(uuid) from public, anon;
grant execute on function public.ai_hint_comparison(uuid) to authenticated;
