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
