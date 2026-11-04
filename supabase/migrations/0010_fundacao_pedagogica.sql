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
