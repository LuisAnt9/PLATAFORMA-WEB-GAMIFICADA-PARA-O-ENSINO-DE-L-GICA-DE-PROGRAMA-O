-- Dicas com IA (Gemini): registro de uso, usado também como cota diária por aluno.
-- A chave do Gemini fica só no servidor (Vercel); o banco só controla o limite e guarda o histórico.
-- O site funciona sem esta migration (o botão de dica com IA apenas avisa que está indisponível).

create table public.ai_hints (
  id          bigint generated always as identity primary key,
  user_id     uuid not null references public.profiles (id) on delete cascade,
  exercise_id text not null references public.exercises (id) on delete cascade,
  day         date not null default current_date,
  created_at  timestamptz not null default now()
);

create index ai_hints_user_day_idx on public.ai_hints (user_id, day);

alter table public.ai_hints enable row level security;

-- O aluno vê o próprio uso; o professor vê o dos alunos das suas turmas (para a avaliação do TCC).
create policy "dicas: o próprio ou aluno de uma turma sua" on public.ai_hints
  for select to authenticated
  using (user_id = (select auth.uid()) or public.is_teacher_of_student(user_id));

grant select on public.ai_hints to authenticated;

-- Reserva uma dica do dia. Devolve o id do registro e quantas ainda restam; falha se passou do limite.
create function public.use_ai_hint(p_exercise text, p_limit integer default 10)
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
  -- trava por aluno para duas chamadas simultâneas não furarem o limite
  perform pg_advisory_xact_lock(hashtextextended(uid::text, 0));
  select count(*) into used from public.ai_hints where user_id = uid and day = current_date;
  if used >= p_limit then
    raise exception 'LIMITE_DIARIO';
  end if;
  insert into public.ai_hints (user_id, exercise_id) values (uid, p_exercise) returning id into new_id;
  return query select new_id, p_limit - used - 1;
end;
$$;

-- Devolve a dica ao aluno quando o Gemini falha (só apaga registro do próprio aluno, de hoje).
create function public.refund_ai_hint(p_id bigint)
returns void
language sql
security definer
set search_path = ''
as $$
  delete from public.ai_hints
  where id = p_id and user_id = (select auth.uid()) and day = current_date;
$$;

revoke execute on function public.use_ai_hint(text, integer) from public, anon;
revoke execute on function public.refund_ai_hint(bigint) from public, anon;
grant execute on function public.use_ai_hint(text, integer) to authenticated;
grant execute on function public.refund_ai_hint(bigint) to authenticated;
