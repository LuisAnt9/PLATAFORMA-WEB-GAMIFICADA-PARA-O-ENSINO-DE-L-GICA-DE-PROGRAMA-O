-- GERADO por "npm run content:build" a partir de content/. Não edite à mão.
-- Importa mundos, conceitos, lições e exercícios. Pode ser executado várias vezes (idempotente).
-- Requer as migrations até a 0012. Não altera "published" nem "position" de exercícios que já existem
-- e não toca em lições/exercícios que o professor editou no painel (origem = 'painel').

insert into public.worlds (id, title, objective, position) values
  ($c$mundo-1$c$, $c$Introdução à Lógica de Programação$c$, $c$Fazer o aluno compreender o que é programação e como organizar instruções para resolver problemas.$c$, 1),
  ($c$mundo-2$c$, $c$Variáveis e Tipos de Dados$c$, $c$Ensinar o aluno a armazenar, identificar e manipular informações.$c$, 2),
  ($c$mundo-3$c$, $c$Operadores$c$, $c$Ensinar o aluno a realizar operações matemáticas e comparações utilizando operadores.$c$, 3),
  ($c$mundo-4$c$, $c$Estruturas Condicionais$c$, $c$Ensinar o aluno a criar programas que tomam decisões de acordo com determinadas condições.$c$, 4),
  ($c$mundo-5$c$, $c$Estruturas de Repetição$c$, $c$Ensinar o aluno a automatizar tarefas repetitivas e compreender o funcionamento dos laços de repetição.$c$, 5),
  ($c$mundo-6$c$, $c$Vetores e Matrizes$c$, $c$Ensinar o aluno a armazenar e organizar vários valores em uma única estrutura.$c$, 6),
  ($c$mundo-7$c$, $c$Funções e Modularização$c$, $c$Ensinar o aluno a organizar programas em partes menores, reutilizar códigos e estruturar soluções.$c$, 7)
on conflict (id) do update set title = excluded.title, objective = excluded.objective, position = excluded.position;

insert into public.concepts (id, title, description, world_id, position) values
  ($c$m1-programacao$c$, $c$O que é programação?$c$, $c$$c$, $c$mundo-1$c$, 1),
  ($c$m1-logica$c$, $c$O que é lógica de programação?$c$, $c$$c$, $c$mundo-1$c$, 2),
  ($c$m1-algoritmos$c$, $c$O que são algoritmos?$c$, $c$$c$, $c$mundo-1$c$, 3),
  ($c$m1-sequencia$c$, $c$Sequência lógica$c$, $c$$c$, $c$mundo-1$c$, 4),
  ($c$m1-entrada-processamento-saida$c$, $c$Entrada, processamento e saída$c$, $c$$c$, $c$mundo-1$c$, 5),
  ($c$m1-pseudocodigo$c$, $c$Pseudocódigo$c$, $c$$c$, $c$mundo-1$c$, 6),
  ($c$m1-fluxogramas$c$, $c$Fluxogramas$c$, $c$$c$, $c$mundo-1$c$, 7),
  ($c$m2-introducao-variaveis$c$, $c$Introdução às variáveis$c$, $c$$c$, $c$mundo-2$c$, 1),
  ($c$m2-declaracao$c$, $c$Declaração de variáveis$c$, $c$$c$, $c$mundo-2$c$, 2),
  ($c$m2-let-const$c$, $c$Utilização de let e const$c$, $c$$c$, $c$mundo-2$c$, 3),
  ($c$m2-string$c$, $c$Tipo String$c$, $c$$c$, $c$mundo-2$c$, 4),
  ($c$m2-number$c$, $c$Tipo Number$c$, $c$$c$, $c$mundo-2$c$, 5),
  ($c$m2-boolean$c$, $c$Tipo Boolean$c$, $c$$c$, $c$mundo-2$c$, 6),
  ($c$m2-manipulacao-textos$c$, $c$Manipulação de textos$c$, $c$$c$, $c$mundo-2$c$, 7),
  ($c$m2-concatenacao$c$, $c$Concatenação$c$, $c$$c$, $c$mundo-2$c$, 8),
  ($c$m2-template-literals$c$, $c$Template literals$c$, $c$$c$, $c$mundo-2$c$, 9),
  ($c$m2-operacoes-numeros$c$, $c$Operações com números$c$, $c$$c$, $c$mundo-2$c$, 10),
  ($c$m2-conversao-tipos$c$, $c$Conversão de tipos$c$, $c$$c$, $c$mundo-2$c$, 11),
  ($c$m2-entrada-saida$c$, $c$Entrada e saída de informações$c$, $c$$c$, $c$mundo-2$c$, 12),
  ($c$m2-console-log$c$, $c$Utilização de console.log()$c$, $c$$c$, $c$mundo-2$c$, 13),
  ($c$m3-introducao-operadores$c$, $c$Introdução aos operadores$c$, $c$$c$, $c$mundo-3$c$, 1),
  ($c$m3-aritmeticos$c$, $c$Operadores aritméticos$c$, $c$$c$, $c$mundo-3$c$, 2),
  ($c$m3-atribuicao$c$, $c$Operadores de atribuição$c$, $c$$c$, $c$mundo-3$c$, 3),
  ($c$m3-relacionais$c$, $c$Operadores relacionais$c$, $c$$c$, $c$mundo-3$c$, 4),
  ($c$m3-logicos$c$, $c$Operadores lógicos$c$, $c$$c$, $c$mundo-3$c$, 5),
  ($c$m3-precedencia$c$, $c$Precedência dos operadores$c$, $c$$c$, $c$mundo-3$c$, 6),
  ($c$m4-introducao$c$, $c$Introdução às estruturas condicionais$c$, $c$$c$, $c$mundo-4$c$, 1),
  ($c$m4-revisao-relacionais$c$, $c$Revisão dos operadores relacionais$c$, $c$$c$, $c$mundo-4$c$, 2),
  ($c$m4-revisao-logicos$c$, $c$Revisão dos operadores lógicos$c$, $c$$c$, $c$mundo-4$c$, 3),
  ($c$m4-if$c$, $c$Estrutura if$c$, $c$$c$, $c$mundo-4$c$, 4),
  ($c$m4-if-else$c$, $c$Estrutura if/else$c$, $c$$c$, $c$mundo-4$c$, 5),
  ($c$m4-else-if$c$, $c$Estrutura else if$c$, $c$$c$, $c$mundo-4$c$, 6),
  ($c$m4-aninhadas$c$, $c$Condicionais aninhadas$c$, $c$$c$, $c$mundo-4$c$, 7),
  ($c$m4-switch$c$, $c$Estrutura switch$c$, $c$$c$, $c$mundo-4$c$, 8),
  ($c$m4-ternario$c$, $c$Operador ternário (conteúdo complementar)$c$, $c$$c$, $c$mundo-4$c$, 9),
  ($c$m5-introducao$c$, $c$Introdução às estruturas de repetição$c$, $c$$c$, $c$mundo-5$c$, 1),
  ($c$m5-for$c$, $c$Estrutura for$c$, $c$$c$, $c$mundo-5$c$, 2),
  ($c$m5-while$c$, $c$Estrutura while$c$, $c$$c$, $c$mundo-5$c$, 3),
  ($c$m5-do-while$c$, $c$Estrutura do...while$c$, $c$$c$, $c$mundo-5$c$, 4),
  ($c$m5-contadores$c$, $c$Contadores$c$, $c$$c$, $c$mundo-5$c$, 5),
  ($c$m5-acumuladores$c$, $c$Acumuladores$c$, $c$$c$, $c$mundo-5$c$, 6),
  ($c$m5-break$c$, $c$Comando break$c$, $c$$c$, $c$mundo-5$c$, 7),
  ($c$m5-continue$c$, $c$Comando continue$c$, $c$$c$, $c$mundo-5$c$, 8),
  ($c$m5-aninhados$c$, $c$Laços de repetição aninhados$c$, $c$$c$, $c$mundo-5$c$, 9),
  ($c$m6-introducao-vetores$c$, $c$Introdução aos vetores$c$, $c$$c$, $c$mundo-6$c$, 1),
  ($c$m6-arrays$c$, $c$Arrays em JavaScript$c$, $c$$c$, $c$mundo-6$c$, 2),
  ($c$m6-indices$c$, $c$Índices e posições$c$, $c$$c$, $c$mundo-6$c$, 3),
  ($c$m6-length$c$, $c$Propriedade length$c$, $c$$c$, $c$mundo-6$c$, 4),
  ($c$m6-push$c$, $c$Inserção de elementos com push()$c$, $c$$c$, $c$mundo-6$c$, 5),
  ($c$m6-pop$c$, $c$Remoção de elementos com pop()$c$, $c$$c$, $c$mundo-6$c$, 6),
  ($c$m6-shift-unshift$c$, $c$Utilização de shift() e unshift()$c$, $c$$c$, $c$mundo-6$c$, 7),
  ($c$m6-percorrer-for$c$, $c$Percorrer arrays com for$c$, $c$$c$, $c$mundo-6$c$, 8),
  ($c$m6-percorrer-while$c$, $c$Percorrer arrays com while$c$, $c$$c$, $c$mundo-6$c$, 9),
  ($c$m6-introducao-matrizes$c$, $c$Introdução às matrizes$c$, $c$$c$, $c$mundo-6$c$, 10),
  ($c$m6-bidimensionais$c$, $c$Arrays bidimensionais$c$, $c$$c$, $c$mundo-6$c$, 11),
  ($c$m6-percorrer-matrizes$c$, $c$Percorrer matrizes com laços aninhados$c$, $c$$c$, $c$mundo-6$c$, 12),
  ($c$m7-introducao$c$, $c$Introdução às funções$c$, $c$$c$, $c$mundo-7$c$, 1),
  ($c$m7-declaracao$c$, $c$Declaração de funções$c$, $c$$c$, $c$mundo-7$c$, 2),
  ($c$m7-chamada$c$, $c$Chamada de funções$c$, $c$$c$, $c$mundo-7$c$, 3),
  ($c$m7-parametros$c$, $c$Parâmetros$c$, $c$$c$, $c$mundo-7$c$, 4),
  ($c$m7-argumentos$c$, $c$Argumentos$c$, $c$$c$, $c$mundo-7$c$, 5),
  ($c$m7-return$c$, $c$Retorno com return$c$, $c$$c$, $c$mundo-7$c$, 6),
  ($c$m7-parametros-retorno$c$, $c$Funções com parâmetros e retornos$c$, $c$$c$, $c$mundo-7$c$, 7),
  ($c$m7-escopo-global$c$, $c$Escopo global$c$, $c$$c$, $c$mundo-7$c$, 8),
  ($c$m7-escopo-local$c$, $c$Escopo local$c$, $c$$c$, $c$mundo-7$c$, 9),
  ($c$m7-arrow$c$, $c$Arrow functions (conteúdo complementar)$c$, $c$$c$, $c$mundo-7$c$, 10)
on conflict (id) do update set title = excluded.title, description = excluded.description,
  world_id = excluded.world_id, position = excluded.position;

insert into public.modules (id, title, focus, intro, example, review, world_id, position, origem) values
  ($c$primeiros-passos$c$, $c$Primeiros passos$c$, $c$Entender o que é um algoritmo e como o computador segue instruções$c$, $c$Um algoritmo é uma sequência de passos para resolver um problema, como uma receita de bolo. O computador só faz o que mandamos, na ordem em que mandamos, e por isso cada passo precisa ser claro.

Neste módulo você vai conhecer o vocabulário básico: valores, tipos (número, texto, lógico) e operadores. Não se preocupe em decorar: errar faz parte, e cada exercício explica a resposta.$c$, $c$$c$, $c$$c$, $c$mundo-1$c$, 0, $c$arquivo$c$),
  ($c$exemplos-dos-tipos$c$, $c$Exemplos dos tipos de exercício$c$, $c$Modelos para o professor copiar (rascunhos)$c$, $c$Esta lição reúne um exemplo de cada tipo novo de exercício, como modelo para escrever os seus. Todos estão como rascunho: só o professor os vê.$c$, $c$$c$, $c$$c$, $c$mundo-1$c$, 99, $c$arquivo$c$),
  ($c$textos$c$, $c$Textos$c$, $c$Percorrer e transformar sequências de caracteres$c$, $c$Um texto (string) é uma sequência de caracteres entre aspas. Cada caractere tem uma posição, começando em 0:

const palavra = "casa";
palavra[0] // "c"
palavra.length // 4

Dá para percorrer um texto com um laço, como num vetor. Lembre que maiúsculas e minúsculas são caracteres diferentes: "A" não é igual a "a".$c$, $c$$c$, $c$$c$, $c$mundo-2$c$, 6, $c$arquivo$c$),
  ($c$fundamentos$c$, $c$Fundamentos$c$, $c$Traduzir um problema em passos e operações$c$, $c$Uma função recebe valores (parâmetros), faz um cálculo e devolve um resultado com return. Por exemplo:

function dobro(n) {
  return n * 2;
}

dobro(4) devolve 8. Nos exercícios você escreve funções assim: leia o enunciado, pense no passo a passo e só então escreva o código. Use os testes como guia: eles mostram o que a função deveria devolver.$c$, $c$$c$, $c$$c$, $c$mundo-3$c$, 1, $c$arquivo$c$),
  ($c$condicionais$c$, $c$Condicionais$c$, $c$Tomar decisões no fluxo do algoritmo$c$, $c$Condicionais fazem o programa escolher um caminho. A estrutura básica é:

if (idade >= 18) {
  return "maior";
} else {
  return "menor";
}

A condição entre parênteses vale verdadeiro ou falso. Operadores úteis: ===, !==, >, <, >=, <=, e && (e) e || (ou). Dica: teste os casos de borda, como o valor exatamente igual ao limite.$c$, $c$$c$, $c$$c$, $c$mundo-4$c$, 2, $c$arquivo$c$),
  ($c$repeticao$c$, $c$Estruturas de repetição$c$, $c$Compreender o passo a passo de um laço$c$, $c$Um laço repete um bloco de código. O mais comum é o for:

for (let i = 1; i <= 5; i++) {
  total = total + i;
}

Ele tem três partes: início (let i = 1), condição para continuar (i <= 5) e passo (i++). Para entender um laço, acompanhe a tabela de valores a cada volta: quanto valem i e total? Cuidado com laços que nunca terminam.$c$, $c$$c$, $c$$c$, $c$mundo-5$c$, 3, $c$arquivo$c$),
  ($c$vetores$c$, $c$Vetores$c$, $c$Manipular coleções de dados$c$, $c$Um vetor (array) guarda vários valores numa lista ordenada:

const notas = [7, 9, 5];

A primeira posição é a 0: notas[0] vale 7. notas.length diz quantos itens existem. Para percorrer o vetor use um laço de i = 0 até i < notas.length. Muitos problemas de vetores são "percorra e acumule": somar, contar, achar o maior.$c$, $c$$c$, $c$$c$, $c$mundo-6$c$, 4, $c$arquivo$c$),
  ($c$funcoes$c$, $c$Funções$c$, $c$Dividir um problema em partes reutilizáveis$c$, $c$Quando um trecho de código se repete, vale transformá-lo numa função e reutilizá-la. Uma função boa faz uma coisa só e tem um nome que diz o que ela faz.

function ehPar(n) {
  return n % 2 === 0;
}

Uma função pode chamar outras funções: assim você divide um problema grande em partes pequenas que dá para testar separadamente.$c$, $c$$c$, $c$$c$, $c$mundo-7$c$, 5, $c$arquivo$c$)
on conflict (id) do update set title = excluded.title, focus = excluded.focus, intro = excluded.intro,
  example = excluded.example, review = excluded.review, world_id = excluded.world_id, position = excluded.position
  where public.modules.origem = 'arquivo';

insert into public.exercises
  (id, module_id, kind, title, difficulty, statement, lesson, function_name, starter_code, tests, config, hint, position, published, origem)
values
  ($c$o-que-e-algoritmo$c$, $c$primeiros-passos$c$, $c$choice$c$, $c$O que é um algoritmo?$c$, $c$facil$c$, $c$Escolha a alternativa que melhor define um algoritmo.$c$, $c$Um algoritmo é uma sequência finita de passos para resolver um problema, como uma receita de bolo: cada passo é claro e acontece numa ordem definida. Programar é escrever esses passos de um jeito que o computador consiga executar.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["Uma linguagem de programação","Uma sequência de passos para resolver um problema","Um tipo de computador","Um erro no programa"],"correct":1,"explanation":"Isso mesmo: um algoritmo é o passo a passo. A linguagem de programação é só a forma de escrevê-lo para o computador."}$c$::jsonb, $c$Pense numa receita de bolo.$c$, 1, true, $c$arquivo$c$),
  ($c$ordem-das-instrucoes$c$, $c$primeiros-passos$c$, $c$choice$c$, $c$A ordem importa$c$, $c$facil$c$, $c$Qual é a ordem correta dos passos para calcular a média de dois números?$c$, $c$O computador executa as instruções uma de cada vez, de cima para baixo. Trocar a ordem dos passos muda o resultado, ou até impede de chegar a um.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["Dividir por 2, somar os números, mostrar o resultado","Somar os números, dividir por 2, mostrar o resultado","Mostrar o resultado, somar os números, dividir por 2","Dividir por 2, mostrar o resultado, somar os números"],"correct":1,"explanation":"Primeiro é preciso somar, depois dividir a soma por 2 e só então mostrar o resultado."}$c$::jsonb, $c$Você só pode mostrar o resultado depois de calculá-lo.$c$, 2, true, $c$arquivo$c$),
  ($c$valor-da-variavel$c$, $c$primeiros-passos$c$, $c$choice$c$, $c$Qual é o valor final?$c$, $c$facil$c$, $c$Considere as instruções abaixo, executadas em ordem:

x = 4
x = x + 3

Qual é o valor final de x?$c$, $c$Uma variável é um nome que guarda um valor. Quando escrevemos x = x + 3, o computador primeiro calcula o lado direito (o valor atual de x mais 3) e depois guarda o resultado de volta em x.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["4","3","7","43"],"correct":2,"explanation":"x começa valendo 4. Na segunda linha, x passa a valer 4 + 3 = 7."}$c$::jsonb, $c$Execute uma linha de cada vez.$c$, 3, true, $c$arquivo$c$),
  ($c$completar-condicional$c$, $c$primeiros-passos$c$, $c$blank$c$, $c$Complete a condicional$c$, $c$facil$c$, $c$Complete as lacunas para que a função devolva "maior" para quem tem 18 anos ou mais e "menor" nos demais casos.$c$, $c$Uma condicional faz o programa escolher um caminho. Usamos "if" (se) para o caso em que a condição é verdadeira e "else" (senão) para todos os outros casos.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"function classifica(idade) {\n  {{1}} (idade >= 18) {\n    return \"maior\";\n  } {{2}} {\n    return \"menor\";\n  }\n}","blanks":[{"answers":["if"]},{"answers":["else"]}],"explanation":"A primeira lacuna é o \"if\" (se a idade for 18 ou mais) e a segunda é o \"else\" (caso contrário)."}$c$::jsonb, $c$Em inglês: "se" e "senão".$c$, 4, true, $c$arquivo$c$),
  ($c$completar-laco$c$, $c$primeiros-passos$c$, $c$blank$c$, $c$Complete o laço$c$, $c$medio$c$, $c$Complete as lacunas para somar os números de 1 até 5 na variável soma.$c$, $c$Um laço "for" repete um bloco de instruções. Ele tem três partes: onde começa (let i = 1), até quando continua (i <= 5) e como muda a cada volta (por exemplo, i++ aumenta i em 1).$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"let soma = 0;\nfor (let i = 1; i <= 5; i{{1}}) {\n  soma {{2}} i;\n}","blanks":[{"answers":["++","+= 1","+=1"]},{"answers":["+=","= soma +"]}],"explanation":"O i++ aumenta i de 1 em 1 a cada volta, e soma += i acumula cada valor de i na variável soma."}$c$::jsonb, $c$i++ aumenta i em 1. Para acumular, use +=.$c$, 5, true, $c$arquivo$c$),
  ($c$tipos-de-dados$c$, $c$primeiros-passos$c$, $c$choice$c$, $c$Qual é o tipo do valor?$c$, $c$facil$c$, $c$Em JavaScript, qual é o tipo do valor "42" (escrito entre aspas)?$c$, $c$Todo valor tem um tipo: número (3 ou 2.5), texto ("olá") ou lógico (true ou false). O tipo define o que podemos fazer com o valor.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["Número","Texto (string)","Lógico (boolean)","Vetor"],"correct":1,"explanation":"As aspas fazem de \"42\" um texto. Sem aspas, 42 seria um número."}$c$::jsonb, $c$Repare nas aspas.$c$, 101, false, $c$arquivo$c$),
  ($c$precedencia-operadores$c$, $c$primeiros-passos$c$, $c$choice$c$, $c$Quem calcula primeiro?$c$, $c$facil$c$, $c$Qual é o resultado de 2 + 3 * 4?$c$, $c$Como na matemática, multiplicação e divisão são calculadas antes de soma e subtração. Parênteses mudam a ordem.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["20","14","24","10"],"correct":1,"explanation":"A multiplicação vem primeiro: 3 * 4 = 12, e depois 2 + 12 = 14. Com parênteses, (2 + 3) * 4 daria 20."}$c$::jsonb, $c$Faça a multiplicação antes da soma.$c$, 102, false, $c$arquivo$c$),
  ($c$resto-da-divisao$c$, $c$primeiros-passos$c$, $c$choice$c$, $c$Resto da divisão$c$, $c$facil$c$, $c$Quanto vale 17 % 5?$c$, $c$O operador % devolve o resto da divisão inteira. Por exemplo, 7 % 3 vale 1, porque 7 = 2 * 3 + 1. Um número é par quando n % 2 vale 0.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["3","2","12","3,4"],"correct":1,"explanation":"17 = 3 * 5 + 2, então o resto é 2."}$c$::jsonb, $c$Quantas vezes o 5 cabe no 17? O que sobra?$c$, 103, false, $c$arquivo$c$),
  ($c$exemplo-interpretacao$c$, $c$exemplos-dos-tipos$c$, $c$interpretation$c$, $c$Qual valor será impresso?$c$, $c$facil$c$, $c$Leia o código com atenção. Qual valor aparece na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"4","misconception":"ignora a linha que muda o valor da variável"},{"text":"3","misconception":"acha que x = x + 3 guarda só o 3"},{"text":"7"},{"text":"43","misconception":"confunde soma com junção de textos"}],"correct":2,"code":"let x = 4;\nx = x + 3;\nconsole.log(x);","explanation":"x começa valendo 4; depois x = x + 3 guarda 4 + 3 = 7 na mesma variável."}$c$::jsonb, $c$Acompanhe o valor de x linha por linha.$c$, 1, false, $c$arquivo$c$),
  ($c$exemplo-ordenacao$c$, $c$exemplos-dos-tipos$c$, $c$order$c$, $c$Ordene os passos do café$c$, $c$facil$c$, $c$Coloque os passos para preparar um café na ordem certa.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["Ferver a água","Colocar o pó no filtro","Despejar a água quente no filtro","Servir o café"],"explanation":"Um algoritmo depende da ordem: não dá para despejar a água antes de fervê-la."}$c$::jsonb, $c$Pense no que precisa estar pronto antes de cada passo.$c$, 2, false, $c$arquivo$c$),
  ($c$exemplo-corrigir$c$, $c$exemplos-dos-tipos$c$, $c$fix$c$, $c$Corrija a função dobro$c$, $c$facil$c$, $c$A função `dobro(n)` deveria devolver o dobro de um número, mas tem um defeito. Encontre o erro e corrija.$c$, null, $c$dobro$c$, $c$function dobro(n) {
  return n + 2;
}
$c$, $c$[{"args":[3],"expected":6},{"args":[5],"expected":10},{"args":[0],"expected":0}]$c$::jsonb, $c${}$c$::jsonb, $c$Teste a função com o número 3 e compare com o resultado esperado.$c$, 3, false, $c$arquivo$c$),
  ($c$exemplo-entrada-saida$c$, $c$exemplos-dos-tipos$c$, $c$challenge$c$, $c$Saudação com entrada e saída$c$, $c$medio$c$, $c$Escreva `saudacao()`: leia o nome com `lerEntrada()` e imprima, com `console.log`, a frase `Olá, NOME!`.$c$, null, $c$saudacao$c$, $c$function saudacao() {
  // leia o nome com lerEntrada() e imprima a saudação
}
$c$, $c$[{"args":[],"inputs":["Ana"],"output":["Olá, Ana!"]},{"args":[],"inputs":["Beto"],"output":["Olá, Beto!"]}]$c$::jsonb, $c${}$c$::jsonb, $c$lerEntrada() devolve o próximo valor digitado.$c$, 4, false, $c$arquivo$c$),
  ($c$tamanho-do-texto$c$, $c$textos$c$, $c$choice$c$, $c$Letras e índices$c$, $c$facil$c$, $c$Em let s = "lógica";, quanto vale s.length?$c$, $c$Um texto é uma sequência de caracteres, e cada um tem um índice começando em 0, como num vetor: "abc"[0] é "a". O tamanho do texto vem de .length.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["5","6","7","4"],"correct":1,"explanation":"\"lógica\" tem 6 letras (l, ó, g, i, c, a), então s.length vale 6."}$c$::jsonb, $c$Conte as letras uma a uma.$c$, 101, false, $c$arquivo$c$),
  ($c$completar-texto$c$, $c$textos$c$, $c$blank$c$, $c$Complete as consultas ao texto$c$, $c$facil$c$, $c$Complete as lacunas para obter o tamanho do texto e a sua primeira letra.$c$, $c$Todo texto tem a propriedade .length (quantos caracteres) e permite acessar uma letra pelo índice entre colchetes, como s[0] para a primeira.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"let nome = \"Ana\";\nlet tamanho = nome{{1}};\nlet primeira = nome{{2}};","blanks":[{"answers":[".length"]},{"answers":["[0]",".charAt(0)"]}],"explanation":"nome.length dá o tamanho (3) e nome[0] dá a primeira letra (\"A\")."}$c$::jsonb, $c$A primeira posição tem índice 0.$c$, 102, false, $c$arquivo$c$),
  ($c$inverter-texto$c$, $c$textos$c$, $c$code$c$, $c$Inverter um texto$c$, $c$medio$c$, $c$Escreva `inverterTexto(s)` que retorna o texto `s` de trás para frente. Por exemplo, "abc" vira "cba".$c$, $c$Os textos podem ser percorridos como vetores, usando s[i], e concatenados com +.$c$, $c$inverterTexto$c$, $c$function inverterTexto(s) {
  // seu código aqui
}
$c$, $c$[{"args":["abc"],"expected":"cba"},{"args":[""],"expected":""},{"args":["a"],"expected":"a"},{"args":["lógica"],"expected":"acigól"},{"args":["ab ba"],"expected":"ab ba"}]$c$::jsonb, $c${}$c$::jsonb, $c$Percorra do último índice até o 0, juntando as letras num novo texto.$c$, 103, false, $c$arquivo$c$),
  ($c$conta-vogais$c$, $c$textos$c$, $c$code$c$, $c$Contar vogais$c$, $c$medio$c$, $c$Escreva `contaVogais(s)` que retorna quantas vogais (a, e, i, o, u) há no texto `s`. Os textos de teste têm só letras minúsculas e sem acentos.$c$, null, $c$contaVogais$c$, $c$function contaVogais(s) {
  // seu código aqui
}
$c$, $c$[{"args":["banana"],"expected":3},{"args":[""],"expected":0},{"args":["xyz"],"expected":0},{"args":["aeiou"],"expected":5},{"args":["programacao"],"expected":5},{"args":["logica"],"expected":3}]$c$::jsonb, $c${}$c$::jsonb, $c$Percorra as letras e use "aeiou".includes(letra) para testar cada uma.$c$, 104, false, $c$arquivo$c$),
  ($c$palindromo$c$, $c$textos$c$, $c$code$c$, $c$Palíndromo$c$, $c$dificil$c$, $c$Escreva `ehPalindromo(s)` que retorna true se o texto `s` é igual quando lido de trás para frente (por exemplo, "arara"). Os testes usam só letras minúsculas, sem espaços. O texto vazio é um palíndromo.$c$, null, $c$ehPalindromo$c$, $c$function ehPalindromo(s) {
  // seu código aqui
}
$c$, $c$[{"args":["arara"],"expected":true},{"args":["casa"],"expected":false},{"args":["a"],"expected":true},{"args":[""],"expected":true},{"args":["radar"],"expected":true},{"args":["abca"],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Compare a primeira letra com a última, a segunda com a penúltima, e assim por diante.$c$, 105, false, $c$arquivo$c$),
  ($c$soma$c$, $c$fundamentos$c$, $c$code$c$, $c$Somar dois números$c$, $c$facil$c$, $c$Escreva a função `soma(a, b)` que retorna a soma de dois números.$c$, null, $c$soma$c$, $c$function soma(a, b) {
  // seu código aqui
}
$c$, $c$[{"args":[2,3],"expected":5},{"args":[-1,1],"expected":0},{"args":[10,25],"expected":35}]$c$::jsonb, $c${}$c$::jsonb, $c$Use o operador + e não esqueça do `return`.$c$, 1, true, $c$arquivo$c$),
  ($c$media$c$, $c$fundamentos$c$, $c$code$c$, $c$Média aritmética$c$, $c$facil$c$, $c$Escreva `media(a, b, c)` que retorna a média aritmética de três números.$c$, null, $c$media$c$, $c$function media(a, b, c) {
  // seu código aqui
}
$c$, $c$[{"args":[3,6,9],"expected":6},{"args":[0,0,0],"expected":0},{"args":[1,2,3],"expected":2}]$c$::jsonb, $c${}$c$::jsonb, $c$Some os três valores entre parênteses antes de dividir por 3.$c$, 2, true, $c$arquivo$c$),
  ($c$celsius$c$, $c$fundamentos$c$, $c$code$c$, $c$Celsius para Fahrenheit$c$, $c$facil$c$, $c$Escreva `celsiusParaFahrenheit(c)` que converte graus Celsius para Fahrenheit (F = C × 9/5 + 32).$c$, null, $c$celsiusParaFahrenheit$c$, $c$function celsiusParaFahrenheit(c) {
  // seu código aqui
}
$c$, $c$[{"args":[0],"expected":32},{"args":[100],"expected":212},{"args":[-40],"expected":-40},{"args":[10],"expected":50}]$c$::jsonb, $c${}$c$::jsonb, $c$Multiplique por 9, divida por 5 e some 32.$c$, 9, true, $c$arquivo$c$),
  ($c$area-retangulo$c$, $c$fundamentos$c$, $c$code$c$, $c$Área do retângulo$c$, $c$facil$c$, $c$Escreva `areaRetangulo(base, altura)` que retorna a área do retângulo.$c$, null, $c$areaRetangulo$c$, $c$function areaRetangulo(base, altura) {
  // seu código aqui
}
$c$, $c$[{"args":[3,4],"expected":12},{"args":[1,1],"expected":1},{"args":[0,5],"expected":0},{"args":[2.5,4],"expected":10}]$c$::jsonb, $c${}$c$::jsonb, $c$A área é base vezes altura.$c$, 10, true, $c$arquivo$c$),
  ($c$quadrado$c$, $c$fundamentos$c$, $c$code$c$, $c$Quadrado de um número$c$, $c$facil$c$, $c$Escreva `quadrado(n)` que retorna n multiplicado por ele mesmo.$c$, null, $c$quadrado$c$, $c$function quadrado(n) {
  // seu código aqui
}
$c$, $c$[{"args":[2],"expected":4},{"args":[0],"expected":0},{"args":[-3],"expected":9},{"args":[1.5],"expected":2.25}]$c$::jsonb, $c${}$c$::jsonb, $c$Use o operador * com n duas vezes.$c$, 101, false, $c$arquivo$c$),
  ($c$media-ponderada$c$, $c$fundamentos$c$, $c$code$c$, $c$Média ponderada$c$, $c$medio$c$, $c$Escreva `mediaPonderada(a, b)` que calcula a média em que a nota `a` tem peso 3 e a nota `b` tem peso 7 (some os pesos: 3 + 7 = 10).$c$, null, $c$mediaPonderada$c$, $c$function mediaPonderada(a, b) {
  // seu código aqui
}
$c$, $c$[{"args":[10,10],"expected":10},{"args":[0,10],"expected":7},{"args":[10,0],"expected":3},{"args":[5,5],"expected":5},{"args":[6,8],"expected":7.4},{"args":[9,4],"expected":5.5}]$c$::jsonb, $c${}$c$::jsonb, $c$Multiplique cada nota pelo peso, some e divida por 10.$c$, 102, false, $c$arquivo$c$),
  ($c$completar-media$c$, $c$fundamentos$c$, $c$blank$c$, $c$Complete o cálculo da média$c$, $c$facil$c$, $c$Complete as lacunas para que a função retorne a média de dois números.$c$, $c$Os operadores aritméticos são + (soma), - (subtração), * (multiplicação) e / (divisão). Parênteses garantem que a soma aconteça antes da divisão.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"function media(a, b) {\n  return (a {{1}} b) {{2}} 2;\n}","blanks":[{"answers":["+"]},{"answers":["/"]}],"explanation":"Primeiro somamos os dois valores e depois dividimos a soma por 2."}$c$::jsonb, $c$Média = soma dividida pela quantidade.$c$, 103, false, $c$arquivo$c$),
  ($c$par-ou-impar$c$, $c$condicionais$c$, $c$code$c$, $c$Par ou ímpar$c$, $c$facil$c$, $c$Escreva `parOuImpar(n)` que retorna a string "par" ou "impar".$c$, null, $c$parOuImpar$c$, $c$function parOuImpar(n) {
  // seu código aqui
}
$c$, $c$[{"args":[4],"expected":"par"},{"args":[7],"expected":"impar"},{"args":[0],"expected":"par"}]$c$::jsonb, $c${}$c$::jsonb, $c$O resto da divisão por 2 (`n % 2`) diz se o número é par.$c$, 3, true, $c$arquivo$c$),
  ($c$maior-de-tres$c$, $c$condicionais$c$, $c$code$c$, $c$Maior de três$c$, $c$medio$c$, $c$Escreva `maiorDeTres(a, b, c)` que retorna o maior dos três números, sem usar `Math.max`.$c$, null, $c$maiorDeTres$c$, $c$function maiorDeTres(a, b, c) {
  // seu código aqui
}
$c$, $c$[{"args":[1,2,3],"expected":3},{"args":[9,2,3],"expected":9},{"args":[4,8,3],"expected":8},{"args":[-5,-2,-9],"expected":-2}]$c$::jsonb, $c${}$c$::jsonb, $c$Guarde o maior valor visto até agora numa variável e compare com cada número.$c$, 4, true, $c$arquivo$c$),
  ($c$nota$c$, $c$condicionais$c$, $c$code$c$, $c$Situação do aluno$c$, $c$medio$c$, $c$Escreva `situacao(nota)` que retorna "aprovado" se nota >= 7, "recuperacao" se nota >= 5, ou "reprovado" caso contrário.$c$, null, $c$situacao$c$, $c$function situacao(nota) {
  // seu código aqui
}
$c$, $c$[{"args":[10],"expected":"aprovado"},{"args":[7],"expected":"aprovado"},{"args":[6.5],"expected":"recuperacao"},{"args":[5],"expected":"recuperacao"},{"args":[4.9],"expected":"reprovado"}]$c$::jsonb, $c${}$c$::jsonb, $c$Teste primeiro a faixa mais alta e use `else if` para as demais.$c$, 11, true, $c$arquivo$c$),
  ($c$bissexto$c$, $c$condicionais$c$, $c$code$c$, $c$Ano bissexto$c$, $c$dificil$c$, $c$Escreva `ehBissexto(ano)` que retorna true se o ano é bissexto: divisível por 4, exceto os divisíveis por 100, a menos que também sejam divisíveis por 400.$c$, null, $c$ehBissexto$c$, $c$function ehBissexto(ano) {
  // seu código aqui
}
$c$, $c$[{"args":[2024],"expected":true},{"args":[2023],"expected":false},{"args":[1900],"expected":false},{"args":[2000],"expected":true},{"args":[2100],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Combine as três regras com `&&` e `||`, cuidando dos parênteses.$c$, 12, true, $c$arquivo$c$),
  ($c$operadores-logicos$c$, $c$condicionais$c$, $c$choice$c$, $c$E, OU e NÃO$c$, $c$facil$c$, $c$Se idade = 20 e temCarteira = false, quanto vale a expressão (idade >= 18 && temCarteira)?$c$, $c$&& (E) só é verdadeiro quando as duas condições são verdadeiras. || (OU) é verdadeiro se pelo menos uma for. ! (NÃO) inverte o valor lógico.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["true","false","20","dá erro"],"correct":1,"explanation":"idade >= 18 é true, mas temCarteira é false. Com &&, as duas precisam ser verdadeiras, então o resultado é false."}$c$::jsonb, $c$Com && (E), uma condição falsa já basta para o resultado ser falso.$c$, 101, false, $c$arquivo$c$),
  ($c$completar-else-if$c$, $c$condicionais$c$, $c$blank$c$, $c$Complete a classificação$c$, $c$medio$c$, $c$Complete as lacunas para classificar a nota em A (9 ou mais), B (7 ou mais) ou C (as demais).$c$, $c$Quando há mais de dois caminhos, encadeamos condições com "else if" (senão, se). O "else" final trata todos os casos que sobraram.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"function conceito(nota) {\n  if (nota >= 9) {\n    return \"A\";\n  } {{1}} (nota >= 7) {\n    return \"B\";\n  } {{2}} {\n    return \"C\";\n  }\n}","blanks":[{"answers":["else if"]},{"answers":["else"]}],"explanation":"Depois do primeiro \"if\", usamos \"else if\" para a segunda condição e \"else\" para o que sobrou."}$c$::jsonb, $c$Em inglês: "senão, se" e "senão".$c$, 102, false, $c$arquivo$c$),
  ($c$dentro-do-intervalo$c$, $c$condicionais$c$, $c$code$c$, $c$Dentro do intervalo$c$, $c$facil$c$, $c$Escreva `dentroDoIntervalo(n, min, max)` que retorna true se n está entre min e max (incluindo os extremos) e false caso contrário.$c$, null, $c$dentroDoIntervalo$c$, $c$function dentroDoIntervalo(n, min, max) {
  // seu código aqui
}
$c$, $c$[{"args":[5,1,10],"expected":true},{"args":[1,1,10],"expected":true},{"args":[10,1,10],"expected":true},{"args":[0,1,10],"expected":false},{"args":[11,1,10],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Combine duas comparações com && (E).$c$, 103, false, $c$arquivo$c$),
  ($c$tipo-de-triangulo$c$, $c$condicionais$c$, $c$code$c$, $c$Tipo de triângulo$c$, $c$medio$c$, $c$Escreva `tipoTriangulo(a, b, c)` que recebe os três lados e retorna "equilatero" (três lados iguais), "isosceles" (exatamente dois iguais) ou "escaleno" (todos diferentes).$c$, null, $c$tipoTriangulo$c$, $c$function tipoTriangulo(a, b, c) {
  // seu código aqui
}
$c$, $c$[{"args":[3,3,3],"expected":"equilatero"},{"args":[3,3,4],"expected":"isosceles"},{"args":[3,4,3],"expected":"isosceles"},{"args":[4,3,3],"expected":"isosceles"},{"args":[3,4,5],"expected":"escaleno"}]$c$::jsonb, $c${}$c$::jsonb, $c$Teste primeiro o caso mais específico (os três iguais).$c$, 104, false, $c$arquivo$c$),
  ($c$somatorio$c$, $c$repeticao$c$, $c$code$c$, $c$Somatório de 1 até n$c$, $c$facil$c$, $c$Escreva `somatorio(n)` que retorna 1 + 2 + ... + n usando um laço. Para n = 0, retorna 0.$c$, null, $c$somatorio$c$, $c$function somatorio(n) {
  // seu código aqui
}
$c$, $c$[{"args":[5],"expected":15},{"args":[1],"expected":1},{"args":[0],"expected":0},{"args":[100],"expected":5050}]$c$::jsonb, $c${}$c$::jsonb, $c$Crie um acumulador começando em 0 e some `i` a cada volta do `for`.$c$, 5, true, $c$arquivo$c$),
  ($c$fatorial$c$, $c$repeticao$c$, $c$code$c$, $c$Fatorial$c$, $c$medio$c$, $c$Escreva `fatorial(n)` que retorna n! (com 0! = 1).$c$, null, $c$fatorial$c$, $c$function fatorial(n) {
  // seu código aqui
}
$c$, $c$[{"args":[0],"expected":1},{"args":[1],"expected":1},{"args":[5],"expected":120},{"args":[10],"expected":3628800}]$c$::jsonb, $c${}$c$::jsonb, $c$Diferente do somatório, o acumulador começa em 1 e é multiplicado.$c$, 6, true, $c$arquivo$c$),
  ($c$tabuada$c$, $c$repeticao$c$, $c$code$c$, $c$Tabuada$c$, $c$facil$c$, $c$Escreva `tabuada(n)` que retorna um vetor com n×1, n×2, ..., n×10.$c$, null, $c$tabuada$c$, $c$function tabuada(n) {
  // seu código aqui
}
$c$, $c$[{"args":[2],"expected":[2,4,6,8,10,12,14,16,18,20]},{"args":[0],"expected":[0,0,0,0,0,0,0,0,0,0]},{"args":[5],"expected":[5,10,15,20,25,30,35,40,45,50]}]$c$::jsonb, $c${}$c$::jsonb, $c$Crie um vetor vazio e faça `push(n * i)` para i de 1 a 10.$c$, 13, true, $c$arquivo$c$),
  ($c$primo$c$, $c$repeticao$c$, $c$code$c$, $c$Número primo$c$, $c$dificil$c$, $c$Escreva `ehPrimo(n)` que retorna true se n é primo (maior que 1 e divisível apenas por 1 e por ele mesmo).$c$, null, $c$ehPrimo$c$, $c$function ehPrimo(n) {
  // seu código aqui
}
$c$, $c$[{"args":[2],"expected":true},{"args":[1],"expected":false},{"args":[0],"expected":false},{"args":[17],"expected":true},{"args":[18],"expected":false},{"args":[97],"expected":true}]$c$::jsonb, $c${}$c$::jsonb, $c$Teste os divisores de 2 até n-1; se algum dividir exatamente, não é primo.$c$, 14, true, $c$arquivo$c$),
  ($c$quantas-vezes$c$, $c$repeticao$c$, $c$choice$c$, $c$Quantas vezes o laço executa?$c$, $c$facil$c$, $c$for (let i = 0; i < 4; i++) {
  // bloco
}

Quantas vezes o bloco executa?$c$, $c$Um laço for tem três partes: onde começa (let i = 0), até quando continua (i < 4) e como muda a cada volta (i++). O bloco executa enquanto a condição for verdadeira.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["3","4","5","Infinitas vezes"],"correct":1,"explanation":"i vale 0, 1, 2 e 3, ou seja, 4 voltas. Quando i chega a 4, a condição i < 4 deixa de ser verdadeira."}$c$::jsonb, $c$Liste os valores de i, um por volta.$c$, 101, false, $c$arquivo$c$),
  ($c$completar-while$c$, $c$repeticao$c$, $c$blank$c$, $c$Complete o while$c$, $c$medio$c$, $c$Complete as lacunas para calcular 5! (5 × 4 × 3 × 2 × 1) em fatorial.$c$, $c$O laço "while" (enquanto) repete o bloco enquanto a condição for verdadeira. É preciso mudar alguma variável dentro do laço, senão ele nunca termina.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"let n = 5;\nlet fatorial = 1;\n{{1}} (n > 1) {\n  fatorial = fatorial * n;\n  n{{2}};\n}","blanks":[{"answers":["while"]},{"answers":["--","-= 1","-=1"]}],"explanation":"O while repete enquanto n > 1, e n-- diminui n em 1 a cada volta, até a condição ficar falsa."}$c$::jsonb, $c$Em inglês: "enquanto". Para diminuir 1, existe um operador parecido com o ++.$c$, 102, false, $c$arquivo$c$),
  ($c$soma-dos-pares$c$, $c$repeticao$c$, $c$code$c$, $c$Soma dos números pares$c$, $c$medio$c$, $c$Escreva `somaPares(n)` que retorna a soma de todos os números pares de 1 até n (incluindo n, se for par). Para n menor que 2, o resultado é 0.$c$, null, $c$somaPares$c$, $c$function somaPares(n) {
  // seu código aqui
}
$c$, $c$[{"args":[10],"expected":30},{"args":[1],"expected":0},{"args":[0],"expected":0},{"args":[7],"expected":12},{"args":[2],"expected":2}]$c$::jsonb, $c${}$c$::jsonb, $c$Percorra os números e some só os que têm resto 0 na divisão por 2.$c$, 103, false, $c$arquivo$c$),
  ($c$potencia$c$, $c$repeticao$c$, $c$code$c$, $c$Potência$c$, $c$medio$c$, $c$Escreva `potencia(base, exp)` que retorna base elevada a exp (um inteiro maior ou igual a 0), usando um laço. Não use `Math.pow` nem o operador `**`.$c$, null, $c$potencia$c$, $c$function potencia(base, exp) {
  // seu código aqui
}
$c$, $c$[{"args":[2,3],"expected":8},{"args":[5,0],"expected":1},{"args":[3,1],"expected":3},{"args":[10,4],"expected":10000},{"args":[0,5],"expected":0}]$c$::jsonb, $c${}$c$::jsonb, $c$Comece o resultado em 1 e multiplique pela base, exp vezes.$c$, 104, false, $c$arquivo$c$),
  ($c$conta-digitos$c$, $c$repeticao$c$, $c$code$c$, $c$Quantos dígitos?$c$, $c$medio$c$, $c$Escreva `contaDigitos(n)` que retorna quantos dígitos tem o inteiro n (maior ou igual a 0), sem converter para texto. O número 0 tem 1 dígito.$c$, null, $c$contaDigitos$c$, $c$function contaDigitos(n) {
  // seu código aqui
}
$c$, $c$[{"args":[0],"expected":1},{"args":[7],"expected":1},{"args":[10],"expected":2},{"args":[12345],"expected":5},{"args":[100],"expected":3}]$c$::jsonb, $c${}$c$::jsonb, $c$Divida por 10 (parte inteira) até sobrar um dígito, contando as divisões.$c$, 105, false, $c$arquivo$c$),
  ($c$mdc$c$, $c$repeticao$c$, $c$code$c$, $c$Máximo divisor comum$c$, $c$dificil$c$, $c$Escreva `mdc(a, b)` que retorna o maior número que divide a e b ao mesmo tempo (a e b inteiros positivos). Dica: o algoritmo de Euclides troca (a, b) por (b, a % b) até o resto ser 0.$c$, null, $c$mdc$c$, $c$function mdc(a, b) {
  // seu código aqui
}
$c$, $c$[{"args":[12,18],"expected":6},{"args":[7,13],"expected":1},{"args":[100,25],"expected":25},{"args":[48,36],"expected":12},{"args":[17,17],"expected":17}]$c$::jsonb, $c${}$c$::jsonb, $c$Repita enquanto b for diferente de 0; quando b chegar a 0, a resposta é a.$c$, 106, false, $c$arquivo$c$),
  ($c$soma-vetor$c$, $c$vetores$c$, $c$code$c$, $c$Soma dos elementos$c$, $c$medio$c$, $c$Escreva `somaVetor(v)` que retorna a soma de todos os elementos do vetor `v`.$c$, null, $c$somaVetor$c$, $c$function somaVetor(v) {
  // seu código aqui
}
$c$, $c$[{"args":[[1,2,3]],"expected":6},{"args":[[]],"expected":0},{"args":[[-2,2,10]],"expected":10}]$c$::jsonb, $c${}$c$::jsonb, $c$Percorra o vetor com um laço usando `v.length` e acumule `v[i]`.$c$, 7, true, $c$arquivo$c$),
  ($c$inverter-vetor$c$, $c$vetores$c$, $c$code$c$, $c$Inverter vetor$c$, $c$dificil$c$, $c$Escreva `inverter(v)` que retorna um NOVO vetor com os elementos na ordem inversa, sem usar `reverse`.$c$, null, $c$inverter$c$, $c$function inverter(v) {
  // seu código aqui
}
$c$, $c$[{"args":[[1,2,3]],"expected":[3,2,1]},{"args":[[]],"expected":[]},{"args":[["a","b"]],"expected":["b","a"]},{"args":[[7]],"expected":[7]}]$c$::jsonb, $c${}$c$::jsonb, $c$Percorra o vetor do último índice até o 0 e use `push` num vetor novo.$c$, 8, true, $c$arquivo$c$),
  ($c$maior-vetor$c$, $c$vetores$c$, $c$code$c$, $c$Maior elemento$c$, $c$medio$c$, $c$Escreva `maiorElemento(v)` que retorna o maior número de um vetor não vazio, sem usar `Math.max`.$c$, null, $c$maiorElemento$c$, $c$function maiorElemento(v) {
  // seu código aqui
}
$c$, $c$[{"args":[[3,9,2]],"expected":9},{"args":[[-4,-1,-7]],"expected":-1},{"args":[[5]],"expected":5}]$c$::jsonb, $c${}$c$::jsonb, $c$Comece com `v[0]` como maior e compare com os demais elementos.$c$, 15, true, $c$arquivo$c$),
  ($c$busca-linear$c$, $c$vetores$c$, $c$code$c$, $c$Busca linear$c$, $c$medio$c$, $c$Escreva `buscar(v, x)` que retorna o índice da primeira ocorrência de x no vetor, ou -1 se não existir. Não use `indexOf`.$c$, null, $c$buscar$c$, $c$function buscar(v, x) {
  // seu código aqui
}
$c$, $c$[{"args":[[4,8,15],8],"expected":1},{"args":[[4,8,15],99],"expected":-1},{"args":[[],1],"expected":-1},{"args":[[7,7,7],7],"expected":0}]$c$::jsonb, $c${}$c$::jsonb, $c$Percorra o vetor e retorne o índice assim que encontrar o valor; só retorne -1 depois do laço.$c$, 16, true, $c$arquivo$c$),
  ($c$ordenar$c$, $c$vetores$c$, $c$code$c$, $c$Ordenar vetor$c$, $c$dificil$c$, $c$Escreva `ordenar(v)` que retorna um NOVO vetor de números em ordem crescente, sem usar `sort`.$c$, null, $c$ordenar$c$, $c$function ordenar(v) {
  // seu código aqui
}
$c$, $c$[{"args":[[3,1,2]],"expected":[1,2,3]},{"args":[[]],"expected":[]},{"args":[[5,5,1]],"expected":[1,5,5]},{"args":[[-1,-3,2,0]],"expected":[-3,-1,0,2]},{"args":[[1,2,3]],"expected":[1,2,3]}]$c$::jsonb, $c${}$c$::jsonb, $c$Uma ideia simples: percorra pares vizinhos e troque os que estão fora de ordem, repetindo até não haver trocas (bubble sort).$c$, 17, true, $c$arquivo$c$),
  ($c$indice-do-vetor$c$, $c$vetores$c$, $c$choice$c$, $c$O primeiro elemento$c$, $c$facil$c$, $c$Em let v = [10, 20, 30, 40], quanto vale v[2]?$c$, $c$Um vetor guarda vários valores numa só variável. Cada posição tem um índice, e a contagem começa em 0: v[0] é o primeiro elemento, v[1] o segundo, e assim por diante.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["20","30","40","10"],"correct":1,"explanation":"Os índices são v[0] = 10, v[1] = 20, v[2] = 30 e v[3] = 40."}$c$::jsonb, $c$Lembre-se: o primeiro índice é 0.$c$, 101, false, $c$arquivo$c$),
  ($c$completar-percorrer$c$, $c$vetores$c$, $c$blank$c$, $c$Percorrer o vetor$c$, $c$facil$c$, $c$Complete as lacunas para somar todos os elementos do vetor v.$c$, $c$Para percorrer um vetor, usamos um índice i que vai de 0 até o último elemento. O tamanho do vetor é v.length, e o elemento da posição i é v[i].$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"let soma = 0;\nfor (let i = 0; i < v{{1}}; i++) {\n  soma += v{{2}};\n}","blanks":[{"answers":[".length"]},{"answers":["[i]"]}],"explanation":"O laço vai de 0 até v.length - 1, e a cada volta somamos o elemento da posição i, que é v[i]."}$c$::jsonb, $c$O tamanho é uma propriedade do vetor; o elemento usa colchetes.$c$, 102, false, $c$arquivo$c$),
  ($c$conta-pares$c$, $c$vetores$c$, $c$code$c$, $c$Quantos pares?$c$, $c$facil$c$, $c$Escreva `contaPares(v)` que retorna quantos elementos pares existem no vetor de inteiros `v`.$c$, null, $c$contaPares$c$, $c$function contaPares(v) {
  // seu código aqui
}
$c$, $c$[{"args":[[1,2,3,4]],"expected":2},{"args":[[]],"expected":0},{"args":[[1,3,5]],"expected":0},{"args":[[2,4,6,8]],"expected":4},{"args":[[0]],"expected":1}]$c$::jsonb, $c${}$c$::jsonb, $c$Percorra o vetor e some 1 a um contador sempre que o elemento for par.$c$, 103, false, $c$arquivo$c$),
  ($c$media-do-vetor$c$, $c$vetores$c$, $c$code$c$, $c$Média do vetor$c$, $c$medio$c$, $c$Escreva `mediaVetor(v)` que retorna a média dos números do vetor `v`, que tem pelo menos um elemento.$c$, null, $c$mediaVetor$c$, $c$function mediaVetor(v) {
  // seu código aqui
}
$c$, $c$[{"args":[[1,2,3]],"expected":2},{"args":[[10]],"expected":10},{"args":[[1,2]],"expected":1.5},{"args":[[0,0,6]],"expected":2},{"args":[[-2,2]],"expected":0}]$c$::jsonb, $c${}$c$::jsonb, $c$Some tudo e divida pela quantidade de elementos.$c$, 104, false, $c$arquivo$c$),
  ($c$segundo-maior$c$, $c$vetores$c$, $c$code$c$, $c$Segundo maior valor$c$, $c$dificil$c$, $c$Escreva `segundoMaior(v)` que retorna o segundo maior valor DISTINTO do vetor `v` (que tem pelo menos dois valores diferentes). Por exemplo, em [10, 9, 10, 8] o segundo maior é 9.$c$, null, $c$segundoMaior$c$, $c$function segundoMaior(v) {
  // seu código aqui
}
$c$, $c$[{"args":[[3,1,2]],"expected":2},{"args":[[5,5,4]],"expected":4},{"args":[[1,2]],"expected":1},{"args":[[10,9,10,8]],"expected":9},{"args":[[-1,-5,-3]],"expected":-3}]$c$::jsonb, $c${}$c$::jsonb, $c$Guarde o maior e o segundo maior vistos até agora, atualizando os dois a cada elemento.$c$, 105, false, $c$arquivo$c$),
  ($c$parametro-e-retorno$c$, $c$funcoes$c$, $c$choice$c$, $c$Parâmetro e retorno$c$, $c$facil$c$, $c$Na função abaixo, o que é n?

function dobro(n) {
  return n * 2;
}$c$, $c$Uma função recebe valores de entrada, chamados parâmetros, e pode devolver um resultado com return. Assim, o mesmo código pode ser reutilizado com valores diferentes.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["O resultado da função","Um parâmetro: o valor de entrada","O nome da função","Um erro"],"correct":1,"explanation":"n é o parâmetro: o valor que a função recebe. O resultado é o que ela devolve com return."}$c$::jsonb, $c$Fica entre parênteses, depois do nome.$c$, 101, false, $c$arquivo$c$),
  ($c$completar-funcao$c$, $c$funcoes$c$, $c$blank$c$, $c$Complete a função$c$, $c$facil$c$, $c$Complete as lacunas para definir uma função que devolve a área de um retângulo.$c$, $c$Uma função é declarada com a palavra "function", seguida do nome e dos parâmetros entre parênteses. Para devolver o resultado, usamos "return".$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"{{1}} area(base, altura) {\n  {{2}} base * altura;\n}","blanks":[{"answers":["function"]},{"answers":["return"]}],"explanation":"\"function\" declara a função e \"return\" devolve o resultado para quem a chamou."}$c$::jsonb, $c$Em inglês: "função" e "retornar".$c$, 102, false, $c$arquivo$c$),
  ($c$escopo-de-variavel$c$, $c$funcoes$c$, $c$choice$c$, $c$Onde a variável existe?$c$, $c$medio$c$, $c$O que acontece ao executar o código abaixo?

function f() {
  let x = 5;
}
f();
console.log(x);$c$, $c$Uma variável criada dentro de uma função só existe ali dentro. Esse limite se chama escopo: fora da função, o nome não é conhecido.$c$, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":["Mostra 5","Dá erro: x não existe fora da função","Mostra undefined","Mostra 0"],"correct":1,"explanation":"x foi criada dentro de f, então só existe ali. Fora da função, usar x causa um erro (ReferenceError)."}$c$::jsonb, $c$Onde a variável x foi declarada?$c$, 103, false, $c$arquivo$c$),
  ($c$maior-de-dois$c$, $c$funcoes$c$, $c$code$c$, $c$Maior de dois$c$, $c$facil$c$, $c$Escreva `maiorDeDois(a, b)` que retorna o maior entre os dois números.$c$, $c$Uma função pode escolher entre valores e devolver só um deles. Cada caminho do if pode ter o seu próprio return.$c$, $c$maiorDeDois$c$, $c$function maiorDeDois(a, b) {
  // seu código aqui
}
$c$, $c$[{"args":[1,2],"expected":2},{"args":[5,3],"expected":5},{"args":[4,4],"expected":4},{"args":[-1,-2],"expected":-1},{"args":[0,-7],"expected":0}]$c$::jsonb, $c${}$c$::jsonb, $c$Compare os dois com um if e retorne o maior.$c$, 104, false, $c$arquivo$c$),
  ($c$hipotenusa$c$, $c$funcoes$c$, $c$code$c$, $c$Hipotenusa$c$, $c$medio$c$, $c$Escreva `hipotenusa(a, b)` que retorna o comprimento da hipotenusa de um triângulo retângulo com catetos a e b (teorema de Pitágoras). Você pode usar `Math.sqrt`.$c$, $c$Math.sqrt(x) devolve a raiz quadrada de x. Funções prontas como essa podem ser usadas dentro das suas.$c$, $c$hipotenusa$c$, $c$function hipotenusa(a, b) {
  // seu código aqui
}
$c$, $c$[{"args":[3,4],"expected":5},{"args":[5,12],"expected":13},{"args":[0,0],"expected":0},{"args":[8,15],"expected":17},{"args":[1,1],"expected":1.4142135623730951}]$c$::jsonb, $c${}$c$::jsonb, $c$A hipotenusa é a raiz quadrada de a² + b².$c$, 105, false, $c$arquivo$c$)
on conflict (id) do update set module_id = excluded.module_id, kind = excluded.kind, title = excluded.title,
  difficulty = excluded.difficulty, statement = excluded.statement, lesson = excluded.lesson,
  function_name = excluded.function_name, starter_code = excluded.starter_code, tests = excluded.tests,
  config = excluded.config, hint = excluded.hint
  where public.exercises.origem = 'arquivo';

-- Soluções comentadas (só professores leem a tabela; o aluno recebe pela função get_solution depois de acertar).
insert into public.exercise_solutions (exercise_id, solution, commentary)
select v.exercise_id, v.solution, v.commentary
from (values
  ($c$exemplo-corrigir$c$, $c$function dobro(n) {
  return n * 2;
}$c$, $c$O defeito estava no operador: somar 2 só coincide com o dobro quando n vale 2. O dobro é n * 2.$c$),
  ($c$exemplo-entrada-saida$c$, $c$function saudacao() {
  const nome = lerEntrada();
  console.log(`Olá, ${nome}!`);
}$c$, $c$lerEntrada() entrega o nome; um template literal (com crases) monta a frase e console.log a imprime.$c$),
  ($c$inverter-texto$c$, $c$function inverterTexto(s) {
  let r = "";
  for (let i = s.length - 1; i >= 0; i--) r += s[i];
  return r;
}$c$, $c$$c$),
  ($c$conta-vogais$c$, $c$function contaVogais(s) {
  let c = 0;
  for (const ch of s) if ("aeiou".includes(ch)) c++;
  return c;
}$c$, $c$$c$),
  ($c$palindromo$c$, $c$function ehPalindromo(s) {
  for (let i = 0, j = s.length - 1; i < j; i++, j--)
    if (s[i] !== s[j]) return false;
  return true;
}$c$, $c$$c$),
  ($c$soma$c$, $c$function soma(a, b) {
  return a + b;
}$c$, $c$$c$),
  ($c$media$c$, $c$function media(a, b, c) {
  return (a + b + c) / 3;
}$c$, $c$$c$),
  ($c$celsius$c$, $c$function celsiusParaFahrenheit(c) {
  return (c * 9) / 5 + 32;
}$c$, $c$$c$),
  ($c$area-retangulo$c$, $c$function areaRetangulo(b, a) {
  return b * a;
}$c$, $c$$c$),
  ($c$quadrado$c$, $c$function quadrado(n) {
  return n * n;
}$c$, $c$$c$),
  ($c$media-ponderada$c$, $c$function mediaPonderada(a, b) {
  return (a * 3 + b * 7) / 10;
}$c$, $c$$c$),
  ($c$par-ou-impar$c$, $c$function parOuImpar(n) {
  return n % 2 === 0 ? "par" : "impar";
}$c$, $c$$c$),
  ($c$maior-de-tres$c$, $c$function maiorDeTres(a, b, c) {
  let m = a;
  if (b > m) m = b;
  if (c > m) m = c;
  return m;
}$c$, $c$$c$),
  ($c$nota$c$, $c$function situacao(n) {
  if (n >= 7) return "aprovado";
  else if (n >= 5) return "recuperacao";
  return "reprovado";
}$c$, $c$$c$),
  ($c$bissexto$c$, $c$function ehBissexto(a) {
  return (a % 4 === 0 && a % 100 !== 0) || a % 400 === 0;
}$c$, $c$$c$),
  ($c$dentro-do-intervalo$c$, $c$function dentroDoIntervalo(n, min, max) {
  return n >= min && n <= max;
}$c$, $c$$c$),
  ($c$tipo-de-triangulo$c$, $c$function tipoTriangulo(a, b, c) {
  if (a === b && b === c) return "equilatero";
  if (a === b || a === c || b === c) return "isosceles";
  return "escaleno";
}$c$, $c$$c$),
  ($c$somatorio$c$, $c$function somatorio(n) {
  let s = 0;
  for (let i = 1; i <= n; i++) s += i;
  return s;
}$c$, $c$$c$),
  ($c$fatorial$c$, $c$function fatorial(n) {
  let f = 1;
  for (let i = 2; i <= n; i++) f *= i;
  return f;
}$c$, $c$$c$),
  ($c$tabuada$c$, $c$function tabuada(n) {
  const r = [];
  for (let i = 1; i <= 10; i++) r.push(n * i);
  return r;
}$c$, $c$$c$),
  ($c$primo$c$, $c$function ehPrimo(n) {
  if (n < 2) return false;
  for (let i = 2; i < n; i++) if (n % i === 0) return false;
  return true;
}$c$, $c$$c$),
  ($c$soma-dos-pares$c$, $c$function somaPares(n) {
  let s = 0;
  for (let i = 2; i <= n; i += 2) s += i;
  return s;
}$c$, $c$$c$),
  ($c$potencia$c$, $c$function potencia(base, exp) {
  let r = 1;
  for (let i = 0; i < exp; i++) r *= base;
  return r;
}$c$, $c$$c$),
  ($c$conta-digitos$c$, $c$function contaDigitos(n) {
  let c = 1;
  while (n >= 10) {
    n = Math.floor(n / 10);
    c++;
  }
  return c;
}$c$, $c$$c$),
  ($c$mdc$c$, $c$function mdc(a, b) {
  while (b !== 0) {
    const r = a % b;
    a = b;
    b = r;
  }
  return a;
}$c$, $c$$c$),
  ($c$soma-vetor$c$, $c$function somaVetor(v) {
  let s = 0;
  for (let i = 0; i < v.length; i++) s += v[i];
  return s;
}$c$, $c$$c$),
  ($c$inverter-vetor$c$, $c$function inverter(v) {
  const r = [];
  for (let i = v.length - 1; i >= 0; i--) r.push(v[i]);
  return r;
}$c$, $c$$c$),
  ($c$maior-vetor$c$, $c$function maiorElemento(v) {
  let m = v[0];
  for (const x of v) if (x > m) m = x;
  return m;
}$c$, $c$$c$),
  ($c$busca-linear$c$, $c$function buscar(v, x) {
  for (let i = 0; i < v.length; i++) if (v[i] === x) return i;
  return -1;
}$c$, $c$$c$),
  ($c$ordenar$c$, $c$function ordenar(v) {
  const r = [...v];
  for (let i = 0; i < r.length; i++)
    for (let j = 0; j < r.length - 1 - i; j++)
      if (r[j] > r[j + 1]) {
        const t = r[j];
        r[j] = r[j + 1];
        r[j + 1] = t;
      }
  return r;
}$c$, $c$$c$),
  ($c$conta-pares$c$, $c$function contaPares(v) {
  let c = 0;
  for (const x of v) if (x % 2 === 0) c++;
  return c;
}$c$, $c$$c$),
  ($c$media-do-vetor$c$, $c$function mediaVetor(v) {
  let s = 0;
  for (const x of v) s += x;
  return s / v.length;
}$c$, $c$$c$),
  ($c$segundo-maior$c$, $c$function segundoMaior(v) {
  let a = -Infinity,
    b = -Infinity;
  for (const x of v) {
    if (x > a) {
      b = a;
      a = x;
    } else if (x < a && x > b) {
      b = x;
    }
  }
  return b;
}$c$, $c$$c$),
  ($c$maior-de-dois$c$, $c$function maiorDeDois(a, b) {
  return a > b ? a : b;
}$c$, $c$$c$),
  ($c$hipotenusa$c$, $c$function hipotenusa(a, b) {
  return Math.sqrt(a * a + b * b);
}$c$, $c$$c$)
) as v (exercise_id, solution, commentary)
join public.exercises e on e.id = v.exercise_id and e.origem = 'arquivo'
on conflict (exercise_id) do update set solution = excluded.solution, commentary = excluded.commentary;

-- Vínculos exercício-conceito: só dos exercícios que o importador administra.
delete from public.exercise_concepts where exercise_id in (
  select id from public.exercises where origem = 'arquivo' and id in ($c$o-que-e-algoritmo$c$, $c$ordem-das-instrucoes$c$, $c$valor-da-variavel$c$, $c$completar-condicional$c$, $c$completar-laco$c$, $c$tipos-de-dados$c$, $c$precedencia-operadores$c$, $c$resto-da-divisao$c$, $c$exemplo-interpretacao$c$, $c$exemplo-ordenacao$c$, $c$exemplo-corrigir$c$, $c$exemplo-entrada-saida$c$, $c$tamanho-do-texto$c$, $c$completar-texto$c$, $c$inverter-texto$c$, $c$conta-vogais$c$, $c$palindromo$c$, $c$soma$c$, $c$media$c$, $c$celsius$c$, $c$area-retangulo$c$, $c$quadrado$c$, $c$media-ponderada$c$, $c$completar-media$c$, $c$par-ou-impar$c$, $c$maior-de-tres$c$, $c$nota$c$, $c$bissexto$c$, $c$operadores-logicos$c$, $c$completar-else-if$c$, $c$dentro-do-intervalo$c$, $c$tipo-de-triangulo$c$, $c$somatorio$c$, $c$fatorial$c$, $c$tabuada$c$, $c$primo$c$, $c$quantas-vezes$c$, $c$completar-while$c$, $c$soma-dos-pares$c$, $c$potencia$c$, $c$conta-digitos$c$, $c$mdc$c$, $c$soma-vetor$c$, $c$inverter-vetor$c$, $c$maior-vetor$c$, $c$busca-linear$c$, $c$ordenar$c$, $c$indice-do-vetor$c$, $c$completar-percorrer$c$, $c$conta-pares$c$, $c$media-do-vetor$c$, $c$segundo-maior$c$, $c$parametro-e-retorno$c$, $c$completar-funcao$c$, $c$escopo-de-variavel$c$, $c$maior-de-dois$c$, $c$hipotenusa$c$)
);
insert into public.exercise_concepts (exercise_id, concept_id, weight)
select v.exercise_id, v.concept_id, v.weight
from (values
  ($c$o-que-e-algoritmo$c$, $c$m1-algoritmos$c$, 2),
  ($c$ordem-das-instrucoes$c$, $c$m1-sequencia$c$, 2),
  ($c$valor-da-variavel$c$, $c$m2-introducao-variaveis$c$, 2),
  ($c$completar-condicional$c$, $c$m4-if-else$c$, 2),
  ($c$completar-laco$c$, $c$m5-for$c$, 2),
  ($c$tipos-de-dados$c$, $c$m2-string$c$, 1),
  ($c$tipos-de-dados$c$, $c$m2-number$c$, 1),
  ($c$precedencia-operadores$c$, $c$m3-precedencia$c$, 2),
  ($c$resto-da-divisao$c$, $c$m3-aritmeticos$c$, 2),
  ($c$exemplo-interpretacao$c$, $c$m2-introducao-variaveis$c$, 2),
  ($c$exemplo-interpretacao$c$, $c$m2-console-log$c$, 1),
  ($c$exemplo-ordenacao$c$, $c$m1-sequencia$c$, 2),
  ($c$exemplo-corrigir$c$, $c$m3-aritmeticos$c$, 2),
  ($c$exemplo-corrigir$c$, $c$m7-return$c$, 1),
  ($c$exemplo-entrada-saida$c$, $c$m2-entrada-saida$c$, 2),
  ($c$exemplo-entrada-saida$c$, $c$m2-console-log$c$, 2),
  ($c$exemplo-entrada-saida$c$, $c$m2-template-literals$c$, 1),
  ($c$tamanho-do-texto$c$, $c$m2-manipulacao-textos$c$, 2),
  ($c$completar-texto$c$, $c$m2-manipulacao-textos$c$, 2),
  ($c$inverter-texto$c$, $c$m2-manipulacao-textos$c$, 2),
  ($c$inverter-texto$c$, $c$m5-for$c$, 1),
  ($c$conta-vogais$c$, $c$m2-manipulacao-textos$c$, 2),
  ($c$conta-vogais$c$, $c$m5-contadores$c$, 1),
  ($c$palindromo$c$, $c$m2-manipulacao-textos$c$, 2),
  ($c$palindromo$c$, $c$m5-for$c$, 1),
  ($c$soma$c$, $c$m3-aritmeticos$c$, 2),
  ($c$soma$c$, $c$m7-return$c$, 1),
  ($c$media$c$, $c$m3-aritmeticos$c$, 2),
  ($c$media$c$, $c$m7-return$c$, 1),
  ($c$celsius$c$, $c$m3-aritmeticos$c$, 2),
  ($c$celsius$c$, $c$m7-return$c$, 1),
  ($c$area-retangulo$c$, $c$m3-aritmeticos$c$, 2),
  ($c$area-retangulo$c$, $c$m7-return$c$, 1),
  ($c$quadrado$c$, $c$m3-aritmeticos$c$, 2),
  ($c$quadrado$c$, $c$m7-return$c$, 1),
  ($c$media-ponderada$c$, $c$m3-aritmeticos$c$, 2),
  ($c$media-ponderada$c$, $c$m3-precedencia$c$, 1),
  ($c$media-ponderada$c$, $c$m7-return$c$, 1),
  ($c$completar-media$c$, $c$m3-precedencia$c$, 2),
  ($c$completar-media$c$, $c$m3-aritmeticos$c$, 1),
  ($c$par-ou-impar$c$, $c$m4-if-else$c$, 2),
  ($c$par-ou-impar$c$, $c$m3-aritmeticos$c$, 1),
  ($c$maior-de-tres$c$, $c$m4-if$c$, 2),
  ($c$maior-de-tres$c$, $c$m3-relacionais$c$, 1),
  ($c$nota$c$, $c$m4-else-if$c$, 2),
  ($c$nota$c$, $c$m3-relacionais$c$, 1),
  ($c$bissexto$c$, $c$m3-logicos$c$, 2),
  ($c$bissexto$c$, $c$m3-aritmeticos$c$, 1),
  ($c$operadores-logicos$c$, $c$m3-logicos$c$, 2),
  ($c$completar-else-if$c$, $c$m4-else-if$c$, 2),
  ($c$dentro-do-intervalo$c$, $c$m3-relacionais$c$, 2),
  ($c$dentro-do-intervalo$c$, $c$m3-logicos$c$, 1),
  ($c$tipo-de-triangulo$c$, $c$m4-else-if$c$, 2),
  ($c$tipo-de-triangulo$c$, $c$m3-relacionais$c$, 1),
  ($c$somatorio$c$, $c$m5-acumuladores$c$, 2),
  ($c$somatorio$c$, $c$m5-for$c$, 1),
  ($c$fatorial$c$, $c$m5-acumuladores$c$, 2),
  ($c$fatorial$c$, $c$m5-for$c$, 1),
  ($c$tabuada$c$, $c$m5-for$c$, 2),
  ($c$tabuada$c$, $c$m6-push$c$, 1),
  ($c$primo$c$, $c$m5-for$c$, 2),
  ($c$primo$c$, $c$m4-if$c$, 1),
  ($c$quantas-vezes$c$, $c$m5-for$c$, 2),
  ($c$completar-while$c$, $c$m5-while$c$, 2),
  ($c$soma-dos-pares$c$, $c$m5-acumuladores$c$, 2),
  ($c$soma-dos-pares$c$, $c$m4-if$c$, 1),
  ($c$potencia$c$, $c$m5-acumuladores$c$, 2),
  ($c$potencia$c$, $c$m5-for$c$, 1),
  ($c$conta-digitos$c$, $c$m5-while$c$, 2),
  ($c$conta-digitos$c$, $c$m5-contadores$c$, 1),
  ($c$mdc$c$, $c$m5-while$c$, 2),
  ($c$mdc$c$, $c$m3-aritmeticos$c$, 1),
  ($c$soma-vetor$c$, $c$m6-percorrer-for$c$, 2),
  ($c$soma-vetor$c$, $c$m5-acumuladores$c$, 1),
  ($c$inverter-vetor$c$, $c$m6-percorrer-for$c$, 2),
  ($c$inverter-vetor$c$, $c$m6-push$c$, 1),
  ($c$maior-vetor$c$, $c$m6-percorrer-for$c$, 2),
  ($c$maior-vetor$c$, $c$m4-if$c$, 1),
  ($c$busca-linear$c$, $c$m6-percorrer-for$c$, 2),
  ($c$busca-linear$c$, $c$m4-if$c$, 1),
  ($c$ordenar$c$, $c$m6-percorrer-for$c$, 2),
  ($c$ordenar$c$, $c$m5-aninhados$c$, 1),
  ($c$indice-do-vetor$c$, $c$m6-indices$c$, 2),
  ($c$completar-percorrer$c$, $c$m6-percorrer-for$c$, 2),
  ($c$completar-percorrer$c$, $c$m6-length$c$, 1),
  ($c$conta-pares$c$, $c$m6-percorrer-for$c$, 2),
  ($c$conta-pares$c$, $c$m5-contadores$c$, 1),
  ($c$media-do-vetor$c$, $c$m6-percorrer-for$c$, 2),
  ($c$media-do-vetor$c$, $c$m5-acumuladores$c$, 1),
  ($c$segundo-maior$c$, $c$m6-percorrer-for$c$, 2),
  ($c$segundo-maior$c$, $c$m4-if$c$, 1),
  ($c$parametro-e-retorno$c$, $c$m7-parametros$c$, 2),
  ($c$parametro-e-retorno$c$, $c$m7-return$c$, 1),
  ($c$completar-funcao$c$, $c$m7-declaracao$c$, 2),
  ($c$completar-funcao$c$, $c$m7-return$c$, 1),
  ($c$escopo-de-variavel$c$, $c$m7-escopo-local$c$, 2),
  ($c$maior-de-dois$c$, $c$m7-return$c$, 2),
  ($c$maior-de-dois$c$, $c$m4-if$c$, 1),
  ($c$hipotenusa$c$, $c$m7-parametros-retorno$c$, 2),
  ($c$hipotenusa$c$, $c$m3-aritmeticos$c$, 1)
) as v (exercise_id, concept_id, weight)
join public.exercises e on e.id = v.exercise_id and e.origem = 'arquivo'
on conflict (exercise_id, concept_id) do update set weight = excluded.weight;

do $$
declare n integer;
begin
  select count(*) into n from public.exercises where origem = 'painel' and id in ($c$o-que-e-algoritmo$c$, $c$ordem-das-instrucoes$c$, $c$valor-da-variavel$c$, $c$completar-condicional$c$, $c$completar-laco$c$, $c$tipos-de-dados$c$, $c$precedencia-operadores$c$, $c$resto-da-divisao$c$, $c$exemplo-interpretacao$c$, $c$exemplo-ordenacao$c$, $c$exemplo-corrigir$c$, $c$exemplo-entrada-saida$c$, $c$tamanho-do-texto$c$, $c$completar-texto$c$, $c$inverter-texto$c$, $c$conta-vogais$c$, $c$palindromo$c$, $c$soma$c$, $c$media$c$, $c$celsius$c$, $c$area-retangulo$c$, $c$quadrado$c$, $c$media-ponderada$c$, $c$completar-media$c$, $c$par-ou-impar$c$, $c$maior-de-tres$c$, $c$nota$c$, $c$bissexto$c$, $c$operadores-logicos$c$, $c$completar-else-if$c$, $c$dentro-do-intervalo$c$, $c$tipo-de-triangulo$c$, $c$somatorio$c$, $c$fatorial$c$, $c$tabuada$c$, $c$primo$c$, $c$quantas-vezes$c$, $c$completar-while$c$, $c$soma-dos-pares$c$, $c$potencia$c$, $c$conta-digitos$c$, $c$mdc$c$, $c$soma-vetor$c$, $c$inverter-vetor$c$, $c$maior-vetor$c$, $c$busca-linear$c$, $c$ordenar$c$, $c$indice-do-vetor$c$, $c$completar-percorrer$c$, $c$conta-pares$c$, $c$media-do-vetor$c$, $c$segundo-maior$c$, $c$parametro-e-retorno$c$, $c$completar-funcao$c$, $c$escopo-de-variavel$c$, $c$maior-de-dois$c$, $c$hipotenusa$c$);
  if n > 0 then
    raise notice '% exercício(s) do conteúdo foram ignorados porque foram editados no painel do professor.', n;
  end if;
end $$;
