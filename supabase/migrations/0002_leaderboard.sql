-- Fase 4: ranking da turma.
-- Cada aluno só enxerga o próprio progresso (RLS), então o ranking é uma função
-- SECURITY DEFINER que devolve apenas dados mínimos e anonimizados:
-- posição, nome abreviado ("Maria S."), XP total e quantidade de exercícios resolvidos.
-- Nunca devolve e-mail nem identificador de outros usuários.

create function public.leaderboard(lim integer default 20)
returns table (pos bigint, display_name text, total_xp bigint, solved bigint, is_me boolean)
language sql
stable
security definer
set search_path = ''
as $$
  with scores as (
    select
      p.id,
      case
        when position(' ' in trim(p.name)) > 0 then
          split_part(trim(p.name), ' ', 1) || ' ' ||
          upper(left((regexp_split_to_array(trim(p.name), '\s+'))[array_length(regexp_split_to_array(trim(p.name), '\s+'), 1)], 1)) || '.'
        else trim(p.name)
      end as display_name,
      coalesce(sum(ep.xp) filter (where ep.solved), 0)::bigint as total_xp,
      (count(*) filter (where ep.solved))::bigint as solved
    from public.profiles p
    left join public.exercise_progress ep on ep.user_id = p.id
    where p.role = 'aluno'
    group by p.id, p.name
  ),
  ranked as (
    select s.*, rank() over (order by s.total_xp desc) as pos
    from scores s
    where s.solved > 0 or s.id = (select auth.uid())
  )
  select r.pos, r.display_name, r.total_xp, r.solved, (r.id = (select auth.uid())) as is_me
  from ranked r
  where r.pos <= greatest(least(lim, 100), 1) or r.id = (select auth.uid())
  order by r.pos, r.display_name;
$$;

revoke all on function public.leaderboard(integer) from public, anon;
grant execute on function public.leaderboard(integer) to authenticated;
