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
