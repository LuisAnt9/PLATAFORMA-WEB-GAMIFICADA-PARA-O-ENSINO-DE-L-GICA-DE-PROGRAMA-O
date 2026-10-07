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
