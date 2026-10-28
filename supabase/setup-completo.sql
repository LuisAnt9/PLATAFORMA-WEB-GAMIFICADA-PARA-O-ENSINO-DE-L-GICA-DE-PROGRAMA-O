-- GERADO por "npm run db:bundle" a partir de supabase/migrations. Não edite à mão.
-- Cria o banco inteiro do zero num projeto Supabase NOVO (cole tudo no SQL Editor e clique em Run).
-- Não rode num projeto que já tenha as tabelas: use apenas as migrations que faltam.

-- ============================================================
-- 0001_init.sql
-- ============================================================

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

-- ============================================================
-- 0002_leaderboard.sql
-- ============================================================

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

-- ============================================================
-- 0003_teacher_classes.sql
-- ============================================================

-- Fase 5 (etapa A): catálogo de exercícios no banco, turmas e acesso do professor por turma.
-- Execute no SQL Editor do Supabase DEPOIS de 0001 e 0002.
--
-- Mudança de privacidade: o professor deixa de ver TODOS os alunos e passa a ver apenas
-- os alunos que entraram em uma turma dele.

------------------------------------------------------------------------
-- Catálogo: módulos e exercícios
------------------------------------------------------------------------
create table public.modules (
  id       text primary key check (id ~ '^[a-z0-9-]{1,40}$'),
  title    text not null check (char_length(title) between 1 and 80),
  focus    text not null default '' check (char_length(focus) <= 200),
  position integer not null default 0
);

create table public.exercises (
  id            text primary key check (id ~ '^[a-z0-9-]{1,60}$'),
  module_id     text not null references public.modules (id),
  title         text not null check (char_length(title) between 1 and 100),
  difficulty    text not null check (difficulty in ('facil', 'medio', 'dificil')),
  statement     text not null check (char_length(statement) between 1 and 2000),
  function_name text not null check (function_name ~ '^[A-Za-z_$][A-Za-z0-9_$]{0,39}$'),
  starter_code  text not null check (char_length(starter_code) <= 4000),
  tests         jsonb not null check (jsonb_typeof(tests) = 'array' and jsonb_array_length(tests) between 1 and 30),
  hint          text not null default '' check (char_length(hint) <= 500),
  position      integer not null default 0,
  published     boolean not null default true,
  created_by    uuid references public.profiles (id) on delete set null,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

create index exercises_module_idx on public.exercises (module_id, position);

alter table public.modules enable row level security;
alter table public.exercises enable row level security;

create function public.touch_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

create trigger exercises_touch before update on public.exercises
  for each row execute function public.touch_updated_at();

-- Exercícios são despublicados (published = false) em vez de apagados, para não perder o histórico dos alunos.
-- Observação: os casos de teste ficam legíveis pelos alunos, pois a correção roda no navegador.
create policy "módulos: todos leem" on public.modules for select to authenticated using (true);
create policy "módulos: professor cria" on public.modules for insert to authenticated with check (public.is_professor());
create policy "módulos: professor edita" on public.modules for update to authenticated
  using (public.is_professor()) with check (public.is_professor());

create policy "exercícios: alunos leem os publicados; professor lê todos" on public.exercises
  for select to authenticated using (published or public.is_professor());
create policy "exercícios: professor cria" on public.exercises for insert to authenticated
  with check (public.is_professor() and created_by = (select auth.uid()));
create policy "exercícios: professor edita" on public.exercises for update to authenticated
  using (public.is_professor()) with check (public.is_professor());

grant select, insert, update on public.modules, public.exercises to authenticated;

-- Dados iniciais: módulos e exercícios que antes ficavam no código.
insert into public.modules (id, title, focus, position) values
  ($q$fundamentos$q$, $q$Fundamentos$q$, $q$Traduzir um problema em passos e operações$q$, 1),
  ($q$condicionais$q$, $q$Condicionais$q$, $q$Tomar decisões no fluxo do algoritmo$q$, 2),
  ($q$repeticao$q$, $q$Estruturas de repetição$q$, $q$Compreender o passo a passo de um laço$q$, 3),
  ($q$vetores$q$, $q$Vetores$q$, $q$Manipular coleções de dados$q$, 4);

insert into public.exercises (id, module_id, title, difficulty, statement, function_name, starter_code, tests, hint, position) values
  ($q$soma$q$, $q$fundamentos$q$, $q$Somar dois números$q$, $q$facil$q$, $q$Escreva a função `soma(a, b)` que retorna a soma de dois números.$q$, $q$soma$q$, $q$function soma(a, b) {
  // seu código aqui
}
$q$, $q$[{"args":[2,3],"expected":5},{"args":[-1,1],"expected":0},{"args":[10,25],"expected":35}]$q$::jsonb, $q$Use o operador + e não esqueça do `return`.$q$, 1),
  ($q$media$q$, $q$fundamentos$q$, $q$Média aritmética$q$, $q$facil$q$, $q$Escreva `media(a, b, c)` que retorna a média aritmética de três números.$q$, $q$media$q$, $q$function media(a, b, c) {
  // seu código aqui
}
$q$, $q$[{"args":[3,6,9],"expected":6},{"args":[0,0,0],"expected":0},{"args":[1,2,3],"expected":2}]$q$::jsonb, $q$Some os três valores entre parênteses antes de dividir por 3.$q$, 2),
  ($q$par-ou-impar$q$, $q$condicionais$q$, $q$Par ou ímpar$q$, $q$facil$q$, $q$Escreva `parOuImpar(n)` que retorna a string "par" ou "impar".$q$, $q$parOuImpar$q$, $q$function parOuImpar(n) {
  // seu código aqui
}
$q$, $q$[{"args":[4],"expected":"par"},{"args":[7],"expected":"impar"},{"args":[0],"expected":"par"}]$q$::jsonb, $q$O resto da divisão por 2 (`n % 2`) diz se o número é par.$q$, 3),
  ($q$maior-de-tres$q$, $q$condicionais$q$, $q$Maior de três$q$, $q$medio$q$, $q$Escreva `maiorDeTres(a, b, c)` que retorna o maior dos três números, sem usar `Math.max`.$q$, $q$maiorDeTres$q$, $q$function maiorDeTres(a, b, c) {
  // seu código aqui
}
$q$, $q$[{"args":[1,2,3],"expected":3},{"args":[9,2,3],"expected":9},{"args":[4,8,3],"expected":8},{"args":[-5,-2,-9],"expected":-2}]$q$::jsonb, $q$Guarde o maior valor visto até agora numa variável e compare com cada número.$q$, 4),
  ($q$somatorio$q$, $q$repeticao$q$, $q$Somatório de 1 até n$q$, $q$facil$q$, $q$Escreva `somatorio(n)` que retorna 1 + 2 + ... + n usando um laço. Para n = 0, retorna 0.$q$, $q$somatorio$q$, $q$function somatorio(n) {
  // seu código aqui
}
$q$, $q$[{"args":[5],"expected":15},{"args":[1],"expected":1},{"args":[0],"expected":0},{"args":[100],"expected":5050}]$q$::jsonb, $q$Crie um acumulador começando em 0 e some `i` a cada volta do `for`.$q$, 5),
  ($q$fatorial$q$, $q$repeticao$q$, $q$Fatorial$q$, $q$medio$q$, $q$Escreva `fatorial(n)` que retorna n! (com 0! = 1).$q$, $q$fatorial$q$, $q$function fatorial(n) {
  // seu código aqui
}
$q$, $q$[{"args":[0],"expected":1},{"args":[1],"expected":1},{"args":[5],"expected":120},{"args":[10],"expected":3628800}]$q$::jsonb, $q$Diferente do somatório, o acumulador começa em 1 e é multiplicado.$q$, 6),
  ($q$soma-vetor$q$, $q$vetores$q$, $q$Soma dos elementos$q$, $q$medio$q$, $q$Escreva `somaVetor(v)` que retorna a soma de todos os elementos do vetor `v`.$q$, $q$somaVetor$q$, $q$function somaVetor(v) {
  // seu código aqui
}
$q$, $q$[{"args":[[1,2,3]],"expected":6},{"args":[[]],"expected":0},{"args":[[-2,2,10]],"expected":10}]$q$::jsonb, $q$Percorra o vetor com um laço usando `v.length` e acumule `v[i]`.$q$, 7),
  ($q$inverter-vetor$q$, $q$vetores$q$, $q$Inverter vetor$q$, $q$dificil$q$, $q$Escreva `inverter(v)` que retorna um NOVO vetor com os elementos na ordem inversa, sem usar `reverse`.$q$, $q$inverter$q$, $q$function inverter(v) {
  // seu código aqui
}
$q$, $q$[{"args":[[1,2,3]],"expected":[3,2,1]},{"args":[[]],"expected":[]},{"args":[["a","b"]],"expected":["b","a"]},{"args":[[7]],"expected":[7]}]$q$::jsonb, $q$Percorra o vetor do último índice até o 0 e use `push` num vetor novo.$q$, 8),
  ($q$celsius$q$, $q$fundamentos$q$, $q$Celsius para Fahrenheit$q$, $q$facil$q$, $q$Escreva `celsiusParaFahrenheit(c)` que converte graus Celsius para Fahrenheit (F = C × 9/5 + 32).$q$, $q$celsiusParaFahrenheit$q$, $q$function celsiusParaFahrenheit(c) {
  // seu código aqui
}
$q$, $q$[{"args":[0],"expected":32},{"args":[100],"expected":212},{"args":[-40],"expected":-40},{"args":[10],"expected":50}]$q$::jsonb, $q$Multiplique por 9, divida por 5 e some 32.$q$, 9),
  ($q$area-retangulo$q$, $q$fundamentos$q$, $q$Área do retângulo$q$, $q$facil$q$, $q$Escreva `areaRetangulo(base, altura)` que retorna a área do retângulo.$q$, $q$areaRetangulo$q$, $q$function areaRetangulo(base, altura) {
  // seu código aqui
}
$q$, $q$[{"args":[3,4],"expected":12},{"args":[1,1],"expected":1},{"args":[0,5],"expected":0},{"args":[2.5,4],"expected":10}]$q$::jsonb, $q$A área é base vezes altura.$q$, 10),
  ($q$nota$q$, $q$condicionais$q$, $q$Situação do aluno$q$, $q$medio$q$, $q$Escreva `situacao(nota)` que retorna "aprovado" se nota >= 7, "recuperacao" se nota >= 5, ou "reprovado" caso contrário.$q$, $q$situacao$q$, $q$function situacao(nota) {
  // seu código aqui
}
$q$, $q$[{"args":[10],"expected":"aprovado"},{"args":[7],"expected":"aprovado"},{"args":[6.5],"expected":"recuperacao"},{"args":[5],"expected":"recuperacao"},{"args":[4.9],"expected":"reprovado"}]$q$::jsonb, $q$Teste primeiro a faixa mais alta e use `else if` para as demais.$q$, 11),
  ($q$bissexto$q$, $q$condicionais$q$, $q$Ano bissexto$q$, $q$dificil$q$, $q$Escreva `ehBissexto(ano)` que retorna true se o ano é bissexto: divisível por 4, exceto os divisíveis por 100, a menos que também sejam divisíveis por 400.$q$, $q$ehBissexto$q$, $q$function ehBissexto(ano) {
  // seu código aqui
}
$q$, $q$[{"args":[2024],"expected":true},{"args":[2023],"expected":false},{"args":[1900],"expected":false},{"args":[2000],"expected":true},{"args":[2100],"expected":false}]$q$::jsonb, $q$Combine as três regras com `&&` e `||`, cuidando dos parênteses.$q$, 12),
  ($q$tabuada$q$, $q$repeticao$q$, $q$Tabuada$q$, $q$facil$q$, $q$Escreva `tabuada(n)` que retorna um vetor com n×1, n×2, ..., n×10.$q$, $q$tabuada$q$, $q$function tabuada(n) {
  // seu código aqui
}
$q$, $q$[{"args":[2],"expected":[2,4,6,8,10,12,14,16,18,20]},{"args":[0],"expected":[0,0,0,0,0,0,0,0,0,0]},{"args":[5],"expected":[5,10,15,20,25,30,35,40,45,50]}]$q$::jsonb, $q$Crie um vetor vazio e faça `push(n * i)` para i de 1 a 10.$q$, 13),
  ($q$primo$q$, $q$repeticao$q$, $q$Número primo$q$, $q$dificil$q$, $q$Escreva `ehPrimo(n)` que retorna true se n é primo (maior que 1 e divisível apenas por 1 e por ele mesmo).$q$, $q$ehPrimo$q$, $q$function ehPrimo(n) {
  // seu código aqui
}
$q$, $q$[{"args":[2],"expected":true},{"args":[1],"expected":false},{"args":[0],"expected":false},{"args":[17],"expected":true},{"args":[18],"expected":false},{"args":[97],"expected":true}]$q$::jsonb, $q$Teste os divisores de 2 até n-1; se algum dividir exatamente, não é primo.$q$, 14),
  ($q$maior-vetor$q$, $q$vetores$q$, $q$Maior elemento$q$, $q$medio$q$, $q$Escreva `maiorElemento(v)` que retorna o maior número de um vetor não vazio, sem usar `Math.max`.$q$, $q$maiorElemento$q$, $q$function maiorElemento(v) {
  // seu código aqui
}
$q$, $q$[{"args":[[3,9,2]],"expected":9},{"args":[[-4,-1,-7]],"expected":-1},{"args":[[5]],"expected":5}]$q$::jsonb, $q$Comece com `v[0]` como maior e compare com os demais elementos.$q$, 15),
  ($q$busca-linear$q$, $q$vetores$q$, $q$Busca linear$q$, $q$medio$q$, $q$Escreva `buscar(v, x)` que retorna o índice da primeira ocorrência de x no vetor, ou -1 se não existir. Não use `indexOf`.$q$, $q$buscar$q$, $q$function buscar(v, x) {
  // seu código aqui
}
$q$, $q$[{"args":[[4,8,15],8],"expected":1},{"args":[[4,8,15],99],"expected":-1},{"args":[[],1],"expected":-1},{"args":[[7,7,7],7],"expected":0}]$q$::jsonb, $q$Percorra o vetor e retorne o índice assim que encontrar o valor; só retorne -1 depois do laço.$q$, 16),
  ($q$ordenar$q$, $q$vetores$q$, $q$Ordenar vetor$q$, $q$dificil$q$, $q$Escreva `ordenar(v)` que retorna um NOVO vetor de números em ordem crescente, sem usar `sort`.$q$, $q$ordenar$q$, $q$function ordenar(v) {
  // seu código aqui
}
$q$, $q$[{"args":[[3,1,2]],"expected":[1,2,3]},{"args":[[]],"expected":[]},{"args":[[5,5,1]],"expected":[1,5,5]},{"args":[[-1,-3,2,0]],"expected":[-3,-1,0,2]},{"args":[[1,2,3]],"expected":[1,2,3]}]$q$::jsonb, $q$Uma ideia simples: percorra pares vizinhos e troque os que estão fora de ordem, repetindo até não haver trocas (bubble sort).$q$, 17);

-- O progresso existente só pode apontar para exercícios que existam.
alter table public.exercise_progress
  add constraint exercise_progress_exercise_fk
  foreign key (exercise_id) references public.exercises (id) on delete cascade;

------------------------------------------------------------------------
-- Turmas
------------------------------------------------------------------------
create table public.classes (
  id         uuid primary key default gen_random_uuid(),
  name       text not null check (char_length(name) between 2 and 80),
  code       text not null unique check (code ~ '^[A-HJ-NP-Z2-9]{6}$'),
  teacher_id uuid not null references public.profiles (id) on delete cascade,
  created_at timestamptz not null default now()
);

create table public.class_members (
  class_id   uuid not null references public.classes (id) on delete cascade,
  student_id uuid not null references public.profiles (id) on delete cascade,
  joined_at  timestamptz not null default now(),
  primary key (class_id, student_id)
);

create index class_members_student_idx on public.class_members (student_id);

alter table public.classes enable row level security;
alter table public.class_members enable row level security;

-- Auxiliares das políticas. SECURITY DEFINER evita recursão de RLS entre classes e class_members.
create function public.is_teacher_of_class(cid uuid)
returns boolean language sql stable security definer set search_path = ''
as $$ select exists (select 1 from public.classes where id = cid and teacher_id = (select auth.uid())); $$;

create function public.is_class_member(cid uuid)
returns boolean language sql stable security definer set search_path = ''
as $$ select exists (select 1 from public.class_members where class_id = cid and student_id = (select auth.uid())); $$;

create function public.is_teacher_of_student(sid uuid)
returns boolean language sql stable security definer set search_path = ''
as $$
  select exists (
    select 1 from public.class_members cm
    join public.classes c on c.id = cm.class_id
    where cm.student_id = sid and c.teacher_id = (select auth.uid())
  );
$$;

-- Nenhuma função pública deve ser chamável por visitantes (anon); só pelos logados.
revoke execute on function public.is_professor(), public.is_teacher_of_class(uuid),
  public.is_class_member(uuid), public.is_teacher_of_student(uuid) from public, anon;
grant execute on function public.is_professor(), public.is_teacher_of_class(uuid),
  public.is_class_member(uuid), public.is_teacher_of_student(uuid) to authenticated;
revoke execute on function public.handle_new_user(), public.lock_solved_progress(),
  public.touch_updated_at() from public, anon, authenticated;

create policy "turmas: professor dono ou aluno membro" on public.classes
  for select to authenticated
  using (teacher_id = (select auth.uid()) or public.is_class_member(id));
create policy "turmas: professor dono renomeia" on public.classes
  for update to authenticated
  using (teacher_id = (select auth.uid())) with check (teacher_id = (select auth.uid()));
create policy "turmas: professor dono apaga" on public.classes
  for delete to authenticated using (teacher_id = (select auth.uid()));

create policy "membros: o próprio aluno ou o professor da turma" on public.class_members
  for select to authenticated
  using (student_id = (select auth.uid()) or public.is_teacher_of_class(class_id));
create policy "membros: aluno sai ou professor remove" on public.class_members
  for delete to authenticated
  using (student_id = (select auth.uid()) or public.is_teacher_of_class(class_id));

grant select, delete on public.classes, public.class_members to authenticated;
grant update (name) on public.classes to authenticated;
-- Criar turma e entrar nela só por funções (abaixo): não há política de INSERT.

create function public.create_class(class_name text)
returns table (id uuid, name text, code text)
language plpgsql
security definer
set search_path = ''
as $$
declare
  alphabet constant text := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; -- sem 0/O/1/I
  new_code text;
  tries integer := 0;
begin
  if not public.is_professor() then
    raise exception 'Apenas professores podem criar turmas.';
  end if;
  loop
    new_code := '';
    for i in 1..6 loop
      new_code := new_code || substr(alphabet, 1 + floor(random() * length(alphabet))::int, 1);
    end loop;
    exit when not exists (select 1 from public.classes c where c.code = new_code);
    tries := tries + 1;
    if tries > 20 then raise exception 'Não foi possível gerar um código único.'; end if;
  end loop;
  return query
    insert into public.classes (name, code, teacher_id)
    values (trim(class_name), new_code, (select auth.uid()))
    returning classes.id, classes.name, classes.code;
end;
$$;

create function public.join_class(class_code text)
returns table (id uuid, name text)
language plpgsql
security definer
set search_path = ''
as $$
declare
  found_id uuid;
  found_name text;
begin
  if exists (select 1 from public.profiles p where p.id = (select auth.uid()) and p.role <> 'aluno') then
    raise exception 'Apenas alunos entram em turmas.';
  end if;
  select c.id, c.name into found_id, found_name
  from public.classes c where c.code = upper(trim(class_code));
  if found_id is null then
    raise exception 'Código de turma inválido.';
  end if;
  insert into public.class_members (class_id, student_id)
  values (found_id, (select auth.uid()))
  on conflict do nothing;
  return query select found_id, found_name;
end;
$$;

revoke execute on function public.create_class(text), public.join_class(text) from public, anon;
grant execute on function public.create_class(text), public.join_class(text) to authenticated;

------------------------------------------------------------------------
-- Professor passa a ver apenas os alunos das suas turmas
------------------------------------------------------------------------
drop policy "perfil: ler o próprio ou, sendo professor, todos" on public.profiles;
create policy "perfil: o próprio ou aluno de uma turma sua" on public.profiles
  for select to authenticated
  using (id = (select auth.uid()) or public.is_teacher_of_student(id));

drop policy "progresso: ler o próprio ou, sendo professor, todos" on public.exercise_progress;
create policy "progresso: o próprio ou de aluno de uma turma sua" on public.exercise_progress
  for select to authenticated
  using (user_id = (select auth.uid()) or public.is_teacher_of_student(user_id));

-- ============================================================
-- 0004_streak.sql
-- ============================================================

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

-- ============================================================
-- 0005_exercise_kinds.sql
-- ============================================================

-- Novos tipos de exercício: múltipla escolha ("choice") e completar a lacuna ("blank"),
-- além do tipo original com código ("code"). Também adiciona a mini-explicação "lesson".
-- Execute depois de 0003/0004. O site funciona sem esta migration (só não mostra os tipos novos).
--
-- Observação: assim como os casos de teste, as respostas corretas ficam legíveis pelos alunos,
-- pois a correção acontece no navegador.

alter table public.exercises
  add column kind   text  not null default 'code' check (kind in ('code', 'choice', 'blank')),
  add column config jsonb not null default '{}'::jsonb,
  add column lesson text  check (lesson is null or char_length(lesson) <= 1500);

-- Exercícios sem código não têm função nem testes.
alter table public.exercises alter column function_name drop not null;
alter table public.exercises drop constraint exercises_function_name_check;
alter table public.exercises drop constraint exercises_tests_check;

-- Atenção: um CHECK que resulta em NULL (campo ausente) é aprovado pelo Postgres; por isso o coalesce(..., false).
alter table public.exercises add constraint exercises_kind_fields_check check (
  coalesce(case kind
    when 'code' then
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
  coalesce(case kind
    when 'code' then true
    when 'choice' then
      jsonb_typeof(config -> 'options') = 'array'
      and jsonb_array_length(config -> 'options') between 2 and 6
      and jsonb_typeof(config -> 'correct') = 'number'
      and (config ->> 'correct')::numeric >= 0
      and (config ->> 'correct')::numeric < jsonb_array_length(config -> 'options')
    when 'blank' then
      jsonb_typeof(config -> 'template') = 'string'
      and char_length(config ->> 'template') between 1 and 2000
      and jsonb_typeof(config -> 'blanks') = 'array'
      and jsonb_array_length(config -> 'blanks') between 1 and 10
  end, false)
);

------------------------------------------------------------------------
-- Exercícios de exemplo (módulo novo, antes de "Fundamentos")
------------------------------------------------------------------------
insert into public.modules (id, title, focus, position) values
  ($q$primeiros-passos$q$, $q$Primeiros passos$q$, $q$Entender o que é um algoritmo e como o computador segue instruções$q$, 0);

insert into public.exercises
  (id, module_id, kind, title, difficulty, statement, lesson, function_name, starter_code, tests, config, hint, position)
values
  ($q$o-que-e-algoritmo$q$, $q$primeiros-passos$q$, 'choice', $q$O que é um algoritmo?$q$, 'facil',
   $q$Escolha a alternativa que melhor define um algoritmo.$q$,
   $q$Um algoritmo é uma sequência finita de passos para resolver um problema, como uma receita de bolo: cada passo é claro e acontece numa ordem definida. Programar é escrever esses passos de um jeito que o computador consiga executar.$q$,
   null, '', '[]'::jsonb,
   $q${"options":["Uma linguagem de programação","Uma sequência de passos para resolver um problema","Um tipo de computador","Um erro no programa"],"correct":1,"explanation":"Isso mesmo: um algoritmo é o passo a passo. A linguagem de programação é só a forma de escrevê-lo para o computador."}$q$::jsonb,
   $q$Pense numa receita de bolo.$q$, 1),

  ($q$ordem-das-instrucoes$q$, $q$primeiros-passos$q$, 'choice', $q$A ordem importa$q$, 'facil',
   $q$Qual é a ordem correta dos passos para calcular a média de dois números?$q$,
   $q$O computador executa as instruções uma de cada vez, de cima para baixo. Trocar a ordem dos passos muda o resultado, ou até impede de chegar a um.$q$,
   null, '', '[]'::jsonb,
   $q${"options":["Dividir por 2, somar os números, mostrar o resultado","Somar os números, dividir por 2, mostrar o resultado","Mostrar o resultado, somar os números, dividir por 2","Dividir por 2, mostrar o resultado, somar os números"],"correct":1,"explanation":"Primeiro é preciso somar, depois dividir a soma por 2 e só então mostrar o resultado."}$q$::jsonb,
   $q$Você só pode mostrar o resultado depois de calculá-lo.$q$, 2),

  ($q$valor-da-variavel$q$, $q$primeiros-passos$q$, 'choice', $q$Qual é o valor final?$q$, 'facil',
   $q$Considere as instruções abaixo, executadas em ordem:

x = 4
x = x + 3

Qual é o valor final de x?$q$,
   $q$Uma variável é um nome que guarda um valor. Quando escrevemos x = x + 3, o computador primeiro calcula o lado direito (o valor atual de x mais 3) e depois guarda o resultado de volta em x.$q$,
   null, '', '[]'::jsonb,
   $q${"options":["4","3","7","43"],"correct":2,"explanation":"x começa valendo 4. Na segunda linha, x passa a valer 4 + 3 = 7."}$q$::jsonb,
   $q$Execute uma linha de cada vez.$q$, 3),

  ($q$completar-condicional$q$, $q$primeiros-passos$q$, 'blank', $q$Complete a condicional$q$, 'facil',
   $q$Complete as lacunas para que a função devolva "maior" para quem tem 18 anos ou mais e "menor" nos demais casos.$q$,
   $q$Uma condicional faz o programa escolher um caminho. Usamos "if" (se) para o caso em que a condição é verdadeira e "else" (senão) para todos os outros casos.$q$,
   null, '', '[]'::jsonb,
   $q${"template":"function classifica(idade) {\n  {{1}} (idade >= 18) {\n    return \"maior\";\n  } {{2}} {\n    return \"menor\";\n  }\n}","blanks":[{"answers":["if"]},{"answers":["else"]}],"explanation":"A primeira lacuna é o \"if\" (se a idade for 18 ou mais) e a segunda é o \"else\" (caso contrário)."}$q$::jsonb,
   $q$Em inglês: "se" e "senão".$q$, 4),

  ($q$completar-laco$q$, $q$primeiros-passos$q$, 'blank', $q$Complete o laço$q$, 'medio',
   $q$Complete as lacunas para somar os números de 1 até 5 na variável soma.$q$,
   $q$Um laço "for" repete um bloco de instruções. Ele tem três partes: onde começa (let i = 1), até quando continua (i <= 5) e como muda a cada volta (por exemplo, i++ aumenta i em 1).$q$,
   null, '', '[]'::jsonb,
   $q${"template":"let soma = 0;\nfor (let i = 1; i <= 5; i{{1}}) {\n  soma {{2}} i;\n}","blanks":[{"answers":["++","+= 1","+=1"]},{"answers":["+=","= soma +"]}],"explanation":"O i++ aumenta i de 1 em 1 a cada volta, e soma += i acumula cada valor de i na variável soma."}$q$::jsonb,
   $q$i++ aumenta i em 1. Para acumular, use +=.$q$, 5);

-- ============================================================
-- 0006_exercicios_extras.sql
-- ============================================================

-- Conteúdo extra para o piloto: 31 exercícios novos e 2 módulos ("Funções" e "Textos").
-- Execute depois de 0005.
--
-- TODOS entram como RASCUNHO (published = false): os alunos só os veem depois que o professor
-- revisar e publicar em Professor > Exercícios. As respostas dos de código estão em
-- docs/gabarito-exercicios-extras.md (cole a solução no editor, clique em "Validar testes" e publique).

insert into public.modules (id, title, focus, position) values
  ($q$funcoes$q$, $q$Funções$q$, $q$Dividir um problema em partes reutilizáveis$q$, 5),
  ($q$textos$q$, $q$Textos$q$, $q$Percorrer e transformar sequências de caracteres$q$, 6);

insert into public.exercises
  (id, module_id, kind, title, difficulty, statement, lesson, function_name, starter_code, tests, config, hint, position, published)
values
  ($q$tipos-de-dados$q$, $q$primeiros-passos$q$, $q$choice$q$, $q$Qual é o tipo do valor?$q$, $q$facil$q$, $q$Em JavaScript, qual é o tipo do valor "42" (escrito entre aspas)?$q$, $q$Todo valor tem um tipo: número (3 ou 2.5), texto ("olá") ou lógico (true ou false). O tipo define o que podemos fazer com o valor.$q$, null, '', '[]'::jsonb, $q${"options":["Número","Texto (string)","Lógico (boolean)","Vetor"],"correct":1,"explanation":"As aspas fazem de \"42\" um texto. Sem aspas, 42 seria um número."}$q$::jsonb, $q$Repare nas aspas.$q$, 101, false),
  ($q$precedencia-operadores$q$, $q$primeiros-passos$q$, $q$choice$q$, $q$Quem calcula primeiro?$q$, $q$facil$q$, $q$Qual é o resultado de 2 + 3 * 4?$q$, $q$Como na matemática, multiplicação e divisão são calculadas antes de soma e subtração. Parênteses mudam a ordem.$q$, null, '', '[]'::jsonb, $q${"options":["20","14","24","10"],"correct":1,"explanation":"A multiplicação vem primeiro: 3 * 4 = 12, e depois 2 + 12 = 14. Com parênteses, (2 + 3) * 4 daria 20."}$q$::jsonb, $q$Faça a multiplicação antes da soma.$q$, 102, false),
  ($q$resto-da-divisao$q$, $q$primeiros-passos$q$, $q$choice$q$, $q$Resto da divisão$q$, $q$facil$q$, $q$Quanto vale 17 % 5?$q$, $q$O operador % devolve o resto da divisão inteira. Por exemplo, 7 % 3 vale 1, porque 7 = 2 * 3 + 1. Um número é par quando n % 2 vale 0.$q$, null, '', '[]'::jsonb, $q${"options":["3","2","12","3,4"],"correct":1,"explanation":"17 = 3 * 5 + 2, então o resto é 2."}$q$::jsonb, $q$Quantas vezes o 5 cabe no 17? O que sobra?$q$, 103, false),
  ($q$quadrado$q$, $q$fundamentos$q$, 'code', $q$Quadrado de um número$q$, $q$facil$q$, $q$Escreva `quadrado(n)` que retorna n multiplicado por ele mesmo.$q$, null, $q$quadrado$q$, $q$function quadrado(n) {
  // seu código aqui
}
$q$, $q$[{"args":[2],"expected":4},{"args":[0],"expected":0},{"args":[-3],"expected":9},{"args":[1.5],"expected":2.25}]$q$::jsonb, '{}'::jsonb, $q$Use o operador * com n duas vezes.$q$, 101, false),
  ($q$media-ponderada$q$, $q$fundamentos$q$, 'code', $q$Média ponderada$q$, $q$medio$q$, $q$Escreva `mediaPonderada(a, b)` que calcula a média em que a nota `a` tem peso 3 e a nota `b` tem peso 7 (some os pesos: 3 + 7 = 10).$q$, null, $q$mediaPonderada$q$, $q$function mediaPonderada(a, b) {
  // seu código aqui
}
$q$, $q$[{"args":[10,10],"expected":10},{"args":[0,10],"expected":7},{"args":[10,0],"expected":3},{"args":[5,5],"expected":5},{"args":[6,8],"expected":7.4},{"args":[9,4],"expected":5.5}]$q$::jsonb, '{}'::jsonb, $q$Multiplique cada nota pelo peso, some e divida por 10.$q$, 102, false),
  ($q$completar-media$q$, $q$fundamentos$q$, $q$blank$q$, $q$Complete o cálculo da média$q$, $q$facil$q$, $q$Complete as lacunas para que a função retorne a média de dois números.$q$, $q$Os operadores aritméticos são + (soma), - (subtração), * (multiplicação) e / (divisão). Parênteses garantem que a soma aconteça antes da divisão.$q$, null, '', '[]'::jsonb, $q${"template":"function media(a, b) {\n  return (a {{1}} b) {{2}} 2;\n}","blanks":[{"answers":["+"]},{"answers":["/"]}],"explanation":"Primeiro somamos os dois valores e depois dividimos a soma por 2."}$q$::jsonb, $q$Média = soma dividida pela quantidade.$q$, 103, false),
  ($q$operadores-logicos$q$, $q$condicionais$q$, $q$choice$q$, $q$E, OU e NÃO$q$, $q$facil$q$, $q$Se idade = 20 e temCarteira = false, quanto vale a expressão (idade >= 18 && temCarteira)?$q$, $q$&& (E) só é verdadeiro quando as duas condições são verdadeiras. || (OU) é verdadeiro se pelo menos uma for. ! (NÃO) inverte o valor lógico.$q$, null, '', '[]'::jsonb, $q${"options":["true","false","20","dá erro"],"correct":1,"explanation":"idade >= 18 é true, mas temCarteira é false. Com &&, as duas precisam ser verdadeiras, então o resultado é false."}$q$::jsonb, $q$Com && (E), uma condição falsa já basta para o resultado ser falso.$q$, 101, false),
  ($q$completar-else-if$q$, $q$condicionais$q$, $q$blank$q$, $q$Complete a classificação$q$, $q$medio$q$, $q$Complete as lacunas para classificar a nota em A (9 ou mais), B (7 ou mais) ou C (as demais).$q$, $q$Quando há mais de dois caminhos, encadeamos condições com "else if" (senão, se). O "else" final trata todos os casos que sobraram.$q$, null, '', '[]'::jsonb, $q${"template":"function conceito(nota) {\n  if (nota >= 9) {\n    return \"A\";\n  } {{1}} (nota >= 7) {\n    return \"B\";\n  } {{2}} {\n    return \"C\";\n  }\n}","blanks":[{"answers":["else if"]},{"answers":["else"]}],"explanation":"Depois do primeiro \"if\", usamos \"else if\" para a segunda condição e \"else\" para o que sobrou."}$q$::jsonb, $q$Em inglês: "senão, se" e "senão".$q$, 102, false),
  ($q$dentro-do-intervalo$q$, $q$condicionais$q$, 'code', $q$Dentro do intervalo$q$, $q$facil$q$, $q$Escreva `dentroDoIntervalo(n, min, max)` que retorna true se n está entre min e max (incluindo os extremos) e false caso contrário.$q$, null, $q$dentroDoIntervalo$q$, $q$function dentroDoIntervalo(n, min, max) {
  // seu código aqui
}
$q$, $q$[{"args":[5,1,10],"expected":true},{"args":[1,1,10],"expected":true},{"args":[10,1,10],"expected":true},{"args":[0,1,10],"expected":false},{"args":[11,1,10],"expected":false}]$q$::jsonb, '{}'::jsonb, $q$Combine duas comparações com && (E).$q$, 103, false),
  ($q$tipo-de-triangulo$q$, $q$condicionais$q$, 'code', $q$Tipo de triângulo$q$, $q$medio$q$, $q$Escreva `tipoTriangulo(a, b, c)` que recebe os três lados e retorna "equilatero" (três lados iguais), "isosceles" (exatamente dois iguais) ou "escaleno" (todos diferentes).$q$, null, $q$tipoTriangulo$q$, $q$function tipoTriangulo(a, b, c) {
  // seu código aqui
}
$q$, $q$[{"args":[3,3,3],"expected":"equilatero"},{"args":[3,3,4],"expected":"isosceles"},{"args":[3,4,3],"expected":"isosceles"},{"args":[4,3,3],"expected":"isosceles"},{"args":[3,4,5],"expected":"escaleno"}]$q$::jsonb, '{}'::jsonb, $q$Teste primeiro o caso mais específico (os três iguais).$q$, 104, false),
  ($q$quantas-vezes$q$, $q$repeticao$q$, $q$choice$q$, $q$Quantas vezes o laço executa?$q$, $q$facil$q$, $q$for (let i = 0; i < 4; i++) {
  // bloco
}

Quantas vezes o bloco executa?$q$, $q$Um laço for tem três partes: onde começa (let i = 0), até quando continua (i < 4) e como muda a cada volta (i++). O bloco executa enquanto a condição for verdadeira.$q$, null, '', '[]'::jsonb, $q${"options":["3","4","5","Infinitas vezes"],"correct":1,"explanation":"i vale 0, 1, 2 e 3, ou seja, 4 voltas. Quando i chega a 4, a condição i < 4 deixa de ser verdadeira."}$q$::jsonb, $q$Liste os valores de i, um por volta.$q$, 101, false),
  ($q$completar-while$q$, $q$repeticao$q$, $q$blank$q$, $q$Complete o while$q$, $q$medio$q$, $q$Complete as lacunas para calcular 5! (5 × 4 × 3 × 2 × 1) em fatorial.$q$, $q$O laço "while" (enquanto) repete o bloco enquanto a condição for verdadeira. É preciso mudar alguma variável dentro do laço, senão ele nunca termina.$q$, null, '', '[]'::jsonb, $q${"template":"let n = 5;\nlet fatorial = 1;\n{{1}} (n > 1) {\n  fatorial = fatorial * n;\n  n{{2}};\n}","blanks":[{"answers":["while"]},{"answers":["--","-= 1","-=1"]}],"explanation":"O while repete enquanto n > 1, e n-- diminui n em 1 a cada volta, até a condição ficar falsa."}$q$::jsonb, $q$Em inglês: "enquanto". Para diminuir 1, existe um operador parecido com o ++.$q$, 102, false),
  ($q$soma-dos-pares$q$, $q$repeticao$q$, 'code', $q$Soma dos números pares$q$, $q$medio$q$, $q$Escreva `somaPares(n)` que retorna a soma de todos os números pares de 1 até n (incluindo n, se for par). Para n menor que 2, o resultado é 0.$q$, null, $q$somaPares$q$, $q$function somaPares(n) {
  // seu código aqui
}
$q$, $q$[{"args":[10],"expected":30},{"args":[1],"expected":0},{"args":[0],"expected":0},{"args":[7],"expected":12},{"args":[2],"expected":2}]$q$::jsonb, '{}'::jsonb, $q$Percorra os números e some só os que têm resto 0 na divisão por 2.$q$, 103, false),
  ($q$potencia$q$, $q$repeticao$q$, 'code', $q$Potência$q$, $q$medio$q$, $q$Escreva `potencia(base, exp)` que retorna base elevada a exp (um inteiro maior ou igual a 0), usando um laço. Não use `Math.pow` nem o operador `**`.$q$, null, $q$potencia$q$, $q$function potencia(base, exp) {
  // seu código aqui
}
$q$, $q$[{"args":[2,3],"expected":8},{"args":[5,0],"expected":1},{"args":[3,1],"expected":3},{"args":[10,4],"expected":10000},{"args":[0,5],"expected":0}]$q$::jsonb, '{}'::jsonb, $q$Comece o resultado em 1 e multiplique pela base, exp vezes.$q$, 104, false),
  ($q$conta-digitos$q$, $q$repeticao$q$, 'code', $q$Quantos dígitos?$q$, $q$medio$q$, $q$Escreva `contaDigitos(n)` que retorna quantos dígitos tem o inteiro n (maior ou igual a 0), sem converter para texto. O número 0 tem 1 dígito.$q$, null, $q$contaDigitos$q$, $q$function contaDigitos(n) {
  // seu código aqui
}
$q$, $q$[{"args":[0],"expected":1},{"args":[7],"expected":1},{"args":[10],"expected":2},{"args":[12345],"expected":5},{"args":[100],"expected":3}]$q$::jsonb, '{}'::jsonb, $q$Divida por 10 (parte inteira) até sobrar um dígito, contando as divisões.$q$, 105, false),
  ($q$mdc$q$, $q$repeticao$q$, 'code', $q$Máximo divisor comum$q$, $q$dificil$q$, $q$Escreva `mdc(a, b)` que retorna o maior número que divide a e b ao mesmo tempo (a e b inteiros positivos). Dica: o algoritmo de Euclides troca (a, b) por (b, a % b) até o resto ser 0.$q$, null, $q$mdc$q$, $q$function mdc(a, b) {
  // seu código aqui
}
$q$, $q$[{"args":[12,18],"expected":6},{"args":[7,13],"expected":1},{"args":[100,25],"expected":25},{"args":[48,36],"expected":12},{"args":[17,17],"expected":17}]$q$::jsonb, '{}'::jsonb, $q$Repita enquanto b for diferente de 0; quando b chegar a 0, a resposta é a.$q$, 106, false),
  ($q$indice-do-vetor$q$, $q$vetores$q$, $q$choice$q$, $q$O primeiro elemento$q$, $q$facil$q$, $q$Em let v = [10, 20, 30, 40], quanto vale v[2]?$q$, $q$Um vetor guarda vários valores numa só variável. Cada posição tem um índice, e a contagem começa em 0: v[0] é o primeiro elemento, v[1] o segundo, e assim por diante.$q$, null, '', '[]'::jsonb, $q${"options":["20","30","40","10"],"correct":1,"explanation":"Os índices são v[0] = 10, v[1] = 20, v[2] = 30 e v[3] = 40."}$q$::jsonb, $q$Lembre-se: o primeiro índice é 0.$q$, 101, false),
  ($q$completar-percorrer$q$, $q$vetores$q$, $q$blank$q$, $q$Percorrer o vetor$q$, $q$facil$q$, $q$Complete as lacunas para somar todos os elementos do vetor v.$q$, $q$Para percorrer um vetor, usamos um índice i que vai de 0 até o último elemento. O tamanho do vetor é v.length, e o elemento da posição i é v[i].$q$, null, '', '[]'::jsonb, $q${"template":"let soma = 0;\nfor (let i = 0; i < v{{1}}; i++) {\n  soma += v{{2}};\n}","blanks":[{"answers":[".length"]},{"answers":["[i]"]}],"explanation":"O laço vai de 0 até v.length - 1, e a cada volta somamos o elemento da posição i, que é v[i]."}$q$::jsonb, $q$O tamanho é uma propriedade do vetor; o elemento usa colchetes.$q$, 102, false),
  ($q$conta-pares$q$, $q$vetores$q$, 'code', $q$Quantos pares?$q$, $q$facil$q$, $q$Escreva `contaPares(v)` que retorna quantos elementos pares existem no vetor de inteiros `v`.$q$, null, $q$contaPares$q$, $q$function contaPares(v) {
  // seu código aqui
}
$q$, $q$[{"args":[[1,2,3,4]],"expected":2},{"args":[[]],"expected":0},{"args":[[1,3,5]],"expected":0},{"args":[[2,4,6,8]],"expected":4},{"args":[[0]],"expected":1}]$q$::jsonb, '{}'::jsonb, $q$Percorra o vetor e some 1 a um contador sempre que o elemento for par.$q$, 103, false),
  ($q$media-do-vetor$q$, $q$vetores$q$, 'code', $q$Média do vetor$q$, $q$medio$q$, $q$Escreva `mediaVetor(v)` que retorna a média dos números do vetor `v`, que tem pelo menos um elemento.$q$, null, $q$mediaVetor$q$, $q$function mediaVetor(v) {
  // seu código aqui
}
$q$, $q$[{"args":[[1,2,3]],"expected":2},{"args":[[10]],"expected":10},{"args":[[1,2]],"expected":1.5},{"args":[[0,0,6]],"expected":2},{"args":[[-2,2]],"expected":0}]$q$::jsonb, '{}'::jsonb, $q$Some tudo e divida pela quantidade de elementos.$q$, 104, false),
  ($q$segundo-maior$q$, $q$vetores$q$, 'code', $q$Segundo maior valor$q$, $q$dificil$q$, $q$Escreva `segundoMaior(v)` que retorna o segundo maior valor DISTINTO do vetor `v` (que tem pelo menos dois valores diferentes). Por exemplo, em [10, 9, 10, 8] o segundo maior é 9.$q$, null, $q$segundoMaior$q$, $q$function segundoMaior(v) {
  // seu código aqui
}
$q$, $q$[{"args":[[3,1,2]],"expected":2},{"args":[[5,5,4]],"expected":4},{"args":[[1,2]],"expected":1},{"args":[[10,9,10,8]],"expected":9},{"args":[[-1,-5,-3]],"expected":-3}]$q$::jsonb, '{}'::jsonb, $q$Guarde o maior e o segundo maior vistos até agora, atualizando os dois a cada elemento.$q$, 105, false),
  ($q$parametro-e-retorno$q$, $q$funcoes$q$, $q$choice$q$, $q$Parâmetro e retorno$q$, $q$facil$q$, $q$Na função abaixo, o que é n?

function dobro(n) {
  return n * 2;
}$q$, $q$Uma função recebe valores de entrada, chamados parâmetros, e pode devolver um resultado com return. Assim, o mesmo código pode ser reutilizado com valores diferentes.$q$, null, '', '[]'::jsonb, $q${"options":["O resultado da função","Um parâmetro: o valor de entrada","O nome da função","Um erro"],"correct":1,"explanation":"n é o parâmetro: o valor que a função recebe. O resultado é o que ela devolve com return."}$q$::jsonb, $q$Fica entre parênteses, depois do nome.$q$, 101, false),
  ($q$completar-funcao$q$, $q$funcoes$q$, $q$blank$q$, $q$Complete a função$q$, $q$facil$q$, $q$Complete as lacunas para definir uma função que devolve a área de um retângulo.$q$, $q$Uma função é declarada com a palavra "function", seguida do nome e dos parâmetros entre parênteses. Para devolver o resultado, usamos "return".$q$, null, '', '[]'::jsonb, $q${"template":"{{1}} area(base, altura) {\n  {{2}} base * altura;\n}","blanks":[{"answers":["function"]},{"answers":["return"]}],"explanation":"\"function\" declara a função e \"return\" devolve o resultado para quem a chamou."}$q$::jsonb, $q$Em inglês: "função" e "retornar".$q$, 102, false),
  ($q$escopo-de-variavel$q$, $q$funcoes$q$, $q$choice$q$, $q$Onde a variável existe?$q$, $q$medio$q$, $q$O que acontece ao executar o código abaixo?

function f() {
  let x = 5;
}
f();
console.log(x);$q$, $q$Uma variável criada dentro de uma função só existe ali dentro. Esse limite se chama escopo: fora da função, o nome não é conhecido.$q$, null, '', '[]'::jsonb, $q${"options":["Mostra 5","Dá erro: x não existe fora da função","Mostra undefined","Mostra 0"],"correct":1,"explanation":"x foi criada dentro de f, então só existe ali. Fora da função, usar x causa um erro (ReferenceError)."}$q$::jsonb, $q$Onde a variável x foi declarada?$q$, 103, false),
  ($q$maior-de-dois$q$, $q$funcoes$q$, 'code', $q$Maior de dois$q$, $q$facil$q$, $q$Escreva `maiorDeDois(a, b)` que retorna o maior entre os dois números.$q$, $q$Uma função pode escolher entre valores e devolver só um deles. Cada caminho do if pode ter o seu próprio return.$q$, $q$maiorDeDois$q$, $q$function maiorDeDois(a, b) {
  // seu código aqui
}
$q$, $q$[{"args":[1,2],"expected":2},{"args":[5,3],"expected":5},{"args":[4,4],"expected":4},{"args":[-1,-2],"expected":-1},{"args":[0,-7],"expected":0}]$q$::jsonb, '{}'::jsonb, $q$Compare os dois com um if e retorne o maior.$q$, 104, false),
  ($q$hipotenusa$q$, $q$funcoes$q$, 'code', $q$Hipotenusa$q$, $q$medio$q$, $q$Escreva `hipotenusa(a, b)` que retorna o comprimento da hipotenusa de um triângulo retângulo com catetos a e b (teorema de Pitágoras). Você pode usar `Math.sqrt`.$q$, $q$Math.sqrt(x) devolve a raiz quadrada de x. Funções prontas como essa podem ser usadas dentro das suas.$q$, $q$hipotenusa$q$, $q$function hipotenusa(a, b) {
  // seu código aqui
}
$q$, $q$[{"args":[3,4],"expected":5},{"args":[5,12],"expected":13},{"args":[0,0],"expected":0},{"args":[8,15],"expected":17},{"args":[1,1],"expected":1.4142135623730951}]$q$::jsonb, '{}'::jsonb, $q$A hipotenusa é a raiz quadrada de a² + b².$q$, 105, false),
  ($q$tamanho-do-texto$q$, $q$textos$q$, $q$choice$q$, $q$Letras e índices$q$, $q$facil$q$, $q$Em let s = "lógica";, quanto vale s.length?$q$, $q$Um texto é uma sequência de caracteres, e cada um tem um índice começando em 0, como num vetor: "abc"[0] é "a". O tamanho do texto vem de .length.$q$, null, '', '[]'::jsonb, $q${"options":["5","6","7","4"],"correct":1,"explanation":"\"lógica\" tem 6 letras (l, ó, g, i, c, a), então s.length vale 6."}$q$::jsonb, $q$Conte as letras uma a uma.$q$, 101, false),
  ($q$completar-texto$q$, $q$textos$q$, $q$blank$q$, $q$Complete as consultas ao texto$q$, $q$facil$q$, $q$Complete as lacunas para obter o tamanho do texto e a sua primeira letra.$q$, $q$Todo texto tem a propriedade .length (quantos caracteres) e permite acessar uma letra pelo índice entre colchetes, como s[0] para a primeira.$q$, null, '', '[]'::jsonb, $q${"template":"let nome = \"Ana\";\nlet tamanho = nome{{1}};\nlet primeira = nome{{2}};","blanks":[{"answers":[".length"]},{"answers":["[0]",".charAt(0)"]}],"explanation":"nome.length dá o tamanho (3) e nome[0] dá a primeira letra (\"A\")."}$q$::jsonb, $q$A primeira posição tem índice 0.$q$, 102, false),
  ($q$inverter-texto$q$, $q$textos$q$, 'code', $q$Inverter um texto$q$, $q$medio$q$, $q$Escreva `inverterTexto(s)` que retorna o texto `s` de trás para frente. Por exemplo, "abc" vira "cba".$q$, $q$Os textos podem ser percorridos como vetores, usando s[i], e concatenados com +.$q$, $q$inverterTexto$q$, $q$function inverterTexto(s) {
  // seu código aqui
}
$q$, $q$[{"args":["abc"],"expected":"cba"},{"args":[""],"expected":""},{"args":["a"],"expected":"a"},{"args":["lógica"],"expected":"acigól"},{"args":["ab ba"],"expected":"ab ba"}]$q$::jsonb, '{}'::jsonb, $q$Percorra do último índice até o 0, juntando as letras num novo texto.$q$, 103, false),
  ($q$conta-vogais$q$, $q$textos$q$, 'code', $q$Contar vogais$q$, $q$medio$q$, $q$Escreva `contaVogais(s)` que retorna quantas vogais (a, e, i, o, u) há no texto `s`. Os textos de teste têm só letras minúsculas e sem acentos.$q$, null, $q$contaVogais$q$, $q$function contaVogais(s) {
  // seu código aqui
}
$q$, $q$[{"args":["banana"],"expected":3},{"args":[""],"expected":0},{"args":["xyz"],"expected":0},{"args":["aeiou"],"expected":5},{"args":["programacao"],"expected":5},{"args":["logica"],"expected":3}]$q$::jsonb, '{}'::jsonb, $q$Percorra as letras e use "aeiou".includes(letra) para testar cada uma.$q$, 104, false),
  ($q$palindromo$q$, $q$textos$q$, 'code', $q$Palíndromo$q$, $q$dificil$q$, $q$Escreva `ehPalindromo(s)` que retorna true se o texto `s` é igual quando lido de trás para frente (por exemplo, "arara"). Os testes usam só letras minúsculas, sem espaços. O texto vazio é um palíndromo.$q$, null, $q$ehPalindromo$q$, $q$function ehPalindromo(s) {
  // seu código aqui
}
$q$, $q$[{"args":["arara"],"expected":true},{"args":["casa"],"expected":false},{"args":["a"],"expected":true},{"args":[""],"expected":true},{"args":["radar"],"expected":true},{"args":["abca"],"expected":false}]$q$::jsonb, '{}'::jsonb, $q$Compare a primeira letra com a última, a segunda com a penúltima, e assim por diante.$q$, 105, false);

-- ============================================================
-- 0007_ping.sql
-- ============================================================

-- Função mínima que só devolve 1. Serve para a rotina diária do GitHub (.github/workflows/keep-alive.yml)
-- dar um "toque" real no banco e evitar que o plano gratuito do Supabase pause o projeto por inatividade.
-- Pode ser chamada sem login e não lê nem altera dado nenhum.

create function public.ping()
returns integer
language sql
stable
as $$ select 1; $$;

revoke execute on function public.ping() from public;
grant execute on function public.ping() to anon, authenticated;

-- ============================================================
-- 0008_ai_hints.sql
-- ============================================================

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
