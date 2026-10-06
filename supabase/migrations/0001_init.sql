-- Fase 3: perfis e progresso dos alunos.
-- Execute no painel do Supabase: SQL Editor > New query > cole este arquivo > Run.
-- O projeto foi criado com "expor novas tabelas" desligado, por isso os GRANTs são explícitos.

------------------------------------------------------------------------
-- Perfis
------------------------------------------------------------------------
create table public.profiles (
  id         uuid primary key references auth.users (id) on delete cascade,
  name       text not null check (char_length(name) between 2 and 80),
  role       text not null default 'aluno' check (role in ('aluno', 'professor')),
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

-- Todo cadastro novo vira "aluno". Professores são promovidos manualmente (ver README),
-- para que ninguém consiga se declarar professor pelo navegador.
create function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.profiles (id, name)
  values (
    new.id,
    coalesce(nullif(trim(new.raw_user_meta_data ->> 'name'), ''), split_part(new.email, '@', 1))
  );
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Função auxiliar usada nas políticas (evita recursão de RLS em profiles).
create function public.is_professor()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (select 1 from public.profiles where id = (select auth.uid()) and role = 'professor');
$$;

create policy "perfil: ler o próprio ou, sendo professor, todos"
  on public.profiles for select to authenticated
  using (id = (select auth.uid()) or public.is_professor());

create policy "perfil: editar o próprio"
  on public.profiles for update to authenticated
  using (id = (select auth.uid()))
  with check (id = (select auth.uid()));

grant select on public.profiles to authenticated;
-- Só o nome é editável pelo usuário; "role" nunca.
grant update (name) on public.profiles to authenticated;

------------------------------------------------------------------------
-- Progresso por exercício
------------------------------------------------------------------------
create table public.exercise_progress (
  user_id     uuid not null references public.profiles (id) on delete cascade,
  exercise_id text not null check (char_length(exercise_id) between 1 and 80),
  attempts    integer not null default 0 check (attempts >= 0),
  solved      boolean not null default false,
  first_try   boolean not null default false,
  xp          integer not null default 0 check (xp between 0 and 100),
  solved_at   timestamptz,
  updated_at  timestamptz not null default now(),
  primary key (user_id, exercise_id)
);

create index exercise_progress_exercise_idx on public.exercise_progress (exercise_id);

alter table public.exercise_progress enable row level security;

create policy "progresso: ler o próprio ou, sendo professor, todos"
  on public.exercise_progress for select to authenticated
  using (user_id = (select auth.uid()) or public.is_professor());

create policy "progresso: criar o próprio"
  on public.exercise_progress for insert to authenticated
  with check (user_id = (select auth.uid()));

create policy "progresso: atualizar o próprio"
  on public.exercise_progress for update to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

grant select, insert, update on public.exercise_progress to authenticated;

-- Um exercício resolvido não pode ser "des-resolvido" nem ter o XP alterado depois.
create function public.lock_solved_progress()
returns trigger
language plpgsql
as $$
begin
  if old.solved then
    new.solved := old.solved;
    new.first_try := old.first_try;
    new.xp := old.xp;
    new.attempts := old.attempts;
    new.solved_at := old.solved_at;
  end if;
  new.updated_at := now();
  return new;
end;
$$;

create trigger lock_solved_progress
  before update on public.exercise_progress
  for each row execute function public.lock_solved_progress();
