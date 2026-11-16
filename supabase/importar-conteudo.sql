-- GERADO por "npm run content:build" a partir de content/. Não edite à mão.
-- Importa mundos, conceitos, lições e exercícios. Pode ser executado várias vezes (idempotente).
-- Requer as migrations até a 0013. Não altera "published" nem "position" de exercícios que já existem
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

insert into public.modules (id, title, focus, intro, example, review, world_id, position, optional, origem) values
  ($c$primeiros-passos$c$, $c$Primeiros passos$c$, $c$Entender o que é um algoritmo e como o computador segue instruções$c$, $c$Um algoritmo é uma sequência de passos para resolver um problema, como uma receita de bolo. O computador só faz o que mandamos, na ordem em que mandamos, e por isso cada passo precisa ser claro.

Neste módulo você vai conhecer o vocabulário básico: valores, tipos (número, texto, lógico) e operadores. Não se preocupe em decorar: errar faz parte, e cada exercício explica a resposta.$c$, $c$$c$, $c$$c$, $c$mundo-1$c$, 100, false, $c$arquivo$c$),
  ($c$exemplos-dos-tipos$c$, $c$Exemplos dos tipos de exercício$c$, $c$Modelos para o professor copiar (rascunhos)$c$, $c$Esta lição reúne um exemplo de cada tipo novo de exercício, como modelo para escrever os seus. Todos estão como rascunho: só o professor os vê.$c$, $c$$c$, $c$$c$, $c$mundo-1$c$, 999, false, $c$arquivo$c$),
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
- console.log mostra um resultado na tela.$c$, $c$mundo-1$c$, 101, false, $c$arquivo$c$),
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
- Não é preciso decorar comandos para começar: é preciso treinar o raciocínio.$c$, $c$mundo-1$c$, 102, false, $c$arquivo$c$),
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
- O algoritmo é a ideia; o programa é o algoritmo escrito em uma linguagem de programação.$c$, $c$mundo-1$c$, 103, false, $c$arquivo$c$),
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
- O computador executa as instruções de cima para baixo, uma por vez.$c$, $c$mundo-1$c$, 104, false, $c$arquivo$c$),
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
- Mostrar um resultado é saída; calcular é processamento; receber um valor é entrada.$c$, $c$mundo-1$c$, 105, false, $c$arquivo$c$),
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
- INÍCIO e FIM delimitam o algoritmo, que é lido de cima para baixo.$c$, $c$mundo-1$c$, 106, false, $c$arquivo$c$),
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
- Em uma decisão, só um dos caminhos é seguido, de acordo com a resposta.$c$, $c$mundo-1$c$, 107, false, $c$arquivo$c$),
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
- Testar o algoritmo com um caso simples ajuda a encontrar erros de raciocínio.$c$, $c$mundo-1$c$, 108, false, $c$arquivo$c$),
  ($c$textos$c$, $c$Textos$c$, $c$Percorrer e transformar sequências de caracteres$c$, $c$Um texto (string) é uma sequência de caracteres entre aspas. Cada caractere tem uma posição, começando em 0:

const palavra = "casa";
palavra[0] // "c"
palavra.length // 4

Dá para percorrer um texto com um laço, como num vetor. Lembre que maiúsculas e minúsculas são caracteres diferentes: "A" não é igual a "a".$c$, $c$$c$, $c$$c$, $c$mundo-2$c$, 290, false, $c$arquivo$c$),
  ($c$introducao-as-variaveis$c$, $c$Introdução às variáveis$c$, $c$Entender a variável como um nome que guarda um valor$c$, $c$Um programa precisa guardar informações: o nome de uma pessoa, uma idade, um saldo. Para isso usamos variáveis.

Uma variável é um nome que guarda um valor na memória do computador. Pense em uma caixa com uma etiqueta: a etiqueta é o nome da variável e o que está dentro da caixa é o valor. Quando precisamos do valor, chamamos a variável pelo nome.

O valor pode mudar ao longo do programa (daí o nome "variável"). Para guardar um valor em uma variável, usamos o sinal =. Atenção: em programação, = não significa "igual a" como na matemática. Ele manda guardar: "idade = 21" lê-se "idade recebe 21". Isso se chama atribuição.$c$, $c$let idade = 20;
console.log(idade);   // mostra 20

idade = 21;           // troca o valor guardado
console.log(idade);   // mostra 21

Passo a passo:
1. let idade = 20; cria a variável idade e guarda o valor 20 nela.
2. console.log(idade); mostra o valor guardado (20), e não a palavra "idade".
3. idade = 21; substitui o valor antigo por 21. O 20 se perde.
4. O último console.log mostra 21.

Repare que o nome da variável não vai entre aspas: as aspas serviriam para mostrar o texto "idade" em vez do valor.$c$, $c$- Variável é um nome que guarda um valor na memória.
- O valor guardado pode mudar durante o programa.
- O sinal = guarda um valor na variável (atribuição); não é "igual" da matemática.
- Para usar o valor, escrevemos o nome da variável, sem aspas.
- Ao guardar um novo valor, o antigo é substituído.$c$, $c$mundo-2$c$, 201, false, $c$arquivo$c$),
  ($c$declaracao-de-variaveis$c$, $c$Declaração de variáveis$c$, $c$Declarar variáveis e escolher nomes válidos$c$, $c$Declarar uma variável é criá-la. Em JavaScript usamos a palavra let, seguida do nome. Podemos já guardar um valor (inicializar) ou deixar a variável sem valor, e então ela vale undefined, que significa "ainda não tem valor".

Regras para os nomes:
- podem ter letras, números, _ e $;
- não podem começar com número nem ter espaços;
- não podem ser palavras reservadas da linguagem (let, const, if...);
- maiúsculas e minúsculas fazem diferença: idade e Idade são variáveis diferentes.

Boas práticas: use nomes que expliquem o conteúdo (notaFinal, e não x) e o estilo camelCase (a primeira palavra em minúsculas e as seguintes com inicial maiúscula). Cada instrução termina com ponto e vírgula.$c$, $c$let nome = "Ana";        // declara e já guarda um valor
let idade;               // declara sem valor
console.log(idade);      // undefined
idade = 30;              // agora guarda 30
let notaFinal = 8.5;     // nome em camelCase

Passo a passo:
1. let nome = "Ana"; cria a variável nome e guarda o texto Ana.
2. let idade; cria a variável, mas ela ainda não tem valor: vale undefined.
3. idade = 30; guarda o valor depois. Aqui não usamos let de novo, porque a variável já existe.
4. notaFinal é um nome claro e segue o camelCase.$c$, $c$- let cria uma variável: let nome = valor;
- Sem valor inicial, a variável vale undefined.
- Nomes: letras, números, _ e $; sem espaços; não começam com número; não podem ser palavras reservadas.
- Maiúsculas e minúsculas são diferentes: idade e Idade não são a mesma variável.
- Prefira nomes claros em camelCase.$c$, $c$mundo-2$c$, 202, false, $c$arquivo$c$),
  ($c$let-e-const$c$, $c$Utilização de let e const$c$, $c$Escolher entre let (valor muda) e const (valor fixo)$c$, $c$Há duas formas de declarar uma variável em JavaScript:
- let: o valor pode ser trocado depois.
- const: o valor é fixo. Depois de guardado, não pode ser substituído, e a variável precisa receber o valor na própria declaração.

Se o programa tentar mudar uma const, ele para com o erro "Assignment to constant variable".

Regra prática: use const para o que não muda (o valor de PI, uma taxa, o nome do curso) e let para o que muda (um contador, um saldo, uma pontuação). Assim quem lê o código sabe, só pela palavra, se o valor pode mudar. Existe também a palavra var, mais antiga; neste curso usamos só let e const.$c$, $c$const PI = 3.14159;     // não muda
let raio = 2;           // pode mudar
raio = 5;               // ok: let aceita um novo valor
// PI = 3;              // ERRO: Assignment to constant variable
console.log(PI * raio); // 15.70795

Passo a passo:
1. PI é uma const: o valor 3.14159 nunca muda.
2. raio é uma let: começa em 2 e depois recebe 5.
3. A linha comentada com // tentaria mudar a const PI e causaria um erro, por isso ela está desativada.
4. O resultado é 3.14159 * 5 = 15.70795.$c$, $c$- let: o valor pode mudar. const: o valor é fixo.
- const precisa receber o valor na declaração.
- Mudar uma const causa o erro "Assignment to constant variable".
- Use const por padrão e let só quando o valor precisar mudar.
- Não declare a mesma variável duas vezes no mesmo lugar.$c$, $c$mundo-2$c$, 203, false, $c$arquivo$c$),
  ($c$tipo-string$c$, $c$Tipo String$c$, $c$Reconhecer e escrever textos (strings)$c$, $c$Todo valor tem um tipo, que define o que ele é e o que podemos fazer com ele. O primeiro tipo que vamos estudar é a string: um texto, isto é, uma sequência de caracteres entre aspas.

- Podemos usar aspas duplas ("Ana"), aspas simples ('Ana') ou crases (veremos mais adiante). A aspa que abre precisa ser a mesma que fecha.
- O texto vazio ("") também é uma string.
- Atenção: "42" entre aspas é um texto, e não um número. O que está entre aspas é tratado como texto, mesmo que pareça outra coisa.
- Sem aspas, o computador entende que Ana é o nome de uma variável, e não um texto.

Para descobrir o tipo de um valor usamos typeof.$c$, $c$const nome = "Ana";
const sobrenome = 'Lima';
const vazio = "";
const numeroEmTexto = "42";

console.log(typeof nome);          // string
console.log(typeof numeroEmTexto); // string (as aspas fazem dele um texto)
console.log(typeof 42);            // number (sem aspas, é um número)
console.log('Ele disse "oi"');     // Ele disse "oi"

Passo a passo:
1. As quatro primeiras linhas guardam textos, com aspas duplas ou simples.
2. typeof mostra o tipo: "42" é string, mas 42 sem aspas é number.
3. Para mostrar aspas dentro do texto, usamos outro tipo de aspas por fora: por fora aspas simples, por dentro aspas duplas.$c$, $c$- String é um texto: uma sequência de caracteres entre aspas.
- As aspas que abrem e fecham devem ser do mesmo tipo.
- "42" entre aspas é texto, não número.
- Sem aspas, o nome é entendido como uma variável.
- typeof mostra o tipo de um valor.$c$, $c$mundo-2$c$, 204, false, $c$arquivo$c$),
  ($c$tipo-number$c$, $c$Tipo Number$c$, $c$Reconhecer e escrever números (inteiros e decimais)$c$, $c$O tipo number guarda números. Em JavaScript, inteiros (7, -2) e decimais (3.14) são o mesmo tipo: number.

Pontos importantes:
- Números não levam aspas. Com aspas, viram texto.
- O separador decimal é o ponto (3.5), e não a vírgula.
- Podemos fazer contas com + (soma), - (subtração), * (multiplicação) e / (divisão). Veremos todos os operadores com calma no Mundo 3.
- Algumas contas têm resultados especiais: dividir por zero dá Infinity, e uma conta sem sentido, como "abc" * 2, dá NaN (a sigla de "Not a Number", ou "não é um número").$c$, $c$const inteiro = 7;
const decimal = 3.14;
const negativo = -2;

console.log(typeof inteiro);   // number
console.log(typeof decimal);   // number (decimal também é number)
console.log(10 / 4);           // 2.5
console.log(10 / 0);           // Infinity
console.log("abc" * 2);        // NaN

Passo a passo:
1. Inteiros, decimais e negativos são todos do tipo number.
2. 10 / 4 dá 2.5: a divisão em JavaScript não arredonda sozinha.
3. Dividir por zero não causa erro: o resultado é Infinity.
4. Multiplicar um texto que não é número por 2 não faz sentido: o resultado é NaN.$c$, $c$- number é o tipo dos números, inteiros ou decimais.
- Números não levam aspas e usam ponto como separador decimal.
- 10 / 0 resulta em Infinity.
- NaN significa "não é um número" e aparece em contas sem sentido.
- typeof mostra number para qualquer número, inclusive NaN.$c$, $c$mundo-2$c$, 205, false, $c$arquivo$c$),
  ($c$tipo-boolean$c$, $c$Tipo Boolean$c$, $c$Reconhecer valores lógicos: true e false$c$, $c$O tipo boolean tem apenas dois valores: true (verdadeiro) e false (falso). Eles são escritos em minúsculas e sem aspas. Com aspas, "true" vira um texto; com letra maiúscula, True não existe em JavaScript.

Valores booleanos aparecem como resposta a perguntas: "5 é maior que 3?" (true), "2 é maior que 10?" (false). Usamos os operadores de comparação: > (maior), < (menor), >= (maior ou igual), <= (menor ou igual) e === (igual). Você vai estudá-los com calma no Mundo 3.

No Mundo 4, os booleanos serão a base das decisões do programa: se a resposta for true, fazemos uma coisa; se for false, outra.$c$, $c$const maiorDeIdade = true;
const temDesconto = false;

console.log(typeof maiorDeIdade);  // boolean
console.log(5 > 3);                // true
console.log(2 > 10);               // false
console.log("true");               // true (mas aqui é um texto!)

Passo a passo:
1. true e false, sem aspas, são valores boolean.
2. Uma comparação como 5 > 3 é uma pergunta, e a resposta é um boolean.
3. A última linha mostra o texto true. Na tela parece igual ao valor lógico, mas o tipo é string.$c$, $c$- boolean tem só dois valores: true e false (minúsculos, sem aspas).
- Comparações (>, <, >=, <=, ===) resultam em boolean.
- "true" entre aspas é texto, não boolean.
- True com T maiúsculo não existe em JavaScript.
- Booleanos serão a base das decisões do programa.$c$, $c$mundo-2$c$, 206, false, $c$arquivo$c$),
  ($c$manipulacao-de-textos$c$, $c$Manipulação de textos$c$, $c$Consultar e transformar textos com propriedades e métodos$c$, $c$Os textos têm ferramentas prontas, que chamamos com um ponto depois do texto:
- .length: quantos caracteres o texto tem (é uma propriedade, sem parênteses).
- .toUpperCase() e .toLowerCase(): devolvem o texto em maiúsculas ou minúsculas.
- .trim(): remove os espaços do início e do fim.
- .includes("x"): diz (true ou false) se o texto contém "x".
- .indexOf("x"): devolve a posição de "x", ou -1 se não achar.
- .slice(inicio, fim): devolve um pedaço do texto.

As posições (índices) começam em 0: o primeiro caractere é texto[0]. Os métodos não alteram o texto original: eles devolvem um novo valor.$c$, $c$const nome = "  Ana Lima ";
console.log(nome.length);        // 11
console.log(nome.trim());        // Ana Lima

const t = "lógica";
console.log(t.toUpperCase());    // LÓGICA
console.log(t[0]);               // l
console.log(t.slice(0, 3));      // lóg
console.log(t.includes("gi"));   // true
console.log(t.indexOf("g"));     // 2
console.log(t.indexOf("z"));     // -1

Passo a passo:
1. O texto "  Ana Lima " tem 11 caracteres, contando os espaços. trim() devolve Ana Lima, sem os espaços das pontas.
2. Em "lógica", as posições são l=0, ó=1, g=2, i=3, c=4, a=5.
3. slice(0, 3) pega das posições 0 até 2 (o 3 não entra): lóg.
4. indexOf devolve -1 quando o pedaço não existe.$c$, $c$- .length dá o tamanho do texto; os índices começam em 0.
- toUpperCase, toLowerCase e trim devolvem um novo texto.
- includes responde true ou false; indexOf devolve a posição ou -1.
- slice(inicio, fim) inclui o início e não inclui o fim.
- Os métodos não mudam o texto original.$c$, $c$mundo-2$c$, 207, false, $c$arquivo$c$),
  ($c$concatenacao$c$, $c$Concatenação$c$, $c$Juntar textos com o operador +$c$, $c$Concatenar é juntar textos. Em JavaScript, usamos o operador +.

- "Bom" + "dia" resulta em "Bomdia": o + não coloca espaço, então precisamos escrevê-lo: "Bom" + " " + "dia".
- Quando um dos lados é texto, o + junta em vez de somar. Por isso "Idade: " + 20 resulta em "Idade: 20".
- Cuidado: "5" + 3 resulta em "53" (junção de textos), mas 5 + 3 resulta em 8 (soma de números).
- Quando há vários + seguidos, o computador resolve da esquerda para a direita, trocando de comportamento assim que aparece um texto: 1 + 2 + "3" resulta em "33" e "1" + 2 + 3 resulta em "123".$c$, $c$const nome = "Ana";
const sobrenome = "Lima";
console.log(nome + sobrenome);          // AnaLima
console.log(nome + " " + sobrenome);    // Ana Lima
console.log("Idade: " + 20);            // Idade: 20
console.log("5" + 3);                   // 53
console.log(5 + 3);                     // 8

Passo a passo:
1. Sem espaço entre as variáveis, os textos grudam: AnaLima.
2. O espaço entra como um texto pequeno: " ".
3. Um número ao lado de um texto vira texto: "Idade: " + 20 dá "Idade: 20".
4. "5" + 3 junta (53), mas 5 + 3 soma (8). A diferença está nas aspas.$c$, $c$- O operador + junta textos (concatenação).
- O + não coloca espaços sozinho: escreva-os entre aspas.
- Se um dos lados é texto, o + junta; se os dois são números, soma.
- "5" + 3 é "53", e 5 + 3 é 8.
- Em uma sequência de +, a conta vai da esquerda para a direita.$c$, $c$mundo-2$c$, 208, false, $c$arquivo$c$),
  ($c$template-literals$c$, $c$Template literals$c$, $c$Montar textos com variáveis usando crases e ${ }$c$, $c$Montar frases com + pode ficar confuso: "Olá, " + nome + "! Você tem " + idade + " anos.". Os template literals tornam isso mais fácil.

Um template literal é um texto escrito entre crases (`), a tecla do acento grave. Dentro dele, usamos ${ } para inserir o valor de uma variável ou o resultado de uma conta. Os espaços e a pontuação ficam exatamente como escritos.

Atenção: só as crases fazem a substituição. Com aspas comuns, o texto ${nome} aparece literalmente na tela, sem trocar pelo valor da variável.$c$, $c$const nome = "Ana";
const idade = 20;

console.log(`Olá, ${nome}! Você tem ${idade} anos.`);
// Olá, Ana! Você tem 20 anos.

console.log(`O dobro de ${idade} é ${idade * 2}.`);
// O dobro de 20 é 40.

console.log("Olá, ${nome}");
// Olá, ${nome}   (aspas comuns não substituem nada)

Passo a passo:
1. O texto está entre crases e cada ${ } é trocado pelo valor que tem dentro.
2. Dentro do ${ } cabe até uma conta: ${idade * 2} vira 40.
3. Na última linha, as aspas comuns mostram o texto literalmente.$c$, $c$- Template literal é um texto entre crases (`).
- ${ } insere o valor de uma variável ou de uma expressão.
- Só as crases fazem a substituição; aspas comuns não.
- Facilita montar frases com várias variáveis, sem muitos +.$c$, $c$mundo-2$c$, 209, false, $c$arquivo$c$),
  ($c$operacoes-com-numeros$c$, $c$Operações com números$c$, $c$Fazer contas com números e variáveis$c$, $c$Com números, o computador faz contas:
- + soma, - subtração, * multiplicação, / divisão;
- % resto da divisão (7 % 2 vale 1);
- ** potência (2 ** 3 vale 8).

Como na matemática, multiplicação, divisão e resto são feitos antes de soma e subtração, e os parênteses mudam a ordem: 2 + 3 * 4 vale 14, mas (2 + 3) * 4 vale 20.

Para arredondar, usamos Math.round (para o inteiro mais próximo) e Math.floor (para baixo). As contas podem usar variáveis, e o resultado pode ser guardado em outra variável.$c$, $c$const a = 7;
const b = 2;
console.log(a + b);             // 9
console.log(a - b);             // 5
console.log(a * b);             // 14
console.log(a / b);             // 3.5
console.log(a % b);             // 1 (resto de 7 dividido por 2)
console.log(a ** b);            // 49 (7 elevado a 2)
console.log(Math.round(3.6));   // 4
console.log(Math.floor(3.9));   // 3

Passo a passo:
1. Cada linha faz uma conta com as variáveis a e b e mostra o resultado.
2. 7 % 2 dá 1, porque 7 dividido por 2 dá 3 e sobra 1.
3. Math.round(3.6) arredonda para o inteiro mais próximo (4); Math.floor(3.9) arredonda sempre para baixo (3).$c$, $c$- + - * / fazem as quatro operações; % dá o resto; ** é a potência.
- Multiplicação, divisão e resto vêm antes de soma e subtração; parênteses mudam a ordem.
- Math.round arredonda para o mais próximo; Math.floor arredonda para baixo.
- Podemos usar variáveis nas contas e guardar o resultado em outra variável.$c$, $c$mundo-2$c$, 210, false, $c$arquivo$c$),
  ($c$conversao-de-tipos$c$, $c$Conversão de tipos$c$, $c$Converter valores entre texto e número$c$, $c$Converter é mudar o tipo de um valor. As principais conversões:
- Number("42") transforma o texto "42" no número 42. Se o texto não for um número, o resultado é NaN.
- String(42) transforma o número 42 no texto "42".
- parseInt("42px") e parseFloat("3.5kg") leem o número no começo do texto (42 e 3.5).

Por que isso importa? Dados digitados por uma pessoa costumam chegar como texto, mesmo que pareçam números. Sem converter, "10" + 5 vira "105", e não 15.

O JavaScript também converte sozinho em alguns casos: "5" * 2 vira 10. Porém o + junta textos, então "5" + 2 vira "52". Para evitar surpresas, converta de forma explícita.$c$, $c$const idadeTexto = "20";
const idade = Number(idadeTexto);

console.log(typeof idadeTexto);   // string
console.log(typeof idade);        // number
console.log(idade + 1);           // 21
console.log(idadeTexto + 1);      // 201 (junta, não soma!)
console.log(Number("abc"));       // NaN
console.log(String(15) + "5");    // 155
console.log(parseFloat("3.5kg")); // 3.5
console.log(parseInt("42px"));    // 42

Passo a passo:
1. Number(idadeTexto) cria um número a partir do texto "20".
2. Com o número, idade + 1 soma e dá 21. Com o texto, idadeTexto + 1 junta e dá "201".
3. Textos que não são números viram NaN.
4. parseInt e parseFloat aproveitam o número que aparece no começo do texto.$c$, $c$- Number("42") converte texto em número; texto inválido vira NaN.
- String(42) converte número em texto.
- parseInt e parseFloat leem o número do começo de um texto.
- Dados de entrada costumam ser texto: converta antes de fazer contas.
- O + junta textos; o * converte textos que parecem números.$c$, $c$mundo-2$c$, 211, false, $c$arquivo$c$),
  ($c$entrada-e-saida-de-informacoes$c$, $c$Entrada e saída de informações$c$, $c$Ler dados, convertê-los, processá-los e mostrar o resultado$c$, $c$Já vimos que todo programa tem entrada, processamento e saída. Agora vamos colocar isso em prática com variáveis.

- Entrada: nesta plataforma, lerEntrada() lê um valor de cada vez, na ordem em que foram informados.
- Conversão: o valor lido costuma ser texto. Se for número, converta com Number().
- Processamento: as contas e transformações, guardando resultados em variáveis.
- Saída: console.log mostra o resultado; um template literal deixa a frase bem montada.

Um programa de verdade, em um navegador, receberia a entrada de uma caixa de texto ou de um formulário. A lógica é a mesma.$c$, $c$function dobroDoNumero() {
  // ENTRADA: o valor chega como texto
  const texto = lerEntrada();
  // CONVERSÃO: transforma em número
  const numero = Number(texto);
  // PROCESSAMENTO: calcula o dobro
  const dobro = numero * 2;
  // SAÍDA: mostra a frase
  console.log(`O dobro de ${numero} é ${dobro}`);
}

Se a entrada for "5", o programa mostra: O dobro de 5 é 10.

Passo a passo:
1. lerEntrada() entrega o valor digitado.
2. Number() converte o texto em número.
3. A conta é feita e guardada em uma variável.
4. O template literal monta a frase e console.log a mostra.$c$, $c$- lerEntrada() lê um valor por vez, na ordem informada.
- Entradas costumam ser texto: converta com Number() antes de calcular.
- Guarde resultados intermediários em variáveis com nomes claros.
- console.log mostra a saída; template literals ajudam a montar frases.
- O caminho é sempre: ler, converter, processar e mostrar.$c$, $c$mundo-2$c$, 212, false, $c$arquivo$c$),
  ($c$uso-do-console-log$c$, $c$Utilização de console.log()$c$, $c$Usar o console.log para mostrar e acompanhar valores$c$, $c$O console.log é a principal ferramenta de saída: ele mostra valores na tela e também ajuda a descobrir o que está acontecendo dentro do programa.

- Cada chamada mostra uma nova linha.
- Podemos passar vários valores separados por vírgula: eles aparecem na mesma linha, separados por um espaço. console.log("Total:", 50) mostra Total: 50.
- Textos aparecem sem as aspas. Números, booleanos e resultados de contas aparecem normalmente.
- Um texto entre aspas aparece exatamente como foi escrito, e um cálculo sem aspas é resolvido antes de ser mostrado.

Programadores usam console.log o tempo todo para acompanhar o valor de variáveis passo a passo. Isso se chama depurar (procurar defeitos).$c$, $c$console.log("Olá");              // Olá
console.log("Total:", 50);       // Total: 50
console.log("a", "b", "c");      // a b c
console.log(2 + 3);              // 5
console.log("2 + 3");            // 2 + 3
console.log(true);               // true

Passo a passo:
1. Cada console.log mostra uma linha.
2. Com vírgulas, os valores aparecem juntos, separados por um espaço.
3. 2 + 3 sem aspas é calculado (5); com aspas é só um texto, mostrado como está.
4. Valores booleanos também podem ser mostrados.$c$, $c$- Cada console.log mostra uma nova linha.
- Com vírgulas, os valores ficam na mesma linha, separados por espaço.
- Textos aparecem sem aspas; contas sem aspas são calculadas.
- console.log ajuda a acompanhar os valores das variáveis e a achar defeitos.$c$, $c$mundo-2$c$, 213, false, $c$arquivo$c$),
  ($c$desafio-do-mundo-2$c$, $c$Desafio final do Mundo 2$c$, $c$Juntar variáveis, tipos, conversões, entrada e saída em um só programa$c$, $c$Hora de juntar tudo o que você aprendeu no Mundo 2: variáveis, tipos de dados, concatenação, template literals, conversões e entrada e saída.

O desafio principal é o primeiro exercício: criar um pequeno programa que receba os dados de uma pessoa (nome, idade e altura), guarde-os em variáveis e mostre os resultados em frases bem formatadas. Os outros dois exercícios treinam a conversão de tipos em situações em que é fácil errar.

Dica: antes de escrever, pense em cada dado: qual é o tipo? Ele chega como texto? Precisa ser convertido?$c$, $c$Como atacar um desafio de programa:
1. Liste as entradas e o tipo de cada uma (nome: texto; idade: número; altura: número).
2. Lembre que lerEntrada() entrega os valores na ordem e que eles chegam como texto.
3. Guarde cada valor em uma variável com nome claro e converta quando for preciso.
4. Faça as contas pedidas e guarde os resultados em variáveis.
5. Mostre cada resultado em uma frase, com template literals.
6. Teste mentalmente com um caso simples antes de executar.$c$, $c$- Toda variável guarda um valor de um tipo: string, number ou boolean.
- Entradas chegam como texto: converta com Number() antes de calcular.
- O + junta textos e soma números: cuidado com a mistura.
- Template literals montam frases com variáveis e contas.
- console.log mostra o resultado, uma linha por chamada.$c$, $c$mundo-2$c$, 214, false, $c$arquivo$c$),
  ($c$fundamentos$c$, $c$Fundamentos$c$, $c$Traduzir um problema em passos e operações$c$, $c$Uma função recebe valores (parâmetros), faz um cálculo e devolve um resultado com return. Por exemplo:

function dobro(n) {
  return n * 2;
}

dobro(4) devolve 8. Nos exercícios você escreve funções assim: leia o enunciado, pense no passo a passo e só então escreva o código. Use os testes como guia: eles mostram o que a função deveria devolver.$c$, $c$$c$, $c$$c$, $c$mundo-3$c$, 390, false, $c$arquivo$c$),
  ($c$introducao-aos-operadores$c$, $c$Introdução aos operadores$c$, $c$Reconhecer operadores, operandos e os quatro grupos de operadores$c$, $c$Um operador é um símbolo que faz uma operação com valores. Os valores sobre os quais ele atua se chamam operandos. Em 2 + 3, o + é o operador e 2 e 3 são os operandos. Uma expressão é qualquer combinação de valores e operadores que produz um resultado.

Os operadores se dividem em quatro grupos:
- Aritméticos: fazem contas (+, -, *, /, %, **) e resultam em número.
- De atribuição: guardam valores em variáveis (=, +=, ++...).
- Relacionais: comparam dois valores (>, <, ===...) e resultam em true ou false.
- Lógicos: combinam resultados true ou false (&&, ||, !).

A maioria usa dois operandos (2 + 3); alguns usam só um, como o ! em !true. Neste mundo você vai estudar cada grupo e, no final, a ordem em que o computador resolve tudo.$c$, $c$const soma = 2 + 3;            // aritmético: resultado 5 (number)
let total = 10;
total = total + 1;             // atribuição: guarda 11 em total
console.log(5 > 3);            // relacional: true (boolean)
console.log(5 > 3 && 2 > 1);   // lógico: true (boolean)
console.log(-total);           // operador de um operando só: -11

Passo a passo:
1. 2 + 3 é uma expressão aritmética: o + é o operador, e o resultado é um número.
2. total = total + 1 usa o operador de atribuição (=) para guardar o resultado.
3. 5 > 3 é uma comparação: pergunta "5 é maior que 3?" e responde com um boolean.
4. O && junta duas comparações em uma só resposta.
5. O sinal - na frente de total usa um operando só: inverte o sinal do número.$c$, $c$- Operador é um símbolo que realiza uma operação; operandos são os valores usados por ele.
- Expressão é uma combinação de valores e operadores que produz um resultado.
- Aritméticos resultam em número; relacionais e lógicos resultam em boolean.
- Atribuição guarda um valor em uma variável.
- Alguns operadores usam um operando só (como o !).$c$, $c$mundo-3$c$, 301, false, $c$arquivo$c$),
  ($c$operadores-aritmeticos$c$, $c$Operadores aritméticos$c$, $c$Fazer contas com +, -, *, /, % e **$c$, $c$Os operadores aritméticos fazem as contas:
- + soma, - subtração, * multiplicação;
- / divisão: em JavaScript o resultado pode ser decimal (17 / 5 vale 3.4);
- % resto da divisão: 17 % 5 vale 2, porque 17 = 3 * 5 + 2;
- ** potência: 2 ** 10 vale 1024.

O resto é muito útil: n % 2 vale 0 quando n é par, e n % 10 dá o último dígito de n. Para obter só a parte inteira de uma divisão, use Math.floor(17 / 5), que vale 3.

Casos especiais: dividir por zero dá Infinity (ou -Infinity), e pedir o resto da divisão por zero ou fazer 0 / 0 dá NaN. Nenhum deles causa erro no programa.$c$, $c$console.log(17 + 5);              // 22
console.log(17 - 5);              // 12
console.log(17 * 5);              // 85
console.log(17 / 5);              // 3.4
console.log(17 % 5);              // 2  (resto da divisão)
console.log(2 ** 10);             // 1024
console.log(Math.floor(17 / 5));  // 3  (parte inteira da divisão)

Passo a passo:
1. As três primeiras linhas são as contas básicas.
2. 17 / 5 mantém a parte decimal: 3.4.
3. 17 % 5 dá o que sobra: 5 cabe 3 vezes em 17 (15), e sobram 2.
4. 2 ** 10 é 2 multiplicado por ele mesmo 10 vezes.
5. Math.floor arredonda para baixo e dá a parte inteira da divisão.$c$, $c$- + - * / % ** são os operadores aritméticos.
- / dá resultado decimal; Math.floor dá a parte inteira da divisão.
- % dá o resto: n % 2 === 0 indica um número par; n % 10 dá o último dígito.
- ** é a potência. O símbolo ^ NÃO é potência em JavaScript.
- Dividir por zero dá Infinity; 0 / 0 e o resto por zero dão NaN.$c$, $c$mundo-3$c$, 302, false, $c$arquivo$c$),
  ($c$operadores-de-atribuicao$c$, $c$Operadores de atribuição$c$, $c$Guardar e atualizar valores com =, +=, -=, ++ e --$c$, $c$O operador de atribuição = guarda um valor em uma variável. Para atualizar uma variável usando o valor que ela já tem, existem formas abreviadas:
- x += 5 é o mesmo que x = x + 5;
- x -= 5, x *= 5, x /= 5, x %= 5 e x **= 2 funcionam do mesmo jeito;
- x++ aumenta x em 1 e x-- diminui x em 1.

Cuidados:
- = guarda um valor; ele não compara. Para comparar usamos ===.
- Com textos, += junta: se frase vale "Olá", frase += "!" resulta em "Olá!".
- Só variáveis declaradas com let podem ser atualizadas; uma const dá erro.
- Escreva += e não =+: x =+ 5 guarda o valor +5 em x, apagando o valor antigo.

Esses operadores serão muito usados nos contadores e acumuladores das estruturas de repetição.$c$, $c$let pontos = 10;
pontos += 5;     // pontos = pontos + 5  ->  15
pontos -= 3;     // 12
pontos *= 2;     // 24
pontos /= 4;     // 6
pontos++;        // 7
pontos--;        // 6
console.log(pontos);   // 6

let frase = "Olá";
frase += ", mundo";    // com texto, += junta
console.log(frase);    // Olá, mundo

Passo a passo:
1. Cada linha usa o valor atual de pontos para calcular o novo.
2. ++ e -- somam ou subtraem 1.
3. Com um texto, += faz a concatenação.$c$, $c$- = guarda um valor; += -= *= /= %= atualizam usando o valor atual.
- x++ e x-- somam e subtraem 1.
- Com textos, += junta.
- const não pode ser atualizada.
- Não confunda = (guardar) com === (comparar).$c$, $c$mundo-3$c$, 303, false, $c$arquivo$c$),
  ($c$operadores-relacionais$c$, $c$Operadores relacionais$c$, $c$Comparar valores e obter true ou false$c$, $c$Os operadores relacionais comparam dois valores e respondem com true ou false:
- > maior, < menor, >= maior ou igual, <= menor ou igual;
- === igual (mesmo valor e mesmo tipo) e !== diferente.

O erro mais comum: = guarda um valor, e === compara. Escrever idade = 18 onde se queria comparar muda a variável em vez de comparar.

Existe também o == (igual "frouxo"), que converte os tipos antes de comparar: 5 == "5" é true. Isso causa surpresas, então use sempre === e !==.

Textos também são comparados, seguindo a ordem das letras: "a" < "b" é true. As letras maiúsculas vêm antes das minúsculas, e textos de números não são comparados como números: "10" < "9" é true, porque o "1" vem antes do "9". Por fim, números decimais podem ter pequenas diferenças: 0.1 + 0.2 === 0.3 é false.$c$, $c$console.log(5 > 3);          // true
console.log(5 <= 5);         // true
console.log(5 === 5);        // true
console.log(5 === "5");      // false (tipos diferentes)
console.log(5 == "5");       // true (o == converte o tipo: evite)
console.log(5 !== 3);        // true
console.log("a" < "b");      // true

Passo a passo:
1. Cada comparação responde com true ou false.
2. 5 <= 5 é true porque 5 é igual a 5.
3. 5 === "5" é false: o número 5 e o texto "5" têm tipos diferentes.
4. O == "perdoa" a diferença de tipos e diz true: por isso preferimos ===.
5. Textos são comparados letra por letra, na ordem do alfabeto.$c$, $c$- > < >= <= comparam ordem; === e !== comparam igualdade e diferença, com o tipo.
- = guarda um valor; === compara.
- Prefira === e !== ao == e !=, que convertem tipos.
- Textos são comparados pela ordem das letras; "10" < "9" é true.
- Decimais podem ter pequenas diferenças: 0.1 + 0.2 === 0.3 é false.$c$, $c$mundo-3$c$, 304, false, $c$arquivo$c$),
  ($c$operadores-logicos$c$, $c$Operadores lógicos$c$, $c$Combinar valores true e false com &&, || e !$c$, $c$Os operadores lógicos combinam valores booleanos:
- && (E): true somente se os dois lados são true.
- || (OU): true se pelo menos um dos lados é true.
- ! (NÃO): inverte o valor: !true é false e !false é true.

Tabela-verdade (V = true, F = false):
  A  B  | A && B | A || B
  V  V  |   V    |   V
  V  F  |   F    |   V
  F  V  |   F    |   V
  F  F  |   F    |   F

Na prática, combinamos comparações: idade >= 18 && temIngresso. Para saber se x está entre 1 e 10, escreva x >= 1 && x <= 10; a forma matemática 1 <= x <= 10 não funciona. Quando misturamos operadores, o ! é resolvido primeiro, depois o && e por último o ||; use parênteses para deixar a intenção clara.$c$, $c$const idade = 20;
const temIngresso = true;
console.log(idade >= 18 && temIngresso);   // true
console.log(idade < 18 || temIngresso);    // true
console.log(!temIngresso);                 // false
console.log(idade >= 18 && !temIngresso);  // false

Passo a passo:
1. idade >= 18 é true e temIngresso é true: o && dá true.
2. idade < 18 é false, mas temIngresso é true: basta um true para o || dar true.
3. !temIngresso inverte true em false.
4. idade >= 18 é true, mas !temIngresso é false: o && dá false.$c$, $c$- && é E: precisa dos dois lados true. || é OU: basta um lado true. ! inverte.
- Combine comparações: idade >= 18 && temIngresso.
- "Entre 1 e 10" é x >= 1 && x <= 10 (não 1 <= x <= 10).
- Ordem: ! primeiro, depois &&, por último ||; parênteses deixam claro.
- Use a tabela-verdade para conferir o resultado.$c$, $c$mundo-3$c$, 305, false, $c$arquivo$c$),
  ($c$precedencia-dos-operadores$c$, $c$Precedência dos operadores$c$, $c$Saber em que ordem o computador resolve uma expressão$c$, $c$Quando uma expressão tem vários operadores, o computador segue uma ordem, chamada precedência (da mais alta para a mais baixa):
1. parênteses ( );
2. potência **;
3. ! (NÃO);
4. * / %;
5. + e -;
6. < <= > >=;
7. === !== (e == !=);
8. &&;
9. ||;
10. atribuições (=, +=, ...), por último.

Operadores do mesmo nível são resolvidos da esquerda para a direita (10 - 4 - 3 vale 3), exceto a potência, que vai da direita para a esquerda (2 ** 3 ** 2 vale 512).

Por isso 2 + 3 * 4 vale 14. Para mudar a ordem, use parênteses: (2 + 3) * 4 vale 20. Mesmo quando a ordem natural já resolve, os parênteses deixam o código mais fácil de ler.$c$, $c$console.log(2 + 3 * 4);               // 14
console.log((2 + 3) * 4);             // 20
console.log(10 - 4 - 3);              // 3 (da esquerda para a direita)
console.log(2 ** 3 ** 2);             // 512 (a potência vai da direita para a esquerda)
console.log(5 + 3 > 7);               // true (a soma vem antes da comparação)
console.log(true || false && false);  // true (&& vem antes de ||)

Passo a passo:
1. A multiplicação vem antes da soma: 3 * 4 = 12 e depois 2 + 12 = 14.
2. Com parênteses, 2 + 3 vem primeiro: 5 * 4 = 20.
3. 10 - 4 - 3: primeiro 10 - 4 = 6 e depois 6 - 3 = 3.
4. 2 ** 3 ** 2 é 2 ** 9 = 512.
5. 5 + 3 > 7 vira 8 > 7, que é true.
6. false && false é false, e true || false é true.$c$, $c$- Ordem: parênteses, **, !, * / %, + -, comparações, ===, &&, ||, atribuição.
- Operadores do mesmo nível: da esquerda para a direita (a potência é da direita para a esquerda).
- Parênteses mudam a ordem e deixam o código mais claro.
- Aritméticos vêm antes das comparações, e as comparações antes de && e ||.$c$, $c$mundo-3$c$, 306, false, $c$arquivo$c$),
  ($c$desafio-do-mundo-3$c$, $c$Desafio final do Mundo 3$c$, $c$Juntar os operadores em uma calculadora simples$c$, $c$Chegou o desafio do Mundo 3: uma calculadora simples. Você vai usar operadores aritméticos, relacionais e lógicos, e vai cuidar dos casos especiais, como a divisão por zero.

O desafio principal é o primeiro exercício: um programa que lê dois números e mostra o resultado das principais operações, avisando quando a divisão for por zero. No Mundo 4 você vai aprender a tomar decisões (if/else) e poderá impedir a conta; por enquanto, o programa avisa usando uma comparação.

Os outros dois exercícios treinam a precedência e o acompanhamento de valores.$c$, $c$Como montar uma calculadora:
1. Leia os dois números com lerEntrada() e converta cada um com Number().
2. Calcule cada operação: soma, subtração, multiplicação, divisão, resto.
3. Mostre cada resultado com um rótulo, em uma linha de console.log.
4. Para avisar sobre a divisão por zero, compare o divisor com 0 usando ===: o resultado é true ou false.
5. Teste com casos simples e com o caso especial (divisor igual a 0): o programa não pode "quebrar".$c$, $c$- Aritméticos fazem as contas; relacionais e lógicos respondem com true ou false.
- Atribuição guarda e atualiza valores (=, +=, ++...).
- A precedência define a ordem; parênteses deixam a intenção clara.
- Divisão por zero dá Infinity e o resto por zero dá NaN: vale testar o divisor antes.
- Em toda comparação, use === (e não =).$c$, $c$mundo-3$c$, 307, false, $c$arquivo$c$),
  ($c$condicionais$c$, $c$Condicionais$c$, $c$Tomar decisões no fluxo do algoritmo$c$, $c$Condicionais fazem o programa escolher um caminho. A estrutura básica é:

if (idade >= 18) {
  return "maior";
} else {
  return "menor";
}

A condição entre parênteses vale verdadeiro ou falso. Operadores úteis: ===, !==, >, <, >=, <=, e && (e) e || (ou). Dica: teste os casos de borda, como o valor exatamente igual ao limite.$c$, $c$$c$, $c$$c$, $c$mundo-4$c$, 490, false, $c$arquivo$c$),
  ($c$introducao-as-condicionais$c$, $c$Introdução às estruturas condicionais$c$, $c$Entender como um programa toma decisões$c$, $c$Até agora, os programas executavam as instruções de cima para baixo, sempre do mesmo jeito. Na vida real, porém, decidimos o tempo todo: "se estiver chovendo, levo o guarda-chuva".

Uma estrutura condicional faz o programa decidir. Ela testa uma condição, uma expressão que resulta em true ou false (como as comparações do Mundo 3), e executa um trecho do código somente se a condição for verdadeira.

Com isso, o programa deixa de seguir um único caminho: o resultado depende dos dados. Neste mundo você vai conhecer as principais estruturas condicionais de JavaScript: if, if/else, else if, switch e o operador ternário.$c$, $c$const idade = 20;

if (idade >= 18) {
  console.log("Pode entrar");
}
console.log("Fim");

Passo a passo:
1. A condição idade >= 18 é testada. Com idade 20, o resultado é true.
2. Como é verdadeira, o computador executa o bloco entre as chaves { } e mostra Pode entrar.
3. Depois, o programa segue normalmente e mostra Fim.

Se idade valesse 15, a condição seria false: o bloco seria ignorado e só Fim apareceria.$c$, $c$- Uma estrutura condicional executa um trecho do código só quando uma condição é verdadeira.
- A condição é uma expressão que resulta em true ou false.
- O bloco da condição fica entre chaves { }.
- O resultado do programa passa a depender dos dados.
- As principais estruturas: if, if/else, else if, switch e ternário.$c$, $c$mundo-4$c$, 401, false, $c$arquivo$c$),
  ($c$revisao-dos-relacionais$c$, $c$Revisão dos operadores relacionais$c$, $c$Revisar as comparações que formam as condições$c$, $c$As condições das estruturas condicionais quase sempre são comparações. Vamos revisar o que você viu no Mundo 3:
- > maior, < menor, >= maior ou igual, <= menor ou igual;
- === igual (mesmo valor e mesmo tipo) e !== diferente.

Traduzindo do português: "a idade é pelo menos 18" vira idade >= 18; "a nota é diferente de 10" vira nota !== 10.

Cuidados que valem ouro dentro de um if:
- use === para comparar, e não =, que guarda um valor;
- evite == e !=, que convertem os tipos;
- textos diferenciam maiúsculas de minúsculas: "Ana" não é igual a "ana";
- um número e um texto são valores de tipos diferentes: 10 === "10" é false.$c$, $c$const idade = 17;
console.log(idade >= 18);               // false
console.log(idade === 17);              // true
console.log(idade !== 17);              // false

const nome = "Ana";
console.log(nome === "ana");            // false (as maiúsculas contam)
console.log(typeof idade === "number"); // true

Passo a passo:
1. Cada comparação resulta em true ou false, e é isso que um if vai usar como condição.
2. nome === "ana" é false: "A" maiúsculo e "a" minúsculo são caracteres diferentes.
3. typeof idade devolve o texto "number", e comparamos com === para conferir o tipo.$c$, $c$- Condições são, em geral, comparações: > < >= <= === !==.
- "Pelo menos" é >=; "no máximo" é <=; "diferente" é !==.
- Use === para comparar e = só para guardar valores.
- Textos diferenciam maiúsculas e minúsculas; número e texto têm tipos diferentes.$c$, $c$mundo-4$c$, 402, false, $c$arquivo$c$),
  ($c$revisao-dos-logicos$c$, $c$Revisão dos operadores lógicos$c$, $c$Revisar &&, || e ! para montar condições com mais de uma regra$c$, $c$Muitas decisões dependem de mais de uma regra. Os operadores lógicos, que você viu no Mundo 3, combinam condições:
- && (E): true somente se as duas condições são true;
- || (OU): true se pelo menos uma é true;
- ! (NÃO): inverte o resultado.

Traduzindo: "idade entre 18 e 65" vira idade >= 18 && idade <= 65 (repita a variável nas duas comparações!); "criança ou idoso" vira idade < 12 || idade >= 60; "não é fim de semana" vira !ehFimDeSemana.

Uma regra útil, a lei de De Morgan, mostra que !(a && b) equivale a !a || !b, e que !(a || b) equivale a !a && !b: ao inverter uma combinação, trocamos E por OU e invertemos cada parte.$c$, $c$const idade = 70;
const ehCrianca = idade < 12;
const ehIdoso = idade >= 60;
console.log(ehCrianca || ehIdoso);            // true  (tem desconto)
console.log(idade >= 18 && idade <= 65);      // false (fora da faixa)
console.log(!(idade >= 18 && idade <= 65));   // true

Passo a passo:
1. ehCrianca é false e ehIdoso é true: o || resulta em true.
2. 70 é maior que 18, mas não é menor ou igual a 65: o && resulta em false.
3. O ! inverte esse false em true.$c$, $c$- && exige as duas condições; || aceita uma delas; ! inverte.
- "Entre 18 e 65" é idade >= 18 && idade <= 65.
- "Criança ou idoso" é idade < 12 || idade >= 60.
- De Morgan: !(a && b) é !a || !b; !(a || b) é !a && !b.
- Use parênteses quando misturar && e ||.$c$, $c$mundo-4$c$, 403, false, $c$arquivo$c$),
  ($c$estrutura-if$c$, $c$Estrutura if$c$, $c$Escrever e entender a estrutura if$c$, $c$A estrutura if é a forma mais simples de decisão:

if (condição) {
  // comandos que só executam se a condição for verdadeira
}

Pontos importantes:
- a condição fica entre parênteses;
- o bloco de comandos fica entre chaves { }, com os comandos recuados (indentados) para facilitar a leitura;
- se a condição for falsa, o bloco inteiro é ignorado e o programa segue adiante;
- não se coloca ponto e vírgula logo depois do parêntese: if (x > 0); termina o if antes de começar e o bloco passa a executar sempre;
- use === para comparar, e não =: if (x = 5) guarda 5 em x e a condição passa a valer sempre.

Um programa pode ter vários if seguidos. Cada um tem a sua condição e é testado de forma independente.$c$, $c$const temperatura = 32;

if (temperatura > 30) {
  console.log("Está quente");
}

if (temperatura < 15) {
  console.log("Está frio");
}

console.log("Fim");

Passo a passo:
1. 32 > 30 é true: o primeiro bloco executa e mostra Está quente.
2. 32 < 15 é false: o segundo bloco é ignorado.
3. O programa continua e mostra Fim.$c$, $c$- if (condição) { ... } executa o bloco só se a condição for verdadeira.
- Condição entre parênteses, comandos entre chaves e recuados.
- Condição falsa: o bloco é ignorado.
- Nada de ; depois do parêntese do if, e use === (e não =) para comparar.
- Vários if seguidos são avaliados independentemente.$c$, $c$mundo-4$c$, 404, false, $c$arquivo$c$),
  ($c$estrutura-if-else$c$, $c$Estrutura if/else$c$, $c$Escolher entre dois caminhos$c$, $c$Muitas vezes precisamos de dois caminhos: um para quando a condição é verdadeira e outro para quando é falsa. A estrutura if/else faz isso:

if (condição) {
  // executa se for verdadeira
} else {
  // executa se for falsa
}

Exatamente um dos dois blocos é executado, nunca os dois e nunca nenhum. O else não tem condição: ele cobre "todo o resto".

Cuidado: dois if seguidos não são um if/else. Em if (x > 5) {...} if (x <= 5) {...}, as duas condições são testadas separadamente; com else, o segundo teste não é necessário.

Um uso clássico é separar par de ímpar: um número é par quando o resto da divisão por 2 é zero.$c$, $c$const numero = 7;

if (numero % 2 === 0) {
  console.log("Par");
} else {
  console.log("Ímpar");
}

Passo a passo:
1. numero % 2 vale 1, e 1 === 0 é false.
2. Como a condição é falsa, o bloco do if é ignorado e o bloco do else executa.
3. O programa mostra Ímpar.

Com numero = 8, 8 % 2 é 0, a condição seria verdadeira e o programa mostraria Par.$c$, $c$- if/else escolhe entre dois caminhos: exatamente um dos blocos executa.
- O else não tem condição: vale quando a condição do if é falsa.
- Dois if seguidos são testes independentes; if/else são caminhos excludentes.
- Número par: n % 2 === 0.$c$, $c$mundo-4$c$, 405, false, $c$arquivo$c$),
  ($c$estrutura-else-if$c$, $c$Estrutura else if$c$, $c$Decidir entre várias faixas ou opções$c$, $c$Quando há mais de dois caminhos, encadeamos condições com else if:

if (condição1) {
  ...
} else if (condição2) {
  ...
} else if (condição3) {
  ...
} else {
  ...
}

O computador testa as condições de cima para baixo. A primeira que for verdadeira executa o seu bloco, e todas as outras são ignoradas, mesmo que também fossem verdadeiras. O else final, que é opcional, cobre o que sobrou.

Por isso a ordem importa: coloque as condições mais específicas antes das mais gerais. Em uma escala de notas, se você testar nota >= 5 antes de nota >= 7, quem tirou 9 cai na primeira faixa e nunca chega à segunda.

E atenção: vários if seguidos não são a mesma coisa que else if: cada if é testado de forma independente.$c$, $c$const nota = 7.5;

if (nota >= 9) {
  console.log("Excelente");
} else if (nota >= 7) {
  console.log("Bom");
} else if (nota >= 5) {
  console.log("Regular");
} else {
  console.log("Insuficiente");
}

Passo a passo:
1. 7.5 >= 9 é false: segue para a próxima condição.
2. 7.5 >= 7 é true: executa o bloco e mostra Bom.
3. As condições seguintes nem são testadas, mesmo que 7.5 >= 5 também seja verdadeiro.$c$, $c$- else if encadeia várias condições: só o primeiro bloco verdadeiro executa.
- As condições são testadas de cima para baixo: a ordem importa.
- Coloque as faixas mais específicas antes das mais gerais.
- O else final cobre os demais casos.
- else if não é o mesmo que vários if seguidos.$c$, $c$mundo-4$c$, 406, false, $c$arquivo$c$),
  ($c$condicionais-aninhadas$c$, $c$Condicionais aninhadas$c$, $c$Colocar uma decisão dentro de outra$c$, $c$Condicionais aninhadas são condicionais dentro de outras: uma decisão que só faz sentido depois de outra. Por exemplo: só perguntamos se a pessoa tem ingresso depois de confirmar que ela é maior de idade.

O bloco interno só é testado se a condição externa for verdadeira. Se a externa for falsa, a interna nem é avaliada.

A indentação é essencial: a cada nível, recue o código mais um pouco para enxergar a quem cada else pertence. Um else sempre pertence ao if mais próximo, acima dele.

Muitos níveis deixam o código difícil de ler. Quando as duas condições levam ao mesmo resultado, uma alternativa é juntá-las com &&: if (a) { if (b) {...} } equivale a if (a && b) {...}.$c$, $c$const idade = 20;
const temIngresso = false;

if (idade >= 18) {
  if (temIngresso) {
    console.log("Pode entrar");
  } else {
    console.log("Compre um ingresso");
  }
} else {
  console.log("Menor de idade");
}

Passo a passo:
1. idade >= 18 é true: entramos no bloco externo.
2. Dentro dele, temIngresso é false: executa o else interno.
3. O programa mostra Compre um ingresso. O else externo (Menor de idade) não executa, porque a condição externa foi verdadeira.$c$, $c$- Condicional aninhada é uma condicional dentro do bloco de outra.
- A interna só é avaliada se a externa for verdadeira.
- Cada else pertence ao if mais próximo acima dele; a indentação ajuda a enxergar isso.
- if (a) { if (b) {...} } equivale a if (a && b) {...}.
- Evite muitos níveis: o código fica difícil de ler.$c$, $c$mundo-4$c$, 407, false, $c$arquivo$c$),
  ($c$estrutura-switch$c$, $c$Estrutura switch$c$, $c$Escolher entre várias opções exatas$c$, $c$Quando queremos comparar uma mesma variável com vários valores exatos (como o número do dia da semana ou a opção de um menu), o switch deixa o código mais organizado que uma longa cadeia de else if.

switch (valor) {
  case 1:
    ...
    break;
  case 2:
    ...
    break;
  default:
    ...
}

O computador compara o valor com cada case usando ===. Ao encontrar o primeiro igual, executa as instruções a partir dali. O break encerra o switch; sem ele, a execução "cai" nos cases seguintes (efeito cascata), mesmo que eles não combinem.

O default é opcional e funciona como o else: executa quando nenhum case combina. O switch só serve para igualdade exata: para faixas (nota >= 7), use if/else if.$c$, $c$const dia = 3;

switch (dia) {
  case 1:
    console.log("Domingo");
    break;
  case 2:
    console.log("Segunda");
    break;
  case 3:
    console.log("Terça");
    break;
  default:
    console.log("Outro dia");
}

Passo a passo:
1. O valor de dia (3) é comparado com cada case, de cima para baixo.
2. case 3 combina: executa console.log("Terça").
3. O break encerra o switch. Se ele faltasse, "Outro dia" também seria mostrado.$c$, $c$- switch compara um valor com vários cases usando === (igualdade exata).
- O break encerra o switch; sem ele, a execução cai nos cases seguintes.
- default executa quando nenhum case combina (é opcional).
- Para faixas de valores, use if/else if, não switch.$c$, $c$mundo-4$c$, 408, false, $c$arquivo$c$),
  ($c$operador-ternario$c$, $c$Operador ternário$c$, $c$Escrever uma decisão simples em uma só linha$c$, $c$Este é um conteúdo complementar: ele não bloqueia a liberação do que vem a seguir. Vale estudar, mas você pode seguir em frente sem concluí-lo.

O operador ternário é um atalho para um if/else simples que escolhe um valor:

condição ? valorSeVerdadeira : valorSeFalsa

Ele é uma expressão: produz um valor, que pode ser guardado em uma variável ou devolvido por uma função. Compare:

let texto;
if (idade >= 18) { texto = "maior"; } else { texto = "menor"; }

const texto = idade >= 18 ? "maior" : "menor";

Use o ternário para decisões curtas. Quando houver muitos caminhos ou blocos com várias instruções, prefira if/else, que fica mais legível.$c$, $c$const nota = 8;
const situacao = nota >= 7 ? "Aprovado" : "Reprovado";
console.log(situacao);

Passo a passo:
1. A condição nota >= 7 é testada: 8 >= 7 é true.
2. Como é verdadeira, o ternário resulta no valor antes dos dois-pontos: "Aprovado".
3. Esse valor é guardado em situacao e mostrado na tela.

Se a nota fosse 5, o resultado seria o valor depois dos dois-pontos: "Reprovado".$c$, $c$- condição ? valorSeVerdadeira : valorSeFalsa: um if/else que produz um valor.
- É uma expressão: pode ser guardada em variável ou usada em um return.
- Bom para decisões curtas; para muitos caminhos, prefira if/else.
- Esta lição é complementar e não bloqueia a liberação do que vem depois.$c$, $c$mundo-4$c$, 409, true, $c$arquivo$c$),
  ($c$desafio-do-mundo-4$c$, $c$Desafio final do Mundo 4$c$, $c$Juntar as condicionais em um sistema de notas$c$, $c$Chegou o desafio do Mundo 4: um sistema de notas. O programa recebe as notas de um aluno, calcula a média e informa a situação: aprovado, recuperação ou reprovado.

Aqui você vai usar tudo o que aprendeu: operadores aritméticos para a média, relacionais para comparar, lógicos para combinar condições e as estruturas condicionais para decidir.

O desafio principal é o primeiro exercício. Os outros dois treinam a leitura e a correção de decisões encadeadas.$c$, $c$Como montar o sistema de notas:
1. Leia as três notas com lerEntrada() e converta cada uma com Number().
2. Calcule a média: (n1 + n2 + n3) / 3.
3. Decida a situação com if / else if / else: média >= 7 é Aprovado, média >= 5 é Recuperação, o restante é Reprovado.
4. Mostre a média e a situação com console.log.
5. Teste os limites (média exatamente 7 e exatamente 5): é aí que mais aparecem erros.$c$, $c$- A média usa parênteses: (n1 + n2 + n3) / 3.
- if / else if / else escolhe um único caminho, testando de cima para baixo.
- Coloque as condições na ordem certa: da faixa mais alta para a mais baixa.
- Teste os valores de fronteira (>= ou >).
- Em toda comparação, use === (e não =).$c$, $c$mundo-4$c$, 410, false, $c$arquivo$c$),
  ($c$repeticao$c$, $c$Estruturas de repetição$c$, $c$Compreender o passo a passo de um laço$c$, $c$Um laço repete um bloco de código. O mais comum é o for:

for (let i = 1; i <= 5; i++) {
  total = total + i;
}

Ele tem três partes: início (let i = 1), condição para continuar (i <= 5) e passo (i++). Para entender um laço, acompanhe a tabela de valores a cada volta: quanto valem i e total? Cuidado com laços que nunca terminam.$c$, $c$$c$, $c$$c$, $c$mundo-5$c$, 501, false, $c$arquivo$c$),
  ($c$vetores$c$, $c$Vetores$c$, $c$Manipular coleções de dados$c$, $c$Um vetor (array) guarda vários valores numa lista ordenada:

const notas = [7, 9, 5];

A primeira posição é a 0: notas[0] vale 7. notas.length diz quantos itens existem. Para percorrer o vetor use um laço de i = 0 até i < notas.length. Muitos problemas de vetores são "percorra e acumule": somar, contar, achar o maior.$c$, $c$$c$, $c$$c$, $c$mundo-6$c$, 601, false, $c$arquivo$c$),
  ($c$funcoes$c$, $c$Funções$c$, $c$Dividir um problema em partes reutilizáveis$c$, $c$Quando um trecho de código se repete, vale transformá-lo numa função e reutilizá-la. Uma função boa faz uma coisa só e tem um nome que diz o que ela faz.

function ehPar(n) {
  return n % 2 === 0;
}

Uma função pode chamar outras funções: assim você divide um problema grande em partes pequenas que dá para testar separadamente.$c$, $c$$c$, $c$$c$, $c$mundo-7$c$, 701, false, $c$arquivo$c$)
on conflict (id) do update set title = excluded.title, focus = excluded.focus, intro = excluded.intro,
  example = excluded.example, review = excluded.review, world_id = excluded.world_id, position = excluded.position,
  optional = excluded.optional
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
  ($c$variaveis-o-que-e$c$, $c$introducao-as-variaveis$c$, $c$choice$c$, $c$O que é uma variável?$c$, $c$facil$c$, $c$O que é uma variável em um programa?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Um valor que nunca pode mudar","misconception":"confunde variável com um valor fixo"},{"text":"Um nome que guarda um valor na memória do computador"},{"text":"Um comando que mostra algo na tela","misconception":"confunde variável com o comando console.log"},{"text":"Um erro que aparece quando o programa muda","misconception":"associa a palavra \"variável\" a algo que dá defeito"}],"correct":1,"explanation":"Uma variável é um nome associado a um valor guardado na memória. O valor pode ser consultado e trocado quando for preciso."}$c$::jsonb, $c$Pense em uma caixa com etiqueta: o nome é a etiqueta e o valor é o conteúdo.$c$, 1, false, $c$arquivo$c$),
  ($c$variaveis-mostrar-valor$c$, $c$introducao-as-variaveis$c$, $c$interpretation$c$, $c$O que aparece na tela?$c$, $c$facil$c$, $c$Veja o programa abaixo. O que ele mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"pontos","misconception":"mostra o nome da variável em vez do valor guardado nela"},{"text":"let pontos","misconception":"acha que o console.log repete a declaração"},{"text":"Nada, porque faltou o ponto e vírgula","misconception":"acha que o programa não funciona sem aquele sinal"},{"text":"10"}],"correct":3,"code":"let pontos = 10;\nconsole.log(pontos);","explanation":"A variável pontos guarda o número 10. Ao escrever pontos dentro do console.log, o computador mostra o valor guardado: 10."}$c$::jsonb, $c$console.log mostra o valor que a variável guarda.$c$, 2, false, $c$arquivo$c$),
  ($c$variaveis-complete-idade$c$, $c$introducao-as-variaveis$c$, $c$blank$c$, $c$Guarde e mostre a idade$c$, $c$facil$c$, $c$Complete o programa para guardar o número 18 na variável idade e mostrar o valor dela.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"let {{1}} = 18;\nconsole.log({{2}});","blanks":[{"answers":["idade"]},{"answers":["idade"]}],"explanation":"O nome idade identifica a variável tanto na declaração quanto no console.log, que mostra o valor guardado (18)."}$c$::jsonb, $c$O mesmo nome é usado para guardar e para consultar o valor.$c$, 3, false, $c$arquivo$c$),
  ($c$variaveis-trocar-o-valor$c$, $c$introducao-as-variaveis$c$, $c$interpretation$c$, $c$E o valor antigo?$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"150"},{"text":"100","misconception":"acha que o primeiro valor guardado nunca é substituído"},{"text":"250","misconception":"acha que o novo valor é somado ao antigo"},{"text":"saldo","misconception":"mostra o nome da variável em vez do valor guardado nela"}],"correct":0,"code":"let saldo = 100;\nsaldo = 150;\nconsole.log(saldo);","explanation":"A atribuição saldo = 150 substitui o valor 100. O valor antigo se perde e o console.log mostra 150."}$c$::jsonb, $c$O que acontece com o valor antigo quando guardamos um novo?$c$, 4, false, $c$arquivo$c$),
  ($c$variaveis-ordene-o-programa$c$, $c$introducao-as-variaveis$c$, $c$order$c$, $c$Ordene o programa$c$, $c$medio$c$, $c$Coloque as linhas na ordem certa para o programa mostrar o número 2.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["let contador = 1;","contador = 2;","console.log(contador);"],"explanation":"Primeiro criamos a variável, depois guardamos o novo valor e, por fim, mostramos o resultado."}$c$::jsonb, $c$A variável precisa existir antes de ser usada, e o valor novo precisa ser guardado antes de ser mostrado.$c$, 5, false, $c$arquivo$c$),
  ($c$variaveis-sinal-de-igual$c$, $c$introducao-as-variaveis$c$, $c$choice$c$, $c$O que significa o =?$c$, $c$medio$c$, $c$Na linha idade = 21; o que o sinal = faz?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Afirma que idade é igual a 21, como na matemática","misconception":"lê o = como igualdade matemática e não como atribuição"},{"text":"Compara idade com 21 e mostra true ou false","misconception":"confunde atribuição com comparação"},{"text":"Guarda o valor 21 na variável idade"},{"text":"Cria uma variável chamada 21","misconception":"inverte os lados da atribuição"}],"correct":2,"explanation":"O = é o operador de atribuição: guarda o valor da direita na variável da esquerda. Comparar é outra operação, que veremos mais adiante."}$c$::jsonb, $c$Leia como "idade recebe 21".$c$, 6, false, $c$arquivo$c$),
  ($c$variaveis-copia-de-valor$c$, $c$introducao-as-variaveis$c$, $c$interpretation$c$, $c$Quanto vale b?$c$, $c$dificil$c$, $c$Acompanhe os valores e responda: o que o programa mostra?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"8","misconception":"acha que b acompanha as mudanças de a"},{"text":"5"},{"text":"13","misconception":"soma os dois valores"},{"text":"a","misconception":"mostra o nome da variável em vez do valor guardado nela"}],"correct":1,"code":"let a = 5;\nlet b = a;\na = 8;\nconsole.log(b);","explanation":"Ao fazer b = a, a variável b guarda o valor 5 (uma cópia). Mudar a depois não altera b: ele continua valendo 5."}$c$::jsonb, $c$b recebeu uma cópia do valor que a tinha naquele momento.$c$, 7, false, $c$arquivo$c$),
  ($c$declaracao-nome-valido$c$, $c$declaracao-de-variaveis$c$, $c$choice$c$, $c$Qual nome é válido?$c$, $c$facil$c$, $c$Qual destes é um nome de variável válido?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"1nota","misconception":"acha que o nome pode começar com número"},{"text":"nota final","misconception":"esquece que o nome não pode ter espaços"},{"text":"let","misconception":"usa uma palavra reservada como nome"},{"text":"nota1"}],"correct":3,"explanation":"nota1 usa só letras e número e não começa com número. Espaços e palavras reservadas, como let, não são permitidos."}$c$::jsonb, $c$O nome pode ter números, mas não pode começar por um.$c$, 1, false, $c$arquivo$c$),
  ($c$declaracao-linha-correta$c$, $c$declaracao-de-variaveis$c$, $c$choice$c$, $c$Qual linha declara a variável?$c$, $c$facil$c$, $c$Qual linha declara a variável cidade guardando o texto "Picos"?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"let cidade = \"Picos\";"},{"text":"cidade let = \"Picos\";","misconception":"inverte a ordem: a palavra let vem antes do nome"},{"text":"let cidade == \"Picos\";","misconception":"usa == (comparação) no lugar de = (atribuição)"},{"text":"let \"cidade\" = Picos;","misconception":"troca as aspas: o texto vai entre aspas, o nome da variável não"}],"correct":0,"explanation":"A forma correta é let nome = valor;. O texto vai entre aspas e o nome da variável, não."}$c$::jsonb, $c$A palavra let vem primeiro; depois o nome; depois o = e o valor.$c$, 2, false, $c$arquivo$c$),
  ($c$declaracao-complete$c$, $c$declaracao-de-variaveis$c$, $c$blank$c$, $c$Complete a declaração$c$, $c$facil$c$, $c$Complete o programa para declarar a variável nome com o texto Ana e mostrá-la.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"{{1}} nome = \"Ana\";\nconsole.log({{2}});","blanks":[{"answers":["let"]},{"answers":["nome"]}],"explanation":"let cria a variável e console.log(nome) mostra o valor guardado nela."}$c$::jsonb, $c$A declaração começa com a palavra reservada que cria variáveis.$c$, 3, false, $c$arquivo$c$),
  ($c$declaracao-sem-valor$c$, $c$declaracao-de-variaveis$c$, $c$interpretation$c$, $c$Variável sem valor$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Um texto vazio","misconception":"acha que uma variável sem valor guarda um texto vazio"},{"text":"0","misconception":"acha que uma variável sem valor guarda zero"},{"text":"undefined"},{"text":"Nada: dá erro, porque a variável não tem valor","misconception":"acha que declarar sem valor causa erro"}],"correct":2,"code":"let nome;\nconsole.log(nome);","explanation":"Uma variável declarada sem valor vale undefined, que significa \"ainda sem valor\". Isso não é um erro."}$c$::jsonb, $c$A variável existe, mas ninguém guardou nada nela.$c$, 4, false, $c$arquivo$c$),
  ($c$declaracao-maiuscula-minuscula$c$, $c$declaracao-de-variaveis$c$, $c$interpretation$c$, $c$Idade ou idade?$c$, $c$medio$c$, $c$O que acontece ao executar o programa abaixo?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Mostra 20","misconception":"acha que maiúsculas e minúsculas não fazem diferença"},{"text":"Dá erro, porque Idade (com I maiúsculo) nunca foi declarada"},{"text":"Mostra Idade","misconception":"acha que o console.log mostra o nome como texto"},{"text":"Mostra undefined","misconception":"acha que uma variável que não existe vale undefined"}],"correct":1,"code":"let idade = 20;\nconsole.log(Idade);","explanation":"O JavaScript diferencia maiúsculas de minúsculas. Idade e idade são nomes diferentes, e Idade não existe: o programa para com um erro."}$c$::jsonb, $c$Compare as duas grafias letra por letra.$c$, 5, false, $c$arquivo$c$),
  ($c$declaracao-corrija-o-nome$c$, $c$declaracao-de-variaveis$c$, $c$fix$c$, $c$Corrija o nome da variável$c$, $c$medio$c$, $c$A função `quadrado(numero)` deveria devolver o número multiplicado por ele mesmo, mas tem um defeito no nome de uma variável. Corrija.$c$, null, $c$quadrado$c$, $c$function quadrado(numero) {
  let resultado = numero * numero;
  return Resultado;
}
$c$, $c$[{"args":[3],"expected":9},{"args":[5],"expected":25},{"args":[0],"expected":0}]$c$::jsonb, $c${}$c$::jsonb, $c$Compare a variável criada com a variável devolvida.$c$, 6, false, $c$arquivo$c$),
  ($c$declaracao-so-nomes-validos$c$, $c$declaracao-de-variaveis$c$, $c$choice$c$, $c$Só nomes válidos$c$, $c$dificil$c$, $c$Qual alternativa tem SOMENTE nomes de variável válidos?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"2aluno, total, preco","misconception":"aceita um nome que começa com número"},{"text":"nota final, total, preco","misconception":"aceita um nome com espaço"},{"text":"let, const, total","misconception":"aceita palavras reservadas como nome"},{"text":"total, nota_final, $preco, aluno2"}],"correct":3,"explanation":"total, nota_final, $preco e aluno2 seguem as regras: só letras, números, _ e $, e nenhum começa com número."}$c$::jsonb, $c$Verifique cada nome: começo, espaços e palavras reservadas.$c$, 7, false, $c$arquivo$c$),
  ($c$letconst-palavra-que-muda$c$, $c$let-e-const$c$, $c$choice$c$, $c$Qual palavra permite mudar o valor?$c$, $c$facil$c$, $c$Qual palavra declara uma variável cujo valor pode ser trocado depois?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"let"},{"text":"const","misconception":"confunde constante com variável que pode mudar"},{"text":"mudar","misconception":"acha que existe uma palavra chamada mudar"},{"text":"valor","misconception":"confunde o conteúdo da variável com a palavra que a declara"}],"correct":0,"explanation":"let cria variáveis que podem receber novos valores. const cria valores fixos."}$c$::jsonb, $c$A outra palavra é a que fixa o valor.$c$, 1, false, $c$arquivo$c$),
  ($c$letconst-quando-usar-const$c$, $c$let-e-const$c$, $c$choice$c$, $c$Quando usar const?$c$, $c$facil$c$, $c$Qual destes valores combina melhor com const?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"O saldo de uma conta bancária","misconception":"usa const para um valor que muda a todo momento"},{"text":"A pontuação de um jogador","misconception":"usa const para um valor que muda durante o jogo"},{"text":"O valor de PI (3,14159)"},{"text":"O número de tentativas já usadas","misconception":"usa const para um valor que aumenta a cada tentativa"}],"correct":2,"explanation":"O valor de PI é sempre o mesmo, então é uma boa const. Saldo, pontuação e tentativas mudam, e pedem let."}$c$::jsonb, $c$Escolha o valor que nunca muda.$c$, 2, false, $c$arquivo$c$),
  ($c$letconst-complete$c$, $c$let-e-const$c$, $c$blank$c$, $c$let ou const?$c$, $c$facil$c$, $c$Complete as declarações: PI nunca muda e raio pode mudar depois.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"{{1}} PI = 3.14;\n{{2}} raio = 5;","blanks":[{"answers":["const"]},{"answers":["let"]}],"explanation":"PI é um valor fixo (const) e raio pode receber outro valor (let)."}$c$::jsonb, $c$Uma palavra fixa o valor; a outra permite trocá-lo.$c$, 3, false, $c$arquivo$c$),
  ($c$letconst-alterando-const$c$, $c$let-e-const$c$, $c$interpretation$c$, $c$Mudando uma const$c$, $c$medio$c$, $c$O que acontece ao executar o programa abaixo?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Mostra 0.2","misconception":"acha que uma const pode receber um novo valor"},{"text":"Dá erro: não é possível alterar uma const"},{"text":"Mostra 0.1, ignorando a segunda linha","misconception":"acha que o programa ignora a tentativa de mudar a const"},{"text":"Mostra taxa","misconception":"mostra o nome da variável em vez do valor guardado nela"}],"correct":1,"code":"const taxa = 0.1;\ntaxa = 0.2;\nconsole.log(taxa);","explanation":"taxa foi declarada com const, então a linha taxa = 0.2 causa o erro \"Assignment to constant variable\" e o programa para."}$c$::jsonb, $c$Veja qual palavra declarou a variável taxa.$c$, 4, false, $c$arquivo$c$),
  ($c$letconst-somando-pontos$c$, $c$let-e-const$c$, $c$interpretation$c$, $c$Quantos pontos?$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"10","misconception":"ignora a nova atribuição"},{"text":"5","misconception":"acha que o novo valor substitui o antigo sem usá-lo no cálculo"},{"text":"pontos + 5","misconception":"acha que o computador mostra a expressão em vez de calculá-la"},{"text":"15"}],"correct":3,"code":"let pontos = 10;\npontos = pontos + 5;\nconsole.log(pontos);","explanation":"pontos + 5 vale 10 + 5 = 15. Esse resultado é guardado em pontos, substituindo o 10."}$c$::jsonb, $c$Primeiro o computador calcula o lado direito, usando o valor atual de pontos.$c$, 5, false, $c$arquivo$c$),
  ($c$letconst-corrija-a-area$c$, $c$let-e-const$c$, $c$fix$c$, $c$Corrija a área do círculo$c$, $c$medio$c$, $c$A função `areaDoCirculo(raio)` deveria devolver a área (3.14 * raio * raio), mas dá erro. Corrija o defeito.$c$, null, $c$areaDoCirculo$c$, $c$function areaDoCirculo(raio) {
  const PI = 3.14;
  const area = 0;
  area = PI * raio * raio;
  return area;
}
$c$, $c$[{"args":[1],"expected":3.14},{"args":[2],"expected":12.56},{"args":[0],"expected":0}]$c$::jsonb, $c${}$c$::jsonb, $c$Qual declaração está sendo alterada depois de criada?$c$, 6, false, $c$arquivo$c$),
  ($c$letconst-qual-funciona$c$, $c$let-e-const$c$, $c$choice$c$, $c$Qual dupla de linhas funciona?$c$, $c$dificil$c$, $c$Qual das duplas de linhas abaixo funciona, sem causar erro?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"let total;\ntotal = 5;"},{"text":"const total = 0;\ntotal = 5;","misconception":"acha que uma const pode ser alterada depois"},{"text":"const total;\ntotal = 5;","misconception":"acha que uma const pode ser declarada sem valor e preenchida depois"},{"text":"let total = 0;\nlet total = 5;","misconception":"acha que a mesma variável pode ser declarada duas vezes"}],"correct":0,"explanation":"let total; cria a variável e total = 5; guarda o valor. As outras duplas alteram uma const, declaram uma const sem valor ou repetem a declaração."}$c$::jsonb, $c$Teste cada dupla: const não muda, e uma variável só é declarada uma vez.$c$, 7, false, $c$arquivo$c$),
  ($c$string-qual-e-texto$c$, $c$tipo-string$c$, $c$choice$c$, $c$Qual valor é uma string?$c$, $c$facil$c$, $c$Qual destes valores é uma string?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"42","misconception":"acha que todo número é um texto"},{"text":"true","misconception":"confunde o valor lógico true com um texto"},{"text":"\"42\""},{"text":"Ana","misconception":"esquece as aspas: sem aspas, Ana seria o nome de uma variável"}],"correct":2,"explanation":"O que está entre aspas é uma string, mesmo quando parece um número. Sem aspas, 42 é número e Ana seria o nome de uma variável."}$c$::jsonb, $c$Procure o valor que está entre aspas.$c$, 1, false, $c$arquivo$c$),
  ($c$string-typeof-numero-entre-aspas$c$, $c$tipo-string$c$, $c$interpretation$c$, $c$Qual é o tipo?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"number","misconception":"acha que um número entre aspas continua sendo número"},{"text":"string"},{"text":"7","misconception":"mostra o valor em vez do tipo"},{"text":"valor","misconception":"mostra o nome da variável em vez do tipo"}],"correct":1,"code":"const valor = \"7\";\nconsole.log(typeof valor);","explanation":"As aspas fazem de \"7\" um texto, então typeof mostra string."}$c$::jsonb, $c$Repare nas aspas em volta do 7.$c$, 2, false, $c$arquivo$c$),
  ($c$string-complete-as-aspas$c$, $c$tipo-string$c$, $c$blank$c$, $c$Complete as aspas$c$, $c$facil$c$, $c$Complete as aspas (use aspas duplas) para guardar o texto gato na variável animal.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const animal = {{1}}gato{{2}};\nconsole.log(typeof animal);","blanks":[{"answers":["\""]},{"answers":["\""]}],"explanation":"As aspas duplas delimitam o texto. Com elas, typeof animal mostra string."}$c$::jsonb, $c$O texto começa e termina com o mesmo símbolo.$c$, 3, false, $c$arquivo$c$),
  ($c$string-typeof-true-entre-aspas$c$, $c$tipo-string$c$, $c$interpretation$c$, $c$true ou "true"?$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"boolean\nboolean","misconception":"acha que as aspas não mudam o tipo do valor"},{"text":"string\nstring","misconception":"acha que o valor true é sempre um texto"},{"text":"boolean\nstring","misconception":"inverte os tipos"},{"text":"string\nboolean"}],"correct":3,"code":"console.log(typeof \"true\");\nconsole.log(typeof true);","explanation":"\"true\" entre aspas é um texto (string). true sem aspas é um valor lógico (boolean)."}$c$::jsonb, $c$Um dos valores está entre aspas e o outro não.$c$, 4, false, $c$arquivo$c$),
  ($c$string-aspas-dentro-do-texto$c$, $c$tipo-string$c$, $c$choice$c$, $c$Aspas dentro do texto$c$, $c$medio$c$, $c$Qual linha mostra corretamente o texto: Ele disse "oi"?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"console.log('Ele disse \"oi\"');"},{"text":"console.log(\"Ele disse \"oi\"\");","misconception":"usa o mesmo tipo de aspas por dentro e por fora, e o texto termina antes da hora"},{"text":"console.log(Ele disse \"oi\");","misconception":"esquece as aspas externas do texto"},{"text":"console.log(\"Ele disse 'oi);","misconception":"abre aspas simples por dentro e não fecha"}],"correct":0,"explanation":"Com aspas simples por fora, as aspas duplas de dentro fazem parte do texto e não o encerram."}$c$::jsonb, $c$Use um tipo de aspas por fora e o outro por dentro.$c$, 5, false, $c$arquivo$c$),
  ($c$string-corrija-as-aspas$c$, $c$tipo-string$c$, $c$fix$c$, $c$Corrija o texto sem aspas$c$, $c$medio$c$, $c$A função `cidade()` deveria devolver o texto Picos, mas dá erro. Corrija o defeito.$c$, null, $c$cidade$c$, $c$function cidade() {
  return Picos;
}
$c$, $c$[{"args":[],"expected":"Picos"}]$c$::jsonb, $c${}$c$::jsonb, $c$Como o computador entende uma palavra sem aspas?$c$, 6, false, $c$arquivo$c$),
  ($c$string-por-que-sao-diferentes$c$, $c$tipo-string$c$, $c$choice$c$, $c$"42" e 42 são iguais?$c$, $c$dificil$c$, $c$Por que "42" e 42 são considerados valores diferentes pelo computador?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Não são diferentes: só mudam as aspas","misconception":"acha que as aspas não mudam o significado do valor"},{"text":"Porque \"42\" é maior que 42","misconception":"compara os valores como se as aspas mudassem o tamanho"},{"text":"Porque o primeiro é um texto e o segundo é um número, e cada tipo se comporta de um jeito"},{"text":"Porque 42 é o nome de uma variável","misconception":"confunde número com nome de variável"}],"correct":2,"explanation":"\"42\" é uma string e 42 é um number. O tipo define o que se pode fazer com o valor: contas com números, junção com textos."}$c$::jsonb, $c$Pense no tipo de cada um.$c$, 7, false, $c$arquivo$c$),
  ($c$number-como-escrever-decimal$c$, $c$tipo-number$c$, $c$choice$c$, $c$Como escrever 3,5?$c$, $c$facil$c$, $c$Como se escreve o número três e meio em JavaScript?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"3,5","misconception":"usa a vírgula como separador decimal"},{"text":"3.5"},{"text":"\"3.5\"","misconception":"coloca aspas e transforma o número em texto"},{"text":"3 e meio","misconception":"escreve o número por extenso, como em um texto"}],"correct":1,"explanation":"O separador decimal é o ponto: 3.5. Com vírgula ou com aspas, o valor deixaria de ser um número."}$c$::jsonb, $c$Em programação, o separador decimal é o mesmo das calculadoras americanas.$c$, 1, false, $c$arquivo$c$),
  ($c$number-typeof-decimal$c$, $c$tipo-number$c$, $c$interpretation$c$, $c$Qual é o tipo de 3.14?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"decimal","misconception":"acha que existe um tipo separado chamado decimal"},{"text":"float","misconception":"usa o nome de tipo de outras linguagens de programação"},{"text":"string","misconception":"acha que um número com ponto é um texto"},{"text":"number"}],"correct":3,"code":"console.log(typeof 3.14);","explanation":"Todos os números, inteiros ou decimais, são do tipo number."}$c$::jsonb, $c$Em JavaScript inteiros e decimais têm o mesmo tipo.$c$, 2, false, $c$arquivo$c$),
  ($c$number-complete-a-altura$c$, $c$tipo-number$c$, $c$blank$c$, $c$Guarde a altura$c$, $c$facil$c$, $c$Complete a linha para guardar a altura 1,75 metro (escreva o número do jeito certo em JavaScript).$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const altura = {{1}};\nconsole.log(typeof altura);","blanks":[{"answers":["1.75"]}],"explanation":"1.75 é um número decimal válido em JavaScript, e typeof mostra number."}$c$::jsonb, $c$Decimais usam ponto e não levam aspas.$c$, 3, false, $c$arquivo$c$),
  ($c$number-divisao-decimal$c$, $c$tipo-number$c$, $c$interpretation$c$, $c$Divisões$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"2.5\n3.5"},{"text":"2\n3","misconception":"acha que a divisão sempre dá um resultado inteiro"},{"text":"2,5\n3,5","misconception":"mostra a vírgula como separador decimal"},{"text":"3\n4","misconception":"acha que o resultado é arredondado para cima"}],"correct":0,"code":"console.log(10 / 4);\nconsole.log(7 / 2);","explanation":"10 / 4 vale 2.5 e 7 / 2 vale 3.5. O resultado é mostrado com ponto decimal."}$c$::jsonb, $c$A divisão em JavaScript mantém a parte decimal.$c$, 4, false, $c$arquivo$c$),
  ($c$number-o-que-e-nan$c$, $c$tipo-number$c$, $c$choice$c$, $c$O que é NaN?$c$, $c$medio$c$, $c$O que significa o valor NaN?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Um número negativo","misconception":"confunde NaN com número negativo"},{"text":"Um número muito grande, maior que qualquer outro","misconception":"confunde NaN com Infinity"},{"text":"\"Não é um número\": o resultado de uma conta sem sentido"},{"text":"O número zero","misconception":"acha que uma conta sem sentido resulta em zero"}],"correct":2,"explanation":"NaN aparece quando uma conta não resulta em um número válido, como \"abc\" * 2."}$c$::jsonb, $c$A sigla vem do inglês: Not a Number.$c$, 5, false, $c$arquivo$c$),
  ($c$number-media-de-dois$c$, $c$tipo-number$c$, $c$code$c$, $c$Média de dois números$c$, $c$medio$c$, $c$Escreva a função `media(a, b)` que devolve a média aritmética de dois números (soma dividida por 2).$c$, null, $c$media$c$, $c$function media(a, b) {
  // seu código aqui
}
$c$, $c$[{"args":[4,6],"expected":5},{"args":[7,8],"expected":7.5},{"args":[0,0],"expected":0}]$c$::jsonb, $c${}$c$::jsonb, $c$Some os dois valores e divida pelo total de valores. Cuidado com a ordem das contas.$c$, 6, false, $c$arquivo$c$),
  ($c$number-contas-especiais$c$, $c$tipo-number$c$, $c$interpretation$c$, $c$Resultados especiais$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Erro\nErro","misconception":"acha que contas inválidas sempre param o programa com erro"},{"text":"Infinity\nNaN"},{"text":"0\n0","misconception":"acha que contas inválidas resultam em zero"},{"text":"Infinity\nInfinity","misconception":"acha que as duas contas dão o mesmo resultado especial"}],"correct":1,"code":"console.log(10 / 0);\nconsole.log(\"abc\" * 2);","explanation":"Dividir por zero dá Infinity, e multiplicar um texto que não é número por 2 dá NaN. Nenhuma das duas causa erro."}$c$::jsonb, $c$Uma conta é uma divisão por zero; a outra tenta multiplicar um texto sem sentido numérico.$c$, 7, false, $c$arquivo$c$),
  ($c$boolean-quais-sao-os-valores$c$, $c$tipo-boolean$c$, $c$choice$c$, $c$Os dois valores do boolean$c$, $c$facil$c$, $c$Quais são os dois únicos valores do tipo boolean?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"0 e 1","misconception":"confunde o tipo boolean com números"},{"text":"sim e não","misconception":"usa palavras do português em vez dos valores da linguagem"},{"text":"\"verdadeiro\" e \"falso\"","misconception":"escreve os valores como textos"},{"text":"true e false"}],"correct":3,"explanation":"O tipo boolean só aceita true e false, sem aspas e em minúsculas."}$c$::jsonb, $c$Os nomes vêm do inglês e são escritos em minúsculas.$c$, 1, false, $c$arquivo$c$),
  ($c$boolean-comparacao-simples$c$, $c$tipo-boolean$c$, $c$interpretation$c$, $c$5 é maior que 3?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true"},{"text":"5 > 3","misconception":"acha que o computador mostra a expressão em vez de avaliá-la"},{"text":"false","misconception":"acha que 5 não é maior que 3"},{"text":"8","misconception":"acha que o sinal > faz uma soma"}],"correct":0,"code":"console.log(5 > 3);","explanation":"A comparação 5 > 3 é verdadeira, então o resultado é o valor boolean true."}$c$::jsonb, $c$O sinal > faz uma pergunta: o da esquerda é maior que o da direita?$c$, 2, false, $c$arquivo$c$),
  ($c$boolean-complete-sem-desconto$c$, $c$tipo-boolean$c$, $c$blank$c$, $c$Cliente sem desconto$c$, $c$facil$c$, $c$O cliente NÃO tem desconto. Complete a linha com o valor booleano certo.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const temDesconto = {{1}};\nconsole.log(typeof temDesconto);","blanks":[{"answers":["false"]}],"explanation":"false representa \"não\". Sem aspas, ele é do tipo boolean."}$c$::jsonb, $c$É um valor lógico, escrito sem aspas.$c$, 3, false, $c$arquivo$c$),
  ($c$boolean-qual-e-boolean$c$, $c$tipo-boolean$c$, $c$choice$c$, $c$Qual valor é boolean?$c$, $c$medio$c$, $c$Qual destes valores é do tipo boolean?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"\"false\"","misconception":"confunde o texto \"false\" com o valor lógico false"},{"text":"True","misconception":"escreve com inicial maiúscula, mas o JavaScript diferencia maiúsculas de minúsculas"},{"text":"false"},{"text":"0","misconception":"confunde número com valor lógico"}],"correct":2,"explanation":"false (minúsculo e sem aspas) é um valor boolean. \"false\" é texto, True não existe em JavaScript e 0 é um número."}$c$::jsonb, $c$O valor lógico é escrito em minúsculas e sem aspas.$c$, 4, false, $c$arquivo$c$),
  ($c$boolean-idade-minima$c$, $c$tipo-boolean$c$, $c$interpretation$c$, $c$Pode entrar?$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true","misconception":"avalia a comparação ao contrário"},{"text":"false"},{"text":"16","misconception":"mostra o valor da variável em vez do resultado da comparação"},{"text":"18","misconception":"mostra o outro valor da comparação"}],"correct":1,"code":"const idade = 16;\nconsole.log(idade >= 18);","explanation":"16 não é maior nem igual a 18, então a comparação resulta em false."}$c$::jsonb, $c$Substitua idade por 16 e responda: 16 é maior ou igual a 18?$c$, 5, false, $c$arquivo$c$),
  ($c$boolean-tres-typeof$c$, $c$tipo-boolean$c$, $c$interpretation$c$, $c$Três tipos$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"string\nstring\nnumber","misconception":"acha que o valor true é sempre um texto"},{"text":"boolean\nboolean\nnumber","misconception":"acha que as aspas não mudam o tipo do valor"},{"text":"boolean\nstring\nboolean","misconception":"acha que o número 1 é um valor lógico"},{"text":"boolean\nstring\nnumber"}],"correct":3,"code":"console.log(typeof true);\nconsole.log(typeof \"true\");\nconsole.log(typeof 1);","explanation":"true é boolean, \"true\" entre aspas é string e 1 é number."}$c$::jsonb, $c$Observe quais valores têm aspas.$c$, 6, false, $c$arquivo$c$),
  ($c$boolean-igualdade$c$, $c$tipo-boolean$c$, $c$interpretation$c$, $c$Resultado da comparação$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true\nboolean"},{"text":"7\nnumber","misconception":"acha que a variável iguais guarda o valor de a"},{"text":"true\nstring","misconception":"acha que o resultado de uma comparação é um texto"},{"text":"false\nboolean","misconception":"avalia a comparação de igualdade ao contrário"}],"correct":0,"code":"const a = 7;\nconst b = 7;\nconst iguais = a === b;\nconsole.log(iguais);\nconsole.log(typeof iguais);","explanation":"a e b valem 7, então a === b é true. O resultado da comparação é guardado em iguais e seu tipo é boolean."}$c$::jsonb, $c$O sinal === compara se os dois valores são iguais e dá um valor lógico.$c$, 7, false, $c$arquivo$c$),
  ($c$textos-propriedade-do-tamanho$c$, $c$manipulacao-de-textos$c$, $c$choice$c$, $c$Como saber o tamanho?$c$, $c$facil$c$, $c$Qual propriedade informa quantos caracteres tem um texto?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"size","misconception":"usa o nome de outras linguagens"},{"text":"count","misconception":"usa o nome de outras linguagens"},{"text":"length"},{"text":"tamanho","misconception":"traduz o nome da propriedade para o português"}],"correct":2,"explanation":"texto.length devolve a quantidade de caracteres, e não leva parênteses."}$c$::jsonb, $c$O nome vem do inglês e significa "comprimento".$c$, 1, false, $c$arquivo$c$),
  ($c$textos-tamanho-de-casa$c$, $c$manipulacao-de-textos$c$, $c$interpretation$c$, $c$Quantas letras?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"3","misconception":"esquece de contar uma das letras, confundindo tamanho com último índice"},{"text":"4"},{"text":"casa","misconception":"mostra o texto em vez do tamanho"},{"text":"5","misconception":"conta um caractere a mais do que o texto tem"}],"correct":1,"code":"const palavra = \"casa\";\nconsole.log(palavra.length);","explanation":"length conta todos os caracteres: c, a, s, a. São 4."}$c$::jsonb, $c$Conte as letras de casa.$c$, 2, false, $c$arquivo$c$),
  ($c$textos-complete-maiusculas$c$, $c$manipulacao-de-textos$c$, $c$blank$c$, $c$Texto em maiúsculas$c$, $c$facil$c$, $c$Complete a linha para mostrar o nome em letras maiúsculas.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const nome = \"ana\";\nconsole.log(nome.{{1}}());","blanks":[{"answers":["toUpperCase"]}],"explanation":"toUpperCase() devolve o texto em maiúsculas: ANA."}$c$::jsonb, $c$O método tem o nome em inglês e usa letra maiúscula no meio.$c$, 3, false, $c$arquivo$c$),
  ($c$textos-indices-de-banana$c$, $c$manipulacao-de-textos$c$, $c$interpretation$c$, $c$Letras e posições$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"b\na\n5","misconception":"acha que length é o último índice, e não a quantidade de letras"},{"text":"a\nb\n6","misconception":"inverte as posições 0 e 5"},{"text":"b\nn\n6","misconception":"erra a letra da posição 5"},{"text":"b\na\n6"}],"correct":3,"code":"const palavra = \"banana\";\nconsole.log(palavra[0]);\nconsole.log(palavra[5]);\nconsole.log(palavra.length);","explanation":"palavra[0] é b, palavra[5] é a (a sexta letra) e palavra.length vale 6."}$c$::jsonb, $c$A posição 0 é a primeira letra; a última letra está na posição length - 1.$c$, 4, false, $c$arquivo$c$),
  ($c$textos-recorte-com-slice$c$, $c$manipulacao-de-textos$c$, $c$choice$c$, $c$Recortando um texto$c$, $c$medio$c$, $c$O que "Programação".slice(0, 4) devolve?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"\"Prog\""},{"text":"\"Progr\"","misconception":"acha que a posição final também entra no pedaço"},{"text":"\"rogr\"","misconception":"começa a contar as posições do 1 em vez do 0"},{"text":"\"ção\"","misconception":"acha que slice pega o final do texto"}],"correct":0,"explanation":"slice(0, 4) pega as posições 0, 1, 2 e 3: P, r, o, g. O 4 não entra."}$c$::jsonb, $c$slice pega da posição inicial até a posição final, sem incluí-la.$c$, 5, false, $c$arquivo$c$),
  ($c$textos-email$c$, $c$manipulacao-de-textos$c$, $c$interpretation$c$, $c$Analisando um e-mail$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"ana@escola.com\ntrue\n3","misconception":"acha que includes ignora a diferença entre maiúsculas e minúsculas"},{"text":"ana@escola.com\nfalse\n4","misconception":"conta a posição do @ a partir de 1"},{"text":"ana@escola.com\nfalse\n3"},{"text":"ana@escola.com\n3\nfalse","misconception":"inverte as respostas de includes e indexOf"}],"correct":2,"code":"const email = \"Ana@Escola.com\";\nconsole.log(email.toLowerCase());\nconsole.log(email.includes(\"ESCOLA\"));\nconsole.log(email.indexOf(\"@\"));","explanation":"toLowerCase deixa o texto em minúsculas. includes(\"ESCOLA\") procura exatamente esse texto no original (que tem \"Escola\"), então é false. O @ está na posição 3 (A=0, n=1, a=2, @=3)."}$c$::jsonb, $c$includes diferencia maiúsculas de minúsculas, e os índices começam em 0.$c$, 6, false, $c$arquivo$c$),
  ($c$textos-inicial-em-maiuscula$c$, $c$manipulacao-de-textos$c$, $c$code$c$, $c$Inicial em maiúscula$c$, $c$dificil$c$, $c$Escreva a função `inicial(nome)` que devolve a primeira letra do nome, em maiúscula, ignorando espaços no começo do texto.$c$, null, $c$inicial$c$, $c$function inicial(nome) {
  // seu código aqui
}
$c$, $c$[{"args":["  ana "],"expected":"A"},{"args":["beto"],"expected":"B"},{"args":["Carla"],"expected":"C"}]$c$::jsonb, $c${}$c$::jsonb, $c$Primeiro tire os espaços, depois pegue a letra de posição 0 e deixe em maiúscula.$c$, 7, false, $c$arquivo$c$),
  ($c$concat-operador$c$, $c$concatenacao$c$, $c$choice$c$, $c$Qual operador junta textos?$c$, $c$facil$c$, $c$Qual operador junta dois textos em JavaScript?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"&","misconception":"usa o operador de outras linguagens"},{"text":"+"},{"text":".","misconception":"usa o operador de outras linguagens"},{"text":",","misconception":"confunde com a vírgula que separa valores no console.log"}],"correct":1,"explanation":"O operador + junta textos. Com números dos dois lados, ele soma."}$c$::jsonb, $c$É o mesmo sinal usado para somar números.$c$, 1, false, $c$arquivo$c$),
  ($c$concat-bom-dia$c$, $c$concatenacao$c$, $c$interpretation$c$, $c$Texto grudado$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Bom dia","misconception":"acha que o + coloca um espaço automaticamente"},{"text":"Bom+dia","misconception":"acha que o console.log mostra o sinal +"},{"text":"undefined","misconception":"acha que juntar textos não funciona sem um terceiro valor"},{"text":"Bomdia"}],"correct":3,"code":"const a = \"Bom\";\nconst b = \"dia\";\nconsole.log(a + b);","explanation":"Os textos são juntados sem nada no meio: Bomdia. Para ter espaço, seria preciso concatenar também \" \"."}$c$::jsonb, $c$O + junta exatamente o que está nos dois textos.$c$, 2, false, $c$arquivo$c$),
  ($c$concat-complete-ola$c$, $c$concatenacao$c$, $c$blank$c$, $c$Complete a saudação$c$, $c$facil$c$, $c$Complete o programa para mostrar Olá, Ana (com o nome vindo da variável).$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const nome = \"Ana\";\nconsole.log(\"Olá, \" {{1}} nome);","blanks":[{"answers":["+"]}],"explanation":"O + junta o texto \"Olá, \" ao valor da variável nome."}$c$::jsonb, $c$Use o operador que junta textos.$c$, 3, false, $c$arquivo$c$),
  ($c$concat-texto-e-numero$c$, $c$concatenacao$c$, $c$interpretation$c$, $c$"5" + 3 e 5 + 3$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"53\n8"},{"text":"8\n8","misconception":"acha que o + sempre soma"},{"text":"53\n53","misconception":"acha que o + sempre junta"},{"text":"8\n53","misconception":"inverte o comportamento do + com texto e com números"}],"correct":0,"code":"console.log(\"5\" + 3);\nconsole.log(5 + 3);","explanation":"Com um texto de um dos lados, o + junta: \"5\" + 3 dá \"53\". Com dois números, o + soma: 5 + 3 dá 8."}$c$::jsonb, $c$Repare em qual dos dois 5 está entre aspas.$c$, 4, false, $c$arquivo$c$),
  ($c$concat-ordene-a-saudacao$c$, $c$concatenacao$c$, $c$order$c$, $c$Ordene o programa$c$, $c$medio$c$, $c$Coloque as linhas na ordem certa para o programa mostrar Olá, Ana!$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["const nome = \"Ana\";","const saudacao = \"Olá, \" + nome + \"!\";","console.log(saudacao);"],"explanation":"Primeiro criamos nome, depois montamos a saudação juntando textos e, por último, mostramos o resultado."}$c$::jsonb, $c$Cada linha usa uma variável criada na linha anterior.$c$, 5, false, $c$arquivo$c$),
  ($c$concat-idade-na-frase$c$, $c$concatenacao$c$, $c$interpretation$c$, $c$Frase com a idade$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Tenho idade anos","misconception":"trata o nome da variável como parte do texto"},{"text":"Tenho20anos","misconception":"acha que o + remove os espaços do texto"},{"text":"Tenho 20 anos"},{"text":"Tenho + 20 + anos","misconception":"acha que o console.log mostra os sinais de +"}],"correct":2,"code":"const idade = 20;\nconsole.log(\"Tenho \" + idade + \" anos\");","explanation":"A variável idade é trocada pelo seu valor (20) e os espaços escritos dentro dos textos são mantidos: Tenho 20 anos."}$c$::jsonb, $c$Os espaços estão dentro dos textos, junto às aspas.$c$, 6, false, $c$arquivo$c$),
  ($c$concat-da-esquerda-para-a-direita$c$, $c$concatenacao$c$, $c$interpretation$c$, $c$Da esquerda para a direita$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"6\n6","misconception":"acha que o + sempre soma"},{"text":"33\n123"},{"text":"123\n123","misconception":"acha que o + sempre junta, ignorando a ordem das contas"},{"text":"33\n6","misconception":"soma os números mesmo depois de aparecer um texto"}],"correct":1,"code":"console.log(1 + 2 + \"3\");\nconsole.log(\"1\" + 2 + 3);","explanation":"Na primeira linha, 1 + 2 vale 3 e só depois 3 + \"3\" vira \"33\". Na segunda, \"1\" + 2 já é texto (\"12\") e continua juntando: \"123\"."}$c$::jsonb, $c$O computador resolve o + da esquerda para a direita, um par de cada vez.$c$, 8, false, $c$arquivo$c$),
  ($c$concat-nome-completo$c$, $c$concatenacao$c$, $c$code$c$, $c$Nome completo$c$, $c$medio$c$, $c$Escreva a função `nomeCompleto(nome, sobrenome)` que devolve os dois textos juntos, separados por um espaço.$c$, null, $c$nomeCompleto$c$, $c$function nomeCompleto(nome, sobrenome) {
  // seu código aqui
}
$c$, $c$[{"args":["Ana","Lima"],"expected":"Ana Lima"},{"args":["Beto","Souza"],"expected":"Beto Souza"}]$c$::jsonb, $c${}$c$::jsonb, $c$Junte nome, um texto com um espaço e sobrenome.$c$, 7, false, $c$arquivo$c$),
  ($c$template-qual-simbolo$c$, $c$template-literals$c$, $c$choice$c$, $c$Qual símbolo usar?$c$, $c$facil$c$, $c$Qual símbolo delimita um template literal?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Aspas duplas (\" \")","misconception":"confunde template literal com texto comum"},{"text":"Aspas simples (' ')","misconception":"confunde template literal com texto comum"},{"text":"Parênteses ( )","misconception":"confunde o delimitador do texto com o de uma chamada de função"},{"text":"Crases (` `)"}],"correct":3,"explanation":"Os template literals usam crases. Só com elas o ${ } é substituído pelo valor."}$c$::jsonb, $c$Fica na tecla do acento grave.$c$, 1, false, $c$arquivo$c$),
  ($c$template-oi-beto$c$, $c$template-literals$c$, $c$interpretation$c$, $c$O que aparece?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Oi, Beto!"},{"text":"Oi, nome!","misconception":"acha que ${ } mostra o nome da variável"},{"text":"Oi, ${nome}!","misconception":"acha que o texto aparece exatamente como foi escrito"},{"text":"Oi, Beto","misconception":"esquece a pontuação que faz parte do texto"}],"correct":0,"code":"const nome = \"Beto\";\nconsole.log(`Oi, ${nome}!`);","explanation":"${nome} é substituído por Beto, e o restante do texto é mantido: Oi, Beto!"}$c$::jsonb, $c$O ${ } é trocado pelo valor da variável.$c$, 2, false, $c$arquivo$c$),
  ($c$template-complete$c$, $c$template-literals$c$, $c$blank$c$, $c$Complete o template$c$, $c$facil$c$, $c$Complete a linha para mostrar Olá, Ana! usando a variável nome.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const nome = \"Ana\";\nconsole.log(`Olá, ${{{1}}}!`);","blanks":[{"answers":["nome"]}],"explanation":"${nome} insere o valor da variável nome no meio do texto."}$c$::jsonb, $c$Dentro do ${ } vai o nome da variável, sem aspas.$c$, 3, false, $c$arquivo$c$),
  ($c$template-conta-dentro$c$, $c$template-literals$c$, $c$interpretation$c$, $c$Conta dentro do ${ }$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Total: preco * 2 reais","misconception":"acha que o conteúdo de ${ } é apenas texto"},{"text":"Total: 50 * 2 reais","misconception":"troca a variável pelo valor, mas não faz a conta"},{"text":"Total: 100 reais"},{"text":"Total: 502 reais","misconception":"junta o 50 e o 2 como se fossem textos"}],"correct":2,"code":"const preco = 50;\nconsole.log(`Total: ${preco * 2} reais`);","explanation":"O computador calcula preco * 2 = 100 e coloca o resultado no lugar do ${ }."}$c$::jsonb, $c$Dentro do ${ } o computador calcula a expressão.$c$, 4, false, $c$arquivo$c$),
  ($c$template-qual-linha$c$, $c$template-literals$c$, $c$choice$c$, $c$Qual linha está certa?$c$, $c$medio$c$, $c$Qual linha mostra Olá, Ana! usando a variável nome (que vale "Ana")?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"console.log(\"Olá, ${nome}!\");","misconception":"usa aspas comuns, que não substituem o ${nome}"},{"text":"console.log(`Olá, ${nome}!`);"},{"text":"console.log(`Olá, nome!`);","misconception":"esquece o ${ } ao redor da variável"},{"text":"console.log(`Olá, {nome}!`);","misconception":"esquece o cifrão antes das chaves"}],"correct":1,"explanation":"Só as crases com ${nome} trocam o nome pelo valor da variável."}$c$::jsonb, $c$Confira o tipo de aspas e o ${ }.$c$, 5, false, $c$arquivo$c$),
  ($c$template-corrija-a-saudacao$c$, $c$template-literals$c$, $c$fix$c$, $c$Corrija a saudação$c$, $c$medio$c$, $c$A função `saudacao(nome)` deveria devolver, por exemplo, Olá, Ana!, mas devolve o texto com ${nome} sem substituir. Corrija.$c$, null, $c$saudacao$c$, $c$function saudacao(nome) {
  return "Olá, ${nome}!";
}
$c$, $c$[{"args":["Ana"],"expected":"Olá, Ana!"},{"args":["Beto"],"expected":"Olá, Beto!"}]$c$::jsonb, $c${}$c$::jsonb, $c$Que símbolo é preciso trocar para o ${ } funcionar?$c$, 6, false, $c$arquivo$c$),
  ($c$template-apresentar$c$, $c$template-literals$c$, $c$code$c$, $c$Apresentar uma pessoa$c$, $c$medio$c$, $c$Escreva a função `apresentar(nome, idade)` que devolve, por exemplo, Ana tem 20 anos (use um template literal).$c$, null, $c$apresentar$c$, $c$function apresentar(nome, idade) {
  // seu código aqui
}
$c$, $c$[{"args":["Ana",20],"expected":"Ana tem 20 anos"},{"args":["Beto",35],"expected":"Beto tem 35 anos"}]$c$::jsonb, $c${}$c$::jsonb, $c$Escreva o texto entre crases e coloque cada variável dentro de um ${ }.$c$, 7, false, $c$arquivo$c$),
  ($c$template-soma-na-frase$c$, $c$template-literals$c$, $c$interpretation$c$, $c$A soma na frase$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"a + b = 7","misconception":"troca só o último valor e esquece de substituir as variáveis do começo"},{"text":"3 + 4 = 34","misconception":"junta os valores como texto dentro do ${ }"},{"text":"3 + 4 = a + b","misconception":"não calcula a expressão dentro do ${ }"},{"text":"3 + 4 = 7"}],"correct":3,"code":"const a = 3;\nconst b = 4;\nconsole.log(`${a} + ${b} = ${a + b}`);","explanation":"${a} vira 3, ${b} vira 4 e ${a + b} vira 7. O sinal + e o = fora dos ${ } fazem parte do texto."}$c$::jsonb, $c$Cada ${ } é resolvido separadamente, e o texto entre eles é mantido.$c$, 8, false, $c$arquivo$c$),
  ($c$operacoes-resto$c$, $c$operacoes-com-numeros$c$, $c$choice$c$, $c$Qual operador dá o resto?$c$, $c$facil$c$, $c$Qual operador dá o resto de uma divisão?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"%"},{"text":"/","misconception":"confunde o resto com o resultado da divisão"},{"text":"*","misconception":"confunde resto com multiplicação"},{"text":"**","misconception":"confunde resto com potência"}],"correct":0,"explanation":"O operador % devolve o resto da divisão. Por exemplo, 7 % 2 vale 1."}$c$::jsonb, $c$É um símbolo que lembra uma porcentagem, mas que aqui tem outro significado.$c$, 1, false, $c$arquivo$c$),
  ($c$operacoes-resto-de-sete$c$, $c$operacoes-com-numeros$c$, $c$interpretation$c$, $c$Quanto vale 7 % 2?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"3","misconception":"mostra o resultado inteiro da divisão em vez do resto"},{"text":"3.5","misconception":"mostra o resultado decimal da divisão"},{"text":"1"},{"text":"0","misconception":"acha que o resto de 7 por 2 é zero"}],"correct":2,"code":"console.log(7 % 2);","explanation":"2 cabe 3 vezes em 7 (6) e sobra 1. O % devolve essa sobra."}$c$::jsonb, $c$7 dividido por 2 dá 3 e sobra...$c$, 2, false, $c$arquivo$c$),
  ($c$operacoes-area-do-quadrado$c$, $c$operacoes-com-numeros$c$, $c$blank$c$, $c$Área do quadrado$c$, $c$facil$c$, $c$Complete a conta para calcular a área de um quadrado (lado vezes lado).$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const lado = 5;\nconst area = lado {{1}} lado;\nconsole.log(area);","blanks":[{"answers":["*"]}],"explanation":"A área do quadrado é lado * lado, que dá 25."}$c$::jsonb, $c$Área é um lado multiplicado pelo outro.$c$, 3, false, $c$arquivo$c$),
  ($c$operacoes-media-de-duas-notas$c$, $c$operacoes-com-numeros$c$, $c$interpretation$c$, $c$Média das notas$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"10","misconception":"ignora os parênteses e divide só a segunda nota por 2"},{"text":"7"},{"text":"14","misconception":"só soma as notas, esquecendo de dividir"},{"text":"3.5","misconception":"divide só a primeira nota por 2 e esquece a soma"}],"correct":1,"code":"const nota1 = 6;\nconst nota2 = 8;\nconst media = (nota1 + nota2) / 2;\nconsole.log(media);","explanation":"(6 + 8) / 2 = 14 / 2 = 7. Sem os parênteses, 6 + 8 / 2 daria 10."}$c$::jsonb, $c$Os parênteses fazem a soma acontecer antes da divisão.$c$, 4, false, $c$arquivo$c$),
  ($c$operacoes-media-de-tres$c$, $c$operacoes-com-numeros$c$, $c$code$c$, $c$Média de três números$c$, $c$medio$c$, $c$Escreva a função `mediaDeTres(a, b, c)` que devolve a média aritmética dos três números.$c$, null, $c$mediaDeTres$c$, $c$function mediaDeTres(a, b, c) {
  // seu código aqui
}
$c$, $c$[{"args":[3,6,9],"expected":6},{"args":[0,0,0],"expected":0},{"args":[1,2,3],"expected":2},{"args":[10,10,10],"expected":10}]$c$::jsonb, $c${}$c$::jsonb, $c$Some os três valores entre parênteses e divida por 3.$c$, 5, false, $c$arquivo$c$),
  ($c$operacoes-porcentagem$c$, $c$operacoes-com-numeros$c$, $c$choice$c$, $c$Vinte por cento do preço$c$, $c$medio$c$, $c$Qual expressão calcula 20% de um preço guardado em p?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"p * 20","misconception":"usa 20 em vez de 0.2: confunde porcentagem com o número inteiro"},{"text":"p / 20","misconception":"divide em vez de multiplicar pela fração"},{"text":"p + 0.2","misconception":"soma em vez de multiplicar"},{"text":"p * 0.2"}],"correct":3,"explanation":"20% equivale a 0.2, e calcular uma parte de um valor é multiplicar: p * 0.2."}$c$::jsonb, $c$20% é o mesmo que 0.2, e "vinte por cento de p" é uma multiplicação.$c$, 6, false, $c$arquivo$c$),
  ($c$operacoes-precedencia-e-arredondamento$c$, $c$operacoes-com-numeros$c$, $c$interpretation$c$, $c$Quatro contas$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"14\n20\n8\n3"},{"text":"20\n20\n8\n3","misconception":"calcula 2 + 3 * 4 da esquerda para a direita, ignorando a precedência"},{"text":"14\n20\n6\n3","misconception":"acha que ** multiplica em vez de elevar à potência"},{"text":"14\n20\n8\n3.5","misconception":"esquece que Math.floor arredonda para baixo"}],"correct":0,"code":"console.log(2 + 3 * 4);\nconsole.log((2 + 3) * 4);\nconsole.log(2 ** 3);\nconsole.log(Math.floor(7 / 2));","explanation":"2 + 3 * 4 = 14; (2 + 3) * 4 = 20; 2 ** 3 = 8; e 7 / 2 = 3.5, que Math.floor arredonda para 3."}$c$::jsonb, $c$Multiplicação vem antes da soma, e os parênteses mudam a ordem.$c$, 7, false, $c$arquivo$c$),
  ($c$conversao-qual-funcao$c$, $c$conversao-de-tipos$c$, $c$choice$c$, $c$Texto para número$c$, $c$facil$c$, $c$Qual expressão converte o texto "42" no número 42?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"String(\"42\")","misconception":"usa a função que converte para texto, mas \"42\" já é texto"},{"text":"Texto(\"42\")","misconception":"inventa uma função que não existe"},{"text":"Number(\"42\")"},{"text":"Converter(\"42\")","misconception":"inventa uma função que não existe"}],"correct":2,"explanation":"Number(\"42\") devolve o número 42. String() faz o contrário: transforma números em texto."}$c$::jsonb, $c$O resultado deve ser do tipo number.$c$, 1, false, $c$arquivo$c$),
  ($c$conversao-tipo-depois-de-number$c$, $c$conversao-de-tipos$c$, $c$interpretation$c$, $c$Tipo depois de converter$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"string","misconception":"acha que Number() mantém o valor como texto"},{"text":"number"},{"text":"15","misconception":"mostra o valor em vez do tipo"},{"text":"n","misconception":"mostra o nome da variável em vez do tipo"}],"correct":1,"code":"const n = Number(\"15\");\nconsole.log(typeof n);","explanation":"Number(\"15\") devolve o número 15, então typeof n mostra number."}$c$::jsonb, $c$Number() converte para o tipo number.$c$, 2, false, $c$arquivo$c$),
  ($c$conversao-complete$c$, $c$conversao-de-tipos$c$, $c$blank$c$, $c$Converta antes de somar$c$, $c$facil$c$, $c$A idade chegou como texto. Complete a linha para convertê-la em número e depois somar 1.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const idade = {{1}}(\"20\");\nconsole.log(idade + 1);","blanks":[{"answers":["Number"]}],"explanation":"Number(\"20\") vira o número 20, e 20 + 1 resulta em 21."}$c$::jsonb, $c$A função tem o mesmo nome do tipo que queremos.$c$, 3, false, $c$arquivo$c$),
  ($c$conversao-texto-ou-numero$c$, $c$conversao-de-tipos$c$, $c$interpretation$c$, $c$Com e sem conversão$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"15\n15","misconception":"acha que o texto \"10\" é somado como número automaticamente"},{"text":"105\n105","misconception":"acha que Number() não muda o comportamento do +"},{"text":"15\n105","misconception":"inverte os resultados com e sem conversão"},{"text":"105\n15"}],"correct":3,"code":"const x = \"10\";\nconsole.log(x + 5);\nconsole.log(Number(x) + 5);","explanation":"\"10\" + 5 junta os textos (105). Number(x) + 5 soma os números (15)."}$c$::jsonb, $c$Na primeira linha x é texto; na segunda, é número.$c$, 4, false, $c$arquivo$c$),
  ($c$conversao-resultados$c$, $c$conversao-de-tipos$c$, $c$interpretation$c$, $c$Três conversões$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"NaN\n12\n71"},{"text":"Erro\n12\n8","misconception":"acha que converter um texto inválido causa erro e que String(7) + 1 soma"},{"text":"0\n12\n71","misconception":"acha que um texto inválido vira zero"},{"text":"NaN\n12\n8","misconception":"acha que String(7) + 1 soma como se fosse número"}],"correct":0,"code":"console.log(Number(\"abc\"));\nconsole.log(Number(\"12\"));\nconsole.log(String(7) + 1);","explanation":"\"abc\" não é um número (NaN), \"12\" vira 12, e \"7\" + 1 junta os textos: 71."}$c$::jsonb, $c$String(7) transforma o 7 em texto antes do +.$c$, 5, false, $c$arquivo$c$),
  ($c$conversao-corrija-a-soma$c$, $c$conversao-de-tipos$c$, $c$fix$c$, $c$Corrija a soma$c$, $c$medio$c$, $c$A função `somar(a, b)` recebe dois números escritos como texto (por exemplo, "2" e "3") e deveria devolver a soma (5), mas junta os textos. Corrija.$c$, null, $c$somar$c$, $c$function somar(a, b) {
  return a + b;
}
$c$, $c$[{"args":["2","3"],"expected":5},{"args":["10","5"],"expected":15},{"args":["0","0"],"expected":0}]$c$::jsonb, $c${}$c$::jsonb, $c$O que o + faz quando os dois lados são textos? Converta antes.$c$, 6, false, $c$arquivo$c$),
  ($c$conversao-somar-entradas$c$, $c$conversao-de-tipos$c$, $c$code$c$, $c$Some duas entradas$c$, $c$medio$c$, $c$Escreva a função `somarEntradas()`: ela deve ler dois valores com `lerEntrada()` (que chegam como texto), converter para número e mostrar a soma com `console.log`.$c$, null, $c$somarEntradas$c$, $c$function somarEntradas() {
  // leia dois valores, converta e mostre a soma
}
$c$, $c$[{"args":[],"inputs":["4","6"],"output":["10"]},{"args":[],"inputs":["10","25"],"output":["35"]},{"args":[],"inputs":["0","0"],"output":["0"]}]$c$::jsonb, $c${}$c$::jsonb, $c$Cada lerEntrada() lê um valor. Converta com Number() antes de somar.$c$, 7, false, $c$arquivo$c$),
  ($c$conversao-multiplicar-e-somar$c$, $c$conversao-de-tipos$c$, $c$interpretation$c$, $c$O * e o + com texto$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"7\n7\nnumber","misconception":"acha que o texto \"3\" é sempre somado como número"},{"text":"12\n12\nnumber","misconception":"acha que o + também converte o texto em número"},{"text":"12\n34\nnumber"},{"text":"34\n34\nstring","misconception":"acha que o * também junta textos"}],"correct":2,"code":"const a = \"3\";\nconst b = 4;\nconsole.log(a * b);\nconsole.log(a + b);\nconsole.log(typeof (a * b));","explanation":"a * b converte \"3\" em 3 e multiplica: 12 (number). a + b junta os valores como texto: \"34\"."}$c$::jsonb, $c$O * converte o texto em número; o + junta quando um dos lados é texto.$c$, 8, false, $c$arquivo$c$),
  ($c$es-comando-de-entrada$c$, $c$entrada-e-saida-de-informacoes$c$, $c$choice$c$, $c$Qual comando lê a entrada?$c$, $c$facil$c$, $c$Qual comando da plataforma lê um valor de entrada?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"console.log()","misconception":"confunde entrada com saída"},{"text":"lerEntrada()"},{"text":"Number()","misconception":"confunde converter um valor com ler um valor"},{"text":"typeof","misconception":"confunde descobrir o tipo com ler um valor"}],"correct":1,"explanation":"lerEntrada() lê um valor. console.log mostra, Number converte e typeof descobre o tipo."}$c$::jsonb, $c$Entrada é o que o programa recebe, e não o que ele mostra.$c$, 1, false, $c$arquivo$c$),
  ($c$es-ola-nome$c$, $c$entrada-e-saida-de-informacoes$c$, $c$interpretation$c$, $c$Olá, nome$c$, $c$facil$c$, $c$Se a entrada for Ana, o que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Olá, nome","misconception":"mostra o nome da variável em vez do valor lido"},{"text":"Olá, lerEntrada()","misconception":"acha que o texto da chamada aparece na tela"},{"text":"Ana","misconception":"esquece a parte fixa do texto"},{"text":"Olá, Ana"}],"correct":3,"code":"const nome = lerEntrada();\nconsole.log(\"Olá, \" + nome);","explanation":"lerEntrada() entrega Ana, que fica na variável nome. A saída junta o texto \"Olá, \" ao valor: Olá, Ana."}$c$::jsonb, $c$A variável nome recebe o que foi digitado.$c$, 2, false, $c$arquivo$c$),
  ($c$es-boas-vindas$c$, $c$entrada-e-saida-de-informacoes$c$, $c$code$c$, $c$Boas-vindas$c$, $c$facil$c$, $c$Escreva a função `boasVindas()`: leia um nome com `lerEntrada()` e mostre, com `console.log`, a frase Bem-vindo, NOME!$c$, null, $c$boasVindas$c$, $c$function boasVindas() {
  // leia o nome e mostre a frase
}
$c$, $c$[{"args":[],"inputs":["Ana"],"output":["Bem-vindo, Ana!"]},{"args":[],"inputs":["Beto"],"output":["Bem-vindo, Beto!"]}]$c$::jsonb, $c${}$c$::jsonb, $c$Guarde o nome em uma variável e monte a frase com um template literal.$c$, 3, false, $c$arquivo$c$),
  ($c$es-entradas-sao-texto$c$, $c$entrada-e-saida-de-informacoes$c$, $c$interpretation$c$, $c$Entradas são texto$c$, $c$medio$c$, $c$As entradas são "2" e "3" (como textos). O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"23"},{"text":"5","misconception":"esquece que a entrada chega como texto, e que o + junta textos"},{"text":"a + b","misconception":"mostra a expressão em vez do resultado"},{"text":"2\n3","misconception":"acha que o console.log mostra as duas entradas"}],"correct":0,"code":"const a = lerEntrada();\nconst b = lerEntrada();\nconsole.log(a + b);","explanation":"Como a entrada chega como texto, \"2\" + \"3\" junta os textos e resulta em \"23\". Para somar, seria preciso converter com Number()."}$c$::jsonb, $c$O + junta quando os dois lados são textos.$c$, 4, false, $c$arquivo$c$),
  ($c$es-ordene-o-programa$c$, $c$entrada-e-saida-de-informacoes$c$, $c$order$c$, $c$Ordene o programa$c$, $c$medio$c$, $c$Coloque as linhas na ordem certa para ler um número, calcular o dobro e mostrar o resultado.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["const texto = lerEntrada();","const numero = Number(texto);","const dobro = numero * 2;","console.log(dobro);"],"explanation":"Lemos o valor, convertemos para número, calculamos o dobro e só então mostramos o resultado."}$c$::jsonb, $c$Cada linha usa a variável criada na linha anterior.$c$, 5, false, $c$arquivo$c$),
  ($c$es-area-do-retangulo$c$, $c$entrada-e-saida-de-informacoes$c$, $c$code$c$, $c$Área do retângulo$c$, $c$medio$c$, $c$Escreva a função `areaDoRetangulo()`: leia a base e a altura com `lerEntrada()` (chegam como texto) e mostre, com `console.log`, a frase Área: VALOR.$c$, null, $c$areaDoRetangulo$c$, $c$function areaDoRetangulo() {
  // leia a base e a altura, calcule e mostre
}
$c$, $c$[{"args":[],"inputs":["5","3"],"output":["Área: 15"]},{"args":[],"inputs":["10","2"],"output":["Área: 20"]}]$c$::jsonb, $c${}$c$::jsonb, $c$Converta os dois valores com Number() antes de multiplicar.$c$, 6, false, $c$arquivo$c$),
  ($c$es-corrija-o-ano-que-vem$c$, $c$entrada-e-saida-de-informacoes$c$, $c$fix$c$, $c$Corrija o ano que vem$c$, $c$medio$c$, $c$O programa lê uma idade e deveria mostrar Ano que vem: 21 (se a idade for 20), mas mostra Ano que vem: 201. Corrija o defeito.$c$, null, $c$anoQueVem$c$, $c$function anoQueVem() {
  const idade = lerEntrada();
  console.log("Ano que vem: " + idade + 1);
}
$c$, $c$[{"args":[],"inputs":["20"],"output":["Ano que vem: 21"]},{"args":[],"inputs":["9"],"output":["Ano que vem: 10"]}]$c$::jsonb, $c${}$c$::jsonb, $c$Primeiro faça a conta com números; depois junte ao texto.$c$, 7, false, $c$arquivo$c$),
  ($c$es-media-das-notas$c$, $c$entrada-e-saida-de-informacoes$c$, $c$code$c$, $c$Média das notas$c$, $c$dificil$c$, $c$Escreva a função `mediaDasNotas()`: leia três notas com `lerEntrada()` (chegam como texto) e mostre, com `console.log`, a frase Média: VALOR.$c$, null, $c$mediaDasNotas$c$, $c$function mediaDasNotas() {
  // leia as três notas, calcule a média e mostre
}
$c$, $c$[{"args":[],"inputs":["6","8","7"],"output":["Média: 7"]},{"args":[],"inputs":["10","10","10"],"output":["Média: 10"]},{"args":[],"inputs":["3","6","9"],"output":["Média: 6"]}]$c$::jsonb, $c${}$c$::jsonb, $c$São três leituras, três conversões, uma soma entre parênteses, uma divisão e uma frase.$c$, 8, false, $c$arquivo$c$),
  ($c$log-varias-chamadas$c$, $c$uso-do-console-log$c$, $c$choice$c$, $c$Duas chamadas$c$, $c$facil$c$, $c$O que acontece quando chamamos console.log duas vezes seguidas?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Os dois valores aparecem na mesma linha","misconception":"acha que console.log não muda de linha"},{"text":"Só o último valor aparece","misconception":"acha que a última chamada apaga a anterior"},{"text":"Cada chamada mostra uma nova linha"},{"text":"O programa dá erro","misconception":"acha que só se pode chamar console.log uma vez"}],"correct":2,"explanation":"Cada chamada de console.log escreve uma linha própria."}$c$::jsonb, $c$Pense nas mensagens que você já viu aparecerem uma embaixo da outra.$c$, 1, false, $c$arquivo$c$),
  ($c$log-com-virgula$c$, $c$uso-do-console-log$c$, $c$interpretation$c$, $c$Valores com vírgula$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Total:50","misconception":"acha que a vírgula junta os valores sem espaço"},{"text":"Total: 50"},{"text":"Total:, 50","misconception":"acha que a vírgula aparece na tela"},{"text":"50","misconception":"acha que só o último valor é mostrado"}],"correct":1,"code":"console.log(\"Total:\", 50);","explanation":"Com vários valores, o console.log mostra todos na mesma linha, separados por um espaço."}$c$::jsonb, $c$A vírgula separa os valores, e o console.log coloca um espaço entre eles.$c$, 2, false, $c$arquivo$c$),
  ($c$log-complete-a-media$c$, $c$uso-do-console-log$c$, $c$blank$c$, $c$Mostre a média$c$, $c$facil$c$, $c$Complete o programa para mostrar Média: 7 usando a variável media.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const media = 7;\nconsole.log(\"Média:\", {{1}});","blanks":[{"answers":["media"]}],"explanation":"media (sem aspas) é substituída pelo valor 7. Com aspas, apareceria a palavra media."}$c$::jsonb, $c$O segundo valor do console.log é o nome da variável, sem aspas.$c$, 3, false, $c$arquivo$c$),
  ($c$log-texto-ou-conta$c$, $c$uso-do-console-log$c$, $c$interpretation$c$, $c$Texto ou conta?$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"10\n10\n55","misconception":"acha que o texto entre aspas também é calculado e que a vírgula junta os valores"},{"text":"5 + 5\n55\n5 5","misconception":"acha que 5 + 5 junta os valores como texto"},{"text":"5 + 5\n10\n10","misconception":"calcula a última linha em vez de mostrar os dois textos"},{"text":"5 + 5\n10\n5 5"}],"correct":3,"code":"console.log(\"5 + 5\");\nconsole.log(5 + 5);\nconsole.log(\"5\", \"5\");","explanation":"\"5 + 5\" é mostrado como texto, 5 + 5 é calculado (10) e os dois \"5\" separados por vírgula aparecem com um espaço entre eles."}$c$::jsonb, $c$Aspas mostram o texto como está; sem aspas, a conta é feita; a vírgula separa com espaço.$c$, 4, false, $c$arquivo$c$),
  ($c$log-mostrar-os-dados$c$, $c$uso-do-console-log$c$, $c$code$c$, $c$Mostre os dados$c$, $c$medio$c$, $c$Escreva a função `mostrarDados()`: leia o nome e a idade com `lerEntrada()` e mostre duas linhas com `console.log`, no formato Nome: NOME e Idade: IDADE (use vírgulas no console.log).$c$, null, $c$mostrarDados$c$, $c$function mostrarDados() {
  // leia o nome e a idade e mostre as duas linhas
}
$c$, $c$[{"args":[],"inputs":["Ana",20],"output":["Nome: Ana","Idade: 20"]},{"args":[],"inputs":["Beto",35],"output":["Nome: Beto","Idade: 35"]}]$c$::jsonb, $c${}$c$::jsonb, $c$Cada console.log é uma linha; use a vírgula para separar o rótulo do valor.$c$, 5, false, $c$arquivo$c$),
  ($c$log-operacoes-em-linhas$c$, $c$uso-do-console-log$c$, $c$interpretation$c$, $c$Contas em linhas$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Soma: 10\nProduto: 24\nDivisão: 1.5"},{"text":"Soma: 64\nProduto: 24\nDivisão: 1.5","misconception":"junta os números como texto na soma"},{"text":"Soma: 10\nProduto: 24\nDivisão: 2","misconception":"acha que a divisão sempre dá um resultado inteiro"},{"text":"Soma: a + b\nProduto: a * b\nDivisão: a / b","misconception":"mostra as expressões em vez de calculá-las"}],"correct":0,"code":"const a = 6;\nconst b = 4;\nconsole.log(\"Soma:\", a + b);\nconsole.log(\"Produto:\", a * b);\nconsole.log(\"Divisão:\", a / b);","explanation":"6 + 4 = 10, 6 * 4 = 24 e 6 / 4 = 1.5. Cada console.log mostra o rótulo e o resultado."}$c$::jsonb, $c$Os valores depois da vírgula são calculados antes de serem mostrados.$c$, 6, false, $c$arquivo$c$),
  ($c$log-corrija-o-total$c$, $c$uso-do-console-log$c$, $c$fix$c$, $c$Corrija o espaço do total$c$, $c$medio$c$, $c$A função `mostrarTotal(preco, quantidade)` deveria mostrar Total: 50 (para preço 10 e quantidade 5), mas mostra Total:50. Corrija o defeito.$c$, null, $c$mostrarTotal$c$, $c$function mostrarTotal(preco, quantidade) {
  const total = preco * quantidade;
  console.log("Total:" + total);
}
$c$, $c$[{"args":[10,5],"output":["Total: 50"]},{"args":[3,3],"output":["Total: 9"]}]$c$::jsonb, $c${}$c$::jsonb, $c$Falta um espaço entre o rótulo e o valor. Há mais de uma forma de resolver.$c$, 7, false, $c$arquivo$c$),
  ($c$log-quatro-linhas$c$, $c$uso-do-console-log$c$, $c$interpretation$c$, $c$Quatro linhas$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Ana\nAna\nAna 3\n2 2","misconception":"mostra o valor da variável mesmo quando o nome está entre aspas e soma o \"1\" + 1"},{"text":"nome\nAna\nAna 3\n2 2","misconception":"soma \"1\" + 1 como se fosse número"},{"text":"nome\nAna\nAna 3\n11 2"},{"text":"nome\nAna\nAna, 3\n11, 2","misconception":"acha que a vírgula aparece na tela"}],"correct":2,"code":"const nome = \"Ana\";\nconsole.log(\"nome\");\nconsole.log(nome);\nconsole.log(nome, nome.length);\nconsole.log(\"1\" + 1, 1 + 1);","explanation":"\"nome\" é um texto; nome é a variável (Ana). nome.length vale 3. \"1\" + 1 junta (11) e 1 + 1 soma (2), e os dois aparecem na mesma linha."}$c$::jsonb, $c$Atenção a quais valores estão entre aspas e ao que o + faz com texto.$c$, 8, false, $c$arquivo$c$),
  ($c$desafio2-ficha-da-pessoa$c$, $c$desafio-do-mundo-2$c$, $c$challenge$c$, $c$Desafio: ficha da pessoa$c$, $c$dificil$c$, $c$Escreva a função `ficha()`: leia o nome, a idade e a altura (em metros) com `lerEntrada()` (chegam como texto) e mostre quatro linhas com `console.log`: Nome: NOME, Idade: IDADE anos, Altura: ALTURA m e Daqui a 10 anos, NOME terá IDADE+10 anos.$c$, null, $c$ficha$c$, $c$function ficha() {
  // leia nome, idade e altura
  // mostre as quatro linhas pedidas
}
$c$, $c$[{"args":[],"inputs":["Ana","20","1.75"],"output":["Nome: Ana","Idade: 20 anos","Altura: 1.75 m","Daqui a 10 anos, Ana terá 30 anos."]},{"args":[],"inputs":["Beto","35","1.8"],"output":["Nome: Beto","Idade: 35 anos","Altura: 1.8 m","Daqui a 10 anos, Beto terá 45 anos."]}]$c$::jsonb, $c${}$c$::jsonb, $c$A idade precisa virar número para somar 10. Use const para os dados que não mudam.$c$, 1, false, $c$arquivo$c$),
  ($c$desafio2-corrija-o-resumo$c$, $c$desafio-do-mundo-2$c$, $c$fix$c$, $c$Desafio: corrija o resumo$c$, $c$dificil$c$, $c$O programa lê dois números e deveria mostrar a soma e a média, mas mostra resultados errados (por exemplo, Soma: 46 e Média: 23 para as entradas 4 e 6). Corrija o defeito.$c$, null, $c$resumo$c$, $c$function resumo() {
  const a = lerEntrada();
  const b = lerEntrada();
  const soma = a + b;
  const media = soma / 2;
  console.log(`Soma: ${soma}`);
  console.log(`Média: ${media}`);
}
$c$, $c$[{"args":[],"inputs":["4","6"],"output":["Soma: 10","Média: 5"]},{"args":[],"inputs":["10","20"],"output":["Soma: 30","Média: 15"]},{"args":[],"inputs":["3","4"],"output":["Soma: 7","Média: 3.5"]}]$c$::jsonb, $c${}$c$::jsonb, $c$Os valores lidos são textos. O que o + faz com dois textos?$c$, 2, false, $c$arquivo$c$),
  ($c$desafio2-tipos-e-conversoes$c$, $c$desafio-do-mundo-2$c$, $c$interpretation$c$, $c$Desafio: acompanhe os tipos$c$, $c$dificil$c$, $c$Acompanhe o valor e o tipo de cada variável. O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"number\n60","misconception":"ignora a segunda atribuição, que transforma o total em texto"},{"text":"string\n600"},{"text":"number\n600","misconception":"acha que somar um texto a um número mantém o tipo number"},{"text":"string\n2060","misconception":"junta \"20\" e 3 em vez de multiplicar"}],"correct":1,"code":"const preco = \"20\";\nconst quantidade = 3;\nlet total = preco * quantidade;\ntotal = total + \"0\";\nconsole.log(typeof total);\nconsole.log(total);","explanation":"preco * quantidade converte \"20\" em 20 e dá 60 (number). Depois, total + \"0\" junta 60 com \"0\" e resulta no texto \"600\" (string)."}$c$::jsonb, $c$O * converte o texto em número; depois o + com um texto junta os valores.$c$, 3, false, $c$arquivo$c$),
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
  ($c$op-intro-quem-e-o-operador$c$, $c$introducao-aos-operadores$c$, $c$choice$c$, $c$Qual é o operador?$c$, $c$facil$c$, $c$Na expressão 7 + 2, qual é o operador?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"7","misconception":"confunde operador com operando"},{"text":"+"},{"text":"2","misconception":"confunde operador com operando"},{"text":"7 + 2","misconception":"chama a expressão inteira de operador"}],"correct":1,"explanation":"O operador é o +. Os números 7 e 2 são os operandos, e a expressão toda é 7 + 2."}$c$::jsonb, $c$O operador é o símbolo que manda fazer a operação.$c$, 1, false, $c$arquivo$c$),
  ($c$op-intro-grupo-relacional$c$, $c$introducao-aos-operadores$c$, $c$choice$c$, $c$Qual grupo compara valores?$c$, $c$facil$c$, $c$Qual grupo de operadores compara dois valores e resulta em true ou false?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Aritméticos","misconception":"confunde comparar valores com fazer contas"},{"text":"De atribuição","misconception":"confunde comparar com guardar um valor em uma variável"},{"text":"Lógicos","misconception":"confunde comparar valores com combinar resultados booleanos"},{"text":"Relacionais"}],"correct":3,"explanation":"Os operadores relacionais comparam dois valores e respondem com um boolean."}$c$::jsonb, $c$São os operadores de >, < e ===.$c$, 2, false, $c$arquivo$c$),
  ($c$op-intro-complete-a-conta$c$, $c$introducao-aos-operadores$c$, $c$blank$c$, $c$Complete a conta$c$, $c$facil$c$, $c$Complete a linha com o operador que faz o programa mostrar 12.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const resultado = 4 {{1}} 3;\nconsole.log(resultado);","blanks":[{"answers":["*"]}],"explanation":"O operador * multiplica: 4 * 3 vale 12."}$c$::jsonb, $c$4 e 3 dão 12 quando um é multiplicado pelo outro.$c$, 3, false, $c$arquivo$c$),
  ($c$op-intro-soma-e-comparacao$c$, $c$introducao-aos-operadores$c$, $c$interpretation$c$, $c$Conta e comparação$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"8\nfalse"},{"text":"8\ntrue","misconception":"acha que 4 é maior que 4"},{"text":"44\nfalse","misconception":"junta os números como se fossem textos"},{"text":"false\n8","misconception":"inverte a ordem dos resultados"}],"correct":0,"code":"const a = 4;\nconst b = 4;\nconsole.log(a + b);\nconsole.log(a > b);","explanation":"a + b vale 8 (número). a > b pergunta se 4 é maior que 4, e a resposta é false."}$c$::jsonb, $c$Uma linha faz uma conta; a outra, uma comparação.$c$, 4, false, $c$arquivo$c$),
  ($c$op-intro-resultado-boolean$c$, $c$introducao-aos-operadores$c$, $c$choice$c$, $c$Qual expressão resulta em boolean?$c$, $c$medio$c$, $c$Qual destas expressões resulta em um valor boolean?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"3 + 4","misconception":"acha que toda expressão com números resulta em boolean"},{"text":"3 * 4","misconception":"confunde uma conta com uma comparação"},{"text":"3 < 4"},{"text":"10 % 3","misconception":"confunde o resto de uma divisão com uma comparação"}],"correct":2,"explanation":"3 < 4 compara dois valores e resulta em true. As outras são contas e resultam em números."}$c$::jsonb, $c$Procure a expressão que faz uma pergunta.$c$, 5, false, $c$arquivo$c$),
  ($c$op-intro-operador-unario$c$, $c$introducao-aos-operadores$c$, $c$choice$c$, $c$Um operando só$c$, $c$medio$c$, $c$Qual destes operadores é usado, normalmente, com um operando só?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"*","misconception":"acha que a multiplicação trabalha com um valor só"},{"text":"!"},{"text":"&&","misconception":"acha que o operador E trabalha com um valor só"},{"text":"===","misconception":"acha que a comparação trabalha com um valor só"}],"correct":1,"explanation":"O ! (NÃO) inverte um valor boolean e usa um operando só. Os outros operadores precisam de dois operandos."}$c$::jsonb, $c$Pense em qual deles aparece na frente de um valor, como em !true.$c$, 6, false, $c$arquivo$c$),
  ($c$op-intro-varios-grupos$c$, $c$introducao-aos-operadores$c$, $c$interpretation$c$, $c$Os grupos juntos$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"false\n4","misconception":"esquece que x foi alterado para 6"},{"text":"true\n61","misconception":"junta o 6 e o 1 como texto"},{"text":"true\n4","misconception":"usa o valor antigo de x (3) na última linha"},{"text":"true\n7"}],"correct":3,"code":"let x = 3;\nx = x * 2;\nconsole.log(x > 5);\nconsole.log(x + 1);","explanation":"x passa a valer 6. Então x > 5 é true e x + 1 vale 7."}$c$::jsonb, $c$Acompanhe o valor de x depois de cada linha.$c$, 7, false, $c$arquivo$c$),
  ($c$arit-operador-da-potencia$c$, $c$operadores-aritmeticos$c$, $c$choice$c$, $c$Qual operador é a potência?$c$, $c$facil$c$, $c$Qual operador calcula uma potência (2 elevado a 3)?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"**"},{"text":"^","misconception":"usa o símbolo da matemática escrita, mas em JavaScript ele faz outra operação"},{"text":"*","misconception":"confunde potência com multiplicação"},{"text":"%","misconception":"confunde potência com resto da divisão"}],"correct":0,"explanation":"A potência usa **. Assim, 2 ** 3 vale 8. O ^ existe, mas faz outra operação (bit a bit)."}$c$::jsonb, $c$São dois asteriscos juntos.$c$, 1, false, $c$arquivo$c$),
  ($c$arit-resto-de-vinte-por-seis$c$, $c$operadores-aritmeticos$c$, $c$interpretation$c$, $c$Quanto vale 20 % 6?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"3","misconception":"mostra o quociente da divisão em vez do resto"},{"text":"3.3333333333333335","misconception":"mostra o resultado decimal da divisão"},{"text":"2"},{"text":"14","misconception":"calcula a diferença em vez do resto"}],"correct":2,"code":"console.log(20 % 6);","explanation":"6 cabe 3 vezes em 20 (18) e sobram 2. O % devolve essa sobra."}$c$::jsonb, $c$Quantas vezes o 6 cabe no 20? E o que sobra?$c$, 2, false, $c$arquivo$c$),
  ($c$arit-complete-o-resto$c$, $c$operadores-aritmeticos$c$, $c$blank$c$, $c$Complete o resto$c$, $c$facil$c$, $c$Complete a linha para mostrar o resto da divisão de 17 por 5.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"console.log(17 {{1}} 5);","blanks":[{"answers":["%"]}],"explanation":"17 % 5 vale 2, porque 5 cabe 3 vezes em 17 e sobram 2."}$c$::jsonb, $c$Esse operador lembra o símbolo de porcentagem.$c$, 3, false, $c$arquivo$c$),
  ($c$arit-tres-contas$c$, $c$operadores-aritmeticos$c$, $c$interpretation$c$, $c$Potência, produto e divisão$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"6\n6\n4.5","misconception":"acha que ** multiplica, como o *"},{"text":"8\n6\n4.5"},{"text":"8\n6\n4","misconception":"acha que a divisão arredonda para um número inteiro"},{"text":"5\n6\n4.5","misconception":"confunde a potência com a soma"}],"correct":1,"code":"console.log(2 ** 3);\nconsole.log(2 * 3);\nconsole.log(9 / 2);","explanation":"2 ** 3 = 2 * 2 * 2 = 8, 2 * 3 = 6 e 9 / 2 = 4.5."}$c$::jsonb, $c$** é potência: 2 multiplicado por ele mesmo 3 vezes.$c$, 4, false, $c$arquivo$c$),
  ($c$arit-ultimo-digito$c$, $c$operadores-aritmeticos$c$, $c$code$c$, $c$Último dígito$c$, $c$medio$c$, $c$Escreva a função `ultimoDigito(n)` que devolve o último dígito de um número inteiro positivo (por exemplo, 123 devolve 3).$c$, null, $c$ultimoDigito$c$, $c$function ultimoDigito(n) {
  // seu código aqui
}
$c$, $c$[{"args":[123],"expected":3},{"args":[40],"expected":0},{"args":[7],"expected":7},{"args":[2024],"expected":4}]$c$::jsonb, $c${}$c$::jsonb, $c$O resto da divisão por 10 é o que sobra depois de tirar as dezenas, centenas...$c$, 5, false, $c$arquivo$c$),
  ($c$arit-parte-inteira$c$, $c$operadores-aritmeticos$c$, $c$choice$c$, $c$Parte inteira da divisão$c$, $c$medio$c$, $c$Qual expressão dá a parte inteira da divisão de 17 por 5 (isto é, 3)?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"17 / 5","misconception":"esquece que a divisão em JavaScript dá resultado decimal (3.4)"},{"text":"17 % 5","misconception":"confunde a parte inteira (quociente) com o resto da divisão"},{"text":"17 // 5","misconception":"usa o operador de divisão inteira de outras linguagens; em JavaScript o // começa um comentário"},{"text":"Math.floor(17 / 5)"}],"correct":3,"explanation":"17 / 5 vale 3.4 e Math.floor arredonda para baixo, resultando em 3."}$c$::jsonb, $c$Faça a divisão decimal e depois arredonde para baixo.$c$, 6, false, $c$arquivo$c$),
  ($c$arit-corrija-o-quadrado$c$, $c$operadores-aritmeticos$c$, $c$fix$c$, $c$Corrija o quadrado$c$, $c$medio$c$, $c$A função `quadrado(n)` deveria devolver n elevado a 2, mas devolve valores errados (por exemplo, 1 para n = 3). Corrija o defeito.$c$, null, $c$quadrado$c$, $c$function quadrado(n) {
  return n ^ 2;
}
$c$, $c$[{"args":[3],"expected":9},{"args":[5],"expected":25},{"args":[0],"expected":0},{"args":[2],"expected":4}]$c$::jsonb, $c${}$c$::jsonb, $c$O sinal ^ não é o operador de potência em JavaScript.$c$, 7, false, $c$arquivo$c$),
  ($c$arit-divisao-por-zero$c$, $c$operadores-aritmeticos$c$, $c$interpretation$c$, $c$Divisões estranhas$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Infinity\nNaN\n-Infinity\nNaN"},{"text":"Erro\nErro\nErro\nErro","misconception":"acha que toda divisão por zero para o programa com erro"},{"text":"0\n0\n0\n0","misconception":"acha que divisões por zero resultam em zero"},{"text":"Infinity\nInfinity\n-Infinity\n0","misconception":"acha que o resto por zero e 0 / 0 dão resultados numéricos finitos"}],"correct":0,"code":"console.log(10 / 0);\nconsole.log(10 % 0);\nconsole.log(-10 / 0);\nconsole.log(0 / 0);","explanation":"10 / 0 vale Infinity e -10 / 0 vale -Infinity. Já 10 % 0 e 0 / 0 não têm resultado numérico: NaN. Nenhuma delas causa erro."}$c$::jsonb, $c$Divisão por zero dá um infinito; o resto por zero e 0 / 0 não têm resultado válido.$c$, 8, false, $c$arquivo$c$),
  ($c$atrib-o-que-faz-o-mais-igual$c$, $c$operadores-de-atribuicao$c$, $c$choice$c$, $c$O que faz x += 5?$c$, $c$facil$c$, $c$O que a instrução x += 5 faz?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Guarda o valor 5 em x, substituindo o que havia","misconception":"confunde += com a atribuição simples ="},{"text":"Compara x com 5","misconception":"confunde atribuição com comparação"},{"text":"Soma 5 ao valor atual de x e guarda o resultado em x"},{"text":"Mostra x + 5 sem alterar a variável","misconception":"acha que += só calcula e não guarda o resultado"}],"correct":2,"explanation":"O operador += usa o valor atual de x, soma 5 e guarda o resultado de volta em x."}$c$::jsonb, $c$x += 5 é uma forma curta de escrever x = x + 5.$c$, 1, false, $c$arquivo$c$),
  ($c$atrib-somar-cinco$c$, $c$operadores-de-atribuicao$c$, $c$interpretation$c$, $c$Quanto vale n?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"5","misconception":"acha que += substitui o valor em vez de somar"},{"text":"15"},{"text":"10","misconception":"acha que += não altera a variável"},{"text":"n + 5","misconception":"acha que o console.log mostra a expressão em vez do valor"}],"correct":1,"code":"let n = 10;\nn += 5;\nconsole.log(n);","explanation":"n += 5 faz n = n + 5, ou seja, 10 + 5 = 15."}$c$::jsonb, $c$n começa em 10 e depois recebe uma soma.$c$, 2, false, $c$arquivo$c$),
  ($c$atrib-complete-o-contador$c$, $c$operadores-de-atribuicao$c$, $c$blank$c$, $c$Some um ao contador$c$, $c$facil$c$, $c$Complete a linha para aumentar o contador em 1.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"let contador = 0;\ncontador{{1}};\nconsole.log(contador);","blanks":[{"answers":["++","+= 1"]}],"explanation":"contador++ aumenta o valor em 1. A forma contador += 1 faria o mesmo."}$c$::jsonb, $c$Há uma forma bem curta de somar 1.$c$, 3, false, $c$arquivo$c$),
  ($c$atrib-varias-atualizacoes$c$, $c$operadores-de-atribuicao$c$, $c$interpretation$c$, $c$Atualizações em sequência$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"5","misconception":"acha que só a primeira atualização altera a variável"},{"text":"10","misconception":"esquece da última atualização (a divisão)"},{"text":"4.4","misconception":"troca o -= por += na primeira atualização"},{"text":"2"}],"correct":3,"code":"let x = 8;\nx -= 3;\nx *= 2;\nx /= 5;\nconsole.log(x);","explanation":"x começa em 8; depois 8 - 3 = 5; depois 5 * 2 = 10; depois 10 / 5 = 2."}$c$::jsonb, $c$Cada linha usa o valor que x tem naquele momento.$c$, 4, false, $c$arquivo$c$),
  ($c$atrib-forma-equivalente$c$, $c$operadores-de-atribuicao$c$, $c$choice$c$, $c$Forma equivalente$c$, $c$medio$c$, $c$Qual linha tem o mesmo efeito de total = total * 3?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"total *= 3"},{"text":"total =* 3","misconception":"escreve o operador composto com os símbolos invertidos"},{"text":"total * 3","misconception":"esquece de guardar o resultado na variável"},{"text":"total == 3","misconception":"confunde atribuição com comparação"}],"correct":0,"explanation":"total *= 3 multiplica o valor atual de total por 3 e guarda o resultado em total."}$c$::jsonb, $c$O operador composto começa com o símbolo da conta e termina com o =.$c$, 5, false, $c$arquivo$c$),
  ($c$atrib-corrija-o-total$c$, $c$operadores-de-atribuicao$c$, $c$fix$c$, $c$Corrija a soma ao total$c$, $c$medio$c$, $c$A função `somarAoTotal(n)` deveria somar n ao total inicial 10, mas devolve apenas n. Corrija o defeito.$c$, null, $c$somarAoTotal$c$, $c$function somarAoTotal(n) {
  let total = 10;
  total =+ n;
  return total;
}
$c$, $c$[{"args":[5],"expected":15},{"args":[0],"expected":10},{"args":[20],"expected":30}]$c$::jsonb, $c${}$c$::jsonb, $c$Compare a ordem dos dois símbolos: eles não são o mesmo operador.$c$, 6, false, $c$arquivo$c$),
  ($c$atrib-aplicar-desconto$c$, $c$operadores-de-atribuicao$c$, $c$code$c$, $c$Aplicar desconto$c$, $c$medio$c$, $c$Escreva a função `aplicarDesconto(preco, percentual)` que devolve o preço depois do desconto percentual (por exemplo, 200 com 10% devolve 180). Use -= na solução.$c$, null, $c$aplicarDesconto$c$, $c$function aplicarDesconto(preco, percentual) {
  // seu código aqui
}
$c$, $c$[{"args":[200,10],"expected":180},{"args":[50,20],"expected":40},{"args":[100,0],"expected":100}]$c$::jsonb, $c${}$c$::jsonb, $c$Calcule o valor do desconto e subtraia do preço com -=.$c$, 7, false, $c$arquivo$c$),
  ($c$atrib-texto-e-numero$c$, $c$operadores-de-atribuicao$c$, $c$interpretation$c$, $c$+= com texto e com número$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"15\n15","misconception":"acha que += sempre soma, mesmo com textos"},{"text":"555\n555","misconception":"acha que += sempre junta"},{"text":"555\n15"},{"text":"55\n15","misconception":"aplica o += só uma vez no texto"}],"correct":2,"code":"let texto = \"5\";\ntexto += 5;\ntexto += 5;\nconsole.log(texto);\nlet numero = 5;\nnumero += 5;\nnumero += 5;\nconsole.log(numero);","explanation":"Com o texto \"5\", cada += junta mais um 5: \"555\". Com o número 5, cada += soma: 5 + 5 + 5 = 15."}$c$::jsonb, $c$Com texto, += junta; com número, += soma.$c$, 8, false, $c$arquivo$c$),
  ($c$rel-operador-de-igualdade$c$, $c$operadores-relacionais$c$, $c$choice$c$, $c$Qual operador compara a igualdade?$c$, $c$facil$c$, $c$Qual operador verifica se dois valores são iguais e do mesmo tipo?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"=","misconception":"confunde comparação com atribuição"},{"text":"==="},{"text":"==","misconception":"acha que o == também confere o tipo dos valores"},{"text":"!==","misconception":"confunde igualdade com diferença"}],"correct":1,"explanation":"=== compara valor e tipo. O = guarda um valor, e o == converte os tipos antes de comparar."}$c$::jsonb, $c$Tem três sinais de igual.$c$, 1, false, $c$arquivo$c$),
  ($c$rel-maior-ou-igual$c$, $c$operadores-relacionais$c$, $c$interpretation$c$, $c$7 >= 7$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"false","misconception":"acha que >= exige que o primeiro valor seja estritamente maior"},{"text":"7","misconception":"mostra o valor em vez do resultado da comparação"},{"text":"14","misconception":"acha que o sinal >= faz uma soma"},{"text":"true"}],"correct":3,"code":"console.log(7 >= 7);","explanation":"7 é igual a 7, então 7 >= 7 é true."}$c$::jsonb, $c$>= significa "maior ou igual".$c$, 2, false, $c$arquivo$c$),
  ($c$rel-complete-a-comparacao$c$, $c$operadores-relacionais$c$, $c$blank$c$, $c$Maior de idade$c$, $c$facil$c$, $c$Complete a comparação para mostrar true se a idade for maior ou igual a 18.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const idade = 20;\nconsole.log(idade {{1}} 18);","blanks":[{"answers":[">="]}],"explanation":"idade >= 18 pergunta se a idade é maior ou igual a 18. Com 20, a resposta é true."}$c$::jsonb, $c$O operador começa com o sinal de maior.$c$, 3, false, $c$arquivo$c$),
  ($c$rel-igual-estrito-e-frouxo$c$, $c$operadores-relacionais$c$, $c$interpretation$c$, $c$=== e ==$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"false\ntrue\ntrue"},{"text":"true\ntrue\nfalse","misconception":"acha que === ignora a diferença de tipo"},{"text":"false\nfalse\ntrue","misconception":"acha que == também diferencia os tipos"},{"text":"true\ntrue\ntrue","misconception":"acha que todas as comparações entre 5 e \"5\" são verdadeiras"}],"correct":0,"code":"console.log(5 === \"5\");\nconsole.log(5 == \"5\");\nconsole.log(5 !== \"5\");","explanation":"=== não aceita tipos diferentes (false). == converte o texto em número (true). !== diz que são diferentes (true)."}$c$::jsonb, $c$5 é um número e "5" é um texto.$c$, 4, false, $c$arquivo$c$),
  ($c$rel-qual-linha-compara$c$, $c$operadores-relacionais$c$, $c$choice$c$, $c$Qual linha compara de verdade?$c$, $c$medio$c$, $c$Qual linha compara se idade é igual a 18, sem alterar a variável?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"idade = 18","misconception":"usa = (atribuição) no lugar de uma comparação"},{"text":"idade := 18","misconception":"usa um operador de outra linguagem"},{"text":"idade === 18"},{"text":"18 => idade","misconception":"troca o operador de comparação por outro símbolo"}],"correct":2,"explanation":"idade === 18 compara e resulta em true ou false. idade = 18 guardaria o valor 18 na variável."}$c$::jsonb, $c$Uma comparação não pode guardar nada na variável.$c$, 5, false, $c$arquivo$c$),
  ($c$rel-pode-votar$c$, $c$operadores-relacionais$c$, $c$code$c$, $c$Pode votar?$c$, $c$medio$c$, $c$Escreva a função `podeVotar(idade)` que devolve true se a idade for 16 ou mais, e false caso contrário.$c$, null, $c$podeVotar$c$, $c$function podeVotar(idade) {
  // seu código aqui
}
$c$, $c$[{"args":[15],"expected":false},{"args":[16],"expected":true},{"args":[17],"expected":true},{"args":[70],"expected":true},{"args":[0],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Uma comparação já resulta em true ou false.$c$, 6, false, $c$arquivo$c$),
  ($c$rel-corrija-a-igualdade$c$, $c$operadores-relacionais$c$, $c$fix$c$, $c$Corrija a igualdade$c$, $c$medio$c$, $c$A função `saoIguais(a, b)` deveria dizer se dois valores são iguais e do mesmo tipo, mas diz true para 5 e "5". Corrija o defeito.$c$, null, $c$saoIguais$c$, $c$function saoIguais(a, b) {
  return a == b;
}
$c$, $c$[{"args":[5,5],"expected":true},{"args":[5,"5"],"expected":false},{"args":["a","a"],"expected":true},{"args":[0,false],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Qual operador também confere o tipo dos valores?$c$, 7, false, $c$arquivo$c$),
  ($c$rel-comparando-textos$c$, $c$operadores-relacionais$c$, $c$interpretation$c$, $c$Ordem dos textos$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true\nfalse\nfalse","misconception":"acha que as letras maiúsculas vêm depois das minúsculas"},{"text":"true\nfalse\ntrue"},{"text":"true\ntrue\ntrue","misconception":"ignora a ordem alfabética, comparando outra coisa, como o tamanho"},{"text":"false\ntrue\ntrue","misconception":"inverte a ordem alfabética"}],"correct":1,"code":"console.log(\"a\" < \"b\");\nconsole.log(\"banana\" < \"abacaxi\");\nconsole.log(\"Z\" < \"a\");","explanation":"\"a\" vem antes de \"b\" (true). \"banana\" começa com b, que vem depois de a (false). \"Z\" maiúsculo vem antes de \"a\" minúsculo (true)."}$c$::jsonb, $c$Textos são comparados letra por letra; as maiúsculas vêm antes das minúsculas.$c$, 8, false, $c$arquivo$c$),
  ($c$rel-textos-de-numeros-e-decimais$c$, $c$operadores-relacionais$c$, $c$interpretation$c$, $c$Cuidados na comparação$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"false\nfalse\ntrue","misconception":"acha que comparar textos funciona como comparar números e que 0.1 + 0.2 é exatamente 0.3"},{"text":"false\nfalse\nfalse","misconception":"compara \"10\" e \"9\" como números"},{"text":"true\ntrue\nfalse","misconception":"acha que 10 é menor que 9"},{"text":"false\ntrue\nfalse"}],"correct":3,"code":"console.log(10 < 9);\nconsole.log(\"10\" < \"9\");\nconsole.log(0.1 + 0.2 === 0.3);","explanation":"10 < 9 é false (números). Já \"10\" < \"9\" compara textos: o \"1\" vem antes do \"9\", então é true. E 0.1 + 0.2 vale 0.30000000000000004, diferente de 0.3: false."}$c$::jsonb, $c$Textos são comparados letra por letra; e o computador guarda decimais de forma aproximada.$c$, 9, false, $c$arquivo$c$),
  ($c$log-qual-e-o-e$c$, $c$operadores-logicos$c$, $c$choice$c$, $c$Qual operador é o E?$c$, $c$facil$c$, $c$Qual operador lógico significa E (os dois lados precisam ser verdadeiros)?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"&&"},{"text":"||","misconception":"confunde o operador E com o operador OU"},{"text":"!","misconception":"confunde o operador E com o operador NÃO"},{"text":"&","misconception":"usa um único &, que é outro operador"}],"correct":0,"explanation":"&& é o operador E: só resulta em true se os dois lados forem true."}$c$::jsonb, $c$São dois símbolos iguais, que lembram o "e" comercial.$c$, 1, false, $c$arquivo$c$),
  ($c$log-o-que-e-o-ou$c$, $c$operadores-logicos$c$, $c$choice$c$, $c$O que o || significa?$c$, $c$facil$c$, $c$O que o operador || faz?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Resulta em true só se os dois lados forem true","misconception":"confunde o operador OU com o operador E"},{"text":"Inverte o valor de um boolean","misconception":"confunde o operador OU com o operador NÃO"},{"text":"Resulta em true se pelo menos um dos lados for true"},{"text":"Compara se dois valores são iguais","misconception":"confunde um operador lógico com um relacional"}],"correct":2,"explanation":"O || é o OU: basta que um dos lados seja true para o resultado ser true."}$c$::jsonb, $c$Pense na frase "tenho cartão OU dinheiro".$c$, 2, false, $c$arquivo$c$),
  ($c$log-true-e-false$c$, $c$operadores-logicos$c$, $c$interpretation$c$, $c$true && false$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true","misconception":"acha que o && precisa de apenas um lado verdadeiro, como o ||"},{"text":"false"},{"text":"true && false","misconception":"acha que o console.log mostra a expressão"},{"text":"undefined","misconception":"acha que combinar valores diferentes não tem resultado"}],"correct":1,"code":"console.log(true && false);","explanation":"Como um dos lados é false, o && resulta em false."}$c$::jsonb, $c$O E só dá true quando os dois lados são true.$c$, 3, false, $c$arquivo$c$),
  ($c$log-complete-o-ou$c$, $c$operadores-logicos$c$, $c$blank$c$, $c$Cartão ou dinheiro$c$, $c$facil$c$, $c$Complete a linha para mostrar true se o cliente tiver cartão OU dinheiro.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const temCartao = false;\nconst temDinheiro = true;\nconsole.log(temCartao {{1}} temDinheiro);","blanks":[{"answers":["||"]}],"explanation":"temCartao || temDinheiro resulta em true, porque temDinheiro é true."}$c$::jsonb, $c$Use o operador que aceita que apenas um dos lados seja verdadeiro.$c$, 4, false, $c$arquivo$c$),
  ($c$log-quatro-combinacoes$c$, $c$operadores-logicos$c$, $c$interpretation$c$, $c$Quatro combinações$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true\ntrue\ntrue\ntrue","misconception":"acha que o || sempre resulta em true"},{"text":"true\nfalse\ntrue\nfalse","misconception":"ignora a inversão feita pelo !"},{"text":"false\nfalse\nfalse\ntrue","misconception":"acha que o || precisa dos dois lados verdadeiros"},{"text":"true\nfalse\nfalse\ntrue"}],"correct":3,"code":"console.log(true || false);\nconsole.log(false || false);\nconsole.log(!true);\nconsole.log(!false && true);","explanation":"true || false é true; false || false é false; !true é false; e !false vale true, então true && true é true."}$c$::jsonb, $c$Use a tabela-verdade e lembre que ! inverte o valor.$c$, 5, false, $c$arquivo$c$),
  ($c$log-pode-entrar$c$, $c$operadores-logicos$c$, $c$code$c$, $c$Pode entrar?$c$, $c$medio$c$, $c$Escreva a função `podeEntrar(idade, temIngresso)` que devolve true apenas se a pessoa tiver 18 anos ou mais E tiver ingresso.$c$, null, $c$podeEntrar$c$, $c$function podeEntrar(idade, temIngresso) {
  // seu código aqui
}
$c$, $c$[{"args":[20,true],"expected":true},{"args":[17,true],"expected":false},{"args":[30,false],"expected":false},{"args":[18,true],"expected":true},{"args":[5,false],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Combine uma comparação com o valor temIngresso usando o operador E.$c$, 6, false, $c$arquivo$c$),
  ($c$log-comparacoes-combinadas$c$, $c$operadores-logicos$c$, $c$interpretation$c$, $c$Autorização$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"false\ntrue\ntrue"},{"text":"true\ntrue\nfalse","misconception":"avalia idade >= 18 como se fosse verdadeiro"},{"text":"false\nfalse\ntrue","misconception":"acha que o || exige que os dois lados sejam true"},{"text":"false\ntrue\nfalse","misconception":"esquece de inverter o resultado com o !"}],"correct":0,"code":"const idade = 16;\nconst temAutorizacao = true;\nconsole.log(idade >= 18 && temAutorizacao);\nconsole.log(idade >= 18 || temAutorizacao);\nconsole.log(!(idade >= 18));","explanation":"idade >= 18 é false. false && true é false; false || true é true; e !(false) é true."}$c$::jsonb, $c$idade >= 18 é false para 16. Aplique cada operador a partir desse resultado.$c$, 7, false, $c$arquivo$c$),
  ($c$log-entre-dois-valores$c$, $c$operadores-logicos$c$, $c$choice$c$, $c$Entre 1 e 10$c$, $c$medio$c$, $c$Qual expressão é true quando x está entre 1 e 10 (inclusive)?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"x >= 1 || x <= 10","misconception":"usa OU, que fica verdadeiro para qualquer número"},{"text":"1 <= x <= 10","misconception":"escreve como na matemática, mas o JavaScript avalia de outra forma"},{"text":"x >= 1 && x <= 10"},{"text":"x === 1 && x === 10","misconception":"exige que x seja igual aos dois valores ao mesmo tempo"}],"correct":2,"explanation":"As duas comparações precisam ser verdadeiras: x >= 1 e x <= 10. Por isso usamos o &&."}$c$::jsonb, $c$x precisa passar nas duas condições ao mesmo tempo.$c$, 8, false, $c$arquivo$c$),
  ($c$log-corrija-o-intervalo$c$, $c$operadores-logicos$c$, $c$fix$c$, $c$Corrija o intervalo$c$, $c$dificil$c$, $c$A função `foraDoIntervalo(n)` deveria devolver true quando n é menor que 0 ou maior que 100, mas devolve sempre false. Corrija o defeito.$c$, null, $c$foraDoIntervalo$c$, $c$function foraDoIntervalo(n) {
  return n < 0 && n > 100;
}
$c$, $c$[{"args":[-5],"expected":true},{"args":[150],"expected":true},{"args":[50],"expected":false},{"args":[0],"expected":false},{"args":[100],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Nenhum número é menor que 0 e maior que 100 ao mesmo tempo.$c$, 9, false, $c$arquivo$c$),
  ($c$log-precedencia-dos-logicos$c$, $c$operadores-logicos$c$, $c$interpretation$c$, $c$Quem vem primeiro?$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"false\nfalse\nfalse\nfalse","misconception":"resolve o || antes do && na primeira linha, ignorando a precedência"},{"text":"true\nfalse\nfalse\nfalse"},{"text":"true\ntrue\nfalse\nfalse","misconception":"ignora o efeito dos parênteses na segunda linha"},{"text":"true\nfalse\ntrue\ntrue","misconception":"ignora o efeito do ! nas duas últimas linhas"}],"correct":1,"code":"const a = true;\nconst b = false;\nconst c = false;\nconsole.log(a || b && c);\nconsole.log((a || b) && c);\nconsole.log(!a || b);\nconsole.log(!(a || b));","explanation":"Linha 1: b && c é false, então a || false é true. Linha 2: (a || b) é true, e true && c é false. Linha 3: !a é false, e false || b é false. Linha 4: (a || b) é true e o ! inverte para false."}$c$::jsonb, $c$O && é resolvido antes do ||, e os parênteses mudam essa ordem.$c$, 10, false, $c$arquivo$c$),
  ($c$prec-o-que-vem-primeiro$c$, $c$precedencia-dos-operadores$c$, $c$choice$c$, $c$O que vem primeiro?$c$, $c$facil$c$, $c$Em 2 + 3 * 4, qual operação é feita primeiro?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"2 + 3","misconception":"faz as operações da esquerda para a direita, ignorando a precedência"},{"text":"Todas ao mesmo tempo","misconception":"acha que o computador resolve tudo simultaneamente"},{"text":"A última da direita, sempre","misconception":"acha que a operação mais à direita é sempre a primeira"},{"text":"3 * 4"}],"correct":3,"explanation":"A multiplicação tem precedência sobre a soma, então 3 * 4 é feito primeiro."}$c$::jsonb, $c$Como na matemática, uma das operações tem prioridade.$c$, 1, false, $c$arquivo$c$),
  ($c$prec-dois-mais-tres-vezes-quatro$c$, $c$precedencia-dos-operadores$c$, $c$interpretation$c$, $c$Quanto vale 2 + 3 * 4?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"14"},{"text":"20","misconception":"faz as operações da esquerda para a direita, ignorando a precedência"},{"text":"9","misconception":"soma todos os números"},{"text":"234","misconception":"junta os números como se fossem textos"}],"correct":0,"code":"console.log(2 + 3 * 4);","explanation":"3 * 4 = 12 e depois 2 + 12 = 14."}$c$::jsonb, $c$Primeiro a multiplicação, depois a soma.$c$, 2, false, $c$arquivo$c$),
  ($c$prec-complete-os-parenteses$c$, $c$precedencia-dos-operadores$c$, $c$blank$c$, $c$Mude a ordem$c$, $c$facil$c$, $c$Complete com parênteses para que o programa mostre 20 (a soma deve ser feita antes da multiplicação).$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"console.log({{1}}2 + 3{{2}} * 4);","blanks":[{"answers":["("]},{"answers":[")"]}],"explanation":"(2 + 3) * 4 faz primeiro a soma (5) e depois a multiplicação: 20."}$c$::jsonb, $c$Os parênteses forçam uma conta a ser feita antes das outras.$c$, 3, false, $c$arquivo$c$),
  ($c$prec-esquerda-direita$c$, $c$precedencia-dos-operadores$c$, $c$interpretation$c$, $c$Esquerda para a direita$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"9\n20\n512","misconception":"resolve subtração e divisão da direita para a esquerda"},{"text":"3\n5\n64","misconception":"acha que a potência também vai da esquerda para a direita"},{"text":"3\n5\n512"},{"text":"3\n20\n64","misconception":"mistura a ordem das operações em cada linha"}],"correct":2,"code":"console.log(10 - 4 - 3);\nconsole.log(100 / 10 / 2);\nconsole.log(2 ** 3 ** 2);","explanation":"10 - 4 - 3 = 6 - 3 = 3; 100 / 10 / 2 = 10 / 2 = 5; e 2 ** 3 ** 2 = 2 ** 9 = 512 (a potência vai da direita para a esquerda)."}$c$::jsonb, $c$A maioria dos operadores vai da esquerda para a direita; a potência é a exceção.$c$, 4, false, $c$arquivo$c$),
  ($c$prec-contas-e-comparacoes$c$, $c$precedencia-dos-operadores$c$, $c$interpretation$c$, $c$Contas antes das comparações$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true\ntrue\ntrue","misconception":"faz as contas da esquerda para a direita, antes de multiplicar"},{"text":"true\ntrue\nfalse"},{"text":"true\nfalse\nfalse","misconception":"acha que 2 * 3 não é igual a 6"},{"text":"false\ntrue\nfalse","misconception":"avalia 5 + 3 > 7 como falso"}],"correct":1,"code":"console.log(5 + 3 > 7);\nconsole.log(2 * 3 === 6);\nconsole.log(10 - 2 * 3 > 5);","explanation":"5 + 3 > 7 vira 8 > 7 (true). 2 * 3 === 6 vira 6 === 6 (true). 10 - 2 * 3 > 5 vira 10 - 6 > 5, isto é 4 > 5 (false)."}$c$::jsonb, $c$As contas são resolvidas antes das comparações, e a multiplicação antes da subtração.$c$, 8, false, $c$arquivo$c$),
  ($c$prec-qual-expressao-da-24$c$, $c$precedencia-dos-operadores$c$, $c$choice$c$, $c$Qual expressão dá 24?$c$, $c$medio$c$, $c$Qual destas expressões tem como resultado 24?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"2 + 4 * 4","misconception":"ignora a precedência: a multiplicação vem antes da soma (resultado 18)"},{"text":"2 * 4 + 4","misconception":"multiplica primeiro e soma depois (resultado 12)"},{"text":"2 + 4 + 4","misconception":"soma tudo, em vez de multiplicar (resultado 10)"},{"text":"(2 + 4) * 4"}],"correct":3,"explanation":"(2 + 4) * 4 = 6 * 4 = 24. Sem parênteses, 2 + 4 * 4 daria 18."}$c$::jsonb, $c$Para a soma vir antes da multiplicação, é preciso parênteses.$c$, 5, false, $c$arquivo$c$),
  ($c$prec-celsius-para-fahrenheit$c$, $c$precedencia-dos-operadores$c$, $c$code$c$, $c$Celsius para Fahrenheit$c$, $c$medio$c$, $c$Escreva a função `fahrenheit(c)` que converte graus Celsius em Fahrenheit: multiplique por 9, divida por 5 e some 32.$c$, null, $c$fahrenheit$c$, $c$function fahrenheit(c) {
  // seu código aqui
}
$c$, $c$[{"args":[0],"expected":32},{"args":[100],"expected":212},{"args":[10],"expected":50},{"args":[-40],"expected":-40}]$c$::jsonb, $c${}$c$::jsonb, $c$A multiplicação e a divisão vêm antes da soma, e parênteses só são necessários se você quiser mudar essa ordem.$c$, 6, false, $c$arquivo$c$),
  ($c$prec-corrija-a-media$c$, $c$precedencia-dos-operadores$c$, $c$fix$c$, $c$Corrija a média$c$, $c$medio$c$, $c$A função `media(a, b)` deveria devolver a média aritmética de dois números, mas devolve valores errados (por exemplo, 7 para 4 e 6). Corrija o defeito.$c$, null, $c$media$c$, $c$function media(a, b) {
  return a + b / 2;
}
$c$, $c$[{"args":[4,6],"expected":5},{"args":[10,10],"expected":10},{"args":[0,8],"expected":4}]$c$::jsonb, $c${}$c$::jsonb, $c$A divisão é feita antes da soma. O que precisa ser dividido por 2?$c$, 7, false, $c$arquivo$c$),
  ($c$prec-logicos-e-parenteses$c$, $c$precedencia-dos-operadores$c$, $c$interpretation$c$, $c$Parênteses e lógica$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true\nfalse\ntrue"},{"text":"false\nfalse\ntrue","misconception":"resolve o || antes do && na primeira linha"},{"text":"true\ntrue\ntrue","misconception":"ignora o efeito dos parênteses na segunda linha"},{"text":"true\nfalse\nfalse","misconception":"aplica o ! a toda a expressão da terceira linha, e não só ao que está entre parênteses"}],"correct":0,"code":"const a = 2;\nconst b = 10;\nconsole.log(a > 3 && b < 5 || a === 2);\nconsole.log(a > 3 && (b < 5 || a === 2));\nconsole.log(!(a > 3) || b === 10 && a < 1);","explanation":"Linha 1: (false && false) || true é true. Linha 2: false && (...) é false. Linha 3: !(false) é true, e true || (...) é true."}$c$::jsonb, $c$O && vem antes do ||, e os parênteses mudam o agrupamento.$c$, 9, false, $c$arquivo$c$),
  ($c$desafio3-calculadora$c$, $c$desafio-do-mundo-3$c$, $c$challenge$c$, $c$Desafio: calculadora simples$c$, $c$dificil$c$, $c$Escreva a função `calculadora()`: leia dois números com `lerEntrada()` (chegam como texto) e mostre seis linhas com `console.log`: Soma, Subtração, Multiplicação, Divisão, Resto e Divisão por zero? (true ou false, comparando o segundo número com 0). Use o formato `Rótulo: valor`.$c$, null, $c$calculadora$c$, $c$function calculadora() {
  // leia os dois números e mostre as seis linhas
}
$c$, $c$[{"args":[],"inputs":["12","4"],"output":["Soma: 16","Subtração: 8","Multiplicação: 48","Divisão: 3","Resto: 0","Divisão por zero? false"]},{"args":[],"inputs":["7","2"],"output":["Soma: 9","Subtração: 5","Multiplicação: 14","Divisão: 3.5","Resto: 1","Divisão por zero? false"]},{"args":[],"inputs":["10","0"],"output":["Soma: 10","Subtração: 10","Multiplicação: 0","Divisão: Infinity","Resto: NaN","Divisão por zero? true"]}]$c$::jsonb, $c${}$c$::jsonb, $c$Converta as duas entradas com Number() e use o segundo número em uma comparação com ===.$c$, 1, false, $c$arquivo$c$),
  ($c$desafio3-corrija-a-aprovacao$c$, $c$desafio-do-mundo-3$c$, $c$fix$c$, $c$Desafio: corrija a aprovação$c$, $c$dificil$c$, $c$A função `aprovado(n1, n2, frequencia)` deveria devolver true se a média das duas notas for 7 ou mais E a frequência for 75 ou mais. Hoje ela aprova alunos que não deveriam ser aprovados. Corrija o defeito.$c$, null, $c$aprovado$c$, $c$function aprovado(n1, n2, frequencia) {
  const media = n1 + n2 / 2;
  return media >= 7 && frequencia >= 75;
}
$c$, $c$[{"args":[6,8,80],"expected":true},{"args":[6,8,70],"expected":false},{"args":[5,5,90],"expected":false},{"args":[10,4,75],"expected":true},{"args":[8,8,60],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Olhe com atenção para o cálculo da média: o que a divisão afeta?$c$, 2, false, $c$arquivo$c$),
  ($c$desafio3-acompanhe-o-saldo$c$, $c$desafio-do-mundo-3$c$, $c$interpretation$c$, $c$Desafio: acompanhe o saldo$c$, $c$dificil$c$, $c$Acompanhe o valor de cada variável a cada linha. O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"60\ntrue\ntrue","misconception":"acha que podeComprarOutro acompanha o saldo e é recalculado"},{"text":"40\nfalse\ntrue","misconception":"esquece a atualização feita com += depois da comparação"},{"text":"60\nfalse\ntrue"},{"text":"60\nfalse\nfalse","misconception":"acha que >= exige que o primeiro valor seja estritamente maior"}],"correct":2,"code":"let saldo = 100;\nconst preco = 60;\nsaldo -= preco;\nconst podeComprarOutro = saldo >= preco;\nsaldo += 10 * 2;\nconsole.log(saldo);\nconsole.log(podeComprarOutro);\nconsole.log(saldo >= preco && saldo % 2 === 0 || saldo === 0);","explanation":"saldo vira 40 e podeComprarOutro é 40 >= 60, isto é, false (guardado nesse momento). Depois saldo += 20 deixa o saldo em 60. Na última linha: 60 >= 60 é true e 60 % 2 === 0 também, então o resultado é true."}$c$::jsonb, $c$podeComprarOutro guarda o resultado da comparação feita naquele momento, e não é atualizado depois.$c$, 3, false, $c$arquivo$c$),
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
  ($c$cond-intro-para-que-serve$c$, $c$introducao-as-condicionais$c$, $c$choice$c$, $c$Para que serve uma condicional?$c$, $c$facil$c$, $c$Para que serve uma estrutura condicional?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Para repetir um trecho do programa várias vezes","misconception":"confunde decisão com repetição"},{"text":"Para executar um trecho só quando uma condição for verdadeira"},{"text":"Para guardar valores em variáveis","misconception":"confunde decisão com declaração de variáveis"},{"text":"Para mostrar um texto na tela","misconception":"confunde decisão com saída de dados"}],"correct":1,"explanation":"A estrutura condicional faz o programa decidir: um trecho só é executado quando a condição é verdadeira."}$c$::jsonb, $c$Pense em "se... então...".$c$, 1, false, $c$arquivo$c$),
  ($c$cond-intro-o-que-a-condicao-resulta$c$, $c$introducao-as-condicionais$c$, $c$choice$c$, $c$O resultado da condição$c$, $c$facil$c$, $c$A condição de uma estrutura condicional precisa resultar em quê?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Em um texto","misconception":"acha que a condição precisa ser um texto"},{"text":"Em um número inteiro positivo","misconception":"acha que a condição precisa ser um número"},{"text":"Em uma atribuição, como x = 5","misconception":"confunde condição com atribuição"},{"text":"Em true ou false"}],"correct":3,"explanation":"A condição é avaliada como verdadeira ou falsa (true ou false), como o resultado de uma comparação."}$c$::jsonb, $c$Lembre-se das comparações do Mundo 3.$c$, 2, false, $c$arquivo$c$),
  ($c$cond-intro-condicao-verdadeira$c$, $c$introducao-as-condicionais$c$, $c$interpretation$c$, $c$Pode entrar?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Pode entrar\nFim"},{"text":"Fim","misconception":"acha que a mensagem do if não aparece"},{"text":"Pode entrar","misconception":"acha que o programa termina dentro do if"},{"text":"Fim\nPode entrar","misconception":"executa o bloco do if depois das linhas seguintes"}],"correct":0,"code":"const idade = 20;\nif (idade >= 18) {\n  console.log(\"Pode entrar\");\n}\nconsole.log(\"Fim\");","explanation":"20 >= 18 é true, então o bloco do if executa. Depois, o programa continua e mostra Fim."}$c$::jsonb, $c$Com 20, a condição é verdadeira.$c$, 3, false, $c$arquivo$c$),
  ($c$cond-intro-complete-o-if$c$, $c$introducao-as-condicionais$c$, $c$blank$c$, $c$Complete o if$c$, $c$facil$c$, $c$Complete a palavra que inicia a estrutura condicional.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const temperatura = 35;\n{{1}} (temperatura > 30) {\n  console.log(\"Está quente\");\n}","blanks":[{"answers":["if"]}],"explanation":"if é a palavra que inicia a estrutura condicional: se a condição for verdadeira, o bloco executa."}$c$::jsonb, $c$A palavra vem do inglês e significa "se".$c$, 4, false, $c$arquivo$c$),
  ($c$cond-intro-condicao-falsa$c$, $c$introducao-as-condicionais$c$, $c$interpretation$c$, $c$Menor de idade$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Pode entrar\nFim","misconception":"executa o bloco sem avaliar a condição"},{"text":"Nada","misconception":"acha que o programa não mostra nada quando a condição é falsa"},{"text":"Fim"},{"text":"Pode entrar","misconception":"acha que o bloco executa mesmo com a condição falsa e o programa termina"}],"correct":2,"code":"const idade = 15;\nif (idade >= 18) {\n  console.log(\"Pode entrar\");\n}\nconsole.log(\"Fim\");","explanation":"15 >= 18 é false, então o bloco é ignorado. O programa continua depois do if e mostra apenas Fim."}$c$::jsonb, $c$Com 15, a condição é falsa. O que acontece com o bloco?$c$, 5, false, $c$arquivo$c$),
  ($c$cond-intro-condicao-invalida$c$, $c$introducao-as-condicionais$c$, $c$choice$c$, $c$Condição ou atribuição?$c$, $c$medio$c$, $c$Qual das alternativas NÃO é uma condição (isto é, não compara valores)?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"idade >= 18","misconception":"acha que uma comparação não pode ser usada como condição"},{"text":"idade = 18"},{"text":"idade === 18","misconception":"acha que uma comparação de igualdade não pode ser usada como condição"},{"text":"idade !== 18","misconception":"acha que uma comparação de diferença não pode ser usada como condição"}],"correct":1,"explanation":"idade = 18 é uma atribuição: guarda 18 em idade. As outras comparam e resultam em true ou false."}$c$::jsonb, $c$Uma delas guarda um valor em vez de comparar.$c$, 6, false, $c$arquivo$c$),
  ($c$cond-intro-ordene-o-if$c$, $c$introducao-as-condicionais$c$, $c$order$c$, $c$Ordene o programa$c$, $c$medio$c$, $c$Coloque as linhas na ordem certa para o programa mostrar Leve o guarda-chuva quando estiver chovendo.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"items":["const chovendo = true;","if (chovendo) {","console.log(\"Leve o guarda-chuva\");","}"],"explanation":"Primeiro a variável, depois o if com a condição, o comando dentro do bloco e, por fim, a chave que fecha o bloco."}$c$::jsonb, $c$A variável precisa existir antes de ser testada, e o bloco fica entre a abertura e o fechamento das chaves.$c$, 7, false, $c$arquivo$c$),
  ($c$cond-intro-dois-ifs-seguidos$c$, $c$introducao-as-condicionais$c$, $c$interpretation$c$, $c$Dois ifs seguidos$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Aprovado\nEstude mais\nFim","misconception":"acha que todos os if executam, sem avaliar as condições"},{"text":"Aprovado\nFim","misconception":"avalia a primeira condição como verdadeira"},{"text":"Fim","misconception":"acha que nenhum dos ifs executa"},{"text":"Estude mais\nFim"}],"correct":3,"code":"const nota = 6;\nif (nota >= 7) {\n  console.log(\"Aprovado\");\n}\nif (nota < 7) {\n  console.log(\"Estude mais\");\n}\nconsole.log(\"Fim\");","explanation":"6 >= 7 é false, então o primeiro bloco é ignorado. 6 < 7 é true, então o segundo bloco executa. Depois, Fim."}$c$::jsonb, $c$Cada if tem a sua própria condição, testada separadamente.$c$, 8, false, $c$arquivo$c$),
  ($c$revrel-pelo-menos$c$, $c$revisao-dos-relacionais$c$, $c$choice$c$, $c$Pelo menos 18$c$, $c$facil$c$, $c$Como se escreve a condição "a idade é pelo menos 18"?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"idade >= 18"},{"text":"idade > 18","misconception":"esquece que \"pelo menos\" inclui o próprio 18"},{"text":"idade <= 18","misconception":"inverte o sentido da comparação"},{"text":"idade = 18","misconception":"usa uma atribuição no lugar de uma comparação"}],"correct":0,"explanation":"\"Pelo menos 18\" é 18 ou mais: idade >= 18."}$c$::jsonb, $c$"Pelo menos" quer dizer "18 ou mais".$c$, 1, false, $c$arquivo$c$),
  ($c$revrel-diferente$c$, $c$revisao-dos-relacionais$c$, $c$choice$c$, $c$Diferente de 10$c$, $c$facil$c$, $c$Como se escreve a condição "a nota é diferente de 10"?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"nota === 10","misconception":"escreve a condição contrária"},{"text":"nota =! 10","misconception":"inverte os símbolos do operador de diferença"},{"text":"nota !== 10"},{"text":"nota <> 10","misconception":"usa o operador de outras linguagens"}],"correct":2,"explanation":"!== compara se dois valores são diferentes (em valor ou em tipo)."}$c$::jsonb, $c$O operador de diferença começa com o ponto de exclamação.$c$, 2, false, $c$arquivo$c$),
  ($c$revrel-maiusculas-contam$c$, $c$revisao-dos-relacionais$c$, $c$interpretation$c$, $c$Ana ou ana?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true","misconception":"acha que maiúsculas e minúsculas não fazem diferença"},{"text":"false"},{"text":"Erro","misconception":"acha que comparar textos com === causa um erro"},{"text":"undefined","misconception":"acha que a comparação de textos não produz resultado"}],"correct":1,"code":"const nome = \"Ana\";\nconsole.log(nome === \"ana\");","explanation":"\"A\" e \"a\" são caracteres diferentes, então os textos não são iguais: false."}$c$::jsonb, $c$Compare os dois textos letra por letra.$c$, 3, false, $c$arquivo$c$),
  ($c$revrel-nota-passou$c$, $c$revisao-dos-relacionais$c$, $c$code$c$, $c$A nota passou?$c$, $c$medio$c$, $c$Escreva a função `passou(nota)` que devolve true se a nota for 7 ou mais, e false caso contrário.$c$, null, $c$passou$c$, $c$function passou(nota) {
  // seu código aqui
}
$c$, $c$[{"args":[7],"expected":true},{"args":[6.9],"expected":false},{"args":[10],"expected":true},{"args":[0],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Uma comparação já resulta em true ou false.$c$, 4, false, $c$arquivo$c$),
  ($c$revrel-corrija-o-igual$c$, $c$revisao-dos-relacionais$c$, $c$fix$c$, $c$Corrija a comparação$c$, $c$medio$c$, $c$A função `ehDez(n)` deveria devolver true apenas quando n for 10, mas devolve outros valores. Corrija o defeito.$c$, null, $c$ehDez$c$, $c$function ehDez(n) {
  return n = 10;
}
$c$, $c$[{"args":[10],"expected":true},{"args":[5],"expected":false},{"args":[0],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Um dos sinais está guardando um valor em vez de comparar.$c$, 5, false, $c$arquivo$c$),
  ($c$revrel-texto-ou-numero$c$, $c$revisao-dos-relacionais$c$, $c$interpretation$c$, $c$10 e "10"$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true\ntrue\ntrue","misconception":"acha que o === ignora a diferença de tipo"},{"text":"false\nfalse\ntrue","misconception":"acha que o == também diferencia os tipos"},{"text":"false\ntrue\nfalse","misconception":"acha que Number() não converte o texto em número"},{"text":"false\ntrue\ntrue"}],"correct":3,"code":"const a = \"10\";\nconst b = 10;\nconsole.log(a === b);\nconsole.log(a == b);\nconsole.log(Number(a) === b);","explanation":"=== não aceita tipos diferentes (false). == converte e diz true. Convertendo a com Number(), os dois são números iguais: true."}$c$::jsonb, $c$a é um texto e b é um número.$c$, 6, false, $c$arquivo$c$),
  ($c$revrel-casos-estranhos$c$, $c$revisao-dos-relacionais$c$, $c$interpretation$c$, $c$Cuidados na comparação$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"false\nfalse\ntrue"},{"text":"true\ntrue\nfalse","misconception":"acha que 0.1 + 0.2 é exatamente 0.3 e que as minúsculas vêm antes das maiúsculas"},{"text":"false\ntrue\ntrue","misconception":"acha que as letras minúsculas vêm antes das maiúsculas"},{"text":"false\nfalse\nfalse","misconception":"compara \"10\" e \"9\" como números"}],"correct":0,"code":"console.log(0.1 + 0.2 === 0.3);\nconsole.log(\"apple\" < \"Banana\");\nconsole.log(\"10\" < \"9\");","explanation":"0.1 + 0.2 vale 0.30000000000000004 (false). \"apple\" começa com a minúsculo, que vem depois do B maiúsculo (false). \"10\" < \"9\" compara textos: \"1\" vem antes de \"9\" (true)."}$c$::jsonb, $c$Decimais são aproximados; textos são comparados letra por letra, com as maiúsculas antes das minúsculas.$c$, 7, false, $c$arquivo$c$),
  ($c$revlog-entre-dois-valores$c$, $c$revisao-dos-logicos$c$, $c$choice$c$, $c$Entre 18 e 65$c$, $c$facil$c$, $c$Como se escreve "a idade está entre 18 e 65 (inclusive)"?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"idade >= 18 || idade <= 65","misconception":"usa OU, que fica verdadeiro para quase qualquer número"},{"text":"18 <= idade <= 65","misconception":"escreve como na matemática, mas o JavaScript avalia de outra forma"},{"text":"idade >= 18 && idade <= 65"},{"text":"idade >= 18 && <= 65","misconception":"esquece de repetir a variável na segunda comparação"}],"correct":2,"explanation":"O && exige as duas comparações verdadeiras: idade >= 18 e idade <= 65."}$c$::jsonb, $c$As duas condições precisam valer ao mesmo tempo, cada uma com a variável.$c$, 1, false, $c$arquivo$c$),
  ($c$revlog-crianca-ou-idoso$c$, $c$revisao-dos-logicos$c$, $c$choice$c$, $c$Criança ou idoso$c$, $c$facil$c$, $c$Como se escreve "a idade é menor que 12 OU maior ou igual a 60"?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"idade < 12 && idade >= 60","misconception":"usa E, que nenhum número satisfaz"},{"text":"idade < 12 || idade >= 60"},{"text":"idade < 12 || 60","misconception":"esquece de comparar a variável com o 60"},{"text":"!(idade < 12) || idade >= 60","misconception":"inverte a primeira condição sem querer"}],"correct":1,"explanation":"O || aceita que qualquer um dos lados seja verdadeiro: idade < 12 || idade >= 60."}$c$::jsonb, $c$Basta uma das duas condições ser verdadeira.$c$, 2, false, $c$arquivo$c$),
  ($c$revlog-tabela-verdade$c$, $c$revisao-dos-logicos$c$, $c$interpretation$c$, $c$Combinações básicas$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"true\ntrue\ntrue\ntrue","misconception":"acha que o && só precisa de um lado verdadeiro"},{"text":"true\nfalse\nfalse\nfalse","misconception":"acha que o || precisa dos dois lados verdadeiros"},{"text":"true\nfalse\ntrue\ntrue","misconception":"esquece que o ! inverte o valor"},{"text":"true\nfalse\ntrue\nfalse"}],"correct":3,"code":"console.log(true && true);\nconsole.log(true && false);\nconsole.log(false || true);\nconsole.log(!true);","explanation":"true && true é true; true && false é false; false || true é true; e !true é false."}$c$::jsonb, $c$Use a tabela-verdade do Mundo 3.$c$, 3, false, $c$arquivo$c$),
  ($c$revlog-tem-desconto$c$, $c$revisao-dos-logicos$c$, $c$code$c$, $c$Tem desconto?$c$, $c$medio$c$, $c$Escreva a função `temDesconto(idade)` que devolve true para crianças (menores de 12 anos) e para idosos (60 anos ou mais), e false para os demais.$c$, null, $c$temDesconto$c$, $c$function temDesconto(idade) {
  // seu código aqui
}
$c$, $c$[{"args":[10],"expected":true},{"args":[12],"expected":false},{"args":[59],"expected":false},{"args":[60],"expected":true},{"args":[70],"expected":true}]$c$::jsonb, $c${}$c$::jsonb, $c$As duas regras valem de forma independente: basta uma delas.$c$, 4, false, $c$arquivo$c$),
  ($c$revlog-corrija-o-fim-de-semana$c$, $c$revisao-dos-logicos$c$, $c$fix$c$, $c$Corrija o fim de semana$c$, $c$medio$c$, $c$A função `ehFimDeSemana(dia)` deveria devolver true para "sábado" e "domingo", mas devolve sempre false. Corrija o defeito.$c$, null, $c$ehFimDeSemana$c$, $c$function ehFimDeSemana(dia) {
  return dia === "sábado" && dia === "domingo";
}
$c$, $c$[{"args":["sábado"],"expected":true},{"args":["domingo"],"expected":true},{"args":["segunda"],"expected":false},{"args":["sexta"],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Um dia não pode ser sábado e domingo ao mesmo tempo.$c$, 5, false, $c$arquivo$c$),
  ($c$revlog-parenteses-mudam-o-resultado$c$, $c$revisao-dos-logicos$c$, $c$interpretation$c$, $c$Parênteses e lógica$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"false\ntrue\ntrue"},{"text":"true\ntrue\ntrue","misconception":"ignora o efeito dos parênteses na primeira linha"},{"text":"false\nfalse\ntrue","misconception":"resolve o || antes do && na segunda linha"},{"text":"false\ntrue\nfalse","misconception":"esquece que o ! inverte false em true"}],"correct":0,"code":"const temCartao = true;\nconst temDinheiro = false;\nconst estaAberto = false;\nconsole.log((temCartao || temDinheiro) && estaAberto);\nconsole.log(temCartao || temDinheiro && estaAberto);\nconsole.log(!estaAberto);","explanation":"Linha 1: (true || false) é true e true && false é false. Linha 2: false && false é false, e true || false é true. Linha 3: !false é true."}$c$::jsonb, $c$Na segunda linha, o && é resolvido antes do ||.$c$, 6, false, $c$arquivo$c$),
  ($c$revlog-de-morgan$c$, $c$revisao-dos-logicos$c$, $c$choice$c$, $c$Invertendo uma combinação$c$, $c$dificil$c$, $c$Qual expressão é equivalente a !(a && b)?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"!a && !b","misconception":"inverte os operandos, mas mantém o &&"},{"text":"a || b","misconception":"troca o && por || sem inverter os operandos"},{"text":"!a || !b"},{"text":"!a || b","misconception":"inverte só um dos operandos"}],"correct":2,"explanation":"Pela lei de De Morgan, !(a && b) equivale a !a || !b: o resultado é true quando pelo menos uma das partes é false."}$c$::jsonb, $c$Ao inverter uma combinação, o E vira OU e cada parte é invertida.$c$, 7, false, $c$arquivo$c$),
  ($c$if-forma-correta$c$, $c$estrutura-if$c$, $c$choice$c$, $c$Qual if está correto?$c$, $c$facil$c$, $c$Qual das formas abaixo é um if escrito corretamente?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"if nota >= 7 { console.log(\"Aprovado\"); }","misconception":"esquece os parênteses em volta da condição"},{"text":"if (nota >= 7) { console.log(\"Aprovado\"); }"},{"text":"if (nota >= 7) then console.log(\"Aprovado\");","misconception":"usa a sintaxe de outras linguagens, com then"},{"text":"if (nota >= 7); { console.log(\"Aprovado\"); }","misconception":"coloca ponto e vírgula logo depois da condição"}],"correct":1,"explanation":"A forma correta tem a condição entre parênteses e o bloco entre chaves, sem ponto e vírgula depois do parêntese."}$c$::jsonb, $c$Condição entre parênteses; comandos entre chaves.$c$, 1, false, $c$arquivo$c$),
  ($c$if-nota-oito$c$, $c$estrutura-if$c$, $c$interpretation$c$, $c$Aprovado?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"nota","misconception":"mostra o nome da variável em vez da mensagem"},{"text":"Nada","misconception":"acha que o programa não mostra nada quando o if é verdadeiro"},{"text":"Reprovado","misconception":"acha que a nota 8 não atinge o mínimo"},{"text":"Aprovado"}],"correct":3,"code":"const nota = 8;\nif (nota >= 7) {\n  console.log(\"Aprovado\");\n}","explanation":"8 >= 7 é true, então o bloco executa e mostra Aprovado."}$c$::jsonb, $c$8 é maior ou igual a 7?$c$, 2, false, $c$arquivo$c$),
  ($c$if-complete-a-condicao$c$, $c$estrutura-if$c$, $c$blank$c$, $c$Complete a condição$c$, $c$facil$c$, $c$Complete a condição com o nome da variável para mostrar Dez quando n for igual a 10.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const n = 10;\nif ({{1}} === 10) {\n  console.log(\"Dez\");\n}","blanks":[{"answers":["n"]}],"explanation":"n === 10 compara o valor guardado em n com 10. Como n vale 10, a condição é verdadeira."}$c$::jsonb, $c$A condição compara a própria variável com 10.$c$, 3, false, $c$arquivo$c$),
  ($c$if-dois-blocos-independentes$c$, $c$estrutura-if$c$, $c$interpretation$c$, $c$Calor ou frio?$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Está quente\nFim"},{"text":"Está quente\nEstá frio\nFim","misconception":"acha que todos os if executam"},{"text":"Está frio\nFim","misconception":"avalia a segunda condição como verdadeira"},{"text":"Fim","misconception":"acha que nenhum bloco executa"}],"correct":0,"code":"const temperatura = 32;\nif (temperatura > 30) {\n  console.log(\"Está quente\");\n}\nif (temperatura < 15) {\n  console.log(\"Está frio\");\n}\nconsole.log(\"Fim\");","explanation":"32 > 30 é true (Está quente); 32 < 15 é false (bloco ignorado); depois, Fim."}$c$::jsonb, $c$Cada if é testado separadamente.$c$, 4, false, $c$arquivo$c$),
  ($c$if-bonus-de-vendas$c$, $c$estrutura-if$c$, $c$code$c$, $c$Bônus de vendas$c$, $c$medio$c$, $c$Escreva a função `bonus(vendas)` que devolve 100 se as vendas forem 1000 ou mais, e 0 caso contrário. Use um if.$c$, null, $c$bonus$c$, $c$function bonus(vendas) {
  let valor = 0;
  // use um if para mudar o valor quando as vendas forem 1000 ou mais
  return valor;
}
$c$, $c$[{"args":[500],"expected":0},{"args":[1000],"expected":100},{"args":[2500],"expected":100},{"args":[999],"expected":0}]$c$::jsonb, $c${}$c$::jsonb, $c$Comece com valor = 0 e só mude se a condição for verdadeira.$c$, 5, false, $c$arquivo$c$),
  ($c$if-corrija-o-ponto-e-virgula$c$, $c$estrutura-if$c$, $c$fix$c$, $c$Corrija o ponto e vírgula$c$, $c$medio$c$, $c$A função `classificar(idade)` deveria devolver "maior" para 18 anos ou mais e "menor" para os outros, mas devolve "maior" para todo mundo. Corrija o defeito.$c$, null, $c$classificar$c$, $c$function classificar(idade) {
  let texto = "menor";
  if (idade >= 18);
  {
    texto = "maior";
  }
  return texto;
}
$c$, $c$[{"args":[20],"expected":"maior"},{"args":[10],"expected":"menor"},{"args":[18],"expected":"maior"},{"args":[17],"expected":"menor"}]$c$::jsonb, $c${}$c$::jsonb, $c$Repare no que vem logo depois do parêntese do if.$c$, 6, false, $c$arquivo$c$),
  ($c$if-corrija-a-atribuicao$c$, $c$estrutura-if$c$, $c$fix$c$, $c$Corrija a condição$c$, $c$medio$c$, $c$A função `ehDezoito(idade)` deveria devolver true só para 18, mas devolve true para qualquer idade. Corrija o defeito.$c$, null, $c$ehDezoito$c$, $c$function ehDezoito(idade) {
  if (idade = 18) {
    return true;
  }
  return false;
}
$c$, $c$[{"args":[18],"expected":true},{"args":[20],"expected":false},{"args":[0],"expected":false}]$c$::jsonb, $c${}$c$::jsonb, $c$Um dos sinais guarda um valor em vez de comparar.$c$, 7, false, $c$arquivo$c$),
  ($c$if-somando-pontos$c$, $c$estrutura-if$c$, $c$interpretation$c$, $c$Acertos e pontos$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"10","misconception":"acha que o programa para no primeiro if verdadeiro"},{"text":"80","misconception":"soma todos os blocos sem avaliar as condições"},{"text":"30"},{"text":"20","misconception":"acha que só o último if verdadeiro conta"}],"correct":2,"code":"let pontos = 0;\nconst acertos = 7;\nif (acertos >= 5) {\n  pontos += 10;\n}\nif (acertos >= 7) {\n  pontos += 20;\n}\nif (acertos >= 10) {\n  pontos += 50;\n}\nconsole.log(pontos);","explanation":"7 >= 5 soma 10 e 7 >= 7 soma 20; 7 >= 10 é falso. Total: 30."}$c$::jsonb, $c$Cada if é testado de forma independente, e os blocos verdadeiros se acumulam.$c$, 8, false, $c$arquivo$c$),
  ($c$ifelse-o-que-faz-o-else$c$, $c$estrutura-if-else$c$, $c$choice$c$, $c$O que faz o else?$c$, $c$facil$c$, $c$O que o else faz em uma estrutura if/else?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Executa um bloco sempre, depois do if","misconception":"acha que o else executa em qualquer caso"},{"text":"Executa um bloco quando a condição do if for falsa"},{"text":"Testa uma segunda condição","misconception":"confunde else com else if"},{"text":"Repete o bloco do if","misconception":"confunde else com repetição"}],"correct":1,"explanation":"O bloco do else só executa quando a condição do if é falsa."}$c$::jsonb, $c$O else cobre o "senão".$c$, 1, false, $c$arquivo$c$),
  ($c$ifelse-par-ou-impar$c$, $c$estrutura-if-else$c$, $c$interpretation$c$, $c$Par ou ímpar?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Par","misconception":"acha que 7 % 2 vale zero"},{"text":"Par\nÍmpar","misconception":"acha que os dois blocos executam"},{"text":"7","misconception":"mostra o valor da variável em vez da mensagem"},{"text":"Ímpar"}],"correct":3,"code":"const numero = 7;\nif (numero % 2 === 0) {\n  console.log(\"Par\");\n} else {\n  console.log(\"Ímpar\");\n}","explanation":"7 % 2 vale 1, então a condição é falsa e o else executa: Ímpar."}$c$::jsonb, $c$7 % 2 é o resto de 7 dividido por 2.$c$, 2, false, $c$arquivo$c$),
  ($c$ifelse-complete-o-else$c$, $c$estrutura-if-else$c$, $c$blank$c$, $c$Complete o else$c$, $c$facil$c$, $c$Complete a palavra que inicia o caminho alternativo.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const idade = 15;\nif (idade >= 18) {\n  console.log(\"Maior\");\n} {{1}} {\n  console.log(\"Menor\");\n}","blanks":[{"answers":["else"]}],"explanation":"else abre o bloco que executa quando a condição do if é falsa."}$c$::jsonb, $c$A palavra vem do inglês e significa "senão".$c$, 3, false, $c$arquivo$c$),
  ($c$ifelse-reprovado$c$, $c$estrutura-if-else$c$, $c$interpretation$c$, $c$Aprovado ou reprovado?$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Reprovado\nFim"},{"text":"Aprovado\nFim","misconception":"avalia 6 >= 7 como verdadeiro"},{"text":"Aprovado\nReprovado\nFim","misconception":"acha que os dois blocos executam"},{"text":"Reprovado","misconception":"acha que o programa termina dentro do else"}],"correct":0,"code":"const nota = 6;\nif (nota >= 7) {\n  console.log(\"Aprovado\");\n} else {\n  console.log(\"Reprovado\");\n}\nconsole.log(\"Fim\");","explanation":"A condição é falsa, então executa o else (Reprovado). Depois do bloco, o programa mostra Fim."}$c$::jsonb, $c$6 >= 7 é falso. Depois do if/else, o programa continua.$c$, 4, false, $c$arquivo$c$),
  ($c$ifelse-par-ou-impar-funcao$c$, $c$estrutura-if-else$c$, $c$code$c$, $c$Par ou ímpar$c$, $c$medio$c$, $c$Escreva a função `parOuImpar(n)` que devolve "par" se n for par e "impar" caso contrário. Use if/else.$c$, null, $c$parOuImpar$c$, $c$function parOuImpar(n) {
  // seu código aqui
}
$c$, $c$[{"args":[4],"expected":"par"},{"args":[7],"expected":"impar"},{"args":[0],"expected":"par"},{"args":[-3],"expected":"impar"}]$c$::jsonb, $c${}$c$::jsonb, $c$Um número é par quando o resto da divisão por 2 é zero.$c$, 5, false, $c$arquivo$c$),
  ($c$ifelse-o-maior-de-dois$c$, $c$estrutura-if-else$c$, $c$code$c$, $c$O maior de dois$c$, $c$medio$c$, $c$Escreva a função `maior(a, b)` que devolve o maior entre dois números. Use if/else.$c$, null, $c$maior$c$, $c$function maior(a, b) {
  // seu código aqui
}
$c$, $c$[{"args":[3,5],"expected":5},{"args":[9,2],"expected":9},{"args":[4,4],"expected":4},{"args":[-1,-7],"expected":-1}]$c$::jsonb, $c${}$c$::jsonb, $c$Se a for maior, devolva a; senão, devolva b.$c$, 6, false, $c$arquivo$c$),
  ($c$ifelse-corrija-o-else-que-faltou$c$, $c$estrutura-if-else$c$, $c$fix$c$, $c$Corrija o else que faltou$c$, $c$medio$c$, $c$A função `situacao(nota)` deveria devolver "aprovado" para 7 ou mais e "reprovado" para os outros, mas devolve "reprovado" sempre. Corrija o defeito.$c$, null, $c$situacao$c$, $c$function situacao(nota) {
  let texto = "";
  if (nota >= 7) {
    texto = "aprovado";
  }
  texto = "reprovado";
  return texto;
}
$c$, $c$[{"args":[8],"expected":"aprovado"},{"args":[5],"expected":"reprovado"},{"args":[7],"expected":"aprovado"},{"args":[6.9],"expected":"reprovado"}]$c$::jsonb, $c${}$c$::jsonb, $c$A linha que define "reprovado" está fora de qualquer else: ela executa sempre.$c$, 7, false, $c$arquivo$c$),
  ($c$ifelse-dois-pares-de-blocos$c$, $c$estrutura-if-else$c$, $c$interpretation$c$, $c$Duas decisões$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"A\nB\nC\nD","misconception":"acha que todos os blocos executam"},{"text":"A\nC","misconception":"avalia a segunda condição como verdadeira"},{"text":"A\nD"},{"text":"B\nD","misconception":"avalia a primeira condição como falsa"}],"correct":2,"code":"const x = 7;\nif (x > 5) {\n  console.log(\"A\");\n} else {\n  console.log(\"B\");\n}\nif (x > 8) {\n  console.log(\"C\");\n} else {\n  console.log(\"D\");\n}","explanation":"7 > 5 é true (A). Já 7 > 8 é false, então o segundo executa o else (D)."}$c$::jsonb, $c$São dois if/else independentes: cada um escolhe o seu caminho.$c$, 8, false, $c$arquivo$c$),
  ($c$elseif-quantos-blocos-executam$c$, $c$estrutura-else-if$c$, $c$choice$c$, $c$Quantos blocos executam?$c$, $c$facil$c$, $c$Em uma cadeia if / else if / else, quantos blocos são executados?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Todos os blocos cujas condições forem verdadeiras","misconception":"acha que executa todos os blocos verdadeiros, como em vários if separados"},{"text":"No máximo um: o primeiro com condição verdadeira (ou o else)"},{"text":"Todos os blocos, sempre","misconception":"acha que o else if não impede a execução dos blocos seguintes"},{"text":"Sempre o último bloco","misconception":"acha que a cadeia sempre termina no último bloco"}],"correct":1,"explanation":"Em uma cadeia if / else if / else, só o primeiro bloco com condição verdadeira executa. Se nenhum for verdadeiro, o else executa."}$c$::jsonb, $c$Depois que uma condição é verdadeira, o computador ignora o resto da cadeia.$c$, 1, false, $c$arquivo$c$),
  ($c$elseif-escala-de-notas$c$, $c$estrutura-else-if$c$, $c$interpretation$c$, $c$Qual faixa?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Excelente","misconception":"acha que 7.5 é maior ou igual a 9"},{"text":"Bom\nRegular","misconception":"acha que os blocos seguintes também executam"},{"text":"Regular","misconception":"pula a faixa correta"},{"text":"Bom"}],"correct":3,"code":"const nota = 7.5;\nif (nota >= 9) {\n  console.log(\"Excelente\");\n} else if (nota >= 7) {\n  console.log(\"Bom\");\n} else if (nota >= 5) {\n  console.log(\"Regular\");\n} else {\n  console.log(\"Insuficiente\");\n}","explanation":"7.5 >= 9 é falso; 7.5 >= 7 é verdadeiro, então mostra Bom e ignora o resto."}$c$::jsonb, $c$Teste as condições de cima para baixo e pare na primeira verdadeira.$c$, 2, false, $c$arquivo$c$),
  ($c$elseif-complete-a-cadeia$c$, $c$estrutura-else-if$c$, $c$blank$c$, $c$Complete a cadeia$c$, $c$facil$c$, $c$Complete a palavra que liga a segunda condição à primeira.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const n = -4;\nif (n > 0) {\n  console.log(\"positivo\");\n} {{1}} if (n < 0) {\n  console.log(\"negativo\");\n} else {\n  console.log(\"zero\");\n}","blanks":[{"answers":["else"]}],"explanation":"else if testa uma nova condição quando a anterior foi falsa."}$c$::jsonb, $c$A segunda condição só é testada se a primeira for falsa.$c$, 3, false, $c$arquivo$c$),
  ($c$elseif-ordem-errada$c$, $c$estrutura-else-if$c$, $c$interpretation$c$, $c$A ordem importa$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Regular"},{"text":"Excelente","misconception":"acha que o computador escolhe a melhor faixa, e não a primeira verdadeira"},{"text":"Regular\nBom\nExcelente","misconception":"acha que todas as condições verdadeiras executam"},{"text":"Nada","misconception":"acha que a nota não se encaixa em nenhuma faixa"}],"correct":0,"code":"const nota = 9.5;\nif (nota >= 5) {\n  console.log(\"Regular\");\n} else if (nota >= 7) {\n  console.log(\"Bom\");\n} else if (nota >= 9) {\n  console.log(\"Excelente\");\n}","explanation":"9.5 >= 5 é verdadeiro, então mostra Regular e as demais faixas nem são testadas. As faixas deveriam estar da maior para a menor."}$c$::jsonb, $c$A primeira condição já é verdadeira para 9.5.$c$, 4, false, $c$arquivo$c$),
  ($c$elseif-classificar-nota$c$, $c$estrutura-else-if$c$, $c$code$c$, $c$Classificar a nota$c$, $c$medio$c$, $c$Escreva a função `classificarNota(nota)` que devolve "A" para 9 ou mais, "B" para 7 ou mais, "C" para 5 ou mais e "D" para o resto.$c$, null, $c$classificarNota$c$, $c$function classificarNota(nota) {
  // seu código aqui
}
$c$, $c$[{"args":[9.5],"expected":"A"},{"args":[9],"expected":"A"},{"args":[8],"expected":"B"},{"args":[7],"expected":"B"},{"args":[6],"expected":"C"},{"args":[5],"expected":"C"},{"args":[4.9],"expected":"D"}]$c$::jsonb, $c${}$c$::jsonb, $c$Comece pela faixa mais alta e vá descendo.$c$, 5, false, $c$arquivo$c$),
  ($c$elseif-sinal-do-numero$c$, $c$estrutura-else-if$c$, $c$code$c$, $c$Sinal do número$c$, $c$medio$c$, $c$Escreva a função `sinal(n)` que devolve "positivo" se n for maior que zero, "negativo" se for menor que zero e "zero" se for zero.$c$, null, $c$sinal$c$, $c$function sinal(n) {
  // seu código aqui
}
$c$, $c$[{"args":[5],"expected":"positivo"},{"args":[-2],"expected":"negativo"},{"args":[0],"expected":"zero"},{"args":[0.1],"expected":"positivo"}]$c$::jsonb, $c${}$c$::jsonb, $c$Três caminhos: positivo, negativo e o que sobrar.$c$, 6, false, $c$arquivo$c$),
  ($c$elseif-corrija-a-ordem$c$, $c$estrutura-else-if$c$, $c$fix$c$, $c$Corrija a ordem das faixas$c$, $c$medio$c$, $c$A função `faixa(nota)` deveria devolver "Bom" para notas de 7 a 8.9, mas devolve "Regular" para quem tira 8. Corrija o defeito.$c$, null, $c$faixa$c$, $c$function faixa(nota) {
  if (nota >= 5) {
    return "Regular";
  } else if (nota >= 7) {
    return "Bom";
  } else {
    return "Insuficiente";
  }
}
$c$, $c$[{"args":[8],"expected":"Bom"},{"args":[6],"expected":"Regular"},{"args":[3],"expected":"Insuficiente"},{"args":[7],"expected":"Bom"},{"args":[5],"expected":"Regular"}]$c$::jsonb, $c${}$c$::jsonb, $c$Qual condição pega todo mundo que tem 7 ou mais antes da hora?$c$, 7, false, $c$arquivo$c$),
  ($c$elseif-versus-ifs-separados$c$, $c$estrutura-else-if$c$, $c$interpretation$c$, $c$else if e if separado$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Fizz\nBuzz\nFizz2\nBuzz2","misconception":"acha que o else if também executa quando o if anterior foi verdadeiro"},{"text":"Fizz\nFizz2","misconception":"acha que só um bloco executa em todo o programa"},{"text":"Fizz\nFizz2\nBuzz2"},{"text":"Buzz\nFizz2\nBuzz2","misconception":"acha que o else if é testado antes do if"}],"correct":2,"code":"const n = 15;\nif (n % 3 === 0) {\n  console.log(\"Fizz\");\n} else if (n % 5 === 0) {\n  console.log(\"Buzz\");\n}\nif (n % 3 === 0) {\n  console.log(\"Fizz2\");\n}\nif (n % 5 === 0) {\n  console.log(\"Buzz2\");\n}","explanation":"15 é divisível por 3 e por 5. Na primeira cadeia, só o primeiro bloco verdadeiro executa (Fizz). Os dois if seguintes são testados separadamente, e os dois são verdadeiros (Fizz2 e Buzz2)."}$c$::jsonb, $c$A primeira cadeia executa um bloco só; os dois if finais são independentes.$c$, 8, false, $c$arquivo$c$),
  ($c$aninhada-o-que-e$c$, $c$condicionais-aninhadas$c$, $c$choice$c$, $c$O que é aninhar?$c$, $c$facil$c$, $c$O que é uma condicional aninhada?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Duas condicionais seguidas, uma depois da outra","misconception":"confunde aninhar com colocar condicionais em sequência"},{"text":"Uma condicional escrita dentro do bloco de outra condicional"},{"text":"Uma condicional com mais de uma condição","misconception":"confunde aninhar com combinar condições com && ou ||"},{"text":"Um if sem else","misconception":"confunde aninhar com a ausência de else"}],"correct":1,"explanation":"Aninhar é colocar uma estrutura condicional dentro do bloco de outra."}$c$::jsonb, $c$Pense em caixas dentro de caixas.$c$, 1, false, $c$arquivo$c$),
  ($c$aninhada-sem-ingresso$c$, $c$condicionais-aninhadas$c$, $c$interpretation$c$, $c$Tem ingresso?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Pode entrar","misconception":"acha que a pessoa entra só por ser maior de idade"},{"text":"Menor de idade","misconception":"ignora a condição externa, que é verdadeira"},{"text":"Compre um ingresso\nMenor de idade","misconception":"acha que os dois else executam"},{"text":"Compre um ingresso"}],"correct":3,"code":"const idade = 20;\nconst temIngresso = false;\nif (idade >= 18) {\n  if (temIngresso) {\n    console.log(\"Pode entrar\");\n  } else {\n    console.log(\"Compre um ingresso\");\n  }\n} else {\n  console.log(\"Menor de idade\");\n}","explanation":"A idade é suficiente (bloco externo). Dentro dele, a pessoa não tem ingresso, então executa o else interno."}$c$::jsonb, $c$Entre primeiro no bloco externo; depois avalie o interno.$c$, 2, false, $c$arquivo$c$),
  ($c$aninhada-complete-o-if-interno$c$, $c$condicionais-aninhadas$c$, $c$blank$c$, $c$Complete o if interno$c$, $c$facil$c$, $c$Complete a palavra que inicia a condicional interna.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const a = 3;\nconst b = 5;\nif (a > 0) {\n  {{1}} (b > 0) {\n    console.log(\"Os dois são positivos\");\n  }\n}","blanks":[{"answers":["if"]}],"explanation":"O if interno só é testado quando a condição externa (a > 0) é verdadeira."}$c$::jsonb, $c$A decisão interna usa a mesma palavra da externa.$c$, 3, false, $c$arquivo$c$),
  ($c$aninhada-menor-de-idade$c$, $c$condicionais-aninhadas$c$, $c$interpretation$c$, $c$Menor de idade$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Menor de idade"},{"text":"Pode entrar","misconception":"avalia só a condição interna, ignorando a externa"},{"text":"Compre um ingresso","misconception":"acha que a condição interna é testada mesmo com a externa falsa"},{"text":"Nada","misconception":"acha que o programa não mostra nada para menores"}],"correct":0,"code":"const idade = 16;\nconst temIngresso = true;\nif (idade >= 18) {\n  if (temIngresso) {\n    console.log(\"Pode entrar\");\n  } else {\n    console.log(\"Compre um ingresso\");\n  }\n} else {\n  console.log(\"Menor de idade\");\n}","explanation":"16 >= 18 é falso, então o bloco externo é ignorado e o else externo executa. A condição interna nem é avaliada."}$c$::jsonb, $c$A condição externa é falsa. A interna é avaliada?$c$, 4, false, $c$arquivo$c$),
  ($c$aninhada-desconto-do-ingresso$c$, $c$condicionais-aninhadas$c$, $c$code$c$, $c$Desconto do ingresso$c$, $c$medio$c$, $c$Escreva a função `descontoDoIngresso(idade, estudante)`: menores de 18 anos têm 100 de desconto; maiores de idade estudantes têm 50; os demais, 0. Use condicionais aninhadas.$c$, null, $c$descontoDoIngresso$c$, $c$function descontoDoIngresso(idade, estudante) {
  // seu código aqui
}
$c$, $c$[{"args":[10,false],"expected":100},{"args":[20,true],"expected":50},{"args":[20,false],"expected":0},{"args":[18,true],"expected":50},{"args":[17,true],"expected":100}]$c$::jsonb, $c${}$c$::jsonb, $c$Primeiro decida pela idade; só para os maiores de idade pergunte se é estudante.$c$, 5, false, $c$arquivo$c$),
  ($c$aninhada-corrija-o-else-interno$c$, $c$condicionais-aninhadas$c$, $c$fix$c$, $c$Corrija o caminho que faltou$c$, $c$medio$c$, $c$A função `acesso(idade, temIngresso)` devolve undefined para um adulto sem ingresso, mas deveria devolver "sem ingresso". Corrija o defeito.$c$, null, $c$acesso$c$, $c$function acesso(idade, temIngresso) {
  if (idade >= 18) {
    if (temIngresso) {
      return "entrou";
    }
  } else {
    return "menor";
  }
}
$c$, $c$[{"args":[20,true],"expected":"entrou"},{"args":[20,false],"expected":"sem ingresso"},{"args":[15,true],"expected":"menor"},{"args":[15,false],"expected":"menor"}]$c$::jsonb, $c${}$c$::jsonb, $c$Que caminho cobre o adulto que não tem ingresso?$c$, 6, false, $c$arquivo$c$),
  ($c$aninhada-equivalente-com-e$c$, $c$condicionais-aninhadas$c$, $c$choice$c$, $c$Juntando as condições$c$, $c$medio$c$, $c$Qual condição única equivale a if (a) { if (b) { ... } }?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"if (a || b) { ... }","misconception":"troca o E por OU"},{"text":"if (!a && b) { ... }","misconception":"inverte a primeira condição"},{"text":"if (a && b) { ... }"},{"text":"if (a) if (b) { ... } else { ... }","misconception":"mantém o aninhamento e ainda acrescenta um else que não existia"}],"correct":2,"explanation":"O bloco só executa quando a e b são verdadeiros ao mesmo tempo: a && b."}$c$::jsonb, $c$O bloco interno só executa quando as duas condições são verdadeiras.$c$, 7, false, $c$arquivo$c$),
  ($c$aninhada-tres-niveis$c$, $c$condicionais-aninhadas$c$, $c$interpretation$c$, $c$Três níveis$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"A","misconception":"avalia y > 20 como verdadeiro"},{"text":"B"},{"text":"C","misconception":"avalia x < y como falso"},{"text":"D","misconception":"avalia x > 0 como falso"}],"correct":1,"code":"const x = 5;\nconst y = 10;\nif (x > 0) {\n  if (y > 20) {\n    console.log(\"A\");\n  } else {\n    if (x < y) {\n      console.log(\"B\");\n    } else {\n      console.log(\"C\");\n    }\n  }\n} else {\n  console.log(\"D\");\n}","explanation":"x > 0 é verdadeiro; y > 20 é falso, então vai para o else; dentro dele, x < y (5 < 10) é verdadeiro: B."}$c$::jsonb, $c$Siga os blocos de fora para dentro, anotando a resposta de cada condição.$c$, 8, false, $c$arquivo$c$),
  ($c$switch-quando-usar$c$, $c$estrutura-switch$c$, $c$choice$c$, $c$Quando usar o switch?$c$, $c$facil$c$, $c$Em que situação o switch é mais indicado?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Para testar faixas de valores, como nota >= 7","misconception":"acha que o switch aceita comparações de faixa"},{"text":"Para repetir um bloco várias vezes","misconception":"confunde switch com repetição"},{"text":"Para combinar várias condições com E e OU","misconception":"confunde switch com operadores lógicos"},{"text":"Para comparar uma variável com vários valores exatos"}],"correct":3,"explanation":"O switch é ideal para comparar uma variável com valores exatos, como a opção escolhida em um menu."}$c$::jsonb, $c$O switch compara com ===, valor por valor.$c$, 1, false, $c$arquivo$c$),
  ($c$switch-dia-da-semana$c$, $c$estrutura-switch$c$, $c$interpretation$c$, $c$Qual dia?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Segunda"},{"text":"Domingo","misconception":"acha que o switch executa sempre o primeiro case"},{"text":"Segunda\nOutro dia","misconception":"acha que o default executa depois de um case que combinou"},{"text":"Outro dia","misconception":"acha que o default executa mesmo quando um case combina"}],"correct":0,"code":"const dia = 2;\nswitch (dia) {\n  case 1:\n    console.log(\"Domingo\");\n    break;\n  case 2:\n    console.log(\"Segunda\");\n    break;\n  default:\n    console.log(\"Outro dia\");\n}","explanation":"case 2 combina, mostra Segunda, e o break encerra o switch."}$c$::jsonb, $c$Procure o case que combina com 2.$c$, 2, false, $c$arquivo$c$),
  ($c$switch-complete-o-break$c$, $c$estrutura-switch$c$, $c$blank$c$, $c$Complete o break$c$, $c$facil$c$, $c$Complete a palavra que encerra o switch depois de um case.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const opcao = 1;\nswitch (opcao) {\n  case 1:\n    console.log(\"Novo jogo\");\n    {{1}};\n  case 2:\n    console.log(\"Sair\");\n    break;\n}","blanks":[{"answers":["break"]}],"explanation":"break encerra o switch e impede que os cases seguintes também executem."}$c$::jsonb, $c$Sem essa palavra, o código cai no case seguinte.$c$, 3, false, $c$arquivo$c$),
  ($c$switch-sem-break$c$, $c$estrutura-switch$c$, $c$interpretation$c$, $c$Sem break$c$, $c$medio$c$, $c$O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Um","misconception":"acha que o switch encerra sozinho depois do case que combinou"},{"text":"Um\nDois\nTrês","misconception":"acha que o break não interrompe a execução"},{"text":"Um\nDois"},{"text":"Dois","misconception":"acha que a execução começa no case seguinte"}],"correct":2,"code":"const n = 1;\nswitch (n) {\n  case 1:\n    console.log(\"Um\");\n  case 2:\n    console.log(\"Dois\");\n    break;\n  case 3:\n    console.log(\"Três\");\n}","explanation":"case 1 combina e mostra Um. Sem break, a execução cai no case 2 (Dois), onde o break finalmente encerra o switch."}$c$::jsonb, $c$O primeiro case não tem break.$c$, 4, false, $c$arquivo$c$),
  ($c$switch-nome-do-dia$c$, $c$estrutura-switch$c$, $c$code$c$, $c$Nome do dia$c$, $c$medio$c$, $c$Escreva a função `nomeDoDia(numero)` que devolve o nome do dia da semana (1 = "domingo", 2 = "segunda", 3 = "terca", 4 = "quarta", 5 = "quinta", 6 = "sexta", 7 = "sabado") e "invalido" para qualquer outro número. Use switch.$c$, null, $c$nomeDoDia$c$, $c$function nomeDoDia(numero) {
  // seu código aqui
}
$c$, $c$[{"args":[1],"expected":"domingo"},{"args":[4],"expected":"quarta"},{"args":[7],"expected":"sabado"},{"args":[0],"expected":"invalido"},{"args":[9],"expected":"invalido"}]$c$::jsonb, $c${}$c$::jsonb, $c$Um case para cada dia e um default para o resto.$c$, 5, false, $c$arquivo$c$),
  ($c$switch-calculadora-de-operacao$c$, $c$estrutura-switch$c$, $c$code$c$, $c$Operação escolhida$c$, $c$medio$c$, $c$Escreva a função `calcular(operacao, a, b)`: para "+" devolve a + b, para "-" devolve a - b, para "*" devolve a * b, para "/" devolve a / b. Para qualquer outra operação, devolve "operacao invalida". Use switch.$c$, null, $c$calcular$c$, $c$function calcular(operacao, a, b) {
  // seu código aqui
}
$c$, $c$[{"args":["+",6,3],"expected":9},{"args":["-",6,3],"expected":3},{"args":["*",6,3],"expected":18},{"args":["/",6,3],"expected":2},{"args":["%",6,3],"expected":"operacao invalida"}]$c$::jsonb, $c${}$c$::jsonb, $c$Compare a operação (um texto) com cada case.$c$, 6, false, $c$arquivo$c$),
  ($c$switch-corrija-o-break$c$, $c$estrutura-switch$c$, $c$fix$c$, $c$Corrija o break que faltou$c$, $c$medio$c$, $c$A função `tipo(codigo)` deveria devolver "fruta" para 1, "legume" para 2 e "outro" nos demais casos, mas devolve sempre "outro" para 1 e 2. Corrija o defeito.$c$, null, $c$tipo$c$, $c$function tipo(codigo) {
  let t = "";
  switch (codigo) {
    case 1:
      t = "fruta";
    case 2:
      t = "legume";
    default:
      t = "outro";
  }
  return t;
}
$c$, $c$[{"args":[1],"expected":"fruta"},{"args":[2],"expected":"legume"},{"args":[3],"expected":"outro"},{"args":[0],"expected":"outro"}]$c$::jsonb, $c${}$c$::jsonb, $c$O que acontece depois que um case termina sem break?$c$, 7, false, $c$arquivo$c$),
  ($c$switch-igualdade-estrita$c$, $c$estrutura-switch$c$, $c$interpretation$c$, $c$Igualdade estrita no switch$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Um","misconception":"acha que o switch converte o texto e escolhe o primeiro case"},{"text":"Nenhuma"},{"text":"Dois","misconception":"acha que o switch compara sem considerar o tipo (como ==)"},{"text":"Um\nDois","misconception":"acha que os dois cases combinam"}],"correct":1,"code":"const opcao = \"2\";\nswitch (opcao) {\n  case 1:\n    console.log(\"Um\");\n    break;\n  case 2:\n    console.log(\"Dois\");\n    break;\n  default:\n    console.log(\"Nenhuma\");\n}","explanation":"O switch usa igualdade estrita (===). O texto \"2\" não é estritamente igual ao número 2, então nenhum case combina e o default executa."}$c$::jsonb, $c$O switch compara usando ===: o texto "2" é igual ao número 2?$c$, 8, false, $c$arquivo$c$),
  ($c$ternario-o-que-e$c$, $c$operador-ternario$c$, $c$choice$c$, $c$O que é o ternário?$c$, $c$facil$c$, $c$O que é o operador ternário?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Um operador que compara três valores ao mesmo tempo","misconception":"acha que \"ternário\" significa comparar três valores"},{"text":"Um laço que repete uma instrução três vezes","misconception":"confunde ternário com repetição"},{"text":"Uma forma de declarar uma variável com três valores","misconception":"confunde ternário com declaração"},{"text":"Um atalho para um if/else simples que produz um valor"}],"correct":3,"explanation":"O ternário é um if/else escrito em uma expressão só: condição ? valorSeVerdadeira : valorSeFalsa."}$c$::jsonb, $c$Ele tem três partes: condição, valor se verdadeira e valor se falsa.$c$, 1, false, $c$arquivo$c$),
  ($c$ternario-situacao$c$, $c$operador-ternario$c$, $c$interpretation$c$, $c$Aprovado ou reprovado?$c$, $c$facil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"Reprovado"},{"text":"Aprovado","misconception":"acha que o ternário devolve sempre o primeiro valor"},{"text":"true","misconception":"acha que o ternário devolve o resultado da condição"},{"text":"Aprovado Reprovado","misconception":"acha que o ternário devolve os dois valores"}],"correct":0,"code":"const nota = 5;\nconst situacao = nota >= 7 ? \"Aprovado\" : \"Reprovado\";\nconsole.log(situacao);","explanation":"A condição é falsa, então o ternário resulta no valor depois dos dois-pontos: Reprovado."}$c$::jsonb, $c$5 >= 7 é verdadeiro ou falso?$c$, 2, false, $c$arquivo$c$),
  ($c$ternario-complete-os-simbolos$c$, $c$operador-ternario$c$, $c$blank$c$, $c$Complete o ternário$c$, $c$facil$c$, $c$Complete o símbolo que separa a condição do primeiro valor.$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"template":"const idade = 20;\nconst texto = idade >= 18 {{1}} \"maior\" : \"menor\";","blanks":[{"answers":["?"]}],"explanation":"O ponto de interrogação vem depois da condição e os dois-pontos separam os dois valores."}$c$::jsonb, $c$Ele aparece logo depois da condição.$c$, 3, false, $c$arquivo$c$),
  ($c$ternario-par-ou-impar$c$, $c$operador-ternario$c$, $c$code$c$, $c$Par ou ímpar em uma linha$c$, $c$medio$c$, $c$Escreva a função `parOuImpar(n)` que devolve "par" ou "impar" usando o operador ternário, em um único return.$c$, null, $c$parOuImpar$c$, $c$function parOuImpar(n) {
  // seu código aqui
}
$c$, $c$[{"args":[2],"expected":"par"},{"args":[9],"expected":"impar"},{"args":[0],"expected":"par"}]$c$::jsonb, $c${}$c$::jsonb, $c$return condição ? "par" : "impar";$c$, 4, false, $c$arquivo$c$),
  ($c$ternario-valor-absoluto$c$, $c$operador-ternario$c$, $c$code$c$, $c$Valor absoluto$c$, $c$medio$c$, $c$Escreva a função `absoluto(n)` que devolve o número sem sinal (por exemplo, -5 vira 5). Use o operador ternário e não use Math.abs.$c$, null, $c$absoluto$c$, $c$function absoluto(n) {
  // seu código aqui
}
$c$, $c$[{"args":[5],"expected":5},{"args":[-5],"expected":5},{"args":[0],"expected":0},{"args":[-2.5],"expected":2.5}]$c$::jsonb, $c${}$c$::jsonb, $c$Se n for negativo, devolva -n; senão, devolva n.$c$, 5, false, $c$arquivo$c$),
  ($c$ternario-corrija-a-ordem$c$, $c$operador-ternario$c$, $c$fix$c$, $c$Corrija o ternário$c$, $c$medio$c$, $c$A função `situacao(nota)` deveria devolver "aprovado" para 7 ou mais, mas devolve o contrário. Corrija o defeito.$c$, null, $c$situacao$c$, $c$function situacao(nota) {
  return nota >= 7 ? "reprovado" : "aprovado";
}
$c$, $c$[{"args":[8],"expected":"aprovado"},{"args":[7],"expected":"aprovado"},{"args":[3],"expected":"reprovado"}]$c$::jsonb, $c${}$c$::jsonb, $c$Qual valor fica depois do ponto de interrogação?$c$, 6, false, $c$arquivo$c$),
  ($c$ternario-aninhado$c$, $c$operador-ternario$c$, $c$interpretation$c$, $c$Ternário em cadeia$c$, $c$dificil$c$, $c$O que o programa abaixo mostra na tela?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"positivo","misconception":"avalia n > 0 como verdadeiro"},{"text":"negativo","misconception":"avalia n < 0 como verdadeiro"},{"text":"zero"},{"text":"true","misconception":"acha que o ternário devolve o resultado da condição"}],"correct":2,"code":"const n = 0;\nconst texto = n > 0 ? \"positivo\" : n < 0 ? \"negativo\" : \"zero\";\nconsole.log(texto);","explanation":"0 > 0 é falso; 0 < 0 também é falso; resta o último valor: zero."}$c$::jsonb, $c$Leia como uma cadeia if / else if / else.$c$, 7, false, $c$arquivo$c$),
  ($c$desafio4-sistema-de-notas$c$, $c$desafio-do-mundo-4$c$, $c$challenge$c$, $c$Desafio: sistema de notas$c$, $c$dificil$c$, $c$Escreva a função `sistemaDeNotas()`: leia três notas com `lerEntrada()` (chegam como texto), calcule a média e mostre duas linhas com `console.log`: `Média: <valor>` e `Situação: <texto>`. A situação é Aprovado (média 7 ou mais), Recuperação (5 ou mais, mas menos de 7) ou Reprovado (menos de 5).$c$, null, $c$sistemaDeNotas$c$, $c$function sistemaDeNotas() {
  // leia as notas, calcule a média e mostre as duas linhas
}
$c$, $c$[{"args":[],"inputs":["9","8","10"],"output":["Média: 9","Situação: Aprovado"]},{"args":[],"inputs":["6","7","5"],"output":["Média: 6","Situação: Recuperação"]},{"args":[],"inputs":["2","3","4"],"output":["Média: 3","Situação: Reprovado"]},{"args":[],"inputs":["7","7","7"],"output":["Média: 7","Situação: Aprovado"]},{"args":[],"inputs":["5","5","5"],"output":["Média: 5","Situação: Recuperação"]}]$c$::jsonb, $c${}$c$::jsonb, $c$Calcule a média com parênteses e depois use if / else if / else, começando pela faixa mais alta.$c$, 1, false, $c$arquivo$c$),
  ($c$desafio4-corrija-o-desconto$c$, $c$desafio-do-mundo-4$c$, $c$fix$c$, $c$Desafio: corrija o desconto$c$, $c$dificil$c$, $c$A função `desconto(valor, cliente)` deveria dar 20% de desconto a clientes "vip" e 10% aos demais clientes quando o valor for 100 ou mais; abaixo de 100, não há desconto. Ela devolve o valor final, mas hoje calcula errado em alguns casos. Corrija o defeito.$c$, null, $c$desconto$c$, $c$function desconto(valor, cliente) {
  if (valor >= 100) {
    return valor * 0.9;
  } else if (cliente === "vip") {
    return valor * 0.8;
  } else {
    return valor;
  }
}
$c$, $c$[{"args":[200,"vip"],"expected":160},{"args":[200,"comum"],"expected":180},{"args":[50,"vip"],"expected":50},{"args":[50,"comum"],"expected":50},{"args":[100,"vip"],"expected":80}]$c$::jsonb, $c${}$c$::jsonb, $c$O desconto vip só vale quando o valor também atinge 100. Que decisão vem primeiro?$c$, 2, false, $c$arquivo$c$),
  ($c$desafio4-acompanhe-as-decisoes$c$, $c$desafio-do-mundo-4$c$, $c$interpretation$c$, $c$Desafio: acompanhe as decisões$c$, $c$dificil$c$, $c$Acompanhe cada condição. O que o programa abaixo mostra na tela, em ordem?$c$, null, null, $c$$c$, $c$[]$c$::jsonb, $c${"options":[{"text":"adulto","misconception":"avalia 17 >= 18 como verdadeiro e ignora a segunda linha"},{"text":"Entrada liberada\nmenor autorizado"},{"text":"Entrada liberada\nadulto","misconception":"avalia 17 >= 18 como verdadeiro"},{"text":"barrado","misconception":"acha que a idade 17 cai direto no else"}],"correct":1,"code":"const idade = 17;\nconst autorizado = true;\nlet resultado = \"\";\nif (idade >= 18) {\n  resultado = \"adulto\";\n} else if (idade >= 16 && autorizado) {\n  resultado = \"menor autorizado\";\n} else {\n  resultado = \"barrado\";\n}\nif (resultado !== \"barrado\") {\n  console.log(\"Entrada liberada\");\n}\nconsole.log(resultado);","explanation":"17 >= 18 é falso; 17 >= 16 && true é verdadeiro, então resultado vira \"menor autorizado\". Como é diferente de \"barrado\", mostra Entrada liberada e depois o resultado."}$c$::jsonb, $c$Siga a primeira cadeia até encontrar a condição verdadeira; depois avalie o segundo if.$c$, 3, false, $c$arquivo$c$),
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
  ($c$declaracao-corrija-o-nome$c$, $c$function quadrado(numero) {
  let resultado = numero * numero;
  return resultado;
}$c$, $c$O defeito estava na grafia: Resultado (maiúsculo) não existe, porque a variável se chama resultado. Em JavaScript, maiúsculas e minúsculas contam.$c$),
  ($c$letconst-corrija-a-area$c$, $c$function areaDoCirculo(raio) {
  const PI = 3.14;
  let area = 0;
  area = PI * raio * raio;
  return area;
}$c$, $c$area foi declarada com const e depois recebeu outro valor. Como ela muda, deve ser let (ou ser declarada já com o resultado).$c$),
  ($c$string-corrija-as-aspas$c$, $c$function cidade() {
  return "Picos";
}$c$, $c$Sem aspas, Picos é entendido como o nome de uma variável que não existe. Entre aspas, vira um texto.$c$),
  ($c$number-media-de-dois$c$, $c$function media(a, b) {
  return (a + b) / 2;
}$c$, $c$A média é a soma dos valores dividida pela quantidade deles: (a + b) / 2. Os parênteses garantem que a soma aconteça antes da divisão.$c$),
  ($c$textos-inicial-em-maiuscula$c$, $c$function inicial(nome) {
  return nome.trim()[0].toUpperCase();
}$c$, $c$trim() remove os espaços das pontas, [0] pega a primeira letra e toUpperCase() a deixa em maiúscula. Os métodos podem ser encadeados.$c$),
  ($c$concat-nome-completo$c$, $c$function nomeCompleto(nome, sobrenome) {
  return nome + " " + sobrenome;
}$c$, $c$Concatenamos três partes: o nome, o espaço (" ") e o sobrenome.$c$),
  ($c$template-corrija-a-saudacao$c$, $c$function saudacao(nome) {
  return `Olá, ${nome}!`;
}$c$, $c$Com aspas comuns, o ${nome} não é substituído. Trocando por crases, o valor da variável entra no texto.$c$),
  ($c$template-apresentar$c$, $c$function apresentar(nome, idade) {
  return `${nome} tem ${idade} anos`;
}$c$, $c$O template literal `${nome} tem ${idade} anos` insere as duas variáveis no texto.$c$),
  ($c$operacoes-media-de-tres$c$, $c$function mediaDeTres(a, b, c) {
  return (a + b + c) / 3;
}$c$, $c$A média é (a + b + c) / 3. Os parênteses fazem a soma acontecer antes da divisão.$c$),
  ($c$conversao-corrija-a-soma$c$, $c$function somar(a, b) {
  return Number(a) + Number(b);
}$c$, $c$Com textos, o + junta ("23"). Convertendo cada valor com Number(), o + soma de verdade.$c$),
  ($c$conversao-somar-entradas$c$, $c$function somarEntradas() {
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  console.log(a + b);
}$c$, $c$Sem a conversão, "4" + "6" daria "46". Com Number() em cada valor, a soma é feita entre números.$c$),
  ($c$es-boas-vindas$c$, $c$function boasVindas() {
  const nome = lerEntrada();
  console.log(`Bem-vindo, ${nome}!`);
}$c$, $c$A entrada fica na variável nome e a saída é montada com um template literal: `Bem-vindo, ${nome}!`.$c$),
  ($c$es-area-do-retangulo$c$, $c$function areaDoRetangulo() {
  const base = Number(lerEntrada());
  const altura = Number(lerEntrada());
  console.log(`Área: ${base * altura}`);
}$c$, $c$Lemos base e altura, convertemos para número, multiplicamos e mostramos a frase com o resultado.$c$),
  ($c$es-corrija-o-ano-que-vem$c$, $c$function anoQueVem() {
  const idade = Number(lerEntrada());
  console.log("Ano que vem: " + (idade + 1));
}$c$, $c$Como idade é texto, o + junta "20" e 1 (201). Convertendo com Number() e somando antes de juntar ao texto, o resultado é 21.$c$),
  ($c$es-media-das-notas$c$, $c$function mediaDasNotas() {
  const n1 = Number(lerEntrada());
  const n2 = Number(lerEntrada());
  const n3 = Number(lerEntrada());
  const media = (n1 + n2 + n3) / 3;
  console.log(`Média: ${media}`);
}$c$, $c$O programa lê as três notas, converte cada uma com Number(), calcula (n1 + n2 + n3) / 3 e mostra a frase.$c$),
  ($c$log-mostrar-os-dados$c$, $c$function mostrarDados() {
  const nome = lerEntrada();
  const idade = lerEntrada();
  console.log("Nome:", nome);
  console.log("Idade:", idade);
}$c$, $c$Duas chamadas de console.log geram duas linhas, e a vírgula coloca o espaço entre o rótulo e o valor.$c$),
  ($c$log-corrija-o-total$c$, $c$function mostrarTotal(preco, quantidade) {
  const total = preco * quantidade;
  console.log("Total:", total);
}$c$, $c$Com a vírgula, o console.log coloca o espaço sozinho. Também funcionaria incluir o espaço no texto: "Total: " + total.$c$),
  ($c$desafio2-ficha-da-pessoa$c$, $c$function ficha() {
  const nome = lerEntrada();
  const idade = Number(lerEntrada());
  const altura = Number(lerEntrada());
  console.log(`Nome: ${nome}`);
  console.log(`Idade: ${idade} anos`);
  console.log(`Altura: ${altura} m`);
  console.log(`Daqui a 10 anos, ${nome} terá ${idade + 10} anos.`);
}$c$, $c$O programa lê os três dados, converte a idade para número, soma 10 e monta cada frase com template literals.$c$),
  ($c$desafio2-corrija-o-resumo$c$, $c$function resumo() {
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  const soma = a + b;
  const media = soma / 2;
  console.log(`Soma: ${soma}`);
  console.log(`Média: ${media}`);
}$c$, $c$Como as entradas são texto, a + b juntava os valores ("46"). Convertendo com Number(), a soma e a média passam a ser calculadas com números.$c$),
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
  ($c$arit-ultimo-digito$c$, $c$function ultimoDigito(n) {
  return n % 10;
}$c$, $c$n % 10 devolve o que sobra da divisão por 10, que é exatamente o último dígito.$c$),
  ($c$arit-corrija-o-quadrado$c$, $c$function quadrado(n) {
  return n ** 2;
}$c$, $c$Em JavaScript, ^ é outro operador (bit a bit), por isso 3 ^ 2 dá 1. A potência é escrita com **: n ** 2.$c$),
  ($c$atrib-corrija-o-total$c$, $c$function somarAoTotal(n) {
  let total = 10;
  total += n;
  return total;
}$c$, $c$total =+ n guarda o valor +n em total, apagando o 10. O operador de soma e atribuição é +=.$c$),
  ($c$atrib-aplicar-desconto$c$, $c$function aplicarDesconto(preco, percentual) {
  const desconto = preco * percentual / 100;
  preco -= desconto;
  return preco;
}$c$, $c$O desconto é preco * percentual / 100. Com preco -= desconto, o preço é atualizado e devolvido.$c$),
  ($c$rel-pode-votar$c$, $c$function podeVotar(idade) {
  return idade >= 16;
}$c$, $c$idade >= 16 resulta em true ou false, que é exatamente o que a função deve devolver.$c$),
  ($c$rel-corrija-a-igualdade$c$, $c$function saoIguais(a, b) {
  return a === b;
}$c$, $c$O == converte os tipos antes de comparar (5 == "5" e 0 == false são true). O === exige o mesmo tipo.$c$),
  ($c$log-pode-entrar$c$, $c$function podeEntrar(idade, temIngresso) {
  return idade >= 18 && temIngresso;
}$c$, $c$idade >= 18 && temIngresso só é true quando a comparação e temIngresso forem verdadeiros ao mesmo tempo.$c$),
  ($c$log-corrija-o-intervalo$c$, $c$function foraDoIntervalo(n) {
  return n < 0 || n > 100;
}$c$, $c$Com &&, as duas condições precisam valer juntas, o que nunca acontece. Com ||, basta que uma delas seja verdadeira.$c$),
  ($c$prec-celsius-para-fahrenheit$c$, $c$function fahrenheit(c) {
  return c * 9 / 5 + 32;
}$c$, $c$c * 9 / 5 + 32 faz a multiplicação e a divisão (da esquerda para a direita) antes de somar 32.$c$),
  ($c$prec-corrija-a-media$c$, $c$function media(a, b) {
  return (a + b) / 2;
}$c$, $c$Sem parênteses, só o b é dividido por 2. A média é (a + b) / 2.$c$),
  ($c$desafio3-calculadora$c$, $c$function calculadora() {
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  console.log("Soma:", a + b);
  console.log("Subtração:", a - b);
  console.log("Multiplicação:", a * b);
  console.log("Divisão:", a / b);
  console.log("Resto:", a % b);
  console.log("Divisão por zero?", b === 0);
}$c$, $c$O programa converte as entradas, calcula cada operação e mostra o resultado. Com divisor 0 a divisão dá Infinity e o resto dá NaN, e a comparação b === 0 avisa o problema.$c$),
  ($c$desafio3-corrija-a-aprovacao$c$, $c$function aprovado(n1, n2, frequencia) {
  const media = (n1 + n2) / 2;
  return media >= 7 && frequencia >= 75;
}$c$, $c$Sem parênteses, só n2 era dividido por 2. A média correta é (n1 + n2) / 2, e o restante da função, com &&, já estava certo.$c$),
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
  ($c$revrel-nota-passou$c$, $c$function passou(nota) {
  return nota >= 7;
}$c$, $c$nota >= 7 compara e devolve o booleano que a função deve retornar.$c$),
  ($c$revrel-corrija-o-igual$c$, $c$function ehDez(n) {
  return n === 10;
}$c$, $c$n = 10 guarda 10 em n e devolve 10. Para comparar, usamos ===: n === 10.$c$),
  ($c$revlog-tem-desconto$c$, $c$function temDesconto(idade) {
  return idade < 12 || idade >= 60;
}$c$, $c$idade < 12 || idade >= 60 é true quando a pessoa é criança ou idosa.$c$),
  ($c$revlog-corrija-o-fim-de-semana$c$, $c$function ehFimDeSemana(dia) {
  return dia === "sábado" || dia === "domingo";
}$c$, $c$Com &&, o dia teria que ser igual aos dois valores ao mesmo tempo, o que nunca acontece. Com ||, basta ser um dos dois.$c$),
  ($c$if-bonus-de-vendas$c$, $c$function bonus(vendas) {
  let valor = 0;
  if (vendas >= 1000) {
    valor = 100;
  }
  return valor;
}$c$, $c$O valor começa em 0 e o if o troca por 100 apenas quando vendas >= 1000.$c$),
  ($c$if-corrija-o-ponto-e-virgula$c$, $c$function classificar(idade) {
  let texto = "menor";
  if (idade >= 18) {
    texto = "maior";
  }
  return texto;
}$c$, $c$O ; depois da condição encerra o if (vazio), e o bloco seguinte passa a executar sempre. Sem o ;, o bloco pertence ao if.$c$),
  ($c$if-corrija-a-atribuicao$c$, $c$function ehDezoito(idade) {
  if (idade === 18) {
    return true;
  }
  return false;
}$c$, $c$idade = 18 guarda 18 na variável e a condição passa a valer 18 (verdadeira) sempre. Para comparar, use ===$c$),
  ($c$ifelse-par-ou-impar-funcao$c$, $c$function parOuImpar(n) {
  if (n % 2 === 0) {
    return "par";
  } else {
    return "impar";
  }
}$c$, $c$n % 2 === 0 identifica os pares. O else cobre todos os outros números (inclusive negativos ímpares).$c$),
  ($c$ifelse-o-maior-de-dois$c$, $c$function maior(a, b) {
  if (a > b) {
    return a;
  } else {
    return b;
  }
}$c$, $c$Se a > b, o maior é a; no caso contrário (inclusive empate), b serve.$c$),
  ($c$ifelse-corrija-o-else-que-faltou$c$, $c$function situacao(nota) {
  let texto = "";
  if (nota >= 7) {
    texto = "aprovado";
  } else {
    texto = "reprovado";
  }
  return texto;
}$c$, $c$A atribuição de "reprovado" ficava depois do if e sobrescrevia o resultado. Colocando-a dentro de um else, ela só executa quando a nota é menor que 7.$c$),
  ($c$elseif-classificar-nota$c$, $c$function classificarNota(nota) {
  if (nota >= 9) {
    return "A";
  } else if (nota >= 7) {
    return "B";
  } else if (nota >= 5) {
    return "C";
  } else {
    return "D";
  }
}$c$, $c$As condições vão da maior faixa para a menor, e o else cobre as notas abaixo de 5.$c$),
  ($c$elseif-sinal-do-numero$c$, $c$function sinal(n) {
  if (n > 0) {
    return "positivo";
  } else if (n < 0) {
    return "negativo";
  } else {
    return "zero";
  }
}$c$, $c$if (n > 0) cobre os positivos, else if (n < 0) os negativos, e o else, o zero.$c$),
  ($c$elseif-corrija-a-ordem$c$, $c$function faixa(nota) {
  if (nota >= 7) {
    return "Bom";
  } else if (nota >= 5) {
    return "Regular";
  } else {
    return "Insuficiente";
  }
}$c$, $c$nota >= 5 é verdadeira também para 8, então a faixa Bom nunca era alcançada. Testando >= 7 antes de >= 5, cada nota cai na faixa certa.$c$),
  ($c$aninhada-desconto-do-ingresso$c$, $c$function descontoDoIngresso(idade, estudante) {
  if (idade < 18) {
    return 100;
  } else {
    if (estudante) {
      return 50;
    } else {
      return 0;
    }
  }
}$c$, $c$Se a pessoa tem menos de 18 anos, o desconto é 100. Caso contrário, dentro do else, o desconto depende de ser estudante.$c$),
  ($c$aninhada-corrija-o-else-interno$c$, $c$function acesso(idade, temIngresso) {
  if (idade >= 18) {
    if (temIngresso) {
      return "entrou";
    } else {
      return "sem ingresso";
    }
  } else {
    return "menor";
  }
}$c$, $c$Faltava um else para o if interno: sem ele, o adulto sem ingresso não passava por nenhum return.$c$),
  ($c$switch-nome-do-dia$c$, $c$function nomeDoDia(numero) {
  switch (numero) {
    case 1:
      return "domingo";
    case 2:
      return "segunda";
    case 3:
      return "terca";
    case 4:
      return "quarta";
    case 5:
      return "quinta";
    case 6:
      return "sexta";
    case 7:
      return "sabado";
    default:
      return "invalido";
  }
}$c$, $c$Cada case devolve o nome; como return já encerra a função, o break não é necessário. O default trata os números fora da lista.$c$),
  ($c$switch-calculadora-de-operacao$c$, $c$function calcular(operacao, a, b) {
  switch (operacao) {
    case "+":
      return a + b;
    case "-":
      return a - b;
    case "*":
      return a * b;
    case "/":
      return a / b;
    default:
      return "operacao invalida";
  }
}$c$, $c$O switch compara o texto da operação com cada case. O default devolve a mensagem para operações desconhecidas.$c$),
  ($c$switch-corrija-o-break$c$, $c$function tipo(codigo) {
  let t = "";
  switch (codigo) {
    case 1:
      t = "fruta";
      break;
    case 2:
      t = "legume";
      break;
    default:
      t = "outro";
  }
  return t;
}$c$, $c$Sem break, a execução cai para os cases seguintes e o último valor (outro) sobrescreve os anteriores. Um break depois de cada atribuição resolve.$c$),
  ($c$ternario-par-ou-impar$c$, $c$function parOuImpar(n) {
  return n % 2 === 0 ? "par" : "impar";
}$c$, $c$O ternário escolhe o valor a devolver conforme n % 2 === 0.$c$),
  ($c$ternario-valor-absoluto$c$, $c$function absoluto(n) {
  return n < 0 ? -n : n;
}$c$, $c$Quando n < 0, o oposto -n é positivo; caso contrário, o próprio n já serve.$c$),
  ($c$ternario-corrija-a-ordem$c$, $c$function situacao(nota) {
  return nota >= 7 ? "aprovado" : "reprovado";
}$c$, $c$O valor depois do ? é usado quando a condição é verdadeira. Os dois textos estavam trocados.$c$),
  ($c$desafio4-sistema-de-notas$c$, $c$function sistemaDeNotas() {
  const n1 = Number(lerEntrada());
  const n2 = Number(lerEntrada());
  const n3 = Number(lerEntrada());
  const media = (n1 + n2 + n3) / 3;
  let situacao;
  if (media >= 7) {
    situacao = "Aprovado";
  } else if (media >= 5) {
    situacao = "Recuperação";
  } else {
    situacao = "Reprovado";
  }
  console.log("Média:", media);
  console.log("Situação:", situacao);
}$c$, $c$Depois de converter as entradas e calcular a média, a cadeia if / else if / else escolhe a situação. Os testes de fronteira (7 e 5) conferem se o >= foi usado corretamente.$c$),
  ($c$desafio4-corrija-o-desconto$c$, $c$function desconto(valor, cliente) {
  if (valor >= 100) {
    if (cliente === "vip") {
      return valor * 0.8;
    } else {
      return valor * 0.9;
    }
  } else {
    return valor;
  }
}$c$, $c$O desconto só existe a partir de 100; dentro dessa faixa, o cliente vip tem 20% e os demais 10%. A estrutura original decidia pelo valor e só olhava o cliente quando o valor era menor.$c$),
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
  select id from public.exercises where origem = 'arquivo' and id in ($c$o-que-e-algoritmo$c$, $c$ordem-das-instrucoes$c$, $c$valor-da-variavel$c$, $c$completar-condicional$c$, $c$completar-laco$c$, $c$tipos-de-dados$c$, $c$precedencia-operadores$c$, $c$resto-da-divisao$c$, $c$exemplo-interpretacao$c$, $c$exemplo-ordenacao$c$, $c$exemplo-corrigir$c$, $c$exemplo-entrada-saida$c$, $c$prog-o-que-e-programar$c$, $c$prog-quem-e-quem$c$, $c$prog-complete-ola-mundo$c$, $c$prog-ordem-das-instrucoes$c$, $c$prog-texto-ou-conta$c$, $c$prog-quem-responde-pelo-erro$c$, $c$logica-o-que-e$c$, $c$logica-deducao-simples$c$, $c$logica-se-entao-senao$c$, $c$logica-calculo-do-troco$c$, $c$logica-quem-pode-entrar$c$, $c$logica-etapas-do-raciocinio$c$, $c$logica-raciocinio-invertido$c$, $c$algoritmo-qual-e-algoritmo$c$, $c$algoritmo-o-que-nao-precisa$c$, $c$algoritmo-trocar-lampada$c$, $c$algoritmo-contar-ate-tres$c$, $c$algoritmo-instrucao-clara$c$, $c$algoritmo-que-nunca-termina$c$, $c$sequencia-escovar-os-dentes$c$, $c$sequencia-por-que-importa$c$, $c$sequencia-abc$c$, $c$sequencia-ordem-do-programa$c$, $c$sequencia-macarrao$c$, $c$sequencia-saque-no-caixa$c$, $c$eps-o-que-e-entrada$c$, $c$eps-classificar-saida$c$, $c$eps-eco$c$, $c$eps-quais-sao-entrada$c$, $c$eps-qual-e-o-processamento$c$, $c$eps-dobro$c$, $c$eps-soma-de-entradas$c$, $c$pseudo-o-que-e$c$, $c$pseudo-comando-de-saida$c$, $c$pseudo-complete-saudacao$c$, $c$pseudo-soma$c$, $c$pseudo-desconto$c$, $c$pseudo-ordene-o-algoritmo$c$, $c$fluxo-simbolo-da-decisao$c$, $c$fluxo-o-que-as-setas-indicam$c$, $c$fluxo-simbolo-da-entrada$c$, $c$fluxo-dobro$c$, $c$fluxo-maior-de-idade$c$, $c$fluxo-guarda-chuva$c$, $c$desafio1-trocar-o-pneu$c$, $c$desafio1-pseudocodigo-da-media$c$, $c$desafio1-aprovado-ou-nao$c$, $c$tamanho-do-texto$c$, $c$completar-texto$c$, $c$inverter-texto$c$, $c$conta-vogais$c$, $c$palindromo$c$, $c$variaveis-o-que-e$c$, $c$variaveis-mostrar-valor$c$, $c$variaveis-complete-idade$c$, $c$variaveis-trocar-o-valor$c$, $c$variaveis-ordene-o-programa$c$, $c$variaveis-sinal-de-igual$c$, $c$variaveis-copia-de-valor$c$, $c$declaracao-nome-valido$c$, $c$declaracao-linha-correta$c$, $c$declaracao-complete$c$, $c$declaracao-sem-valor$c$, $c$declaracao-maiuscula-minuscula$c$, $c$declaracao-corrija-o-nome$c$, $c$declaracao-so-nomes-validos$c$, $c$letconst-palavra-que-muda$c$, $c$letconst-quando-usar-const$c$, $c$letconst-complete$c$, $c$letconst-alterando-const$c$, $c$letconst-somando-pontos$c$, $c$letconst-corrija-a-area$c$, $c$letconst-qual-funciona$c$, $c$string-qual-e-texto$c$, $c$string-typeof-numero-entre-aspas$c$, $c$string-complete-as-aspas$c$, $c$string-typeof-true-entre-aspas$c$, $c$string-aspas-dentro-do-texto$c$, $c$string-corrija-as-aspas$c$, $c$string-por-que-sao-diferentes$c$, $c$number-como-escrever-decimal$c$, $c$number-typeof-decimal$c$, $c$number-complete-a-altura$c$, $c$number-divisao-decimal$c$, $c$number-o-que-e-nan$c$, $c$number-media-de-dois$c$, $c$number-contas-especiais$c$, $c$boolean-quais-sao-os-valores$c$, $c$boolean-comparacao-simples$c$, $c$boolean-complete-sem-desconto$c$, $c$boolean-qual-e-boolean$c$, $c$boolean-idade-minima$c$, $c$boolean-tres-typeof$c$, $c$boolean-igualdade$c$, $c$textos-propriedade-do-tamanho$c$, $c$textos-tamanho-de-casa$c$, $c$textos-complete-maiusculas$c$, $c$textos-indices-de-banana$c$, $c$textos-recorte-com-slice$c$, $c$textos-email$c$, $c$textos-inicial-em-maiuscula$c$, $c$concat-operador$c$, $c$concat-bom-dia$c$, $c$concat-complete-ola$c$, $c$concat-texto-e-numero$c$, $c$concat-ordene-a-saudacao$c$, $c$concat-idade-na-frase$c$, $c$concat-da-esquerda-para-a-direita$c$, $c$concat-nome-completo$c$, $c$template-qual-simbolo$c$, $c$template-oi-beto$c$, $c$template-complete$c$, $c$template-conta-dentro$c$, $c$template-qual-linha$c$, $c$template-corrija-a-saudacao$c$, $c$template-apresentar$c$, $c$template-soma-na-frase$c$, $c$operacoes-resto$c$, $c$operacoes-resto-de-sete$c$, $c$operacoes-area-do-quadrado$c$, $c$operacoes-media-de-duas-notas$c$, $c$operacoes-media-de-tres$c$, $c$operacoes-porcentagem$c$, $c$operacoes-precedencia-e-arredondamento$c$, $c$conversao-qual-funcao$c$, $c$conversao-tipo-depois-de-number$c$, $c$conversao-complete$c$, $c$conversao-texto-ou-numero$c$, $c$conversao-resultados$c$, $c$conversao-corrija-a-soma$c$, $c$conversao-somar-entradas$c$, $c$conversao-multiplicar-e-somar$c$, $c$es-comando-de-entrada$c$, $c$es-ola-nome$c$, $c$es-boas-vindas$c$, $c$es-entradas-sao-texto$c$, $c$es-ordene-o-programa$c$, $c$es-area-do-retangulo$c$, $c$es-corrija-o-ano-que-vem$c$, $c$es-media-das-notas$c$, $c$log-varias-chamadas$c$, $c$log-com-virgula$c$, $c$log-complete-a-media$c$, $c$log-texto-ou-conta$c$, $c$log-mostrar-os-dados$c$, $c$log-operacoes-em-linhas$c$, $c$log-corrija-o-total$c$, $c$log-quatro-linhas$c$, $c$desafio2-ficha-da-pessoa$c$, $c$desafio2-corrija-o-resumo$c$, $c$desafio2-tipos-e-conversoes$c$, $c$soma$c$, $c$media$c$, $c$celsius$c$, $c$area-retangulo$c$, $c$quadrado$c$, $c$media-ponderada$c$, $c$completar-media$c$, $c$op-intro-quem-e-o-operador$c$, $c$op-intro-grupo-relacional$c$, $c$op-intro-complete-a-conta$c$, $c$op-intro-soma-e-comparacao$c$, $c$op-intro-resultado-boolean$c$, $c$op-intro-operador-unario$c$, $c$op-intro-varios-grupos$c$, $c$arit-operador-da-potencia$c$, $c$arit-resto-de-vinte-por-seis$c$, $c$arit-complete-o-resto$c$, $c$arit-tres-contas$c$, $c$arit-ultimo-digito$c$, $c$arit-parte-inteira$c$, $c$arit-corrija-o-quadrado$c$, $c$arit-divisao-por-zero$c$, $c$atrib-o-que-faz-o-mais-igual$c$, $c$atrib-somar-cinco$c$, $c$atrib-complete-o-contador$c$, $c$atrib-varias-atualizacoes$c$, $c$atrib-forma-equivalente$c$, $c$atrib-corrija-o-total$c$, $c$atrib-aplicar-desconto$c$, $c$atrib-texto-e-numero$c$, $c$rel-operador-de-igualdade$c$, $c$rel-maior-ou-igual$c$, $c$rel-complete-a-comparacao$c$, $c$rel-igual-estrito-e-frouxo$c$, $c$rel-qual-linha-compara$c$, $c$rel-pode-votar$c$, $c$rel-corrija-a-igualdade$c$, $c$rel-comparando-textos$c$, $c$rel-textos-de-numeros-e-decimais$c$, $c$log-qual-e-o-e$c$, $c$log-o-que-e-o-ou$c$, $c$log-true-e-false$c$, $c$log-complete-o-ou$c$, $c$log-quatro-combinacoes$c$, $c$log-pode-entrar$c$, $c$log-comparacoes-combinadas$c$, $c$log-entre-dois-valores$c$, $c$log-corrija-o-intervalo$c$, $c$log-precedencia-dos-logicos$c$, $c$prec-o-que-vem-primeiro$c$, $c$prec-dois-mais-tres-vezes-quatro$c$, $c$prec-complete-os-parenteses$c$, $c$prec-esquerda-direita$c$, $c$prec-contas-e-comparacoes$c$, $c$prec-qual-expressao-da-24$c$, $c$prec-celsius-para-fahrenheit$c$, $c$prec-corrija-a-media$c$, $c$prec-logicos-e-parenteses$c$, $c$desafio3-calculadora$c$, $c$desafio3-corrija-a-aprovacao$c$, $c$desafio3-acompanhe-o-saldo$c$, $c$par-ou-impar$c$, $c$maior-de-tres$c$, $c$nota$c$, $c$bissexto$c$, $c$operadores-logicos$c$, $c$completar-else-if$c$, $c$dentro-do-intervalo$c$, $c$tipo-de-triangulo$c$, $c$cond-intro-para-que-serve$c$, $c$cond-intro-o-que-a-condicao-resulta$c$, $c$cond-intro-condicao-verdadeira$c$, $c$cond-intro-complete-o-if$c$, $c$cond-intro-condicao-falsa$c$, $c$cond-intro-condicao-invalida$c$, $c$cond-intro-ordene-o-if$c$, $c$cond-intro-dois-ifs-seguidos$c$, $c$revrel-pelo-menos$c$, $c$revrel-diferente$c$, $c$revrel-maiusculas-contam$c$, $c$revrel-nota-passou$c$, $c$revrel-corrija-o-igual$c$, $c$revrel-texto-ou-numero$c$, $c$revrel-casos-estranhos$c$, $c$revlog-entre-dois-valores$c$, $c$revlog-crianca-ou-idoso$c$, $c$revlog-tabela-verdade$c$, $c$revlog-tem-desconto$c$, $c$revlog-corrija-o-fim-de-semana$c$, $c$revlog-parenteses-mudam-o-resultado$c$, $c$revlog-de-morgan$c$, $c$if-forma-correta$c$, $c$if-nota-oito$c$, $c$if-complete-a-condicao$c$, $c$if-dois-blocos-independentes$c$, $c$if-bonus-de-vendas$c$, $c$if-corrija-o-ponto-e-virgula$c$, $c$if-corrija-a-atribuicao$c$, $c$if-somando-pontos$c$, $c$ifelse-o-que-faz-o-else$c$, $c$ifelse-par-ou-impar$c$, $c$ifelse-complete-o-else$c$, $c$ifelse-reprovado$c$, $c$ifelse-par-ou-impar-funcao$c$, $c$ifelse-o-maior-de-dois$c$, $c$ifelse-corrija-o-else-que-faltou$c$, $c$ifelse-dois-pares-de-blocos$c$, $c$elseif-quantos-blocos-executam$c$, $c$elseif-escala-de-notas$c$, $c$elseif-complete-a-cadeia$c$, $c$elseif-ordem-errada$c$, $c$elseif-classificar-nota$c$, $c$elseif-sinal-do-numero$c$, $c$elseif-corrija-a-ordem$c$, $c$elseif-versus-ifs-separados$c$, $c$aninhada-o-que-e$c$, $c$aninhada-sem-ingresso$c$, $c$aninhada-complete-o-if-interno$c$, $c$aninhada-menor-de-idade$c$, $c$aninhada-desconto-do-ingresso$c$, $c$aninhada-corrija-o-else-interno$c$, $c$aninhada-equivalente-com-e$c$, $c$aninhada-tres-niveis$c$, $c$switch-quando-usar$c$, $c$switch-dia-da-semana$c$, $c$switch-complete-o-break$c$, $c$switch-sem-break$c$, $c$switch-nome-do-dia$c$, $c$switch-calculadora-de-operacao$c$, $c$switch-corrija-o-break$c$, $c$switch-igualdade-estrita$c$, $c$ternario-o-que-e$c$, $c$ternario-situacao$c$, $c$ternario-complete-os-simbolos$c$, $c$ternario-par-ou-impar$c$, $c$ternario-valor-absoluto$c$, $c$ternario-corrija-a-ordem$c$, $c$ternario-aninhado$c$, $c$desafio4-sistema-de-notas$c$, $c$desafio4-corrija-o-desconto$c$, $c$desafio4-acompanhe-as-decisoes$c$, $c$somatorio$c$, $c$fatorial$c$, $c$tabuada$c$, $c$primo$c$, $c$quantas-vezes$c$, $c$completar-while$c$, $c$soma-dos-pares$c$, $c$potencia$c$, $c$conta-digitos$c$, $c$mdc$c$, $c$soma-vetor$c$, $c$inverter-vetor$c$, $c$maior-vetor$c$, $c$busca-linear$c$, $c$ordenar$c$, $c$indice-do-vetor$c$, $c$completar-percorrer$c$, $c$conta-pares$c$, $c$media-do-vetor$c$, $c$segundo-maior$c$, $c$parametro-e-retorno$c$, $c$completar-funcao$c$, $c$escopo-de-variavel$c$, $c$maior-de-dois$c$, $c$hipotenusa$c$)
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
  ($c$variaveis-o-que-e$c$, $c$m2-introducao-variaveis$c$, 3),
  ($c$variaveis-mostrar-valor$c$, $c$m2-introducao-variaveis$c$, 3),
  ($c$variaveis-complete-idade$c$, $c$m2-introducao-variaveis$c$, 2),
  ($c$variaveis-trocar-o-valor$c$, $c$m2-introducao-variaveis$c$, 3),
  ($c$variaveis-ordene-o-programa$c$, $c$m2-introducao-variaveis$c$, 3),
  ($c$variaveis-ordene-o-programa$c$, $c$m1-sequencia$c$, 1),
  ($c$variaveis-sinal-de-igual$c$, $c$m2-introducao-variaveis$c$, 3),
  ($c$variaveis-copia-de-valor$c$, $c$m2-introducao-variaveis$c$, 3),
  ($c$declaracao-nome-valido$c$, $c$m2-declaracao$c$, 3),
  ($c$declaracao-linha-correta$c$, $c$m2-declaracao$c$, 3),
  ($c$declaracao-complete$c$, $c$m2-declaracao$c$, 2),
  ($c$declaracao-complete$c$, $c$m2-introducao-variaveis$c$, 1),
  ($c$declaracao-sem-valor$c$, $c$m2-declaracao$c$, 3),
  ($c$declaracao-maiuscula-minuscula$c$, $c$m2-declaracao$c$, 3),
  ($c$declaracao-corrija-o-nome$c$, $c$m2-declaracao$c$, 3),
  ($c$declaracao-corrija-o-nome$c$, $c$m7-return$c$, 1),
  ($c$declaracao-so-nomes-validos$c$, $c$m2-declaracao$c$, 3),
  ($c$letconst-palavra-que-muda$c$, $c$m2-let-const$c$, 3),
  ($c$letconst-quando-usar-const$c$, $c$m2-let-const$c$, 3),
  ($c$letconst-complete$c$, $c$m2-let-const$c$, 3),
  ($c$letconst-alterando-const$c$, $c$m2-let-const$c$, 3),
  ($c$letconst-somando-pontos$c$, $c$m2-let-const$c$, 2),
  ($c$letconst-somando-pontos$c$, $c$m2-introducao-variaveis$c$, 1),
  ($c$letconst-corrija-a-area$c$, $c$m2-let-const$c$, 3),
  ($c$letconst-corrija-a-area$c$, $c$m2-number$c$, 1),
  ($c$letconst-qual-funciona$c$, $c$m2-let-const$c$, 3),
  ($c$letconst-qual-funciona$c$, $c$m2-declaracao$c$, 1),
  ($c$string-qual-e-texto$c$, $c$m2-string$c$, 3),
  ($c$string-typeof-numero-entre-aspas$c$, $c$m2-string$c$, 3),
  ($c$string-complete-as-aspas$c$, $c$m2-string$c$, 2),
  ($c$string-typeof-true-entre-aspas$c$, $c$m2-string$c$, 3),
  ($c$string-typeof-true-entre-aspas$c$, $c$m2-boolean$c$, 1),
  ($c$string-aspas-dentro-do-texto$c$, $c$m2-string$c$, 3),
  ($c$string-corrija-as-aspas$c$, $c$m2-string$c$, 3),
  ($c$string-por-que-sao-diferentes$c$, $c$m2-string$c$, 3),
  ($c$string-por-que-sao-diferentes$c$, $c$m2-number$c$, 1),
  ($c$number-como-escrever-decimal$c$, $c$m2-number$c$, 3),
  ($c$number-typeof-decimal$c$, $c$m2-number$c$, 3),
  ($c$number-complete-a-altura$c$, $c$m2-number$c$, 2),
  ($c$number-divisao-decimal$c$, $c$m2-number$c$, 3),
  ($c$number-o-que-e-nan$c$, $c$m2-number$c$, 3),
  ($c$number-media-de-dois$c$, $c$m2-number$c$, 2),
  ($c$number-media-de-dois$c$, $c$m2-operacoes-numeros$c$, 1),
  ($c$number-contas-especiais$c$, $c$m2-number$c$, 3),
  ($c$boolean-quais-sao-os-valores$c$, $c$m2-boolean$c$, 3),
  ($c$boolean-comparacao-simples$c$, $c$m2-boolean$c$, 3),
  ($c$boolean-complete-sem-desconto$c$, $c$m2-boolean$c$, 2),
  ($c$boolean-qual-e-boolean$c$, $c$m2-boolean$c$, 3),
  ($c$boolean-qual-e-boolean$c$, $c$m2-string$c$, 1),
  ($c$boolean-idade-minima$c$, $c$m2-boolean$c$, 3),
  ($c$boolean-idade-minima$c$, $c$m2-introducao-variaveis$c$, 1),
  ($c$boolean-tres-typeof$c$, $c$m2-boolean$c$, 2),
  ($c$boolean-tres-typeof$c$, $c$m2-string$c$, 1),
  ($c$boolean-tres-typeof$c$, $c$m2-number$c$, 1),
  ($c$boolean-igualdade$c$, $c$m2-boolean$c$, 3),
  ($c$boolean-igualdade$c$, $c$m2-introducao-variaveis$c$, 1),
  ($c$textos-propriedade-do-tamanho$c$, $c$m2-manipulacao-textos$c$, 3),
  ($c$textos-tamanho-de-casa$c$, $c$m2-manipulacao-textos$c$, 3),
  ($c$textos-complete-maiusculas$c$, $c$m2-manipulacao-textos$c$, 2),
  ($c$textos-indices-de-banana$c$, $c$m2-manipulacao-textos$c$, 3),
  ($c$textos-recorte-com-slice$c$, $c$m2-manipulacao-textos$c$, 3),
  ($c$textos-email$c$, $c$m2-manipulacao-textos$c$, 3),
  ($c$textos-inicial-em-maiuscula$c$, $c$m2-manipulacao-textos$c$, 3),
  ($c$concat-operador$c$, $c$m2-concatenacao$c$, 3),
  ($c$concat-bom-dia$c$, $c$m2-concatenacao$c$, 3),
  ($c$concat-complete-ola$c$, $c$m2-concatenacao$c$, 2),
  ($c$concat-texto-e-numero$c$, $c$m2-concatenacao$c$, 3),
  ($c$concat-texto-e-numero$c$, $c$m2-number$c$, 1),
  ($c$concat-ordene-a-saudacao$c$, $c$m2-concatenacao$c$, 2),
  ($c$concat-ordene-a-saudacao$c$, $c$m1-sequencia$c$, 1),
  ($c$concat-idade-na-frase$c$, $c$m2-concatenacao$c$, 3),
  ($c$concat-da-esquerda-para-a-direita$c$, $c$m2-concatenacao$c$, 3),
  ($c$concat-da-esquerda-para-a-direita$c$, $c$m2-number$c$, 1),
  ($c$concat-nome-completo$c$, $c$m2-concatenacao$c$, 3),
  ($c$concat-nome-completo$c$, $c$m1-algoritmos$c$, 1),
  ($c$template-qual-simbolo$c$, $c$m2-template-literals$c$, 3),
  ($c$template-oi-beto$c$, $c$m2-template-literals$c$, 3),
  ($c$template-complete$c$, $c$m2-template-literals$c$, 2),
  ($c$template-conta-dentro$c$, $c$m2-template-literals$c$, 3),
  ($c$template-conta-dentro$c$, $c$m2-operacoes-numeros$c$, 1),
  ($c$template-qual-linha$c$, $c$m2-template-literals$c$, 3),
  ($c$template-corrija-a-saudacao$c$, $c$m2-template-literals$c$, 3),
  ($c$template-apresentar$c$, $c$m2-template-literals$c$, 3),
  ($c$template-apresentar$c$, $c$m2-concatenacao$c$, 1),
  ($c$template-soma-na-frase$c$, $c$m2-template-literals$c$, 3),
  ($c$template-soma-na-frase$c$, $c$m2-operacoes-numeros$c$, 1),
  ($c$operacoes-resto$c$, $c$m2-operacoes-numeros$c$, 3),
  ($c$operacoes-resto-de-sete$c$, $c$m2-operacoes-numeros$c$, 3),
  ($c$operacoes-area-do-quadrado$c$, $c$m2-operacoes-numeros$c$, 2),
  ($c$operacoes-media-de-duas-notas$c$, $c$m2-operacoes-numeros$c$, 3),
  ($c$operacoes-media-de-duas-notas$c$, $c$m2-number$c$, 1),
  ($c$operacoes-media-de-tres$c$, $c$m2-operacoes-numeros$c$, 3),
  ($c$operacoes-media-de-tres$c$, $c$m2-number$c$, 1),
  ($c$operacoes-porcentagem$c$, $c$m2-operacoes-numeros$c$, 3),
  ($c$operacoes-porcentagem$c$, $c$m2-number$c$, 1),
  ($c$operacoes-precedencia-e-arredondamento$c$, $c$m2-operacoes-numeros$c$, 3),
  ($c$conversao-qual-funcao$c$, $c$m2-conversao-tipos$c$, 3),
  ($c$conversao-tipo-depois-de-number$c$, $c$m2-conversao-tipos$c$, 3),
  ($c$conversao-complete$c$, $c$m2-conversao-tipos$c$, 2),
  ($c$conversao-texto-ou-numero$c$, $c$m2-conversao-tipos$c$, 3),
  ($c$conversao-texto-ou-numero$c$, $c$m2-concatenacao$c$, 1),
  ($c$conversao-resultados$c$, $c$m2-conversao-tipos$c$, 3),
  ($c$conversao-resultados$c$, $c$m2-number$c$, 1),
  ($c$conversao-corrija-a-soma$c$, $c$m2-conversao-tipos$c$, 3),
  ($c$conversao-corrija-a-soma$c$, $c$m2-concatenacao$c$, 1),
  ($c$conversao-somar-entradas$c$, $c$m2-conversao-tipos$c$, 3),
  ($c$conversao-somar-entradas$c$, $c$m2-entrada-saida$c$, 2),
  ($c$conversao-multiplicar-e-somar$c$, $c$m2-conversao-tipos$c$, 3),
  ($c$conversao-multiplicar-e-somar$c$, $c$m2-concatenacao$c$, 2),
  ($c$es-comando-de-entrada$c$, $c$m2-entrada-saida$c$, 3),
  ($c$es-ola-nome$c$, $c$m2-entrada-saida$c$, 3),
  ($c$es-ola-nome$c$, $c$m2-concatenacao$c$, 1),
  ($c$es-boas-vindas$c$, $c$m2-entrada-saida$c$, 3),
  ($c$es-boas-vindas$c$, $c$m2-template-literals$c$, 1),
  ($c$es-entradas-sao-texto$c$, $c$m2-entrada-saida$c$, 3),
  ($c$es-entradas-sao-texto$c$, $c$m2-conversao-tipos$c$, 2),
  ($c$es-ordene-o-programa$c$, $c$m2-entrada-saida$c$, 3),
  ($c$es-ordene-o-programa$c$, $c$m1-sequencia$c$, 2),
  ($c$es-area-do-retangulo$c$, $c$m2-entrada-saida$c$, 3),
  ($c$es-area-do-retangulo$c$, $c$m2-operacoes-numeros$c$, 2),
  ($c$es-area-do-retangulo$c$, $c$m2-template-literals$c$, 1),
  ($c$es-corrija-o-ano-que-vem$c$, $c$m2-entrada-saida$c$, 3),
  ($c$es-corrija-o-ano-que-vem$c$, $c$m2-conversao-tipos$c$, 3),
  ($c$es-media-das-notas$c$, $c$m2-entrada-saida$c$, 3),
  ($c$es-media-das-notas$c$, $c$m2-conversao-tipos$c$, 2),
  ($c$es-media-das-notas$c$, $c$m2-operacoes-numeros$c$, 2),
  ($c$es-media-das-notas$c$, $c$m2-template-literals$c$, 1),
  ($c$log-varias-chamadas$c$, $c$m2-console-log$c$, 3),
  ($c$log-com-virgula$c$, $c$m2-console-log$c$, 3),
  ($c$log-complete-a-media$c$, $c$m2-console-log$c$, 2),
  ($c$log-texto-ou-conta$c$, $c$m2-console-log$c$, 3),
  ($c$log-texto-ou-conta$c$, $c$m2-string$c$, 1),
  ($c$log-mostrar-os-dados$c$, $c$m2-console-log$c$, 3),
  ($c$log-mostrar-os-dados$c$, $c$m2-entrada-saida$c$, 2),
  ($c$log-operacoes-em-linhas$c$, $c$m2-console-log$c$, 3),
  ($c$log-operacoes-em-linhas$c$, $c$m2-operacoes-numeros$c$, 1),
  ($c$log-corrija-o-total$c$, $c$m2-console-log$c$, 3),
  ($c$log-corrija-o-total$c$, $c$m2-concatenacao$c$, 1),
  ($c$log-quatro-linhas$c$, $c$m2-console-log$c$, 3),
  ($c$log-quatro-linhas$c$, $c$m2-string$c$, 1),
  ($c$log-quatro-linhas$c$, $c$m2-concatenacao$c$, 1),
  ($c$desafio2-ficha-da-pessoa$c$, $c$m2-entrada-saida$c$, 2),
  ($c$desafio2-ficha-da-pessoa$c$, $c$m2-template-literals$c$, 2),
  ($c$desafio2-ficha-da-pessoa$c$, $c$m2-conversao-tipos$c$, 2),
  ($c$desafio2-ficha-da-pessoa$c$, $c$m2-introducao-variaveis$c$, 1),
  ($c$desafio2-ficha-da-pessoa$c$, $c$m2-let-const$c$, 1),
  ($c$desafio2-corrija-o-resumo$c$, $c$m2-conversao-tipos$c$, 3),
  ($c$desafio2-corrija-o-resumo$c$, $c$m2-concatenacao$c$, 2),
  ($c$desafio2-corrija-o-resumo$c$, $c$m2-entrada-saida$c$, 2),
  ($c$desafio2-tipos-e-conversoes$c$, $c$m2-conversao-tipos$c$, 2),
  ($c$desafio2-tipos-e-conversoes$c$, $c$m2-concatenacao$c$, 2),
  ($c$desafio2-tipos-e-conversoes$c$, $c$m2-string$c$, 1),
  ($c$desafio2-tipos-e-conversoes$c$, $c$m2-number$c$, 1),
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
  ($c$op-intro-quem-e-o-operador$c$, $c$m3-introducao-operadores$c$, 3),
  ($c$op-intro-grupo-relacional$c$, $c$m3-introducao-operadores$c$, 3),
  ($c$op-intro-complete-a-conta$c$, $c$m3-introducao-operadores$c$, 2),
  ($c$op-intro-soma-e-comparacao$c$, $c$m3-introducao-operadores$c$, 3),
  ($c$op-intro-soma-e-comparacao$c$, $c$m3-relacionais$c$, 1),
  ($c$op-intro-resultado-boolean$c$, $c$m3-introducao-operadores$c$, 3),
  ($c$op-intro-resultado-boolean$c$, $c$m3-relacionais$c$, 1),
  ($c$op-intro-operador-unario$c$, $c$m3-introducao-operadores$c$, 3),
  ($c$op-intro-operador-unario$c$, $c$m3-logicos$c$, 1),
  ($c$op-intro-varios-grupos$c$, $c$m3-introducao-operadores$c$, 3),
  ($c$op-intro-varios-grupos$c$, $c$m3-atribuicao$c$, 1),
  ($c$op-intro-varios-grupos$c$, $c$m3-relacionais$c$, 1),
  ($c$arit-operador-da-potencia$c$, $c$m3-aritmeticos$c$, 3),
  ($c$arit-resto-de-vinte-por-seis$c$, $c$m3-aritmeticos$c$, 3),
  ($c$arit-complete-o-resto$c$, $c$m3-aritmeticos$c$, 2),
  ($c$arit-tres-contas$c$, $c$m3-aritmeticos$c$, 3),
  ($c$arit-ultimo-digito$c$, $c$m3-aritmeticos$c$, 3),
  ($c$arit-parte-inteira$c$, $c$m3-aritmeticos$c$, 3),
  ($c$arit-corrija-o-quadrado$c$, $c$m3-aritmeticos$c$, 3),
  ($c$arit-divisao-por-zero$c$, $c$m3-aritmeticos$c$, 3),
  ($c$atrib-o-que-faz-o-mais-igual$c$, $c$m3-atribuicao$c$, 3),
  ($c$atrib-somar-cinco$c$, $c$m3-atribuicao$c$, 3),
  ($c$atrib-complete-o-contador$c$, $c$m3-atribuicao$c$, 2),
  ($c$atrib-varias-atualizacoes$c$, $c$m3-atribuicao$c$, 3),
  ($c$atrib-forma-equivalente$c$, $c$m3-atribuicao$c$, 3),
  ($c$atrib-corrija-o-total$c$, $c$m3-atribuicao$c$, 3),
  ($c$atrib-aplicar-desconto$c$, $c$m3-atribuicao$c$, 3),
  ($c$atrib-aplicar-desconto$c$, $c$m3-aritmeticos$c$, 2),
  ($c$atrib-texto-e-numero$c$, $c$m3-atribuicao$c$, 3),
  ($c$atrib-texto-e-numero$c$, $c$m2-concatenacao$c$, 1),
  ($c$rel-operador-de-igualdade$c$, $c$m3-relacionais$c$, 3),
  ($c$rel-maior-ou-igual$c$, $c$m3-relacionais$c$, 3),
  ($c$rel-complete-a-comparacao$c$, $c$m3-relacionais$c$, 2),
  ($c$rel-igual-estrito-e-frouxo$c$, $c$m3-relacionais$c$, 3),
  ($c$rel-qual-linha-compara$c$, $c$m3-relacionais$c$, 3),
  ($c$rel-qual-linha-compara$c$, $c$m3-atribuicao$c$, 1),
  ($c$rel-pode-votar$c$, $c$m3-relacionais$c$, 3),
  ($c$rel-corrija-a-igualdade$c$, $c$m3-relacionais$c$, 3),
  ($c$rel-comparando-textos$c$, $c$m3-relacionais$c$, 3),
  ($c$rel-comparando-textos$c$, $c$m2-string$c$, 1),
  ($c$rel-textos-de-numeros-e-decimais$c$, $c$m3-relacionais$c$, 3),
  ($c$rel-textos-de-numeros-e-decimais$c$, $c$m2-conversao-tipos$c$, 1),
  ($c$log-qual-e-o-e$c$, $c$m3-logicos$c$, 3),
  ($c$log-o-que-e-o-ou$c$, $c$m3-logicos$c$, 3),
  ($c$log-true-e-false$c$, $c$m3-logicos$c$, 3),
  ($c$log-complete-o-ou$c$, $c$m3-logicos$c$, 2),
  ($c$log-quatro-combinacoes$c$, $c$m3-logicos$c$, 3),
  ($c$log-pode-entrar$c$, $c$m3-logicos$c$, 3),
  ($c$log-pode-entrar$c$, $c$m3-relacionais$c$, 2),
  ($c$log-comparacoes-combinadas$c$, $c$m3-logicos$c$, 3),
  ($c$log-comparacoes-combinadas$c$, $c$m3-relacionais$c$, 2),
  ($c$log-entre-dois-valores$c$, $c$m3-logicos$c$, 3),
  ($c$log-entre-dois-valores$c$, $c$m3-relacionais$c$, 2),
  ($c$log-corrija-o-intervalo$c$, $c$m3-logicos$c$, 3),
  ($c$log-corrija-o-intervalo$c$, $c$m3-relacionais$c$, 2),
  ($c$log-precedencia-dos-logicos$c$, $c$m3-logicos$c$, 3),
  ($c$log-precedencia-dos-logicos$c$, $c$m3-precedencia$c$, 2),
  ($c$prec-o-que-vem-primeiro$c$, $c$m3-precedencia$c$, 3),
  ($c$prec-dois-mais-tres-vezes-quatro$c$, $c$m3-precedencia$c$, 3),
  ($c$prec-complete-os-parenteses$c$, $c$m3-precedencia$c$, 2),
  ($c$prec-esquerda-direita$c$, $c$m3-precedencia$c$, 3),
  ($c$prec-contas-e-comparacoes$c$, $c$m3-precedencia$c$, 3),
  ($c$prec-contas-e-comparacoes$c$, $c$m3-relacionais$c$, 2),
  ($c$prec-qual-expressao-da-24$c$, $c$m3-precedencia$c$, 3),
  ($c$prec-celsius-para-fahrenheit$c$, $c$m3-precedencia$c$, 3),
  ($c$prec-celsius-para-fahrenheit$c$, $c$m3-aritmeticos$c$, 2),
  ($c$prec-corrija-a-media$c$, $c$m3-precedencia$c$, 3),
  ($c$prec-corrija-a-media$c$, $c$m3-aritmeticos$c$, 2),
  ($c$prec-logicos-e-parenteses$c$, $c$m3-precedencia$c$, 3),
  ($c$prec-logicos-e-parenteses$c$, $c$m3-logicos$c$, 2),
  ($c$desafio3-calculadora$c$, $c$m3-aritmeticos$c$, 2),
  ($c$desafio3-calculadora$c$, $c$m3-relacionais$c$, 2),
  ($c$desafio3-calculadora$c$, $c$m3-precedencia$c$, 1),
  ($c$desafio3-calculadora$c$, $c$m2-entrada-saida$c$, 1),
  ($c$desafio3-calculadora$c$, $c$m2-conversao-tipos$c$, 1),
  ($c$desafio3-corrija-a-aprovacao$c$, $c$m3-precedencia$c$, 3),
  ($c$desafio3-corrija-a-aprovacao$c$, $c$m3-logicos$c$, 2),
  ($c$desafio3-corrija-a-aprovacao$c$, $c$m3-relacionais$c$, 1),
  ($c$desafio3-acompanhe-o-saldo$c$, $c$m3-atribuicao$c$, 2),
  ($c$desafio3-acompanhe-o-saldo$c$, $c$m3-relacionais$c$, 2),
  ($c$desafio3-acompanhe-o-saldo$c$, $c$m3-logicos$c$, 2),
  ($c$desafio3-acompanhe-o-saldo$c$, $c$m3-aritmeticos$c$, 1),
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
  ($c$cond-intro-para-que-serve$c$, $c$m4-introducao$c$, 3),
  ($c$cond-intro-o-que-a-condicao-resulta$c$, $c$m4-introducao$c$, 3),
  ($c$cond-intro-o-que-a-condicao-resulta$c$, $c$m3-relacionais$c$, 1),
  ($c$cond-intro-condicao-verdadeira$c$, $c$m4-introducao$c$, 3),
  ($c$cond-intro-complete-o-if$c$, $c$m4-introducao$c$, 2),
  ($c$cond-intro-complete-o-if$c$, $c$m4-if$c$, 1),
  ($c$cond-intro-condicao-falsa$c$, $c$m4-introducao$c$, 3),
  ($c$cond-intro-condicao-invalida$c$, $c$m4-introducao$c$, 3),
  ($c$cond-intro-condicao-invalida$c$, $c$m3-atribuicao$c$, 1),
  ($c$cond-intro-ordene-o-if$c$, $c$m4-introducao$c$, 3),
  ($c$cond-intro-ordene-o-if$c$, $c$m1-sequencia$c$, 1),
  ($c$cond-intro-dois-ifs-seguidos$c$, $c$m4-introducao$c$, 3),
  ($c$cond-intro-dois-ifs-seguidos$c$, $c$m3-relacionais$c$, 1),
  ($c$revrel-pelo-menos$c$, $c$m4-revisao-relacionais$c$, 3),
  ($c$revrel-pelo-menos$c$, $c$m3-relacionais$c$, 1),
  ($c$revrel-diferente$c$, $c$m4-revisao-relacionais$c$, 3),
  ($c$revrel-maiusculas-contam$c$, $c$m4-revisao-relacionais$c$, 3),
  ($c$revrel-maiusculas-contam$c$, $c$m2-string$c$, 1),
  ($c$revrel-nota-passou$c$, $c$m4-revisao-relacionais$c$, 3),
  ($c$revrel-nota-passou$c$, $c$m3-relacionais$c$, 2),
  ($c$revrel-corrija-o-igual$c$, $c$m4-revisao-relacionais$c$, 3),
  ($c$revrel-corrija-o-igual$c$, $c$m3-atribuicao$c$, 1),
  ($c$revrel-texto-ou-numero$c$, $c$m4-revisao-relacionais$c$, 3),
  ($c$revrel-texto-ou-numero$c$, $c$m3-relacionais$c$, 2),
  ($c$revrel-casos-estranhos$c$, $c$m4-revisao-relacionais$c$, 3),
  ($c$revrel-casos-estranhos$c$, $c$m3-relacionais$c$, 2),
  ($c$revlog-entre-dois-valores$c$, $c$m4-revisao-logicos$c$, 3),
  ($c$revlog-entre-dois-valores$c$, $c$m3-logicos$c$, 1),
  ($c$revlog-crianca-ou-idoso$c$, $c$m4-revisao-logicos$c$, 3),
  ($c$revlog-crianca-ou-idoso$c$, $c$m3-logicos$c$, 1),
  ($c$revlog-tabela-verdade$c$, $c$m4-revisao-logicos$c$, 3),
  ($c$revlog-tabela-verdade$c$, $c$m3-logicos$c$, 2),
  ($c$revlog-tem-desconto$c$, $c$m4-revisao-logicos$c$, 3),
  ($c$revlog-tem-desconto$c$, $c$m3-logicos$c$, 2),
  ($c$revlog-tem-desconto$c$, $c$m3-relacionais$c$, 1),
  ($c$revlog-corrija-o-fim-de-semana$c$, $c$m4-revisao-logicos$c$, 3),
  ($c$revlog-corrija-o-fim-de-semana$c$, $c$m3-logicos$c$, 2),
  ($c$revlog-parenteses-mudam-o-resultado$c$, $c$m4-revisao-logicos$c$, 3),
  ($c$revlog-parenteses-mudam-o-resultado$c$, $c$m3-precedencia$c$, 1),
  ($c$revlog-de-morgan$c$, $c$m4-revisao-logicos$c$, 3),
  ($c$revlog-de-morgan$c$, $c$m3-logicos$c$, 2),
  ($c$if-forma-correta$c$, $c$m4-if$c$, 3),
  ($c$if-nota-oito$c$, $c$m4-if$c$, 3),
  ($c$if-complete-a-condicao$c$, $c$m4-if$c$, 2),
  ($c$if-complete-a-condicao$c$, $c$m3-relacionais$c$, 1),
  ($c$if-dois-blocos-independentes$c$, $c$m4-if$c$, 3),
  ($c$if-bonus-de-vendas$c$, $c$m4-if$c$, 3),
  ($c$if-bonus-de-vendas$c$, $c$m3-relacionais$c$, 1),
  ($c$if-corrija-o-ponto-e-virgula$c$, $c$m4-if$c$, 3),
  ($c$if-corrija-a-atribuicao$c$, $c$m4-if$c$, 3),
  ($c$if-corrija-a-atribuicao$c$, $c$m3-atribuicao$c$, 1),
  ($c$if-somando-pontos$c$, $c$m4-if$c$, 3),
  ($c$if-somando-pontos$c$, $c$m3-atribuicao$c$, 1),
  ($c$ifelse-o-que-faz-o-else$c$, $c$m4-if-else$c$, 3),
  ($c$ifelse-par-ou-impar$c$, $c$m4-if-else$c$, 3),
  ($c$ifelse-par-ou-impar$c$, $c$m3-aritmeticos$c$, 1),
  ($c$ifelse-complete-o-else$c$, $c$m4-if-else$c$, 2),
  ($c$ifelse-reprovado$c$, $c$m4-if-else$c$, 3),
  ($c$ifelse-par-ou-impar-funcao$c$, $c$m4-if-else$c$, 3),
  ($c$ifelse-par-ou-impar-funcao$c$, $c$m3-aritmeticos$c$, 1),
  ($c$ifelse-o-maior-de-dois$c$, $c$m4-if-else$c$, 3),
  ($c$ifelse-o-maior-de-dois$c$, $c$m3-relacionais$c$, 1),
  ($c$ifelse-corrija-o-else-que-faltou$c$, $c$m4-if-else$c$, 3),
  ($c$ifelse-dois-pares-de-blocos$c$, $c$m4-if-else$c$, 3),
  ($c$elseif-quantos-blocos-executam$c$, $c$m4-else-if$c$, 3),
  ($c$elseif-escala-de-notas$c$, $c$m4-else-if$c$, 3),
  ($c$elseif-complete-a-cadeia$c$, $c$m4-else-if$c$, 2),
  ($c$elseif-ordem-errada$c$, $c$m4-else-if$c$, 3),
  ($c$elseif-classificar-nota$c$, $c$m4-else-if$c$, 3),
  ($c$elseif-classificar-nota$c$, $c$m3-relacionais$c$, 1),
  ($c$elseif-sinal-do-numero$c$, $c$m4-else-if$c$, 3),
  ($c$elseif-corrija-a-ordem$c$, $c$m4-else-if$c$, 3),
  ($c$elseif-versus-ifs-separados$c$, $c$m4-else-if$c$, 3),
  ($c$elseif-versus-ifs-separados$c$, $c$m4-if$c$, 1),
  ($c$aninhada-o-que-e$c$, $c$m4-aninhadas$c$, 3),
  ($c$aninhada-sem-ingresso$c$, $c$m4-aninhadas$c$, 3),
  ($c$aninhada-sem-ingresso$c$, $c$m4-if-else$c$, 1),
  ($c$aninhada-complete-o-if-interno$c$, $c$m4-aninhadas$c$, 2),
  ($c$aninhada-complete-o-if-interno$c$, $c$m4-if$c$, 1),
  ($c$aninhada-menor-de-idade$c$, $c$m4-aninhadas$c$, 3),
  ($c$aninhada-desconto-do-ingresso$c$, $c$m4-aninhadas$c$, 3),
  ($c$aninhada-desconto-do-ingresso$c$, $c$m4-if-else$c$, 1),
  ($c$aninhada-corrija-o-else-interno$c$, $c$m4-aninhadas$c$, 3),
  ($c$aninhada-corrija-o-else-interno$c$, $c$m4-if-else$c$, 1),
  ($c$aninhada-equivalente-com-e$c$, $c$m4-aninhadas$c$, 3),
  ($c$aninhada-equivalente-com-e$c$, $c$m3-logicos$c$, 1),
  ($c$aninhada-tres-niveis$c$, $c$m4-aninhadas$c$, 3),
  ($c$aninhada-tres-niveis$c$, $c$m4-if-else$c$, 1),
  ($c$switch-quando-usar$c$, $c$m4-switch$c$, 3),
  ($c$switch-dia-da-semana$c$, $c$m4-switch$c$, 3),
  ($c$switch-complete-o-break$c$, $c$m4-switch$c$, 3),
  ($c$switch-sem-break$c$, $c$m4-switch$c$, 3),
  ($c$switch-nome-do-dia$c$, $c$m4-switch$c$, 3),
  ($c$switch-calculadora-de-operacao$c$, $c$m4-switch$c$, 3),
  ($c$switch-calculadora-de-operacao$c$, $c$m3-aritmeticos$c$, 1),
  ($c$switch-corrija-o-break$c$, $c$m4-switch$c$, 3),
  ($c$switch-igualdade-estrita$c$, $c$m4-switch$c$, 3),
  ($c$switch-igualdade-estrita$c$, $c$m2-conversao-tipos$c$, 1),
  ($c$ternario-o-que-e$c$, $c$m4-ternario$c$, 3),
  ($c$ternario-situacao$c$, $c$m4-ternario$c$, 3),
  ($c$ternario-complete-os-simbolos$c$, $c$m4-ternario$c$, 2),
  ($c$ternario-par-ou-impar$c$, $c$m4-ternario$c$, 3),
  ($c$ternario-par-ou-impar$c$, $c$m3-aritmeticos$c$, 1),
  ($c$ternario-valor-absoluto$c$, $c$m4-ternario$c$, 3),
  ($c$ternario-valor-absoluto$c$, $c$m3-relacionais$c$, 1),
  ($c$ternario-corrija-a-ordem$c$, $c$m4-ternario$c$, 3),
  ($c$ternario-aninhado$c$, $c$m4-ternario$c$, 3),
  ($c$ternario-aninhado$c$, $c$m4-else-if$c$, 1),
  ($c$desafio4-sistema-de-notas$c$, $c$m4-else-if$c$, 2),
  ($c$desafio4-sistema-de-notas$c$, $c$m3-aritmeticos$c$, 2),
  ($c$desafio4-sistema-de-notas$c$, $c$m3-relacionais$c$, 2),
  ($c$desafio4-sistema-de-notas$c$, $c$m2-entrada-saida$c$, 1),
  ($c$desafio4-sistema-de-notas$c$, $c$m2-conversao-tipos$c$, 1),
  ($c$desafio4-corrija-o-desconto$c$, $c$m4-else-if$c$, 3),
  ($c$desafio4-corrija-o-desconto$c$, $c$m4-aninhadas$c$, 2),
  ($c$desafio4-corrija-o-desconto$c$, $c$m3-logicos$c$, 1),
  ($c$desafio4-acompanhe-as-decisoes$c$, $c$m4-else-if$c$, 2),
  ($c$desafio4-acompanhe-as-decisoes$c$, $c$m4-aninhadas$c$, 2),
  ($c$desafio4-acompanhe-as-decisoes$c$, $c$m4-if$c$, 2),
  ($c$desafio4-acompanhe-as-decisoes$c$, $c$m3-logicos$c$, 2),
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
  select count(*) into n from public.exercises where origem = 'painel' and id in ($c$o-que-e-algoritmo$c$, $c$ordem-das-instrucoes$c$, $c$valor-da-variavel$c$, $c$completar-condicional$c$, $c$completar-laco$c$, $c$tipos-de-dados$c$, $c$precedencia-operadores$c$, $c$resto-da-divisao$c$, $c$exemplo-interpretacao$c$, $c$exemplo-ordenacao$c$, $c$exemplo-corrigir$c$, $c$exemplo-entrada-saida$c$, $c$prog-o-que-e-programar$c$, $c$prog-quem-e-quem$c$, $c$prog-complete-ola-mundo$c$, $c$prog-ordem-das-instrucoes$c$, $c$prog-texto-ou-conta$c$, $c$prog-quem-responde-pelo-erro$c$, $c$logica-o-que-e$c$, $c$logica-deducao-simples$c$, $c$logica-se-entao-senao$c$, $c$logica-calculo-do-troco$c$, $c$logica-quem-pode-entrar$c$, $c$logica-etapas-do-raciocinio$c$, $c$logica-raciocinio-invertido$c$, $c$algoritmo-qual-e-algoritmo$c$, $c$algoritmo-o-que-nao-precisa$c$, $c$algoritmo-trocar-lampada$c$, $c$algoritmo-contar-ate-tres$c$, $c$algoritmo-instrucao-clara$c$, $c$algoritmo-que-nunca-termina$c$, $c$sequencia-escovar-os-dentes$c$, $c$sequencia-por-que-importa$c$, $c$sequencia-abc$c$, $c$sequencia-ordem-do-programa$c$, $c$sequencia-macarrao$c$, $c$sequencia-saque-no-caixa$c$, $c$eps-o-que-e-entrada$c$, $c$eps-classificar-saida$c$, $c$eps-eco$c$, $c$eps-quais-sao-entrada$c$, $c$eps-qual-e-o-processamento$c$, $c$eps-dobro$c$, $c$eps-soma-de-entradas$c$, $c$pseudo-o-que-e$c$, $c$pseudo-comando-de-saida$c$, $c$pseudo-complete-saudacao$c$, $c$pseudo-soma$c$, $c$pseudo-desconto$c$, $c$pseudo-ordene-o-algoritmo$c$, $c$fluxo-simbolo-da-decisao$c$, $c$fluxo-o-que-as-setas-indicam$c$, $c$fluxo-simbolo-da-entrada$c$, $c$fluxo-dobro$c$, $c$fluxo-maior-de-idade$c$, $c$fluxo-guarda-chuva$c$, $c$desafio1-trocar-o-pneu$c$, $c$desafio1-pseudocodigo-da-media$c$, $c$desafio1-aprovado-ou-nao$c$, $c$tamanho-do-texto$c$, $c$completar-texto$c$, $c$inverter-texto$c$, $c$conta-vogais$c$, $c$palindromo$c$, $c$variaveis-o-que-e$c$, $c$variaveis-mostrar-valor$c$, $c$variaveis-complete-idade$c$, $c$variaveis-trocar-o-valor$c$, $c$variaveis-ordene-o-programa$c$, $c$variaveis-sinal-de-igual$c$, $c$variaveis-copia-de-valor$c$, $c$declaracao-nome-valido$c$, $c$declaracao-linha-correta$c$, $c$declaracao-complete$c$, $c$declaracao-sem-valor$c$, $c$declaracao-maiuscula-minuscula$c$, $c$declaracao-corrija-o-nome$c$, $c$declaracao-so-nomes-validos$c$, $c$letconst-palavra-que-muda$c$, $c$letconst-quando-usar-const$c$, $c$letconst-complete$c$, $c$letconst-alterando-const$c$, $c$letconst-somando-pontos$c$, $c$letconst-corrija-a-area$c$, $c$letconst-qual-funciona$c$, $c$string-qual-e-texto$c$, $c$string-typeof-numero-entre-aspas$c$, $c$string-complete-as-aspas$c$, $c$string-typeof-true-entre-aspas$c$, $c$string-aspas-dentro-do-texto$c$, $c$string-corrija-as-aspas$c$, $c$string-por-que-sao-diferentes$c$, $c$number-como-escrever-decimal$c$, $c$number-typeof-decimal$c$, $c$number-complete-a-altura$c$, $c$number-divisao-decimal$c$, $c$number-o-que-e-nan$c$, $c$number-media-de-dois$c$, $c$number-contas-especiais$c$, $c$boolean-quais-sao-os-valores$c$, $c$boolean-comparacao-simples$c$, $c$boolean-complete-sem-desconto$c$, $c$boolean-qual-e-boolean$c$, $c$boolean-idade-minima$c$, $c$boolean-tres-typeof$c$, $c$boolean-igualdade$c$, $c$textos-propriedade-do-tamanho$c$, $c$textos-tamanho-de-casa$c$, $c$textos-complete-maiusculas$c$, $c$textos-indices-de-banana$c$, $c$textos-recorte-com-slice$c$, $c$textos-email$c$, $c$textos-inicial-em-maiuscula$c$, $c$concat-operador$c$, $c$concat-bom-dia$c$, $c$concat-complete-ola$c$, $c$concat-texto-e-numero$c$, $c$concat-ordene-a-saudacao$c$, $c$concat-idade-na-frase$c$, $c$concat-da-esquerda-para-a-direita$c$, $c$concat-nome-completo$c$, $c$template-qual-simbolo$c$, $c$template-oi-beto$c$, $c$template-complete$c$, $c$template-conta-dentro$c$, $c$template-qual-linha$c$, $c$template-corrija-a-saudacao$c$, $c$template-apresentar$c$, $c$template-soma-na-frase$c$, $c$operacoes-resto$c$, $c$operacoes-resto-de-sete$c$, $c$operacoes-area-do-quadrado$c$, $c$operacoes-media-de-duas-notas$c$, $c$operacoes-media-de-tres$c$, $c$operacoes-porcentagem$c$, $c$operacoes-precedencia-e-arredondamento$c$, $c$conversao-qual-funcao$c$, $c$conversao-tipo-depois-de-number$c$, $c$conversao-complete$c$, $c$conversao-texto-ou-numero$c$, $c$conversao-resultados$c$, $c$conversao-corrija-a-soma$c$, $c$conversao-somar-entradas$c$, $c$conversao-multiplicar-e-somar$c$, $c$es-comando-de-entrada$c$, $c$es-ola-nome$c$, $c$es-boas-vindas$c$, $c$es-entradas-sao-texto$c$, $c$es-ordene-o-programa$c$, $c$es-area-do-retangulo$c$, $c$es-corrija-o-ano-que-vem$c$, $c$es-media-das-notas$c$, $c$log-varias-chamadas$c$, $c$log-com-virgula$c$, $c$log-complete-a-media$c$, $c$log-texto-ou-conta$c$, $c$log-mostrar-os-dados$c$, $c$log-operacoes-em-linhas$c$, $c$log-corrija-o-total$c$, $c$log-quatro-linhas$c$, $c$desafio2-ficha-da-pessoa$c$, $c$desafio2-corrija-o-resumo$c$, $c$desafio2-tipos-e-conversoes$c$, $c$soma$c$, $c$media$c$, $c$celsius$c$, $c$area-retangulo$c$, $c$quadrado$c$, $c$media-ponderada$c$, $c$completar-media$c$, $c$op-intro-quem-e-o-operador$c$, $c$op-intro-grupo-relacional$c$, $c$op-intro-complete-a-conta$c$, $c$op-intro-soma-e-comparacao$c$, $c$op-intro-resultado-boolean$c$, $c$op-intro-operador-unario$c$, $c$op-intro-varios-grupos$c$, $c$arit-operador-da-potencia$c$, $c$arit-resto-de-vinte-por-seis$c$, $c$arit-complete-o-resto$c$, $c$arit-tres-contas$c$, $c$arit-ultimo-digito$c$, $c$arit-parte-inteira$c$, $c$arit-corrija-o-quadrado$c$, $c$arit-divisao-por-zero$c$, $c$atrib-o-que-faz-o-mais-igual$c$, $c$atrib-somar-cinco$c$, $c$atrib-complete-o-contador$c$, $c$atrib-varias-atualizacoes$c$, $c$atrib-forma-equivalente$c$, $c$atrib-corrija-o-total$c$, $c$atrib-aplicar-desconto$c$, $c$atrib-texto-e-numero$c$, $c$rel-operador-de-igualdade$c$, $c$rel-maior-ou-igual$c$, $c$rel-complete-a-comparacao$c$, $c$rel-igual-estrito-e-frouxo$c$, $c$rel-qual-linha-compara$c$, $c$rel-pode-votar$c$, $c$rel-corrija-a-igualdade$c$, $c$rel-comparando-textos$c$, $c$rel-textos-de-numeros-e-decimais$c$, $c$log-qual-e-o-e$c$, $c$log-o-que-e-o-ou$c$, $c$log-true-e-false$c$, $c$log-complete-o-ou$c$, $c$log-quatro-combinacoes$c$, $c$log-pode-entrar$c$, $c$log-comparacoes-combinadas$c$, $c$log-entre-dois-valores$c$, $c$log-corrija-o-intervalo$c$, $c$log-precedencia-dos-logicos$c$, $c$prec-o-que-vem-primeiro$c$, $c$prec-dois-mais-tres-vezes-quatro$c$, $c$prec-complete-os-parenteses$c$, $c$prec-esquerda-direita$c$, $c$prec-contas-e-comparacoes$c$, $c$prec-qual-expressao-da-24$c$, $c$prec-celsius-para-fahrenheit$c$, $c$prec-corrija-a-media$c$, $c$prec-logicos-e-parenteses$c$, $c$desafio3-calculadora$c$, $c$desafio3-corrija-a-aprovacao$c$, $c$desafio3-acompanhe-o-saldo$c$, $c$par-ou-impar$c$, $c$maior-de-tres$c$, $c$nota$c$, $c$bissexto$c$, $c$operadores-logicos$c$, $c$completar-else-if$c$, $c$dentro-do-intervalo$c$, $c$tipo-de-triangulo$c$, $c$cond-intro-para-que-serve$c$, $c$cond-intro-o-que-a-condicao-resulta$c$, $c$cond-intro-condicao-verdadeira$c$, $c$cond-intro-complete-o-if$c$, $c$cond-intro-condicao-falsa$c$, $c$cond-intro-condicao-invalida$c$, $c$cond-intro-ordene-o-if$c$, $c$cond-intro-dois-ifs-seguidos$c$, $c$revrel-pelo-menos$c$, $c$revrel-diferente$c$, $c$revrel-maiusculas-contam$c$, $c$revrel-nota-passou$c$, $c$revrel-corrija-o-igual$c$, $c$revrel-texto-ou-numero$c$, $c$revrel-casos-estranhos$c$, $c$revlog-entre-dois-valores$c$, $c$revlog-crianca-ou-idoso$c$, $c$revlog-tabela-verdade$c$, $c$revlog-tem-desconto$c$, $c$revlog-corrija-o-fim-de-semana$c$, $c$revlog-parenteses-mudam-o-resultado$c$, $c$revlog-de-morgan$c$, $c$if-forma-correta$c$, $c$if-nota-oito$c$, $c$if-complete-a-condicao$c$, $c$if-dois-blocos-independentes$c$, $c$if-bonus-de-vendas$c$, $c$if-corrija-o-ponto-e-virgula$c$, $c$if-corrija-a-atribuicao$c$, $c$if-somando-pontos$c$, $c$ifelse-o-que-faz-o-else$c$, $c$ifelse-par-ou-impar$c$, $c$ifelse-complete-o-else$c$, $c$ifelse-reprovado$c$, $c$ifelse-par-ou-impar-funcao$c$, $c$ifelse-o-maior-de-dois$c$, $c$ifelse-corrija-o-else-que-faltou$c$, $c$ifelse-dois-pares-de-blocos$c$, $c$elseif-quantos-blocos-executam$c$, $c$elseif-escala-de-notas$c$, $c$elseif-complete-a-cadeia$c$, $c$elseif-ordem-errada$c$, $c$elseif-classificar-nota$c$, $c$elseif-sinal-do-numero$c$, $c$elseif-corrija-a-ordem$c$, $c$elseif-versus-ifs-separados$c$, $c$aninhada-o-que-e$c$, $c$aninhada-sem-ingresso$c$, $c$aninhada-complete-o-if-interno$c$, $c$aninhada-menor-de-idade$c$, $c$aninhada-desconto-do-ingresso$c$, $c$aninhada-corrija-o-else-interno$c$, $c$aninhada-equivalente-com-e$c$, $c$aninhada-tres-niveis$c$, $c$switch-quando-usar$c$, $c$switch-dia-da-semana$c$, $c$switch-complete-o-break$c$, $c$switch-sem-break$c$, $c$switch-nome-do-dia$c$, $c$switch-calculadora-de-operacao$c$, $c$switch-corrija-o-break$c$, $c$switch-igualdade-estrita$c$, $c$ternario-o-que-e$c$, $c$ternario-situacao$c$, $c$ternario-complete-os-simbolos$c$, $c$ternario-par-ou-impar$c$, $c$ternario-valor-absoluto$c$, $c$ternario-corrija-a-ordem$c$, $c$ternario-aninhado$c$, $c$desafio4-sistema-de-notas$c$, $c$desafio4-corrija-o-desconto$c$, $c$desafio4-acompanhe-as-decisoes$c$, $c$somatorio$c$, $c$fatorial$c$, $c$tabuada$c$, $c$primo$c$, $c$quantas-vezes$c$, $c$completar-while$c$, $c$soma-dos-pares$c$, $c$potencia$c$, $c$conta-digitos$c$, $c$mdc$c$, $c$soma-vetor$c$, $c$inverter-vetor$c$, $c$maior-vetor$c$, $c$busca-linear$c$, $c$ordenar$c$, $c$indice-do-vetor$c$, $c$completar-percorrer$c$, $c$conta-pares$c$, $c$media-do-vetor$c$, $c$segundo-maior$c$, $c$parametro-e-retorno$c$, $c$completar-funcao$c$, $c$escopo-de-variavel$c$, $c$maior-de-dois$c$, $c$hipotenusa$c$);
  if n > 0 then
    raise notice '% exercício(s) do conteúdo foram ignorados porque foram editados no painel do professor.', n;
  end if;
end $$;
