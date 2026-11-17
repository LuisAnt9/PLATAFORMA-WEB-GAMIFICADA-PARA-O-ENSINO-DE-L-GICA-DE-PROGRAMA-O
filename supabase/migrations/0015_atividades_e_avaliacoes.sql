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
