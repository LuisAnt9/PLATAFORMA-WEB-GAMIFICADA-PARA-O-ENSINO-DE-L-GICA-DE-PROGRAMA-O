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

Neste módulo você vai conhecer o vocabulário básico: valores, tipos (número, texto, lógico) e operadores. Não se preocupe em decorar: errar faz parte, e cada exercício explica a resposta.$c$, $c$$c$, $c$$c$, $c$mundo-1$c$, 100, $c$arquivo$c$),
  ($c$exemplos-dos-tipos$c$, $c$Exemplos dos tipos de exercício$c$, $c$Modelos para o professor copiar (rascunhos)$c$, $c$Esta lição reúne um exemplo de cada tipo novo de exercício, como modelo para escrever os seus. Todos estão como rascunho: só o professor os vê.$c$, $c$$c$, $c$$c$, $c$mundo-1$c$, 999, $c$arquivo$c$),
  ($c$o-que-e-programacao$c$, $c$O que é programação?$c$, $c$Entender que programar é escrever instruções para o computador executar$c$, $c$Programar é escrever instruções para que o computador faça uma tarefa. O computador é muito rápido e não se cansa, mas não pensa por conta própria: ele só faz exatamente o que mandamos, na ordem em que mandamos.

Três palavras aparecem o tempo todo:
- Programador: a pessoa que escreve as instruções.
- Programa: o conjunto de instruções escrito pelo programador (um jogo, um aplicativo de banco, o semáforo de uma rua).
- Linguagem de programação: a "língua" usada para escrever as instruções de um jeito que o computador entenda. Neste curso, a linguagem é o JavaScript.

Por isso as instruções precisam ser claras e completas. Dizer "faça um café" funciona entre pessoas, mas o computador precisa de cada passo, sem nada subentendido.$c$, $c$Este é um programa de uma única instrução, escrito em JavaScript:

console.log("Olá, mundo!");

Passo a passo:
1. console.log é o comando que manda o computador mostrar algo na tela.
2. O que está entre parênteses é o que será mostrado. O que está entre aspas é um texto e aparece exatamente como foi escrito.
3. O ponto e vírgula (;) marca o fim da instrução.

Ao executar, o computador mostra: Olá, mundo!

Com duas instruções, o computador as executa de cima para baixo, uma de cada vez:

console.log("Bom dia");
console.log("Tudo bem?");

Resultado: primeiro Bom dia, depois Tudo bem?.$c$, $c$- Programar é escrever instruções para o computador executar.
- O programador escreve o programa; a linguagem de programação é a "língua" usada para escrevê-lo.
- O computador não pensa sozinho: segue as instruções, em ordem, do jeito que foram escritas.
- Instruções precisam ser claras e completas.
- console.log mostra um resultado na tela.$c$, $c$mundo-1$c$, 101, $c$arquivo$c$),
  ($c$o-que-e-logica$c$, $c$O que é lógica de programação?$c$, $c$Organizar o raciocínio em passos claros e coerentes antes de programar$c$, $c$Lógica é pensar de forma organizada, sem contradições, para chegar a uma conclusão. Lógica de programação é aplicar esse raciocínio para planejar a solução de um problema em passos claros, antes de escrever qualquer código.

Antes de programar, vale responder quatro perguntas:
1. Qual é o problema?
2. Que informações eu tenho?
3. O que eu quero obter no final?
4. Em que passos chego lá?

Usamos lógica o tempo todo: "se estiver chovendo, levo o guarda-chuva; senão, não levo". Também há raciocínios com premissas e conclusão: "Todo gato é animal. Mimi é um gato. Logo, Mimi é um animal."

Aprender lógica de programação não exige ser bom em matemática avançada: exige ordem, atenção e vontade de testar o raciocínio.$c$, $c$Problema: decidir se devo levar o guarda-chuva.

1. Informação que eu tenho: está chovendo ou não está chovendo.
2. O que eu quero obter: a decisão de levar ou não o guarda-chuva.
3. Raciocínio em passos:
   - Verificar se está chovendo.
   - Se estiver, levar o guarda-chuva.
   - Se não estiver, deixar o guarda-chuva em casa.

Repare que ainda não escrevemos nenhum código. Primeiro organizamos o raciocínio; depois, será fácil transformá-lo em programa. Quem pula essa etapa costuma escrever instruções confusas ou incompletas.$c$, $c$- Lógica de programação é organizar o raciocínio em passos claros e coerentes.
- Antes de programar: qual é o problema, que informações tenho, o que quero obter e em quais passos.
- Um bom raciocínio não tem contradições.
- Cuidado ao inverter regras: "todo A é B" não significa "todo B é A".
- Não é preciso decorar comandos para começar: é preciso treinar o raciocínio.$c$, $c$mundo-1$c$, 102, $c$arquivo$c$),
  ($c$o-que-sao-algoritmos$c$, $c$O que são algoritmos?$c$, $c$Reconhecer um algoritmo e suas características$c$, $c$Um algoritmo é uma sequência finita de passos, claros e ordenados, que resolve um problema ou realiza uma tarefa. Uma receita de bolo, as instruções para montar um móvel e o caminho de casa até a escola são algoritmos.

Um bom algoritmo tem quatro características:
- Finito: termina em algum momento.
- Claro: cada passo é preciso, sem dar margem a dúvidas ("adicione 2 colheres de açúcar", e não "adicione um pouco").
- Ordenado: os passos seguem uma ordem que faz sentido.
- Tem objetivo: parte de informações iniciais e chega a um resultado.

Algoritmo e programa não são a mesma coisa. O algoritmo é a ideia, o plano de solução. O programa é esse plano escrito em uma linguagem de programação para o computador executar.$c$, $c$Algoritmo: trocar uma lâmpada queimada.

1. Desligar o interruptor.
2. Esperar a lâmpada esfriar.
3. Desenroscar a lâmpada queimada.
4. Enroscar a lâmpada nova.
5. Ligar o interruptor para testar.

Por que isso é um bom algoritmo?
- Tem fim: depois do passo 5, a tarefa termina.
- Cada passo é uma ação clara.
- A ordem importa: não dá para enroscar a lâmpada nova antes de tirar a velha, nem mexer nela com o interruptor ligado.
- Parte de uma situação inicial (lâmpada queimada) e chega a um resultado (lâmpada nova funcionando).$c$, $c$- Algoritmo é uma sequência finita de passos claros e ordenados que resolve um problema.
- Um algoritmo precisa ter fim, passos precisos e uma ordem que faça sentido.
- Receitas, manuais e trajetos são algoritmos do dia a dia.
- O algoritmo é a ideia; o programa é o algoritmo escrito em uma linguagem de programação.$c$, $c$mundo-1$c$, 103, $c$arquivo$c$),
  ($c$sequencia-logica$c$, $c$Sequência lógica$c$, $c$Perceber que a ordem dos passos muda o resultado$c$, $c$Sequência lógica é organizar os passos na ordem em que eles fazem sentido. Em geral, cada passo depende do que foi feito antes: não dá para calçar o sapato antes de vestir a meia.

Trocar a ordem pode:
- impedir a tarefa de funcionar (despejar a água no filtro antes de colocar o pó);
- ou mudar o resultado (colocar o macarrão antes de a água ferver).

O computador segue a mesma regra: ele executa as instruções de cima para baixo, uma de cada vez, na ordem em que foram escritas. Por isso, a ordem das instruções de um programa é tão importante quanto a ordem dos passos de uma receita.$c$, $c$Observe estas três instruções:

console.log("1");
console.log("2");
console.log("3");

O computador executa de cima para baixo e mostra:
1
2
3

Agora trocamos a ordem das linhas:

console.log("3");
console.log("2");
console.log("1");

O resultado muda:
3
2
1

As instruções continuam as mesmas, mas a ordem mudou e, com ela, o resultado. Nenhuma instrução foi "errada": a sequência é que determina o que o programa faz.$c$, $c$- Sequência lógica é a ordem em que os passos fazem sentido.
- Cada passo costuma depender dos anteriores.
- Mudar a ordem pode impedir a tarefa ou mudar o resultado.
- O computador executa as instruções de cima para baixo, uma por vez.$c$, $c$mundo-1$c$, 104, $c$arquivo$c$),
  ($c$entrada-processamento-saida$c$, $c$Entrada, processamento e saída$c$, $c$Identificar as três etapas de qualquer programa$c$, $c$Quase todo programa segue o mesmo caminho em três etapas:
- Entrada: os dados que o programa recebe (o que a pessoa digita, clica ou informa).
- Processamento: o que o programa faz com esses dados (cálculos, comparações, decisões).
- Saída: o resultado que o programa entrega (algo mostrado na tela, por exemplo).

Na calculadora, você digita 2 + 3 (entrada), o aparelho faz a conta (processamento) e mostra 5 (saída). No caixa do supermercado, o código de barras é a entrada, a busca do preço é o processamento e o valor na tela é a saída.

Nos exercícios de código desta plataforma, a entrada vem de uma função chamada lerEntrada(), e a saída é mostrada com console.log().$c$, $c$Este programa lê um nome e mostra uma saudação:

// ENTRADA: lê o nome da pessoa
const nome = lerEntrada();
// PROCESSAMENTO: monta a frase juntando "Olá, " ao nome
const frase = "Olá, " + nome + "!";
// SAÍDA: mostra a frase na tela
console.log(frase);

Se a entrada for Ana, a saída será: Olá, Ana!

Não se preocupe com os detalhes de const e do sinal de +: você vai estudá-los no Mundo 2. Por ora, observe as três etapas, que aparecem em quase todos os programas: receber, processar e mostrar.$c$, $c$- Entrada: dados que o programa recebe.
- Processamento: o que o programa faz com os dados.
- Saída: o resultado que o programa entrega.
- Em JavaScript, aqui na plataforma: lerEntrada() lê a entrada e console.log() mostra a saída.
- Mostrar um resultado é saída; calcular é processamento; receber um valor é entrada.$c$, $c$mundo-1$c$, 105, $c$arquivo$c$),
  ($c$pseudocodigo$c$, $c$Pseudocódigo$c$, $c$Escrever algoritmos em linguagem próxima do português$c$, $c$Pseudocódigo é uma forma de escrever algoritmos com palavras do nosso dia a dia, sem as regras rígidas de uma linguagem de programação. O computador não executa pseudocódigo: ele serve para planejar e conversar sobre a solução antes de programar.

Nesta plataforma usamos estas palavras:
- INÍCIO e FIM: abrem e fecham o algoritmo.
- LEIA x: recebe um valor (entrada) e guarda em x.
- ESCREVA x: mostra um valor (saída).
- x ← valor: guarda o resultado de uma conta em x (a seta significa "recebe").

Cada instrução fica em uma linha, e o algoritmo é lido de cima para baixo.$c$, $c$Pseudocódigo para calcular a média de duas notas:

INÍCIO
  LEIA nota1
  LEIA nota2
  media ← (nota1 + nota2) / 2
  ESCREVA media
FIM

Passo a passo:
1. INÍCIO marca onde o algoritmo começa.
2. LEIA nota1 e LEIA nota2 recebem as duas notas (entrada).
3. media ← (nota1 + nota2) / 2 soma as notas e divide por 2 (processamento). O resultado fica guardado em media.
4. ESCREVA media mostra o resultado (saída).
5. FIM encerra o algoritmo.

Se as notas forem 6 e 8, o algoritmo escreve 7.$c$, $c$- Pseudocódigo é um algoritmo escrito em linguagem próxima do português.
- O computador não executa pseudocódigo: ele serve para planejar.
- LEIA recebe dados; ESCREVA mostra resultados; a seta (←) guarda o valor de uma conta.
- INÍCIO e FIM delimitam o algoritmo, que é lido de cima para baixo.$c$, $c$mundo-1$c$, 106, $c$arquivo$c$),
  ($c$fluxogramas$c$, $c$Fluxogramas$c$, $c$Ler e interpretar algoritmos desenhados com símbolos$c$, $c$Um fluxograma é um desenho que mostra o algoritmo com símbolos e setas. Cada símbolo tem um significado:
- Oval, escrito (INÍCIO) ou (FIM): onde o algoritmo começa e termina.
- Paralelogramo, escrito / Ler idade /: entrada ou saída de dados.
- Retângulo, escrito [ dobro ← n * 2 ]: processamento (uma conta ou uma ação).
- Losango, escrito < idade ≥ 18? >: decisão, uma pergunta cuja resposta é Sim ou Não e que abre dois caminhos.
- Setas: mostram a ordem em que os passos são seguidos.

Aqui usamos esses símbolos escritos em texto, para ler o fluxograma de cima para baixo, seguindo as setas.$c$, $c$Fluxograma que lê um número e mostra o dobro:

(INÍCIO)
   ↓
/ Ler numero /
   ↓
[ dobro ← numero * 2 ]
   ↓
/ Escrever dobro /
   ↓
(FIM)

Como ler:
1. Começamos no (INÍCIO) e seguimos as setas.
2. O paralelogramo / Ler numero / é uma entrada.
3. O retângulo é o processamento: calcula o dobro.
4. O paralelogramo / Escrever dobro / é a saída.
5. A oval (FIM) encerra o algoritmo.

Com a entrada 5, o fluxograma escreve 10.$c$, $c$- Fluxograma é um algoritmo desenhado com símbolos e setas.
- Oval: início e fim. Paralelogramo: entrada e saída. Retângulo: processamento. Losango: decisão (Sim ou Não).
- As setas indicam a ordem dos passos.
- Em uma decisão, só um dos caminhos é seguido, de acordo com a resposta.$c$, $c$mundo-1$c$, 107, $c$arquivo$c$),
  ($c$desafio-do-mundo-1$c$, $c$Desafio final do Mundo 1$c$, $c$Juntar tudo: algoritmos, sequência, pseudocódigo e fluxogramas$c$, $c$Chegou a hora de juntar o que você aprendeu no Mundo 1. Neste desafio, você vai usar lógica, sequência, entrada e saída, pseudocódigo e fluxogramas para resolver situações do dia a dia.

O desafio principal é o primeiro exercício: montar, na ordem certa, um algoritmo para uma tarefa cotidiana. Os outros dois exercícios aplicam o mesmo raciocínio a um pseudocódigo e a um fluxograma.

Dica: antes de responder, leia todos os passos e pense no que precisa ter acontecido antes de cada um.$c$, $c$Como atacar um desafio de algoritmo:
1. Entenda o problema: qual é a tarefa e qual é o resultado esperado?
2. Liste os passos, sem se preocupar com a ordem.
3. Pergunte, para cada passo: o que precisa ter acontecido antes dele?
4. Organize a sequência e releia do começo ao fim, como se você fosse o computador executando cada passo.
5. Teste com um caso simples (por exemplo, notas 6 e 8) e veja se o resultado faz sentido.$c$, $c$- Um algoritmo resolve um problema em passos claros, finitos e ordenados.
- A ordem dos passos importa, porque cada passo costuma depender dos anteriores.
- Todo programa tem entrada, processamento e saída.
- Pseudocódigo e fluxogramas servem para planejar o algoritmo antes de programar.
- Testar o algoritmo com um caso simples ajuda a encontrar erros de raciocínio.$c$, $c$mundo-1$c$, 108, $c$arquivo$c$),
  ($c$textos$c$, $c$Textos$c$, $c$Percorrer e transformar sequências de caracteres$c$, $c$Um texto (string) é uma sequência de caracteres entre aspas. Cada caractere tem uma posição, começando em 0:

const palavra = "casa";
palavra[0] // "c"
palavra.length // 4

Dá para percorrer um texto com um laço, como num vetor. Lembre que maiúsculas e minúsculas são caracteres diferentes: "A" não é igual a "a".$c$, $c$$c$, $c$$c$, $c$mundo-2$c$, 201, $c$arquivo$c$),
  ($c$fundamentos$c$, $c$Fundamentos$c$, $c$Traduzir um problema em passos e operações$c$, $c$Uma função recebe valores (parâmetros), faz um cálculo e devolve um resultado com return. Por exemplo:

function dobro(n) {
  return n * 2;
}

dobro(4) devolve 8. Nos exercícios você escreve funções assim: leia o enunciado, pense no passo a passo e só então escreva o código. Use os testes como guia: eles mostram o que a função deveria devolver.$c$, $c$$c$, $c$$c$, $c$mundo-3$c$, 301, $c$arquivo$c$),
  ($c$condicionais$c$, $c$Condicionais$c$, $c$Tomar decisões no fluxo do algoritmo$c$, $c$Condicionais fazem o programa escolher um caminho. A estrutura básica é:

if (idade >= 18) {
  return "maior";
} else {
  return "menor";
}

A condição entre parênteses vale verdadeiro ou falso. Operadores úteis: ===, !==, >, <, >=, <=, e && (e) e || (ou). Dica: teste os casos de borda, como o valor exatamente igual ao limite.$c$, $c$$c$, $c$$c$, $c$mundo-4$c$, 401, $c$arquivo$c$),
  ($c$repeticao$c$, $c$Estruturas de repetição$c$, $c$Compreender o passo a passo de um laço$c$, $c$Um laço repete um bloco de código. O mais comum é o for:

for (let i = 1; i <= 5; i++) {
  total = total + i;
}

Ele tem três partes: início (let i = 1), condição para continuar (i <= 5) e passo (i++). Para entender um laço, acompanhe a tabela de valores a cada volta: quanto valem i e total? Cuidado com laços que nunca terminam.$c$, $c$$c$, $c$$c$, $c$mundo-5$c$, 501, $c$arquivo$c$),
  ($c$vetores$c$, $c$Vetores$c$, $c$Manipular coleções de dados$c$, $c$Um vetor (array) guarda vários valores numa lista ordenada:

const notas = [7, 9, 5];

A primeira posição é a 0: notas[0] vale 7. notas.length diz quantos itens existem. Para percorrer o vetor use um laço de i = 0 até i < notas.length. Muitos problemas de vetores são "percorra e acumule": somar, contar, achar o maior.$c$, $c$$c$, $c$$c$, $c$mundo-6$c$, 601, $c$arquivo$c$),
  ($c$funcoes$c$, $c$Funções$c$, $c$Dividir um problema em partes reutilizáveis$c$, $c$Quando um trecho de código se repete, vale transformá-lo numa função e reutilizá-la. Uma função boa faz uma coisa só e tem um nome que diz o que ela faz.

function ehPar(n) {
  return n % 2 === 0;
}

Uma função pode chamar outras funções: assim você divide um problema grande em partes pequenas que dá para testar separadamente.$c$, $c$$c$, $c$$c$, $c$mundo-7$c$, 701, $c$arquivo$c$)
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
  ($c$prog-o-que-e-programar$c$, $c$o-que-e-programacao$c$, $c$choice$c$, $c$O que é programar?$c$, $c$facil$c$, $c$Qual alternativa descreve melhor o que é programar?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Consertar computadores que quebraram","misconception":"confunde programar com fazer manutenção de equipamentos"},{"text":"Escrever instruções para o computador executar"},{"text":"Usar aplicativos prontos, como o WhatsApp","misconception":"confunde usar um programa com criar um programa"},{"text":"Digitar textos em um editor de documentos","misconception":"acha que programar é só digitar"}],"correct":1,"explanation":"Programar é escrever instruções que o computador consegue executar. Quem usa um aplicativo não está programando: está usando o resultado de um programa."}$c$::jsonb, $c$Pense em quem cria o aplicativo, e não em quem o usa.$c$, 1, false, $c$arquivo$c$),
  ($c$prog-quem-e-quem$c$, $c$o-que-e-programacao$c$, $c$choice$c$, $c$Linguagem, programa e programador$c$, $c$facil$c$, $c$Na frase "o programador escreve um programa em JavaScript", o que é o JavaScript?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"O computador que executa as instruções","misconception":"confunde a linguagem com a máquina"},{"text":"O programa que foi escrito","misconception":"confunde a linguagem com o resultado escrito nela"},{"text":"A pessoa que escreve as instruções","misconception":"confunde a linguagem com o programador"},{"text":"A linguagem de programação usada para escrever o programa"}],"correct":3,"explanation":"O JavaScript é a linguagem: a \"língua\" em que as instruções são escritas. O programador escreve, o programa é o resultado e o computador o executa."}$c$::jsonb, $c$Quem escreve, o que é escrito e a língua em que se escreve são três coisas diferentes.$c$, 2, false, $c$arquivo$c$),
  ($c$prog-complete-ola-mundo$c$, $c$o-que-e-programacao$c$, $c$blank$c$, $c$Complete o primeiro programa$c$, $c$facil$c$, $c$Complete o programa para que o computador mostre a mensagem Olá, mundo! na tela.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"{{1}}.{{2}}(\"Olá, mundo!\");","blanks":[{"answers":["console"]},{"answers":["log"]}],"explanation":"console.log é o comando que manda o computador mostrar o que está entre parênteses."}$c$::jsonb, $c$O comando que mostra algo na tela tem duas partes separadas por um ponto.$c$, 3, false, $c$arquivo$c$),
  ($c$prog-ordem-das-instrucoes$c$, $c$o-que-e-programacao$c$, $c$interpretation$c$, $c$O que aparece na tela?$c$, $c$medio$c$, $c$O computador executa o programa abaixo. O que ele mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Bom dia e depois Boa tarde"},{"text":"Boa tarde e depois Bom dia","misconception":"acha que o computador executa as instruções de baixo para cima"},{"text":"Apenas Boa tarde","misconception":"acha que a última instrução apaga o resultado das anteriores"},{"text":"As duas frases, em qualquer ordem","misconception":"acha que a ordem das instruções não importa"}],"correct":0,"code":"console.log(\"Bom dia\");\nconsole.log(\"Boa tarde\");","explanation":"Cada console.log mostra uma linha, e as instruções são executadas na ordem em que aparecem: primeiro Bom dia, depois Boa tarde."}$c$::jsonb, $c$O computador lê o programa de cima para baixo.$c$, 4, false, $c$arquivo$c$),
  ($c$prog-texto-ou-conta$c$, $c$o-que-e-programacao$c$, $c$interpretation$c$, $c$Texto ou conta?$c$, $c$medio$c$, $c$Veja o programa abaixo. O que o computador mostra, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"5 e depois 5","misconception":"acha que o texto entre aspas também é calculado"},{"text":"2 + 3 e depois 2 + 3","misconception":"acha que o computador não faz contas"},{"text":"2 + 3 e depois 5"},{"text":"5 e depois 2 + 3","misconception":"acha que o computador executa as instruções de baixo para cima"}],"correct":2,"code":"console.log(\"2 + 3\");\nconsole.log(2 + 3);","explanation":"Com aspas, o computador mostra o texto como está: 2 + 3. Sem aspas, ele calcula a conta e mostra o resultado: 5."}$c$::jsonb, $c$O que está entre aspas é um texto e é mostrado exatamente como foi escrito.$c$, 5, false, $c$arquivo$c$),
  ($c$prog-quem-responde-pelo-erro$c$, $c$o-que-e-programacao$c$, $c$choice$c$, $c$De quem é o erro?$c$, $c$dificil$c$, $c$O programa de um semáforo mostra as cores na ordem errada e causa confusão no cruzamento. Quem deve corrigir o problema?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"O próprio computador, que decidiu errar","misconception":"acha que o computador toma decisões próprias"},{"text":"Quem escreveu o programa, revisando as instruções"},{"text":"A linguagem JavaScript, que estava com defeito","misconception":"culpa a linguagem em vez de rever as instruções escritas"},{"text":"Ninguém: programas não têm erros","misconception":"acha que programas não podem conter erros"}],"correct":1,"explanation":"O computador obedece às instruções exatamente como foram escritas. Se a ordem das cores está errada, o erro está nas instruções, e quem as escreveu precisa revisá-las."}$c$::jsonb, $c$Lembre que o computador só faz o que foi mandado.$c$, 6, false, $c$arquivo$c$),
  ($c$logica-o-que-e$c$, $c$o-que-e-logica$c$, $c$choice$c$, $c$O que é lógica de programação?$c$, $c$facil$c$, $c$Qual alternativa descreve melhor a lógica de programação?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Decorar todos os comandos de uma linguagem","misconception":"confunde lógica com memorizar a sintaxe da linguagem"},{"text":"Ser bom em matemática avançada","misconception":"acha que lógica de programação exige matemática avançada"},{"text":"Usar um computador mais rápido","misconception":"associa a lógica à velocidade da máquina"},{"text":"Organizar o raciocínio em passos claros para resolver um problema"}],"correct":3,"explanation":"Lógica de programação é o raciocínio organizado que planeja a solução em passos. A linguagem é só a forma de escrever esse plano para o computador."}$c$::jsonb, $c$Pense no que você faz antes de escrever qualquer código.$c$, 1, false, $c$arquivo$c$),
  ($c$logica-deducao-simples$c$, $c$o-que-e-logica$c$, $c$choice$c$, $c$O que podemos concluir?$c$, $c$facil$c$, $c$Todo aluno do curso estuda lógica. Ana é aluna do curso. O que podemos concluir?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Ana estuda lógica"},{"text":"Todos que estudam lógica são alunos do curso","misconception":"inverte a regra, confundindo \"todo A é B\" com \"todo B é A\""},{"text":"Ana não estuda lógica","misconception":"contradiz uma informação que foi dada"},{"text":"Não dá para concluir nada","misconception":"não aplica as informações que foram dadas"}],"correct":0,"explanation":"A regra vale para todos os alunos do curso. Como Ana é aluna, a regra vale para ela: Ana estuda lógica."}$c$::jsonb, $c$Aplique a regra geral ao caso da Ana.$c$, 2, false, $c$arquivo$c$),
  ($c$logica-se-entao-senao$c$, $c$o-que-e-logica$c$, $c$blank$c$, $c$Complete o raciocínio$c$, $c$facil$c$, $c$Complete a frase com as palavras que faltam.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"Se estiver chovendo, {{1}} levo o guarda-chuva; {{2}} não levo.","blanks":[{"answers":["então","ENTÃO","Então"]},{"answers":["senão","SENÃO","Senão"]}],"explanation":"\"Se... então... senão...\" é a estrutura básica de uma decisão: o que fazer se a condição for verdadeira e o que fazer se não for."}$c$::jsonb, $c$Uma palavra indica a consequência; a outra, o que acontece no caso contrário.$c$, 3, false, $c$arquivo$c$),
  ($c$logica-calculo-do-troco$c$, $c$o-que-e-logica$c$, $c$interpretation$c$, $c$Qual é o troco?$c$, $c$medio$c$, $c$Leia o raciocínio abaixo e responda: qual é o valor do troco?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"R$ 18,00","misconception":"soma os valores em vez de subtrair"},{"text":"R$ 8,00","misconception":"confunde o troco com o valor do lanche"},{"text":"R$ 2,00"},{"text":"R$ 10,00","misconception":"confunde o troco com o valor entregue"}],"correct":2,"code":"Problema: pagar um lanche de R$ 8,00 com uma nota de R$ 10,00.\n1. Receber a nota de R$ 10,00.\n2. Calcular o troco: 10 - 8.\n3. Devolver o troco.","explanation":"O troco é a diferença entre o que foi pago e o que foi gasto: 10 - 8 = 2."}$c$::jsonb, $c$Siga o passo 2 com os números do problema.$c$, 4, false, $c$arquivo$c$),
  ($c$logica-quem-pode-entrar$c$, $c$o-que-e-logica$c$, $c$interpretation$c$, $c$Quem pode entrar?$c$, $c$medio$c$, $c$Leia as informações abaixo e responda: quem pode entrar no cinema?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Só Maria","misconception":"inverte a regra, acreditando que quem não tem ingresso é quem entra"},{"text":"Só João"},{"text":"João e Maria","misconception":"ignora a condição da regra"},{"text":"Ninguém","misconception":"acha que a regra só vale se todos a cumprirem ao mesmo tempo"}],"correct":1,"code":"Regra: só entra no cinema quem tem ingresso.\nJoão tem ingresso.\nMaria não tem ingresso.","explanation":"A regra exige ingresso. João tem, então pode entrar; Maria não tem, então não pode."}$c$::jsonb, $c$Aplique a regra a cada pessoa, uma de cada vez.$c$, 5, false, $c$arquivo$c$),
  ($c$logica-etapas-do-raciocinio$c$, $c$o-que-e-logica$c$, $c$order$c$, $c$Ordene o raciocínio$c$, $c$medio$c$, $c$Coloque na ordem certa as etapas para resolver um problema com lógica.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["Entender qual é o problema","Identificar as informações que temos","Definir o que queremos obter","Planejar os passos da solução","Testar se a solução funciona"],"explanation":"Primeiro entendemos o problema e reunimos as informações; depois definimos o objetivo, planejamos os passos e, por fim, testamos."}$c$::jsonb, $c$Só dá para testar uma solução depois de planejá-la.$c$, 6, false, $c$arquivo$c$),
  ($c$logica-raciocinio-invertido$c$, $c$o-que-e-logica$c$, $c$choice$c$, $c$Encontre o erro no raciocínio$c$, $c$dificil$c$, $c$Um colega diz: "Todo programador usa computador, então quem usa computador é programador". Qual é o erro desse raciocínio?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Não há erro: a conclusão está correta","misconception":"confunde \"todo A é B\" com \"todo B é A\""},{"text":"O erro é dizer \"computador\" em vez de \"celular\"","misconception":"olha para as palavras usadas e não para a estrutura do raciocínio"},{"text":"A premissa é falsa, porque programadores não usam computador","misconception":"contesta a premissa em vez de analisar o raciocínio"},{"text":"Ele inverteu a regra: usar computador não torna ninguém programador"}],"correct":3,"explanation":"A regra diz que todo programador usa computador, mas não diz que todo usuário de computador programa. Inverter regras é um erro de lógica muito comum."}$c$::jsonb, $c$A regra vale em um sentido. Ela vale também no sentido contrário?$c$, 7, false, $c$arquivo$c$),
  ($c$algoritmo-qual-e-algoritmo$c$, $c$o-que-sao-algoritmos$c$, $c$choice$c$, $c$Qual deles é um algoritmo?$c$, $c$facil$c$, $c$Qual das opções é um algoritmo?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Uma receita de bolo com os passos numerados"},{"text":"Uma lista de ingredientes, sem os passos","misconception":"confunde dados com os passos que devem ser executados"},{"text":"A vontade de fazer um bolo","misconception":"confunde o objetivo com os passos para alcançá-lo"},{"text":"A foto do bolo pronto","misconception":"confunde o resultado com o caminho até ele"}],"correct":0,"explanation":"Um algoritmo é uma sequência de passos. A lista de ingredientes é apenas um dado, e o bolo pronto é o resultado, não o caminho até ele."}$c$::jsonb, $c$Um algoritmo diz o que fazer, e em que ordem.$c$, 1, false, $c$arquivo$c$),
  ($c$algoritmo-o-que-nao-precisa$c$, $c$o-que-sao-algoritmos$c$, $c$choice$c$, $c$O que um algoritmo não precisa ter?$c$, $c$facil$c$, $c$Qual destas características um algoritmo NÃO precisa ter?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Terminar depois de um número finito de passos","misconception":"acha que um algoritmo pode ficar executando para sempre"},{"text":"Ter passos claros e sem ambiguidade","misconception":"acha que o algoritmo pode deixar passos vagos"},{"text":"Ser escrito em uma linguagem de programação"},{"text":"Seguir uma ordem definida","misconception":"acha que a ordem dos passos é livre"}],"correct":2,"explanation":"Um algoritmo pode estar escrito em português, em desenhos ou em uma linguagem de programação. O que importa é ser finito, claro e ordenado."}$c$::jsonb, $c$Receitas de bolo também são algoritmos.$c$, 2, false, $c$arquivo$c$),
  ($c$algoritmo-trocar-lampada$c$, $c$o-que-sao-algoritmos$c$, $c$order$c$, $c$Ordene o algoritmo da lâmpada$c$, $c$facil$c$, $c$Coloque na ordem certa os passos para trocar uma lâmpada queimada.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["Desligar o interruptor","Esperar a lâmpada esfriar","Desenroscar a lâmpada queimada","Enroscar a lâmpada nova","Ligar o interruptor para testar"],"explanation":"A ordem protege quem executa o algoritmo: primeiro desligamos a energia e esperamos a lâmpada esfriar; só então a trocamos e testamos."}$c$::jsonb, $c$Segurança primeiro: o que deve acontecer antes de tocar na lâmpada?$c$, 3, false, $c$arquivo$c$),
  ($c$algoritmo-contar-ate-tres$c$, $c$o-que-sao-algoritmos$c$, $c$interpretation$c$, $c$O que a pessoa diz?$c$, $c$medio$c$, $c$Uma pessoa segue o algoritmo abaixo. O que ela diz, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"3, 2, 1","misconception":"lê os passos de baixo para cima"},{"text":"1, 2, 3"},{"text":"1, 2, 3, 4","misconception":"confunde o número do passo com o que deve ser dito"},{"text":"Apenas 3","misconception":"acha que só o último passo de dizer vale"}],"correct":1,"code":"Algoritmo: contar até 3\n1. Dizer \"1\"\n2. Dizer \"2\"\n3. Dizer \"3\"\n4. Parar","explanation":"Os passos 1, 2 e 3 mandam dizer \"1\", \"2\" e \"3\", nessa ordem. O passo 4 manda parar, e não dizer nada."}$c$::jsonb, $c$O número do passo não é o que a pessoa diz: leia o que cada passo manda fazer.$c$, 4, false, $c$arquivo$c$),
  ($c$algoritmo-instrucao-clara$c$, $c$o-que-sao-algoritmos$c$, $c$choice$c$, $c$Qual instrução é clara?$c$, $c$medio$c$, $c$Qual destas instruções é clara o bastante para fazer parte de um algoritmo?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Adicione um pouco de açúcar","misconception":"aceita instruções vagas, que cada pessoa interpreta de um jeito"},{"text":"Faça o bolo ficar gostoso","misconception":"confunde o objetivo com uma ação que pode ser executada"},{"text":"Adicione açúcar se der vontade","misconception":"aceita um passo que depende de opinião, e não de um critério claro"},{"text":"Adicione 2 colheres de açúcar"}],"correct":3,"explanation":"Uma instrução clara indica uma ação exata, que qualquer pessoa executa do mesmo jeito. \"Um pouco\" e \"se der vontade\" dependem de interpretação."}$c$::jsonb, $c$Duas pessoas diferentes fariam exatamente a mesma coisa?$c$, 5, false, $c$arquivo$c$),
  ($c$algoritmo-que-nunca-termina$c$, $c$o-que-sao-algoritmos$c$, $c$interpretation$c$, $c$Esse algoritmo é bom?$c$, $c$dificil$c$, $c$Analise o conjunto de instruções abaixo. Ele é um bom algoritmo?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Não: ele nunca termina, e todo algoritmo precisa ter fim"},{"text":"Sim, porque tem passos e uma ordem","misconception":"ignora que um algoritmo precisa ser finito"},{"text":"Sim, porque caminhar é uma tarefa simples","misconception":"avalia a tarefa e não a estrutura do algoritmo"},{"text":"Não, porque faltou escrevê-lo em JavaScript","misconception":"acha que um algoritmo só existe em uma linguagem de programação"}],"correct":0,"code":"Algoritmo: caminhar\n1. Dar um passo\n2. Voltar ao passo 1","explanation":"O passo 2 sempre manda voltar ao passo 1, então a pessoa caminha para sempre. Um algoritmo precisa terminar depois de um número finito de passos."}$c$::jsonb, $c$Siga as instruções e veja se algum passo manda parar.$c$, 6, false, $c$arquivo$c$),
  ($c$sequencia-escovar-os-dentes$c$, $c$sequencia-logica$c$, $c$order$c$, $c$Ordene: escovar os dentes$c$, $c$facil$c$, $c$Coloque na ordem certa os passos para escovar os dentes.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["Pegar a escova e a pasta","Colocar a pasta na escova","Escovar os dentes","Enxaguar a boca","Guardar a escova"],"explanation":"A pasta só vai para a escova depois de pegarmos os dois; enxaguamos depois de escovar; guardamos por último."}$c$::jsonb, $c$Cada passo só pode acontecer depois de o anterior estar pronto.$c$, 1, false, $c$arquivo$c$),
  ($c$sequencia-por-que-importa$c$, $c$sequencia-logica$c$, $c$choice$c$, $c$Por que a ordem importa?$c$, $c$facil$c$, $c$Por que a ordem dos passos é importante em um algoritmo?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Porque o computador gosta de organização","misconception":"acha que a ordem é só uma questão de estilo"},{"text":"Não é importante: o resultado é sempre o mesmo","misconception":"acha que a ordem dos passos não altera o resultado"},{"text":"Porque cada passo pode depender do resultado do passo anterior"},{"text":"Porque o computador executa tudo ao mesmo tempo","misconception":"acha que o computador executa todas as instruções ao mesmo tempo"}],"correct":2,"explanation":"Muitos passos dependem do que foi feito antes. Por isso o computador os executa um de cada vez, na ordem escrita."}$c$::jsonb, $c$Pense na meia e no sapato.$c$, 2, false, $c$arquivo$c$),
  ($c$sequencia-abc$c$, $c$sequencia-logica$c$, $c$interpretation$c$, $c$Em que ordem aparece?$c$, $c$medio$c$, $c$O computador executa o programa abaixo. O que ele mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"C, B e A","misconception":"acha que o computador começa pela última instrução"},{"text":"A, B e C, nessa ordem, cada um em uma linha"},{"text":"Apenas C","misconception":"acha que cada instrução apaga a anterior"},{"text":"A, B e C em ordem sorteada","misconception":"acha que o computador escolhe a ordem de forma aleatória"}],"correct":1,"code":"console.log(\"A\");\nconsole.log(\"B\");\nconsole.log(\"C\");","explanation":"As instruções são executadas na ordem em que aparecem, e cada console.log mostra uma linha: A, depois B, depois C."}$c$::jsonb, $c$Leia de cima para baixo, como o computador faz.$c$, 3, false, $c$arquivo$c$),
  ($c$sequencia-ordem-do-programa$c$, $c$sequencia-logica$c$, $c$order$c$, $c$Ordene o programa$c$, $c$medio$c$, $c$Coloque as instruções na ordem certa para o programa mostrar Olá, depois Tudo bem? e, por fim, Até logo.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["console.log(\"Olá\");","console.log(\"Tudo bem?\");","console.log(\"Até logo\");"],"explanation":"Como o computador executa de cima para baixo, a primeira instrução deve ser a que mostra Olá e a última, a que mostra Até logo."}$c$::jsonb, $c$O programa mostra as frases na ordem em que as instruções aparecem.$c$, 4, false, $c$arquivo$c$),
  ($c$sequencia-macarrao$c$, $c$sequencia-logica$c$, $c$interpretation$c$, $c$E se trocássemos os passos?$c$, $c$medio$c$, $c$Veja o algoritmo abaixo. O que aconteceria se trocássemos os passos 3 e 4 de lugar?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Nada: o resultado seria o mesmo","misconception":"acha que a ordem dos passos não altera o resultado"},{"text":"O fogo apagaria","misconception":"inventa uma consequência que não tem relação com a ordem dos passos"},{"text":"O algoritmo deixaria de ter passos","misconception":"acha que trocar a ordem apaga os passos"},{"text":"O macarrão seria colocado antes de a água ferver, e o resultado mudaria"}],"correct":3,"code":"Algoritmo: cozinhar macarrão\n1. Encher a panela com água\n2. Colocar a panela no fogo\n3. Esperar a água ferver\n4. Colocar o macarrão","explanation":"Trocar os passos 3 e 4 faz o macarrão entrar na água ainda fria. Os passos continuam existindo, mas a ordem muda o resultado."}$c$::jsonb, $c$Pense no que cada passo precisa que já tenha acontecido.$c$, 5, false, $c$arquivo$c$),
  ($c$sequencia-saque-no-caixa$c$, $c$sequencia-logica$c$, $c$order$c$, $c$Ordene o saque no caixa eletrônico$c$, $c$dificil$c$, $c$Coloque na ordem certa os passos para sacar dinheiro em um caixa eletrônico.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["Chegar ao caixa eletrônico","Inserir o cartão","Digitar a senha","Escolher a opção Saque","Digitar o valor desejado","Retirar as notas e o cartão"],"explanation":"O cartão vem antes da senha, e a senha antes de qualquer operação. Só depois de escolher o saque e o valor o caixa entrega o dinheiro."}$c$::jsonb, $c$O caixa só libera o saque depois de reconhecer você.$c$, 6, false, $c$arquivo$c$),
  ($c$eps-o-que-e-entrada$c$, $c$entrada-processamento-saida$c$, $c$choice$c$, $c$O que é a entrada?$c$, $c$facil$c$, $c$Em uma calculadora, você digita 2 + 3 e a tela mostra 5. O que é a ENTRADA nesse caso?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Os números 2 e 3 e a operação que foram digitados"},{"text":"O resultado 5","misconception":"confunde entrada com saída"},{"text":"A conta que a calculadora faz internamente","misconception":"confunde entrada com processamento"},{"text":"A tela da calculadora","misconception":"confunde os dados com o aparelho que os mostra"}],"correct":0,"explanation":"A entrada são os dados fornecidos ao programa: 2, 3 e a operação. A conta é o processamento e o 5 na tela é a saída."}$c$::jsonb, $c$Entrada é o que o programa recebe antes de fazer qualquer coisa.$c$, 1, false, $c$arquivo$c$),
  ($c$eps-classificar-saida$c$, $c$entrada-processamento-saida$c$, $c$choice$c$, $c$Entrada, processamento ou saída?$c$, $c$facil$c$, $c$Mostrar o valor do troco na tela do caixa é um exemplo de:$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Entrada","misconception":"confunde mostrar um resultado com receber dados"},{"text":"Processamento","misconception":"confunde exibir o resultado com calculá-lo"},{"text":"Saída"},{"text":"Linguagem de programação","misconception":"confunde uma etapa do programa com a linguagem em que ele é escrito"}],"correct":2,"explanation":"Saída é o resultado que o programa entrega. Quando o valor do troco aparece na tela, o programa está fazendo uma saída."}$c$::jsonb, $c$O resultado chegou à pessoa. Em qual etapa isso acontece?$c$, 2, false, $c$arquivo$c$),
  ($c$eps-eco$c$, $c$entrada-processamento-saida$c$, $c$code$c$, $c$Mostre o que foi lido$c$, $c$facil$c$, $c$Escreva a função `eco()`: ela deve ler um valor com `lerEntrada()` e mostrá-lo na tela, do mesmo jeito, com `console.log`.$c$, null, $c$eco$c$, $c$function eco() {
  // leia o valor com lerEntrada() e mostre com console.log
}
$c$, $c$[{"args":[],"inputs":["Olá"],"output":["Olá"]},{"args":[],"inputs":["Ana"],"output":["Ana"]}]$c$::jsonb, $c${}$c$::jsonb, $c$Guarde o que lerEntrada() devolve e mostre com console.log.$c$, 3, false, $c$arquivo$c$),
  ($c$eps-quais-sao-entrada$c$, $c$entrada-processamento-saida$c$, $c$interpretation$c$, $c$Quais passos são de entrada?$c$, $c$medio$c$, $c$Leia o algoritmo abaixo. Quais passos são de ENTRADA?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"O passo 3","misconception":"acha que calcular é receber dados"},{"text":"Os passos 1 e 2"},{"text":"O passo 4","misconception":"confunde saída com entrada"},{"text":"Os passos 1, 2 e 4","misconception":"agrupa mostrar o resultado com receber dados"}],"correct":1,"code":"1. Ler o preço do produto\n2. Ler o desconto, em reais\n3. Calcular: preço - desconto\n4. Mostrar o resultado","explanation":"Os passos 1 e 2 recebem dados (entrada). O passo 3 é processamento e o passo 4 é saída."}$c$::jsonb, $c$Entrada é tudo o que o programa lê antes de calcular.$c$, 4, false, $c$arquivo$c$),
  ($c$eps-qual-e-o-processamento$c$, $c$entrada-processamento-saida$c$, $c$choice$c$, $c$Onde está o processamento?$c$, $c$medio$c$, $c$Um programa lê o nome de uma pessoa e mostra "Olá, NOME!". Qual parte é o processamento?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Digitar o nome","misconception":"confunde processamento com entrada"},{"text":"Ver a frase aparecer na tela","misconception":"confunde processamento com saída"},{"text":"Ligar o computador","misconception":"inclui uma ação que não faz parte do programa"},{"text":"Montar a frase juntando \"Olá\" ao nome"}],"correct":3,"explanation":"Montar a frase com o nome é o que o programa faz com a entrada. Digitar é entrada e ver a frase na tela é saída."}$c$::jsonb, $c$Processamento é o que o programa faz com os dados que recebeu.$c$, 5, false, $c$arquivo$c$),
  ($c$eps-dobro$c$, $c$entrada-processamento-saida$c$, $c$code$c$, $c$Leia um número e mostre o dobro$c$, $c$medio$c$, $c$Escreva a função `dobro()`: ela deve ler um número com `lerEntrada()` e mostrar o dobro dele com `console.log`.$c$, null, $c$dobro$c$, $c$function dobro() {
  // leia o número, calcule o dobro e mostre o resultado
}
$c$, $c$[{"args":[],"inputs":[4],"output":["8"]},{"args":[],"inputs":[10],"output":["20"]},{"args":[],"inputs":[0],"output":["0"]}]$c$::jsonb, $c${}$c$::jsonb, $c$O dobro de um número é ele multiplicado por 2. Use * para multiplicar.$c$, 6, false, $c$arquivo$c$),
  ($c$eps-soma-de-entradas$c$, $c$entrada-processamento-saida$c$, $c$interpretation$c$, $c$Qual será a saída?$c$, $c$dificil$c$, $c$O programa abaixo recebe as entradas 4 e 6, nessa ordem. O que ele mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"10"},{"text":"4 e 6, em linhas separadas","misconception":"acha que console.log mostra as entradas, e não o resultado do processamento"},{"text":"a + b","misconception":"confunde o nome das variáveis com o resultado do cálculo"},{"text":"46","misconception":"confunde a soma de números com juntar os dois como texto"}],"correct":0,"code":"const a = lerEntrada();\nconst b = lerEntrada();\nconsole.log(a + b);","explanation":"Cada lerEntrada() lê um valor: a recebe 4 e b recebe 6. O processamento soma os dois e console.log mostra o resultado: 10."}$c$::jsonb, $c$Os dois valores são lidos, somados e só então mostrados.$c$, 7, false, $c$arquivo$c$),
  ($c$pseudo-o-que-e$c$, $c$pseudocodigo$c$, $c$choice$c$, $c$O que é pseudocódigo?$c$, $c$facil$c$, $c$O que é pseudocódigo?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Uma linguagem de programação que o computador executa diretamente","misconception":"acha que o pseudocódigo roda no computador"},{"text":"Um código falso, que não serve para nada","misconception":"acha que \"pseudo\" significa inútil"},{"text":"Uma forma de escrever algoritmos em linguagem próxima do português, para planejar a solução"},{"text":"Um programa escrito em JavaScript","misconception":"confunde pseudocódigo com uma linguagem de programação real"}],"correct":2,"explanation":"Pseudocódigo descreve o algoritmo com palavras comuns e sem regras rígidas. Para o computador executar, é preciso reescrevê-lo em uma linguagem de programação."}$c$::jsonb, $c$Pense em para que ele serve: planejar antes de programar.$c$, 1, false, $c$arquivo$c$),
  ($c$pseudo-comando-de-saida$c$, $c$pseudocodigo$c$, $c$choice$c$, $c$Qual palavra mostra o resultado?$c$, $c$facil$c$, $c$No pseudocódigo desta plataforma, qual comando mostra um resultado ao usuário?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"LEIA","misconception":"confunde mostrar um dado com receber um dado"},{"text":"ESCREVA"},{"text":"INÍCIO","misconception":"confunde o começo do algoritmo com mostrar resultado"},{"text":"FIM","misconception":"confunde encerrar o algoritmo com mostrar o resultado"}],"correct":1,"explanation":"ESCREVA é o comando de saída. LEIA é de entrada, e INÍCIO e FIM apenas marcam onde o algoritmo começa e termina."}$c$::jsonb, $c$O resultado é uma saída.$c$, 2, false, $c$arquivo$c$),
  ($c$pseudo-complete-saudacao$c$, $c$pseudocodigo$c$, $c$blank$c$, $c$Complete o pseudocódigo$c$, $c$facil$c$, $c$Complete o pseudocódigo que lê um nome e escreve uma saudação.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"INÍCIO\n  {{1}} nome\n  ESCREVA \"Olá, \", nome\n{{2}}","blanks":[{"answers":["LEIA","leia","Leia"]},{"answers":["FIM","fim","Fim"]}],"explanation":"LEIA recebe o nome (entrada), ESCREVA mostra a saudação (saída) e FIM encerra o algoritmo."}$c$::jsonb, $c$Uma palavra recebe o nome; a outra encerra o algoritmo.$c$, 3, false, $c$arquivo$c$),
  ($c$pseudo-soma$c$, $c$pseudocodigo$c$, $c$interpretation$c$, $c$O que será escrito?$c$, $c$medio$c$, $c$O usuário digita 3 e depois 4. O que o algoritmo abaixo escreve?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"34","misconception":"junta os valores em vez de somá-los"},{"text":"a + b","misconception":"escreve a fórmula em vez do resultado da conta"},{"text":"3 e 4","misconception":"acha que ESCREVA mostra as entradas lidas"},{"text":"7"}],"correct":3,"code":"INÍCIO\n  LEIA a\n  LEIA b\n  soma ← a + b\n  ESCREVA soma\nFIM","explanation":"a recebe 3 e b recebe 4. A linha soma ← a + b guarda 7 em soma, e ESCREVA mostra esse valor."}$c$::jsonb, $c$Siga as linhas de cima para baixo, guardando o valor de cada variável.$c$, 4, false, $c$arquivo$c$),
  ($c$pseudo-desconto$c$, $c$pseudocodigo$c$, $c$interpretation$c$, $c$Qual é o total?$c$, $c$medio$c$, $c$O usuário digita 200. O que o algoritmo abaixo escreve?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"180"},{"text":"20","misconception":"mostra o desconto em vez do total"},{"text":"200","misconception":"ignora as contas e mostra a entrada"},{"text":"220","misconception":"soma o desconto em vez de subtraí-lo"}],"correct":0,"code":"INÍCIO\n  LEIA preco\n  desconto ← preco * 0,1\n  total ← preco - desconto\n  ESCREVA total\nFIM","explanation":"O desconto é 200 * 0,1 = 20. O total é 200 - 20 = 180, e é isso que ESCREVA mostra."}$c$::jsonb, $c$Calcule primeiro o desconto e depois o total.$c$, 5, false, $c$arquivo$c$),
  ($c$pseudo-ordene-o-algoritmo$c$, $c$pseudocodigo$c$, $c$order$c$, $c$Ordene as linhas do pseudocódigo$c$, $c$dificil$c$, $c$Coloque as linhas na ordem certa para calcular o preço com desconto de 10%.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["INÍCIO","LEIA preco","desconto ← preco * 0,1","total ← preco - desconto","ESCREVA total","FIM"],"explanation":"Só dá para calcular o desconto depois de ler o preço, e o total só depois do desconto. O resultado é escrito por último, antes do FIM."}$c$::jsonb, $c$Cada linha usa um valor que precisa ter sido calculado antes.$c$, 6, false, $c$arquivo$c$),
  ($c$fluxo-simbolo-da-decisao$c$, $c$fluxogramas$c$, $c$choice$c$, $c$Qual símbolo representa uma decisão?$c$, $c$facil$c$, $c$Qual símbolo do fluxograma representa uma decisão, isto é, uma pergunta com resposta Sim ou Não?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Retângulo","misconception":"confunde processamento com decisão"},{"text":"Oval","misconception":"confunde o início e o fim do algoritmo com uma decisão"},{"text":"Losango"},{"text":"Seta","misconception":"confunde o caminho do fluxo com a decisão"}],"correct":2,"explanation":"O losango faz uma pergunta e, de acordo com a resposta, o fluxo segue por um de dois caminhos: Sim ou Não."}$c$::jsonb, $c$É o símbolo que abre dois caminhos.$c$, 1, false, $c$arquivo$c$),
  ($c$fluxo-o-que-as-setas-indicam$c$, $c$fluxogramas$c$, $c$choice$c$, $c$O que as setas indicam?$c$, $c$facil$c$, $c$O que as setas indicam em um fluxograma?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"A importância de cada passo","misconception":"acha que a seta indica prioridade"},{"text":"A ordem, isto é, o caminho que o algoritmo segue"},{"text":"Que o passo anterior deve ser repetido","misconception":"confunde a seta de sequência com repetição"},{"text":"O tamanho do algoritmo","misconception":"associa as setas a uma medida e não ao fluxo"}],"correct":1,"explanation":"As setas ligam um passo ao próximo e mostram a ordem de execução."}$c$::jsonb, $c$Pense no que você faz para ler o fluxograma de um passo ao seguinte.$c$, 2, false, $c$arquivo$c$),
  ($c$fluxo-simbolo-da-entrada$c$, $c$fluxogramas$c$, $c$choice$c$, $c$Qual símbolo para ler um dado?$c$, $c$facil$c$, $c$No fluxograma, "Ler idade" deve ser desenhado com qual símbolo?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Losango","misconception":"confunde entrada de dados com decisão"},{"text":"Oval","misconception":"confunde entrada de dados com o início do algoritmo"},{"text":"Retângulo","misconception":"confunde entrada de dados com processamento"},{"text":"Paralelogramo, o símbolo de entrada e saída"}],"correct":3,"explanation":"Entrada e saída de dados usam o paralelogramo. O retângulo é para cálculos e ações."}$c$::jsonb, $c$Ler um dado é uma entrada.$c$, 3, false, $c$arquivo$c$),
  ($c$fluxo-dobro$c$, $c$fluxogramas$c$, $c$interpretation$c$, $c$O que será escrito?$c$, $c$medio$c$, $c$Siga as setas do fluxograma abaixo. Se numero for 5, o que será escrito?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"10"},{"text":"5","misconception":"acha que o fluxograma mostra a entrada e não o resultado do cálculo"},{"text":"7","misconception":"soma 2 em vez de multiplicar por 2"},{"text":"dobro","misconception":"escreve o nome da variável em vez do valor guardado nela"}],"correct":0,"code":"(INÍCIO)\n   ↓\n/ Ler numero /\n   ↓\n[ dobro ← numero * 2 ]\n   ↓\n/ Escrever dobro /\n   ↓\n(FIM)","explanation":"numero vale 5. O retângulo calcula dobro ← 5 * 2 = 10, e o paralelogramo de saída escreve esse valor."}$c$::jsonb, $c$Siga as setas e acompanhe o valor de cada variável.$c$, 4, false, $c$arquivo$c$),
  ($c$fluxo-maior-de-idade$c$, $c$fluxogramas$c$, $c$interpretation$c$, $c$Qual caminho é seguido?$c$, $c$medio$c$, $c$Siga o fluxograma abaixo. Se a idade digitada for 16, o que será escrito?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Maior de idade","misconception":"segue o caminho do Sim sem avaliar a condição"},{"text":"Maior de idade e Menor de idade","misconception":"acha que os dois caminhos da decisão são executados"},{"text":"Menor de idade"},{"text":"Nada: o fluxograma termina na decisão","misconception":"acha que a decisão não leva a nenhum caminho"}],"correct":2,"code":"(INÍCIO)\n   ↓\n/ Ler idade /\n   ↓\n< idade ≥ 18? >\n  Sim → / Escrever \"Maior de idade\" /\n  Não → / Escrever \"Menor de idade\" /\n   ↓\n(FIM)","explanation":"16 não é maior ou igual a 18, então a resposta é Não e o fluxo segue pelo caminho do Não: Menor de idade."}$c$::jsonb, $c$Responda à pergunta do losango com a idade 16.$c$, 5, false, $c$arquivo$c$),
  ($c$fluxo-guarda-chuva$c$, $c$fluxogramas$c$, $c$choice$c$, $c$Qual fluxograma está correto?$c$, $c$dificil$c$, $c$Qual destes trechos de fluxograma representa corretamente: "se estiver chovendo, levo o guarda-chuva; senão, não levo"?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"[ Está chovendo? ]\nSim → [ Levar guarda-chuva ]\nNão → [ Não levar guarda-chuva ]","misconception":"usa um retângulo (processamento) onde seria preciso um losango (decisão)"},{"text":"< Está chovendo? >\nSim → [ Levar guarda-chuva ]\nNão → [ Não levar guarda-chuva ]"},{"text":"< Está chovendo? >\nSim → [ Levar guarda-chuva ]","misconception":"esquece o caminho do Não: o que fazer se a resposta for outra?"},{"text":"[ Levar guarda-chuva ]\n[ Não levar guarda-chuva ]","misconception":"coloca os dois passos em sequência, sem decisão: os dois seriam executados"}],"correct":1,"explanation":"A decisão pede um losango com a pergunta e dois caminhos: um para Sim e outro para Não. Sem isso, o fluxo executaria passos que não deveriam ser executados."}$c$::jsonb, $c$Uma decisão precisa de um losango e de um caminho para cada resposta.$c$, 6, false, $c$arquivo$c$),
  ($c$desafio1-trocar-o-pneu$c$, $c$desafio-do-mundo-1$c$, $c$order$c$, $c$Desafio: trocar o pneu de um carro$c$, $c$dificil$c$, $c$Elabore o algoritmo para trocar o pneu furado de um carro: coloque os passos na ordem certa.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["Estacionar em local plano e acionar o freio de mão","Afrouxar os parafusos da roda com a chave","Levantar o carro com o macaco","Retirar os parafusos e o pneu furado","Colocar o pneu novo e apertar levemente os parafusos","Abaixar o carro","Apertar totalmente os parafusos","Guardar o pneu furado e as ferramentas"],"explanation":"Primeiro garantimos a segurança do carro e afrouxamos os parafusos com o pneu apoiado no chão; só depois levantamos o carro, trocamos o pneu, abaixamos e apertamos tudo."}$c$::jsonb, $c$Por segurança, os parafusos são afrouxados com o carro ainda no chão.$c$, 1, false, $c$arquivo$c$),
  ($c$desafio1-pseudocodigo-da-media$c$, $c$desafio-do-mundo-1$c$, $c$blank$c$, $c$Desafio: pseudocódigo da média$c$, $c$dificil$c$, $c$Complete o pseudocódigo que lê duas notas, calcula a média e escreve o resultado.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"INÍCIO\n  {{1}} nota1\n  {{2}} nota2\n  media {{3}} (nota1 + nota2) / 2\n  {{4}} media\nFIM","blanks":[{"answers":["LEIA","leia","Leia"]},{"answers":["LEIA","leia","Leia"]},{"answers":["←","<-"]},{"answers":["ESCREVA","escreva","Escreva"]}],"explanation":"LEIA recebe as notas (entrada), a seta guarda o resultado da conta (processamento) e ESCREVA mostra a média (saída)."}$c$::jsonb, $c$Duas linhas leem, uma guarda o resultado da conta e outra mostra o resultado.$c$, 2, false, $c$arquivo$c$),
  ($c$desafio1-aprovado-ou-nao$c$, $c$desafio-do-mundo-1$c$, $c$interpretation$c$, $c$Desafio: aprovado ou não?$c$, $c$dificil$c$, $c$Siga o fluxograma abaixo. Se as notas digitadas forem 6 e 8, o que será escrito?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Reprovado","misconception":"trata o valor igual ao limite como se ficasse abaixo dele"},{"text":"7","misconception":"escreve a média em vez do resultado da decisão"},{"text":"Aprovado e Reprovado","misconception":"acha que os dois caminhos da decisão são executados"},{"text":"Aprovado"}],"correct":3,"code":"(INÍCIO)\n   ↓\n/ Ler nota1 /\n/ Ler nota2 /\n   ↓\n[ media ← (nota1 + nota2) / 2 ]\n   ↓\n< media ≥ 7? >\n  Sim → / Escrever \"Aprovado\" /\n  Não → / Escrever \"Reprovado\" /\n   ↓\n(FIM)","explanation":"A média é (6 + 8) / 2 = 7. A condição é media ≥ 7, e 7 é igual a 7, então a resposta é Sim e o fluxo escreve Aprovado."}$c$::jsonb, $c$Calcule a média e responda à pergunta do losango: 7 é maior ou igual a 7?$c$, 3, false, $c$arquivo$c$),
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
  ($c$eps-eco$c$, $c$function eco() {
  const valor = lerEntrada();
  console.log(valor);
}$c$, $c$O programa tem só duas etapas: a entrada (lerEntrada) e a saída (console.log). Aqui não há processamento, porque o valor é mostrado do jeito que chegou.$c$),
  ($c$eps-dobro$c$, $c$function dobro() {
  const n = lerEntrada();
  console.log(n * 2);
}$c$, $c$Agora o programa tem as três etapas: lê o número (entrada), multiplica por 2 (processamento) e mostra o resultado (saída).$c$),
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
  select id from public.exercises where origem = 'arquivo' and id in ($c$o-que-e-algoritmo$c$, $c$ordem-das-instrucoes$c$, $c$valor-da-variavel$c$, $c$completar-condicional$c$, $c$completar-laco$c$, $c$tipos-de-dados$c$, $c$precedencia-operadores$c$, $c$resto-da-divisao$c$, $c$exemplo-interpretacao$c$, $c$exemplo-ordenacao$c$, $c$exemplo-corrigir$c$, $c$exemplo-entrada-saida$c$, $c$prog-o-que-e-programar$c$, $c$prog-quem-e-quem$c$, $c$prog-complete-ola-mundo$c$, $c$prog-ordem-das-instrucoes$c$, $c$prog-texto-ou-conta$c$, $c$prog-quem-responde-pelo-erro$c$, $c$logica-o-que-e$c$, $c$logica-deducao-simples$c$, $c$logica-se-entao-senao$c$, $c$logica-calculo-do-troco$c$, $c$logica-quem-pode-entrar$c$, $c$logica-etapas-do-raciocinio$c$, $c$logica-raciocinio-invertido$c$, $c$algoritmo-qual-e-algoritmo$c$, $c$algoritmo-o-que-nao-precisa$c$, $c$algoritmo-trocar-lampada$c$, $c$algoritmo-contar-ate-tres$c$, $c$algoritmo-instrucao-clara$c$, $c$algoritmo-que-nunca-termina$c$, $c$sequencia-escovar-os-dentes$c$, $c$sequencia-por-que-importa$c$, $c$sequencia-abc$c$, $c$sequencia-ordem-do-programa$c$, $c$sequencia-macarrao$c$, $c$sequencia-saque-no-caixa$c$, $c$eps-o-que-e-entrada$c$, $c$eps-classificar-saida$c$, $c$eps-eco$c$, $c$eps-quais-sao-entrada$c$, $c$eps-qual-e-o-processamento$c$, $c$eps-dobro$c$, $c$eps-soma-de-entradas$c$, $c$pseudo-o-que-e$c$, $c$pseudo-comando-de-saida$c$, $c$pseudo-complete-saudacao$c$, $c$pseudo-soma$c$, $c$pseudo-desconto$c$, $c$pseudo-ordene-o-algoritmo$c$, $c$fluxo-simbolo-da-decisao$c$, $c$fluxo-o-que-as-setas-indicam$c$, $c$fluxo-simbolo-da-entrada$c$, $c$fluxo-dobro$c$, $c$fluxo-maior-de-idade$c$, $c$fluxo-guarda-chuva$c$, $c$desafio1-trocar-o-pneu$c$, $c$desafio1-pseudocodigo-da-media$c$, $c$desafio1-aprovado-ou-nao$c$, $c$tamanho-do-texto$c$, $c$completar-texto$c$, $c$inverter-texto$c$, $c$conta-vogais$c$, $c$palindromo$c$, $c$soma$c$, $c$media$c$, $c$celsius$c$, $c$area-retangulo$c$, $c$quadrado$c$, $c$media-ponderada$c$, $c$completar-media$c$, $c$par-ou-impar$c$, $c$maior-de-tres$c$, $c$nota$c$, $c$bissexto$c$, $c$operadores-logicos$c$, $c$completar-else-if$c$, $c$dentro-do-intervalo$c$, $c$tipo-de-triangulo$c$, $c$somatorio$c$, $c$fatorial$c$, $c$tabuada$c$, $c$primo$c$, $c$quantas-vezes$c$, $c$completar-while$c$, $c$soma-dos-pares$c$, $c$potencia$c$, $c$conta-digitos$c$, $c$mdc$c$, $c$soma-vetor$c$, $c$inverter-vetor$c$, $c$maior-vetor$c$, $c$busca-linear$c$, $c$ordenar$c$, $c$indice-do-vetor$c$, $c$completar-percorrer$c$, $c$conta-pares$c$, $c$media-do-vetor$c$, $c$segundo-maior$c$, $c$parametro-e-retorno$c$, $c$completar-funcao$c$, $c$escopo-de-variavel$c$, $c$maior-de-dois$c$, $c$hipotenusa$c$)
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
  ($c$prog-o-que-e-programar$c$, $c$m1-programacao$c$, 3),
  ($c$prog-quem-e-quem$c$, $c$m1-programacao$c$, 3),
  ($c$prog-complete-ola-mundo$c$, $c$m1-programacao$c$, 2),
  ($c$prog-ordem-das-instrucoes$c$, $c$m1-programacao$c$, 2),
  ($c$prog-ordem-das-instrucoes$c$, $c$m1-sequencia$c$, 1),
  ($c$prog-texto-ou-conta$c$, $c$m1-programacao$c$, 2),
  ($c$prog-quem-responde-pelo-erro$c$, $c$m1-programacao$c$, 3),
  ($c$prog-quem-responde-pelo-erro$c$, $c$m1-logica$c$, 1),
  ($c$logica-o-que-e$c$, $c$m1-logica$c$, 3),
  ($c$logica-deducao-simples$c$, $c$m1-logica$c$, 3),
  ($c$logica-se-entao-senao$c$, $c$m1-logica$c$, 2),
  ($c$logica-calculo-do-troco$c$, $c$m1-logica$c$, 2),
  ($c$logica-calculo-do-troco$c$, $c$m1-algoritmos$c$, 1),
  ($c$logica-quem-pode-entrar$c$, $c$m1-logica$c$, 3),
  ($c$logica-etapas-do-raciocinio$c$, $c$m1-logica$c$, 3),
  ($c$logica-raciocinio-invertido$c$, $c$m1-logica$c$, 3),
  ($c$algoritmo-qual-e-algoritmo$c$, $c$m1-algoritmos$c$, 3),
  ($c$algoritmo-o-que-nao-precisa$c$, $c$m1-algoritmos$c$, 3),
  ($c$algoritmo-trocar-lampada$c$, $c$m1-algoritmos$c$, 2),
  ($c$algoritmo-trocar-lampada$c$, $c$m1-sequencia$c$, 1),
  ($c$algoritmo-contar-ate-tres$c$, $c$m1-algoritmos$c$, 2),
  ($c$algoritmo-instrucao-clara$c$, $c$m1-algoritmos$c$, 3),
  ($c$algoritmo-que-nunca-termina$c$, $c$m1-algoritmos$c$, 3),
  ($c$sequencia-escovar-os-dentes$c$, $c$m1-sequencia$c$, 3),
  ($c$sequencia-por-que-importa$c$, $c$m1-sequencia$c$, 3),
  ($c$sequencia-abc$c$, $c$m1-sequencia$c$, 3),
  ($c$sequencia-ordem-do-programa$c$, $c$m1-sequencia$c$, 3),
  ($c$sequencia-ordem-do-programa$c$, $c$m1-programacao$c$, 1),
  ($c$sequencia-macarrao$c$, $c$m1-sequencia$c$, 3),
  ($c$sequencia-saque-no-caixa$c$, $c$m1-sequencia$c$, 3),
  ($c$sequencia-saque-no-caixa$c$, $c$m1-algoritmos$c$, 1),
  ($c$eps-o-que-e-entrada$c$, $c$m1-entrada-processamento-saida$c$, 3),
  ($c$eps-classificar-saida$c$, $c$m1-entrada-processamento-saida$c$, 3),
  ($c$eps-eco$c$, $c$m1-entrada-processamento-saida$c$, 3),
  ($c$eps-quais-sao-entrada$c$, $c$m1-entrada-processamento-saida$c$, 3),
  ($c$eps-qual-e-o-processamento$c$, $c$m1-entrada-processamento-saida$c$, 3),
  ($c$eps-dobro$c$, $c$m1-entrada-processamento-saida$c$, 3),
  ($c$eps-soma-de-entradas$c$, $c$m1-entrada-processamento-saida$c$, 3),
  ($c$pseudo-o-que-e$c$, $c$m1-pseudocodigo$c$, 3),
  ($c$pseudo-comando-de-saida$c$, $c$m1-pseudocodigo$c$, 3),
  ($c$pseudo-comando-de-saida$c$, $c$m1-entrada-processamento-saida$c$, 1),
  ($c$pseudo-complete-saudacao$c$, $c$m1-pseudocodigo$c$, 2),
  ($c$pseudo-complete-saudacao$c$, $c$m1-entrada-processamento-saida$c$, 1),
  ($c$pseudo-soma$c$, $c$m1-pseudocodigo$c$, 3),
  ($c$pseudo-desconto$c$, $c$m1-pseudocodigo$c$, 3),
  ($c$pseudo-desconto$c$, $c$m1-entrada-processamento-saida$c$, 1),
  ($c$pseudo-ordene-o-algoritmo$c$, $c$m1-pseudocodigo$c$, 3),
  ($c$pseudo-ordene-o-algoritmo$c$, $c$m1-sequencia$c$, 2),
  ($c$fluxo-simbolo-da-decisao$c$, $c$m1-fluxogramas$c$, 3),
  ($c$fluxo-o-que-as-setas-indicam$c$, $c$m1-fluxogramas$c$, 3),
  ($c$fluxo-o-que-as-setas-indicam$c$, $c$m1-sequencia$c$, 1),
  ($c$fluxo-simbolo-da-entrada$c$, $c$m1-fluxogramas$c$, 3),
  ($c$fluxo-simbolo-da-entrada$c$, $c$m1-entrada-processamento-saida$c$, 1),
  ($c$fluxo-dobro$c$, $c$m1-fluxogramas$c$, 3),
  ($c$fluxo-dobro$c$, $c$m1-entrada-processamento-saida$c$, 1),
  ($c$fluxo-maior-de-idade$c$, $c$m1-fluxogramas$c$, 3),
  ($c$fluxo-maior-de-idade$c$, $c$m1-logica$c$, 1),
  ($c$fluxo-guarda-chuva$c$, $c$m1-fluxogramas$c$, 3),
  ($c$fluxo-guarda-chuva$c$, $c$m1-logica$c$, 2),
  ($c$desafio1-trocar-o-pneu$c$, $c$m1-algoritmos$c$, 2),
  ($c$desafio1-trocar-o-pneu$c$, $c$m1-sequencia$c$, 2),
  ($c$desafio1-trocar-o-pneu$c$, $c$m1-logica$c$, 1),
  ($c$desafio1-pseudocodigo-da-media$c$, $c$m1-pseudocodigo$c$, 2),
  ($c$desafio1-pseudocodigo-da-media$c$, $c$m1-entrada-processamento-saida$c$, 2),
  ($c$desafio1-pseudocodigo-da-media$c$, $c$m1-sequencia$c$, 1),
  ($c$desafio1-aprovado-ou-nao$c$, $c$m1-fluxogramas$c$, 2),
  ($c$desafio1-aprovado-ou-nao$c$, $c$m1-logica$c$, 2),
  ($c$desafio1-aprovado-ou-nao$c$, $c$m1-entrada-processamento-saida$c$, 1),
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
  select count(*) into n from public.exercises where origem = 'painel' and id in ($c$o-que-e-algoritmo$c$, $c$ordem-das-instrucoes$c$, $c$valor-da-variavel$c$, $c$completar-condicional$c$, $c$completar-laco$c$, $c$tipos-de-dados$c$, $c$precedencia-operadores$c$, $c$resto-da-divisao$c$, $c$exemplo-interpretacao$c$, $c$exemplo-ordenacao$c$, $c$exemplo-corrigir$c$, $c$exemplo-entrada-saida$c$, $c$prog-o-que-e-programar$c$, $c$prog-quem-e-quem$c$, $c$prog-complete-ola-mundo$c$, $c$prog-ordem-das-instrucoes$c$, $c$prog-texto-ou-conta$c$, $c$prog-quem-responde-pelo-erro$c$, $c$logica-o-que-e$c$, $c$logica-deducao-simples$c$, $c$logica-se-entao-senao$c$, $c$logica-calculo-do-troco$c$, $c$logica-quem-pode-entrar$c$, $c$logica-etapas-do-raciocinio$c$, $c$logica-raciocinio-invertido$c$, $c$algoritmo-qual-e-algoritmo$c$, $c$algoritmo-o-que-nao-precisa$c$, $c$algoritmo-trocar-lampada$c$, $c$algoritmo-contar-ate-tres$c$, $c$algoritmo-instrucao-clara$c$, $c$algoritmo-que-nunca-termina$c$, $c$sequencia-escovar-os-dentes$c$, $c$sequencia-por-que-importa$c$, $c$sequencia-abc$c$, $c$sequencia-ordem-do-programa$c$, $c$sequencia-macarrao$c$, $c$sequencia-saque-no-caixa$c$, $c$eps-o-que-e-entrada$c$, $c$eps-classificar-saida$c$, $c$eps-eco$c$, $c$eps-quais-sao-entrada$c$, $c$eps-qual-e-o-processamento$c$, $c$eps-dobro$c$, $c$eps-soma-de-entradas$c$, $c$pseudo-o-que-e$c$, $c$pseudo-comando-de-saida$c$, $c$pseudo-complete-saudacao$c$, $c$pseudo-soma$c$, $c$pseudo-desconto$c$, $c$pseudo-ordene-o-algoritmo$c$, $c$fluxo-simbolo-da-decisao$c$, $c$fluxo-o-que-as-setas-indicam$c$, $c$fluxo-simbolo-da-entrada$c$, $c$fluxo-dobro$c$, $c$fluxo-maior-de-idade$c$, $c$fluxo-guarda-chuva$c$, $c$desafio1-trocar-o-pneu$c$, $c$desafio1-pseudocodigo-da-media$c$, $c$desafio1-aprovado-ou-nao$c$, $c$tamanho-do-texto$c$, $c$completar-texto$c$, $c$inverter-texto$c$, $c$conta-vogais$c$, $c$palindromo$c$, $c$soma$c$, $c$media$c$, $c$celsius$c$, $c$area-retangulo$c$, $c$quadrado$c$, $c$media-ponderada$c$, $c$completar-media$c$, $c$par-ou-impar$c$, $c$maior-de-tres$c$, $c$nota$c$, $c$bissexto$c$, $c$operadores-logicos$c$, $c$completar-else-if$c$, $c$dentro-do-intervalo$c$, $c$tipo-de-triangulo$c$, $c$somatorio$c$, $c$fatorial$c$, $c$tabuada$c$, $c$primo$c$, $c$quantas-vezes$c$, $c$completar-while$c$, $c$soma-dos-pares$c$, $c$potencia$c$, $c$conta-digitos$c$, $c$mdc$c$, $c$soma-vetor$c$, $c$inverter-vetor$c$, $c$maior-vetor$c$, $c$busca-linear$c$, $c$ordenar$c$, $c$indice-do-vetor$c$, $c$completar-percorrer$c$, $c$conta-pares$c$, $c$media-do-vetor$c$, $c$segundo-maior$c$, $c$parametro-e-retorno$c$, $c$completar-funcao$c$, $c$escopo-de-variavel$c$, $c$maior-de-dois$c$, $c$hipotenusa$c$);
  if n > 0 then
    raise notice '% exercício(s) do conteúdo foram ignorados porque foram editados no painel do professor.', n;
  end if;
end $$;
