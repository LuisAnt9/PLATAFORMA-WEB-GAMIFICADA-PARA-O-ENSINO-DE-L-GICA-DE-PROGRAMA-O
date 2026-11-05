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
