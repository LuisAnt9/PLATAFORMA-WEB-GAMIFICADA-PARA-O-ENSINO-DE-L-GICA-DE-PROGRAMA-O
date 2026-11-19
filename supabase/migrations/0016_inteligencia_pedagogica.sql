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
