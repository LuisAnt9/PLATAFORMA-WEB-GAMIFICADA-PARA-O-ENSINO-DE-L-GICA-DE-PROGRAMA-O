-- Sequência diária (streak): um registro por aluno e por dia em que ele praticou.
-- Execute depois de 0003. O site funciona sem esta migration (apenas esconde a sequência).

create table public.daily_activity (
  user_id  uuid not null references public.profiles (id) on delete cascade,
  day      date not null,
  attempts integer not null default 0 check (attempts >= 0),
  solved   integer not null default 0 check (solved >= 0),
  primary key (user_id, day)
);

alter table public.daily_activity enable row level security;

-- O aluno lê o próprio histórico; o professor lê o dos alunos das suas turmas.
create policy "atividade: o próprio ou aluno de uma turma sua" on public.daily_activity
  for select to authenticated
  using (user_id = (select auth.uid()) or public.is_teacher_of_student(user_id));

-- Sem INSERT/UPDATE direto: a escrita acontece só pela função abaixo.
grant select on public.daily_activity to authenticated;

-- Registra uma tentativa do dia. O dia vem do navegador (fuso local do aluno), mas só aceitamos
-- uma janela de ±1 dia em torno da data do servidor, para impedir datas inventadas.
create function public.log_activity(p_day date, p_solved boolean default false)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  if (select auth.uid()) is null then
    raise exception 'Não autenticado.';
  end if;
  if p_day < current_date - 1 or p_day > current_date + 1 then
    raise exception 'Data inválida.';
  end if;
  insert into public.daily_activity (user_id, day, attempts, solved)
  values ((select auth.uid()), p_day, 1, case when p_solved then 1 else 0 end)
  on conflict (user_id, day) do update
    set attempts = public.daily_activity.attempts + 1,
        solved   = public.daily_activity.solved + case when p_solved then 1 else 0 end;
end;
$$;

revoke execute on function public.log_activity(date, boolean) from public, anon;
grant execute on function public.log_activity(date, boolean) to authenticated;
