-- PARTE 1 de 4: mundos, conceitos e lições. Rode as partes em ordem (1, 2, 3, 4); cada uma pode ser repetida sem duplicar nada.

-- GERADO por "npm run content:build" a partir de content/. Não edite à mão.
-- Importa mundos, conceitos, lições e exercícios. Pode ser executado várias vezes (idempotente).
-- Aplique todas as migrations (até a 0017) antes. Não altera "published" nem "position" de exercícios que já existem
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

Ele tem três partes: início (let i = 1), condição para continuar (i <= 5) e passo (i++). Para entender um laço, acompanhe a tabela de valores a cada volta: quanto valem i e total? Cuidado com laços que nunca terminam.$c$, $c$$c$, $c$$c$, $c$mundo-5$c$, 590, false, $c$arquivo$c$),
  ($c$introducao-as-repeticoes$c$, $c$Introdução às estruturas de repetição$c$, $c$Entender por que e como repetir instruções$c$, $c$Imagine ter de escrever "Bom dia!" cem vezes. Você não escreveria o mesmo texto cem vezes: faria uma regra do tipo "repita 100 vezes". É isso que uma estrutura de repetição (ou laço) faz: executa um trecho do código várias vezes, sem precisar escrevê-lo de novo.

Todo laço precisa de três coisas:
- um ponto de partida (por exemplo, começar a contar em 1);
- uma condição para continuar (por exemplo, enquanto a contagem for menor ou igual a 5);
- uma atualização a cada volta (por exemplo, somar 1 à contagem).

Se a condição nunca deixar de ser verdadeira, o laço nunca termina: é o laço infinito, um dos erros mais comuns. Neste mundo você vai conhecer for, while e do...while, além de contadores, acumuladores e os comandos break e continue.$c$, $c$for (let i = 1; i <= 3; i++) {
  console.log("Oi");
}

Passo a passo:
1. let i = 1: o contador começa em 1 (só acontece uma vez).
2. i <= 3 é testado: 1 <= 3 é true, então o corpo executa e mostra Oi.
3. i++ soma 1: i vale 2. A condição é testada de novo: true, mostra Oi.
4. i vale 3: true, mostra Oi.
5. i vale 4: 4 <= 3 é false, e o laço termina.

Resultado: Oi aparece 3 vezes.$c$, $c$- Um laço repete um trecho do código sem precisar escrevê-lo de novo.
- Ele precisa de ponto de partida, condição para continuar e atualização a cada volta.
- Enquanto a condição for verdadeira, o corpo do laço executa.
- Se a condição nunca ficar falsa, o laço é infinito.
- Cada execução do corpo é chamada de iteração (ou volta).$c$, $c$mundo-5$c$, 501, false, $c$arquivo$c$),
  ($c$estrutura-for$c$, $c$Estrutura for$c$, $c$Repetir um número conhecido de vezes$c$, $c$O for é o laço ideal quando você já sabe quantas vezes quer repetir. Ele reúne as três partes do laço em uma só linha:

for (inicialização; condição; passo) {
  // corpo do laço
}

- Inicialização: executa uma única vez, antes da primeira volta (por exemplo, let i = 0).
- Condição: é testada antes de cada volta. Se for falsa, o laço termina.
- Passo: executa depois de cada volta (por exemplo, i++ soma 1; i += 2 soma 2; i-- subtrai 1).

Atenção ao limite: for (let i = 0; i < 3; i++) repete 3 vezes (0, 1 e 2), enquanto i <= 3 repetiria 4 vezes (0, 1, 2 e 3). Errar o limite por uma volta é o famoso "erro de um".

A ordem de execução é: inicialização → condição → corpo → passo → condição → corpo → passo... até a condição ficar falsa.$c$, $c$for (let i = 1; i <= 10; i += 3) {
  console.log(i);
}

Passo a passo:
1. i começa em 1. A condição 1 <= 10 é true: mostra 1.
2. O passo i += 3 faz i valer 4: 4 <= 10 é true: mostra 4.
3. i vale 7: true, mostra 7.
4. i vale 10: true, mostra 10.
5. i vale 13: 13 <= 10 é false, o laço termina.

Resultado: 1, 4, 7 e 10.$c$, $c$- for (inicialização; condição; passo): três partes em uma linha.
- A inicialização executa uma vez; a condição é testada antes de cada volta; o passo roda depois de cada volta.
- i < n repete n vezes a partir de 0; i <= n inclui o valor n.
- O passo pode ser i++, i--, i += 2... conforme o que o problema pede.
- Cuidado com o erro de um no limite do laço.$c$, $c$mundo-5$c$, 502, false, $c$arquivo$c$),
  ($c$estrutura-while$c$, $c$Estrutura while$c$, $c$Repetir enquanto uma condição for verdadeira$c$, $c$O while ("enquanto") repete um bloco enquanto a condição for verdadeira. Ele é ideal quando você não sabe de antemão quantas voltas serão necessárias: o laço continua até que uma situação mude.

let n = 3;
while (n > 0) {
  console.log(n);
  n--;
}

Diferente do for, as três partes ficam separadas: o ponto de partida vem antes do laço, a condição fica nos parênteses e a atualização precisa estar dentro do corpo. Se você esquecer de atualizar a variável da condição, o laço será infinito.

Outra característica: a condição é testada antes de cada volta. Se ela já começar falsa, o corpo não executa nenhuma vez.

Use for quando souber a quantidade de voltas e while quando a repetição depender de uma condição (por exemplo, "dividir até chegar a zero").$c$, $c$let n = 3;
while (n > 0) {
  console.log(n);
  n--;
}
console.log("Fogo!");

Passo a passo:
1. n vale 3. A condição 3 > 0 é true: mostra 3 e n passa a 2.
2. 2 > 0 é true: mostra 2 e n passa a 1.
3. 1 > 0 é true: mostra 1 e n passa a 0.
4. 0 > 0 é false: o laço termina.
5. O programa continua e mostra Fogo!

Resultado: 3, 2, 1 e Fogo!$c$, $c$- while repete o bloco enquanto a condição for verdadeira.
- A condição é testada antes de cada volta: pode ser que o corpo nunca execute.
- Atualize dentro do laço a variável usada na condição, para não criar um laço infinito.
- Use for quando souber quantas voltas; while quando depender de uma condição.$c$, $c$mundo-5$c$, 503, false, $c$arquivo$c$),
  ($c$estrutura-do-while$c$, $c$Estrutura do...while$c$, $c$Repetir com o teste no final do laço$c$, $c$O do...while é parecido com o while, mas com uma diferença importante: o corpo executa primeiro e a condição é testada depois. Por isso, o corpo do do...while executa pelo menos uma vez, mesmo que a condição já comece falsa.

do {
  // corpo do laço
} while (condição);

Repare no ponto e vírgula depois do while(condição): ele faz parte da sintaxe.

Isso é útil quando precisamos fazer algo antes de decidir se repetimos, como pedir uma informação ao usuário e só depois conferir se ela é válida: "peça a nota; se não estiver entre 0 e 10, peça de novo".

Resumindo: no while o teste vem antes (pode executar zero vezes); no do...while o teste vem depois (executa ao menos uma vez).$c$, $c$let n = 10;
do {
  console.log("Executou");
  n++;
} while (n < 5);

Passo a passo:
1. O computador executa o corpo primeiro: mostra Executou e n passa a 11.
2. Só então testa a condição: 11 < 5 é false.
3. O laço termina depois de uma única volta.

Com um while comum (while (n < 5)), o corpo não executaria nenhuma vez.$c$, $c$- do...while executa o corpo primeiro e testa a condição depois.
- O corpo executa pelo menos uma vez, mesmo com a condição falsa desde o início.
- A sintaxe termina com ponto e vírgula: do { ... } while (condição);
- Ótimo para validar entradas: pedir, conferir e repetir se for preciso.$c$, $c$mundo-5$c$, 504, false, $c$arquivo$c$),
  ($c$contadores$c$, $c$Contadores$c$, $c$Contar quantas vezes algo acontece$c$, $c$Um contador é uma variável que guarda "quantas vezes" alguma coisa aconteceu. Ele começa em zero e aumenta de 1 em 1 (contador++) cada vez que o evento acontece.

let pares = 0;                // começa em zero
for (let i = 1; i <= 10; i++) {
  if (i % 2 === 0) {
    pares++;                  // soma 1 só quando i é par
  }
}

Três cuidados:
1. Inicialize o contador antes do laço (geralmente com 0). Se declarar dentro do laço, ele volta a zero a cada volta.
2. Só some quando a situação acontecer: use um if para decidir.
3. Não confunda com acumulador: o contador conta ocorrências (sempre soma 1); o acumulador soma valores (veja a próxima lição).

Contadores servem para contar pares, vogais em um texto, aprovados em uma turma, tentativas e muito mais.$c$, $c$let pares = 0;
for (let i = 1; i <= 6; i++) {
  if (i % 2 === 0) {
    pares++;
  }
}
console.log(pares);

Passo a passo:
1. pares começa em 0.
2. O laço percorre i = 1, 2, 3, 4, 5 e 6.
3. Para i = 2, 4 e 6, o resto da divisão por 2 é 0 e pares aumenta 1 em cada um.
4. Ao final, pares vale 3 e o programa mostra 3.$c$, $c$- Contador: variável que conta quantas vezes algo aconteceu (contador++).
- Inicialize antes do laço, normalmente com 0.
- Use um if para somar só quando a situação ocorrer.
- Contador conta ocorrências; acumulador soma valores.$c$, $c$mundo-5$c$, 505, false, $c$arquivo$c$),
  ($c$acumuladores$c$, $c$Acumuladores$c$, $c$Somar ou multiplicar valores ao longo do laço$c$, $c$Um acumulador é uma variável que vai juntando valores a cada volta do laço: a soma de várias notas, o total de uma compra, o produto de uma sequência.

let soma = 0;
for (let i = 1; i <= 4; i++) {
  soma += i;     // soma = soma + i
}

Diferente do contador, que sempre soma 1, o acumulador soma (ou multiplica) o valor que aparece a cada volta.

Atenção ao valor inicial:
- para somar, comece em 0 (elemento neutro da soma);
- para multiplicar, comece em 1 (elemento neutro do produto): começando em 0, tudo vira 0.

E o erro mais comum: declarar o acumulador dentro do laço. Isso o reinicia a cada volta, e ele nunca acumula nada. Declare-o antes do laço.

Depois do laço, o acumulador guarda o total, e dá para calcular coisas como a média (soma ÷ quantidade).$c$, $c$let soma = 0;
for (let i = 1; i <= 4; i++) {
  soma += i;
}
console.log(soma);

Passo a passo:
1. soma começa em 0.
2. i = 1: soma passa a 1.
3. i = 2: soma passa a 3.
4. i = 3: soma passa a 6.
5. i = 4: soma passa a 10.
6. O laço termina e o programa mostra 10.$c$, $c$- Acumulador: variável que junta valores a cada volta (soma += valor).
- Para somar, comece em 0; para multiplicar, comece em 1.
- Declare o acumulador antes do laço, nunca dentro dele.
- Contador soma sempre 1; acumulador soma o valor da volta.
- Depois do laço, o acumulador guarda o total (e permite calcular médias).$c$, $c$mundo-5$c$, 506, false, $c$arquivo$c$),
  ($c$comando-break$c$, $c$Comando break$c$, $c$Interromper um laço antes da hora$c$, $c$O comando break encerra o laço imediatamente, mesmo que a condição ainda fosse verdadeira. O programa continua na primeira instrução depois do laço.

for (let i = 1; i <= 5; i++) {
  if (i === 3) {
    break;       // sai do laço quando i vale 3
  }
  console.log(i);
}

Ele é útil quando você encontrou o que procurava e não precisa continuar: achar o primeiro número que atende a uma regra, parar de ler quando aparecer um valor especial, ou sair de um laço "infinito" de propósito:

while (true) {
  // ...
  if (terminou) {
    break;
  }
}

Cuidado: break não é o mesmo que continue. O break encerra o laço todo; o continue só pula a volta atual.$c$, $c$for (let i = 1; i <= 5; i++) {
  if (i === 3) {
    break;
  }
  console.log(i);
}
console.log("Fim");

Passo a passo:
1. i = 1: a condição i === 3 é false: mostra 1.
2. i = 2: false: mostra 2.
3. i = 3: true. O break encerra o laço na hora (o 3 não é mostrado).
4. O programa continua depois do laço e mostra Fim.

Resultado: 1, 2 e Fim.$c$, $c$- break encerra o laço imediatamente.
- O programa segue na primeira instrução depois do laço.
- Serve para parar quando já achamos o que procurávamos.
- while (true) com break é um laço que só termina quando a condição de saída acontece.
- break encerra o laço; continue só pula a volta atual.$c$, $c$mundo-5$c$, 507, false, $c$arquivo$c$),
  ($c$comando-continue$c$, $c$Comando continue$c$, $c$Pular uma volta sem encerrar o laço$c$, $c$O comando continue pula o resto da volta atual e passa direto para a próxima volta. Diferente do break, o laço não termina: só aquela volta é interrompida.

for (let i = 1; i <= 5; i++) {
  if (i === 3) {
    continue;     // pula o resto desta volta
  }
  console.log(i);
}

No exemplo, o 3 não é mostrado, mas o laço segue com 4 e 5.

É útil para ignorar casos que não interessam: pular números pares, ignorar letras que não são vogais, desconsiderar valores inválidos.

Num for, depois do continue o passo (i++) executa normalmente. Num while, cuidado: se a atualização da variável estiver depois do continue, ela será pulada e o laço pode ficar infinito. Faça a atualização antes do continue.$c$, $c$for (let i = 1; i <= 6; i++) {
  if (i % 2 === 0) {
    continue;
  }
  console.log(i);
}

Passo a passo:
1. i = 1: 1 % 2 é 1, a condição é false: mostra 1.
2. i = 2: par. O continue pula o console.log e vai para i = 3.
3. i = 3: mostra 3. i = 4: pulado. i = 5: mostra 5. i = 6: pulado.

Resultado: 1, 3 e 5 (só os ímpares).$c$, $c$- continue pula o resto da volta atual e vai para a próxima.
- O laço não termina: só aquela volta é interrompida.
- Útil para ignorar valores que não interessam.
- Num while, atualize a variável antes do continue para evitar laço infinito.
- break encerra o laço; continue apenas pula uma volta.$c$, $c$mundo-5$c$, 508, false, $c$arquivo$c$),
  ($c$lacos-aninhados$c$, $c$Laços de repetição aninhados$c$, $c$Colocar um laço dentro de outro$c$, $c$Laços aninhados são laços dentro de outros laços. Para cada volta do laço de fora, o laço de dentro roda por completo, do início ao fim.

for (let i = 1; i <= 3; i++) {        // laço externo: 3 voltas
  for (let j = 1; j <= 4; j++) {      // laço interno: 4 voltas por volta externa
    console.log(i, j);
  }
}

O corpo do laço interno executa 3 × 4 = 12 vezes: o número de execuções se multiplica, não se soma.

Pense num relógio: o ponteiro dos minutos dá 60 voltas completas enquanto o das horas avança uma casa.

Dicas:
- use variáveis diferentes em cada laço (i e j);
- o limite do laço interno pode depender do externo (por exemplo, j <= i para desenhar triângulos);
- um break dentro do laço interno encerra somente o laço interno.

Laços aninhados servem para tabelas, desenhos com caracteres e para combinar todos os valores de dois conjuntos.$c$, $c$for (let i = 1; i <= 2; i++) {
  for (let j = 1; j <= 3; j++) {
    console.log(i, j);
  }
}

Passo a passo:
1. i = 1: o laço interno roda por inteiro: j = 1, 2 e 3 (mostra 1 1, 1 2 e 1 3).
2. i = 2: o laço interno recomeça e roda de novo: 2 1, 2 2 e 2 3.
3. O corpo executou 2 × 3 = 6 vezes.

O laço de fora muda devagar; o de dentro muda a cada volta.$c$, $c$- Laço aninhado: um laço dentro de outro.
- Para cada volta do laço externo, o interno executa por completo.
- Total de execuções do corpo interno = voltas externas × voltas internas.
- Use variáveis diferentes (i e j) em cada laço.
- break dentro do laço interno encerra só o interno.$c$, $c$mundo-5$c$, 509, false, $c$arquivo$c$),
  ($c$desafio-do-mundo-5$c$, $c$Desafio final do Mundo 5$c$, $c$Juntar os laços em um jogo de adivinhação$c$, $c$Chegou o desafio do Mundo 5: um jogo de adivinhação com tentativas limitadas. O computador "pensa" em um número secreto e o jogador tem um número máximo de tentativas para descobri-lo. A cada palpite errado, o programa dá uma dica: o número secreto é maior ou menor que o palpite.

Aqui você vai juntar o que aprendeu: laços para repetir as tentativas, contador para saber quantas foram usadas, condicionais (Mundo 4) para dar as dicas e break (ou uma condição no laço) para parar quando o jogador acertar.

O desafio principal é o primeiro exercício. Os outros dois treinam a leitura de laços combinados e a correção de um erro clássico.$c$, $c$Como montar o jogo:
1. Use um laço de no máximo "tentativas" voltas e um contador (a volta atual).
2. A cada volta, leia o palpite com lerEntrada() e converta com Number().
3. Se o palpite for igual ao segredo, mostre Acertou! com o número de tentativas e encerre o laço (break ou return).
4. Se for menor que o segredo, mostre que o número é maior; se for maior, mostre que é menor.
5. Se o laço terminar sem acerto, mostre o fim de jogo revelando o número.
6. Teste o acerto na primeira tentativa, o acerto na última e o fim de jogo.$c$, $c$- Laço com limite de voltas: o número máximo de tentativas.
- Contador: quantas tentativas foram usadas.
- Condicionais dão as dicas (maior, menor, acertou).
- break (ou return) encerra o laço quando o jogador acerta.
- Teste os casos de fronteira: acertar de primeira, acertar na última tentativa e esgotar as tentativas.$c$, $c$mundo-5$c$, 510, false, $c$arquivo$c$),
  ($c$vetores$c$, $c$Vetores$c$, $c$Manipular coleções de dados$c$, $c$Um vetor (array) guarda vários valores numa lista ordenada:

const notas = [7, 9, 5];

A primeira posição é a 0: notas[0] vale 7. notas.length diz quantos itens existem. Para percorrer o vetor use um laço de i = 0 até i < notas.length. Muitos problemas de vetores são "percorra e acumule": somar, contar, achar o maior.$c$, $c$$c$, $c$$c$, $c$mundo-6$c$, 690, false, $c$arquivo$c$),
  ($c$introducao-aos-vetores$c$, $c$Introdução aos vetores$c$, $c$Guardar vários valores em uma única variável$c$, $c$Imagine guardar as notas de 30 alunos. Criar 30 variáveis (nota1, nota2, nota3...) seria trabalhoso e impossível de percorrer com um laço. Para isso existe o vetor: uma única variável que guarda vários valores, organizados em fila.

const notas = [7, 8.5, 6, 9];

Cada valor do vetor é um elemento e ocupa uma posição numerada. Em JavaScript, os vetores são chamados de arrays. A grande vantagem é tratar o conjunto como um todo: guardar, percorrer, somar, procurar.

Use um vetor quando tiver muitos valores do mesmo tipo de informação (as notas de uma turma, os preços de uma lista de compras, os nomes de vários alunos) e quiser processá-los do mesmo jeito.

Cuidado: um vetor é uma estrutura que guarda dados. Quando você atribui um vetor a outra variável, as duas passam a apontar para o mesmo conjunto (veremos isso adiante).$c$, $c$const notas = [7, 8, 9];
console.log(notas[0] + notas[2]);

Passo a passo:
1. O vetor notas guarda três valores: 7, 8 e 9.
2. notas[0] é o valor da primeira posição: 7.
3. notas[2] é o valor da terceira posição: 9.
4. A soma 7 + 9 resulta em 16, que é mostrado.

As posições começam em 0: a primeira é 0, a segunda é 1, a terceira é 2.$c$, $c$- Um vetor (array) guarda vários valores em uma única variável.
- Cada valor é um elemento e fica em uma posição numerada.
- As posições começam em 0.
- Use vetores para muitos valores do mesmo tipo de informação que serão processados do mesmo jeito.
- Atribuir um vetor a outra variável não cria uma cópia dos dados.$c$, $c$mundo-6$c$, 601, false, $c$arquivo$c$),
  ($c$arrays-em-javascript$c$, $c$Arrays em JavaScript$c$, $c$Criar, ler e alterar elementos de um array$c$, $c$Em JavaScript, criamos um array escrevendo os valores entre colchetes, separados por vírgula:

const frutas = ["maçã", "uva", "pera"];
const vazio = [];

Para ler um elemento, escrevemos o nome do array e a posição entre colchetes: frutas[1] é "uva". Para alterar, atribuímos um novo valor àquela posição: frutas[1] = "kiwi".

Um array pode guardar qualquer tipo de valor (números, textos, booleanos) e até misturá-los, mas o mais comum é guardar valores do mesmo tipo.

Duas observações importantes:
1. Declarar com const não impede de mudar os elementos: const garante que a variável sempre aponta para o mesmo array, mas o conteúdo pode ser alterado.
2. Atribuir um array a outra variável (const b = a) não copia os dados: as duas variáveis apontam para o mesmo array. Para criar uma cópia, use [...a].$c$, $c$const notas = [6, 8, 10];
notas[0] = 7;
console.log(notas[0]);

const copia = [...notas];
copia[1] = 0;
console.log(notas[1]);

Passo a passo:
1. notas começa com 6, 8 e 10.
2. notas[0] = 7 troca o primeiro elemento: o array passa a ter 7, 8 e 10. Mostra 7.
3. [...notas] cria um array novo com os mesmos valores.
4. Alterar copia[1] não afeta notas: notas[1] continua 8.$c$, $c$- Array: valores entre colchetes, separados por vírgula; [] é o array vazio.
- Ler: nome[posição]. Alterar: nome[posição] = valor.
- const impede trocar o array por outro, mas não impede alterar os elementos.
- Atribuir um array a outra variável não copia: as duas apontam para o mesmo array.
- Para copiar, use [...array].$c$, $c$mundo-6$c$, 602, false, $c$arquivo$c$),
  ($c$indices-e-posicoes$c$, $c$Índices e posições$c$, $c$Acessar elementos pela posição (índice)$c$, $c$O índice é o número da posição de um elemento no array. Em JavaScript (e na maioria das linguagens), a contagem começa em 0: o primeiro elemento tem índice 0, o segundo tem índice 1, e assim por diante.

const cores = ["azul", "verde", "rosa"];
//  índice:      0        1        2

cores[0] é "azul" e cores[2] é "rosa".

Se você pedir um índice que não existe (como cores[3]), o JavaScript não dá erro: devolve undefined, que significa "não há nada aí". Esse é um dos erros mais comuns: confiar que o valor existe e usar o undefined em uma conta (o resultado vira NaN).

O índice pode ser qualquer expressão numérica: cores[1 + 1], cores[i], cores[i - 1]. Isso será essencial para percorrer arrays com laços.

Atenção: o índice do último elemento é a quantidade de elementos menos 1 (veremos na próxima lição).$c$, $c$const v = [10, 20, 30, 40];
const i = 2;
console.log(v[i]);
console.log(v[i - 1]);
console.log(v[4]);

Passo a passo:
1. v[i] com i valendo 2 acessa a terceira posição: mostra 30.
2. v[i - 1] é v[1], a segunda posição: mostra 20.
3. v[4] não existe (o último índice é 3): mostra undefined.$c$, $c$- O índice é a posição do elemento; o primeiro é o 0.
- cores[i] lê o elemento da posição i, e i pode ser uma variável ou uma conta.
- Um índice que não existe devolve undefined (sem erro).
- Usar undefined em uma conta resulta em NaN.
- O último índice é a quantidade de elementos menos 1.$c$, $c$mundo-6$c$, 603, false, $c$arquivo$c$),
  ($c$propriedade-length$c$, $c$Propriedade length$c$, $c$Descobrir quantos elementos o array tem$c$, $c$Todo array tem uma propriedade chamada length (comprimento), que guarda a quantidade de elementos.

const notas = [7, 8, 9];
console.log(notas.length);   // 3

Repare que length não leva parênteses: não é uma função, é uma informação do array.

Como os índices começam em 0, o último elemento tem índice length - 1. Em um array com 3 elementos, os índices são 0, 1 e 2, e o último é notas[notas.length - 1].

Cuidado com um erro clássico: notas[notas.length] não é o último elemento, é uma posição que não existe, e devolve undefined.

Um array vazio tem length 0. Por isso, antes de pegar o último elemento, vale conferir se o array não está vazio.

O length também acompanha as mudanças: quando adicionamos ou removemos elementos, ele se atualiza sozinho.$c$, $c$const v = [5, 6, 7, 8];
console.log(v.length);
console.log(v[v.length - 1]);
console.log(v[v.length]);

Passo a passo:
1. O array tem 4 elementos: v.length mostra 4.
2. O último índice é 4 - 1 = 3: v[3] vale 8.
3. v[4] não existe: mostra undefined.$c$, $c$- array.length é a quantidade de elementos (sem parênteses).
- O último índice é length - 1.
- array[array.length] não existe: devolve undefined.
- Um array vazio tem length 0.
- length se atualiza quando o array cresce ou diminui.$c$, $c$mundo-6$c$, 604, false, $c$arquivo$c$),
  ($c$insercao-com-push$c$, $c$Inserção de elementos com push()$c$, $c$Adicionar elementos no fim do array$c$, $c$O método push() adiciona um ou mais elementos no final do array.

const fila = ["Ana", "Bia"];
fila.push("Caio");     // fila passa a ter Ana, Bia e Caio

Duas coisas importantes sobre o push:
1. Ele altera o próprio array (não cria um novo).
2. Ele devolve o novo tamanho do array, e não o array. Por isso, escrever lista = lista.push(5) é um erro: lista passaria a ser um número.

O push é a forma mais comum de construir um array aos poucos: começamos com um array vazio e, dentro de um laço, vamos adicionando os valores que interessam.

const pares = [];
for (let i = 1; i <= 6; i++) {
  if (i % 2 === 0) {
    pares.push(i);
  }
}
// pares: 2, 4 e 6$c$, $c$const v = [1, 2];
const tamanho = v.push(9);
console.log(tamanho);
console.log(v[2]);

Passo a passo:
1. v tem 2 elementos.
2. v.push(9) adiciona 9 no fim, e o array passa a ter 3 elementos.
3. push devolve o novo tamanho: tamanho vale 3 (mostra 3).
4. O novo elemento está no índice 2: v[2] mostra 9.$c$, $c$- push(valor) adiciona no final do array.
- push altera o próprio array.
- push devolve o novo tamanho, não o array.
- Para construir um array aos poucos: comece com [] e use push dentro do laço.$c$, $c$mundo-6$c$, 605, false, $c$arquivo$c$),
  ($c$remocao-com-pop$c$, $c$Remoção de elementos com pop()$c$, $c$Retirar o último elemento do array$c$, $c$O método pop() remove o último elemento do array e devolve o elemento removido.

const pilha = ["a", "b", "c"];
const retirado = pilha.pop();   // retirado vale "c"; pilha fica com "a" e "b"

Comparando com o push:
- push(valor) acrescenta no final e devolve o novo tamanho;
- pop() retira do final e devolve o elemento retirado.

Como os dois mexem no final do array, eles formam uma pilha: o último a entrar é o primeiro a sair, como uma pilha de pratos.

Se o array estiver vazio, pop() não dá erro: devolve undefined e o array continua vazio.

Atenção: pop altera o próprio array. Se você precisar do array original, faça uma cópia antes ([...v]).$c$, $c$const v = [1, 2, 3];
const x = v.pop();
console.log(x);
console.log(v.length);

Passo a passo:
1. v tem 1, 2 e 3.
2. v.pop() remove o último (3) e o devolve: x vale 3 (mostra 3).
3. O array ficou com 1 e 2: v.length mostra 2.$c$, $c$- pop() remove o último elemento e devolve o elemento removido.
- pop altera o próprio array.
- Em um array vazio, pop() devolve undefined.
- push e pop trabalham no final: formam uma pilha (último a entrar, primeiro a sair).$c$, $c$mundo-6$c$, 606, false, $c$arquivo$c$),
  ($c$shift-e-unshift$c$, $c$Utilização de shift() e unshift()$c$, $c$Trabalhar com o início do array$c$, $c$Enquanto push e pop mexem no final do array, shift e unshift mexem no início.

- shift() remove o primeiro elemento e devolve o elemento removido.
- unshift(valor) adiciona um elemento no início e devolve o novo tamanho.

const fila = ["Ana", "Bia", "Caio"];
const atendido = fila.shift();   // atendido vale "Ana"; fila: Bia, Caio
fila.unshift("Zé");              // fila: Zé, Bia, Caio

Um resumo para não confundir:

| método       | onde mexe | o que faz   | o que devolve     |
| push(x)      | final     | adiciona    | novo tamanho      |
| pop()        | final     | remove      | o removido        |
| unshift(x)   | início    | adiciona    | novo tamanho      |
| shift()      | início    | remove      | o removido        |

Uma fila (primeiro a chegar, primeiro a ser atendido) usa push para entrar e shift para sair.

Todos esses métodos alteram o próprio array.$c$, $c$const v = [1, 2, 3];
const x = v.shift();
const n = v.unshift(9);
console.log(x, n);
console.log(v[0]);

Passo a passo:
1. v.shift() remove o primeiro elemento (1) e devolve 1: x vale 1. v fica com 2 e 3.
2. v.unshift(9) adiciona 9 no início: v fica com 9, 2 e 3. Devolve o novo tamanho: n vale 3.
3. Mostra 1 3, e depois v[0], que é 9.$c$, $c$- shift() remove o primeiro elemento e devolve o removido.
- unshift(x) adiciona no início e devolve o novo tamanho.
- push/pop trabalham no final; unshift/shift trabalham no início.
- Os que adicionam (push, unshift) devolvem o novo tamanho; os que removem (pop, shift) devolvem o elemento removido.
- Uma fila usa push para entrar e shift para sair.$c$, $c$mundo-6$c$, 607, false, $c$arquivo$c$),
  ($c$percorrer-arrays-com-for$c$, $c$Percorrer arrays com for$c$, $c$Visitar cada elemento com um laço for$c$, $c$Percorrer um array é visitar cada um dos seus elementos, do primeiro ao último. O jeito mais comum é um for com um índice:

for (let i = 0; i < v.length; i++) {
  // v[i] é o elemento da vez
}

O índice i começa em 0 (primeira posição) e vai até v.length - 1 (última). Por isso a condição é i < v.length, e não i <= v.length: com <=, o laço tentaria acessar v[v.length], que não existe (undefined), e contas com ele dão NaN.

Com esse laço, você consegue:
- somar os elementos (acumulador);
- contar quantos atendem a uma regra (contador);
- achar o maior ou o menor (guardando o melhor até agora);
- construir outro array com push.

Para percorrer de trás para frente: for (let i = v.length - 1; i >= 0; i--).$c$, $c$const v = [4, 8, 15];
let soma = 0;
for (let i = 0; i < v.length; i++) {
  soma += v[i];
}
console.log(soma);

Passo a passo:
1. soma começa em 0. O laço vai de i = 0 até i = 2 (v.length vale 3).
2. i = 0: soma = 4. i = 1: soma = 12. i = 2: soma = 27.
3. i = 3 não satisfaz i < 3: o laço termina e mostra 27.$c$, $c$- Para percorrer: for (let i = 0; i < v.length; i++) e use v[i].
- A condição é i < v.length; com <= o laço passa do fim.
- Ao passar do fim, v[i] é undefined e contas viram NaN.
- Combine o laço com acumuladores, contadores e push.
- De trás para frente: i começa em v.length - 1 e vai até 0.$c$, $c$mundo-6$c$, 608, false, $c$arquivo$c$),
  ($c$percorrer-arrays-com-while$c$, $c$Percorrer arrays com while$c$, $c$Percorrer um array enquanto uma condição valer$c$, $c$O while também percorre arrays. Ele é a melhor escolha quando não sabemos até onde vamos: por exemplo, procurar um valor e parar assim que o encontrarmos.

let i = 0;
while (i < v.length) {
  // usa v[i]
  i++;
}

Diferente do for, aqui o índice é declarado antes do laço e atualizado dentro do corpo. Esquecer o i++ cria um laço infinito.

Podemos juntar duas condições com && para parar cedo:

let i = 0;
while (i < v.length && v[i] !== 8) {
  i++;
}
// ao sair, i é a posição do primeiro 8 (ou v.length, se não houver)

Repare na ordem: primeiro conferimos i < v.length (para não passar do fim) e só depois olhamos v[i].

Para percorrer de trás para frente, comece em v.length - 1 e use i--.$c$, $c$const v = [3, 8, 5, 8];
let i = 0;
while (i < v.length && v[i] !== 8) {
  i++;
}
console.log(i);

Passo a passo:
1. i = 0: v[0] é 3 (diferente de 8): i passa a 1.
2. i = 1: v[1] é 8: a condição v[i] !== 8 é false e o laço termina.
3. Mostra 1, a posição do primeiro 8.$c$, $c$- while percorre arrays quando a parada depende de uma condição.
- O índice é declarado antes do laço e atualizado dentro dele (i++).
- Sem a atualização, o laço é infinito.
- Confira i < v.length antes de acessar v[i].
- Use && para parar quando achar o que procura.$c$, $c$mundo-6$c$, 609, false, $c$arquivo$c$),
  ($c$introducao-as-matrizes$c$, $c$Introdução às matrizes$c$, $c$Organizar dados em linhas e colunas$c$, $c$Algumas informações naturalmente formam uma tabela: as notas de vários alunos em várias provas, um tabuleiro de jogo, os assentos de um cinema. Para guardá-las, usamos uma matriz: uma tabela organizada em linhas e colunas.

Em JavaScript, uma matriz é um array de arrays: cada elemento do array de fora é uma linha, e cada linha é um array com os valores das colunas.

const notas = [
  [7, 8, 9],     // linha 0: aluno 1
  [5, 6, 10],    // linha 1: aluno 2
];

Essa matriz tem 2 linhas e 3 colunas, e portanto 2 × 3 = 6 elementos.

Como ler os tamanhos:
- notas.length é o número de linhas (quantos arrays existem dentro);
- notas[0].length é o número de colunas (quantos valores tem a primeira linha).

Cuidado para não confundir linha com coluna: linhas são horizontais, colunas são verticais.$c$, $c$const m = [
  [1, 2, 3],
  [4, 5, 6],
];
console.log(m.length);
console.log(m[0].length);

Passo a passo:
1. m é um array com duas linhas: [1, 2, 3] e [4, 5, 6].
2. m.length conta as linhas: mostra 2.
3. m[0] é a primeira linha, [1, 2, 3]; m[0].length conta as colunas: mostra 3.$c$, $c$- Matriz: tabela com linhas e colunas.
- Em JavaScript, é um array de arrays: cada elemento é uma linha.
- matriz.length é o número de linhas; matriz[0].length é o número de colunas.
- Uma matriz com L linhas e C colunas tem L × C elementos.
- Não confunda linha (horizontal) com coluna (vertical).$c$, $c$mundo-6$c$, 610, false, $c$arquivo$c$),
  ($c$arrays-bidimensionais$c$, $c$Arrays bidimensionais$c$, $c$Acessar e alterar elementos de uma matriz$c$, $c$Um array bidimensional é o nome técnico da matriz: tem duas dimensões, linha e coluna. Para acessar um elemento, usamos dois índices:

matriz[linha][coluna]

O primeiro índice escolhe a linha; o segundo, a coluna dentro dela. Os dois começam em 0.

const m = [
  [1, 2, 3],
  [4, 5, 6],
];
m[0][2]   // linha 0, coluna 2: 3
m[1][0]   // linha 1, coluna 0: 4

Como ler: m[1] é a linha inteira (o array [4, 5, 6]) e m[1][0] é o primeiro elemento dessa linha.

Para alterar, atribuímos: m[1][0] = 40.

Truque para não confundir: pense "linha primeiro, coluna depois", como ao procurar uma casa em um mapa: primeiro a rua, depois o número.

As linhas não precisam ter o mesmo tamanho (matrizes irregulares), mas o mais comum é que tenham.$c$, $c$const m = [[1, 2, 3], [4, 5, 6]];
m[1][0] = 40;
console.log(m[1][0] + m[0][2]);

Passo a passo:
1. m[1][0] é a linha 1, coluna 0: valia 4 e passa a valer 40.
2. m[0][2] é a linha 0, coluna 2: vale 3.
3. A soma 40 + 3 é 43, que é mostrada.$c$, $c$- Acesso: matriz[linha][coluna], os dois índices começam em 0.
- matriz[i] é a linha inteira (um array).
- Alterar: matriz[i][j] = valor.
- Pense: linha primeiro, coluna depois.
- As linhas podem ter tamanhos diferentes, mas em geral têm o mesmo.$c$, $c$mundo-6$c$, 611, false, $c$arquivo$c$),
  ($c$percorrer-matrizes$c$, $c$Percorrer matrizes com laços aninhados$c$, $c$Visitar todas as linhas e colunas com dois laços$c$, $c$Para visitar todos os elementos de uma matriz, usamos dois laços aninhados: o de fora percorre as linhas e o de dentro percorre as colunas de cada linha.

for (let i = 0; i < m.length; i++) {          // linhas
  for (let j = 0; j < m[i].length; j++) {     // colunas da linha i
    // m[i][j] é o elemento da vez
  }
}

Os limites:
- o laço das linhas vai até m.length;
- o laço das colunas vai até m[i].length (o tamanho da linha atual).

Com esse padrão você faz o que fazia com arrays simples, mas em duas dimensões: somar todos os elementos, achar o maior, contar valores, mostrar a tabela linha a linha.

Atenção a dois cuidados:
- inicialize acumuladores e contadores antes dos dois laços;
- ao procurar o maior valor, não comece com 0: a matriz pode ter só números negativos. Comece com o primeiro elemento (m[0][0]).$c$, $c$const m = [[1, 2], [3, 4]];
let soma = 0;
for (let i = 0; i < m.length; i++) {
  for (let j = 0; j < m[i].length; j++) {
    soma += m[i][j];
  }
}
console.log(soma);

Passo a passo:
1. i = 0 (primeira linha): j = 0 soma 1; j = 1 soma 2. soma vale 3.
2. i = 1 (segunda linha): j = 0 soma 3; j = 1 soma 4. soma vale 10.
3. Os laços terminam e o programa mostra 10.$c$, $c$- Dois laços aninhados: o externo percorre as linhas, o interno percorre as colunas.
- Limites: i < m.length e j < m[i].length.
- m[i][j] é o elemento da vez.
- Declare acumuladores e contadores antes dos laços.
- Para achar o maior valor, comece pelo primeiro elemento, não por 0.$c$, $c$mundo-6$c$, 612, false, $c$arquivo$c$),
  ($c$desafio-do-mundo-6$c$, $c$Desafio final do Mundo 6$c$, $c$Guardar as notas da turma em um vetor e analisá-las$c$, $c$Chegou o desafio do Mundo 6: um programa de notas da turma. Você vai ler as notas dos estudantes, guardá-las em um vetor e calcular a média da turma, a maior nota e quantos estudantes ficaram acima da média.

Aqui você junta tudo: vetor para guardar os valores, push para ir montando o vetor, laços para percorrê-lo, acumulador para a soma e variável auxiliar para a maior nota.

O desafio principal é o primeiro exercício. Os outros dois treinam a leitura de laços com vetores e a correção de um erro clássico no acumulador.$c$, $c$Como montar o programa:
1. Leia a quantidade de notas com lerEntrada() e converta com Number().
2. Crie um vetor vazio e, em um laço, leia cada nota, converta e guarde com push.
3. Percorra o vetor para somar as notas e descobrir a maior.
4. Calcule a média: soma ÷ quantidade.
5. Percorra o vetor de novo, contando as notas maiores que a média.
6. Mostre os três resultados com console.log.
7. Teste um caso com notas repetidas e um caso em que ninguém passa da média.$c$, $c$- Vetor para guardar as notas; push para adicioná-las.
- Dois percursos: um para somar e achar a maior; outro para contar as acima da média (a média só é conhecida depois do primeiro).
- Acumulador começa em 0; a maior nota começa pela primeira nota.
- Média = soma ÷ quantidade.
- Teste os casos de fronteira.$c$, $c$mundo-6$c$, 613, false, $c$arquivo$c$),
  ($c$funcoes$c$, $c$Funções$c$, $c$Dividir um problema em partes reutilizáveis$c$, $c$Quando um trecho de código se repete, vale transformá-lo numa função e reutilizá-la. Uma função boa faz uma coisa só e tem um nome que diz o que ela faz.

function ehPar(n) {
  return n % 2 === 0;
}

Uma função pode chamar outras funções: assim você divide um problema grande em partes pequenas que dá para testar separadamente.$c$, $c$$c$, $c$$c$, $c$mundo-7$c$, 790, false, $c$arquivo$c$),
  ($c$introducao-as-funcoes$c$, $c$Introdução às funções$c$, $c$Entender por que e como organizar o código em funções$c$, $c$Uma receita de bolo não explica de novo como bater ovos toda vez que aparece "bata os ovos": ela dá um nome ao passo e o reaproveita. Uma função faz o mesmo no código: é um bloco de instruções com um nome, que você escreve uma vez e usa quantas vezes quiser.

Funções trazem três vantagens:
- Reaproveitamento: o mesmo trecho é usado em vários lugares, sem copiar e colar.
- Organização: o programa vira peças pequenas, cada uma com um nome que explica o que faz.
- Manutenção: se algo precisa mudar, você corrige em um lugar só.

Usar uma função tem duas etapas:
1. Declarar: escrever a função (isso só ensina ao computador o que fazer, não executa nada).
2. Chamar: usar o nome da função com parênteses (aí o bloco é executado).

Esquecer a chamada é um erro comum: a função existe, mas nada acontece.

Nos mundos anteriores você já escreveu funções para resolver os exercícios. Agora vamos entender como elas funcionam por dentro.$c$, $c$function saudar() {
  console.log("Olá!");
}

saudar();
saudar();

Passo a passo:
1. A declaração function saudar() { ... } ensina o computador o que é "saudar". Nada é mostrado ainda.
2. saudar(); é a primeira chamada: o bloco executa e mostra Olá!
3. saudar(); é a segunda chamada: o mesmo bloco executa de novo e mostra Olá!

Resultado: Olá! aparece duas vezes, sem repetir o console.log no código.$c$, $c$- Função: bloco de instruções com um nome, reaproveitável.
- Vantagens: reaproveitar código, organizar o programa e facilitar a manutenção.
- Declarar a função não a executa; é preciso chamá-la.
- Para chamar, use o nome seguido de parênteses.
- Uma função declarada e nunca chamada não faz nada.$c$, $c$mundo-7$c$, 701, false, $c$arquivo$c$),
  ($c$declaracao-de-funcoes$c$, $c$Declaração de funções$c$, $c$Escrever a estrutura de uma função$c$, $c$Declarar uma função é escrever a sua estrutura:

function nomeDaFuncao(parametros) {
  // corpo: as instruções da função
}

As partes:
- a palavra function;
- o nome, que deve dizer o que a função faz (calcularMedia, ehPar, mostrarMenu). Começa com letra minúscula e usa camelCase;
- parênteses, com os parâmetros dentro (podem ser vazios);
- chaves { }, que delimitam o corpo.

Boas práticas:
- Dê nomes que descrevem uma ação: calcularArea é melhor que f1.
- Cada função deve fazer uma coisa só.
- Funções pequenas são mais fáceis de entender e testar.

Detalhe: em JavaScript, as declarações de função são "içadas": podemos chamar uma função antes da linha em que ela é declarada, desde que ela esteja declarada no mesmo arquivo. Mesmo assim, é mais claro declarar antes de usar.

Lembre-se: declarar não executa. O corpo só roda quando a função é chamada.$c$, $c$console.log("A");

function mostrar() {
  console.log("B");
}

console.log("C");
mostrar();

Passo a passo:
1. console.log("A") mostra A.
2. A declaração de mostrar não executa nada.
3. console.log("C") mostra C.
4. mostrar() é chamada: o corpo executa e mostra B.

Resultado: A, C e B (nessa ordem).$c$, $c$- Estrutura: function nome(parâmetros) { corpo }.
- O nome deve descrever o que a função faz (camelCase, em geral começando por um verbo).
- Cada função deve fazer uma coisa só.
- Declarar não executa: o corpo só roda quando a função é chamada.
- Funções declaradas podem ser chamadas antes da linha da declaração (içamento).$c$, $c$mundo-7$c$, 702, false, $c$arquivo$c$),
  ($c$chamada-de-funcoes$c$, $c$Chamada de funções$c$, $c$Executar uma função e usar o que ela devolve$c$, $c$Chamar uma função é pedir para executá-la. Para isso, escrevemos o nome da função seguido de parênteses:

saudar();
const resultado = dobro(5);

Os parênteses são obrigatórios. Sem eles, você não está chamando a função: está apenas se referindo a ela, como a um valor.

const x = dobro;      // x passa a ser a própria função (nada foi executado)
const y = dobro(5);   // y recebe o valor devolvido pela chamada (10)

Quando a função devolve um valor, a chamada vira esse valor dentro da expressão. Por isso podemos usar a chamada em contas, comparações e até como argumento de outra chamada:

console.log(dobro(2) + dobro(3));   // 4 + 6
console.log(dobro(dobro(2)));       // dobro(4)

Uma função também pode chamar outra função. Assim, construímos funções maiores combinando funções pequenas, cada uma com uma tarefa.$c$, $c$function soma(a, b) {
  return a + b;
}

function dobroDaSoma(a, b) {
  return soma(a, b) * 2;
}

console.log(dobroDaSoma(2, 3));

Passo a passo:
1. dobroDaSoma(2, 3) é chamada e, dentro dela, soma(2, 3) é chamada.
2. soma(2, 3) devolve 5.
3. A conta 5 * 2 resulta em 10, que dobroDaSoma devolve.
4. O console.log mostra 10.$c$, $c$- Chamar: nome da função seguido de parênteses.
- Sem os parênteses, a função não executa: tem-se só uma referência a ela.
- Quando a função devolve um valor, a chamada vale esse valor na expressão.
- Uma chamada pode ser argumento de outra: dobro(dobro(2)).
- Uma função pode chamar outras funções.$c$, $c$mundo-7$c$, 703, false, $c$arquivo$c$),
  ($c$parametros$c$, $c$Parâmetros$c$, $c$Receber dados de fora para dentro da função$c$, $c$Até agora, nossas funções faziam sempre a mesma coisa. Com parâmetros, a função recebe informações de fora e pode trabalhar com valores diferentes a cada chamada.

Parâmetros são as variáveis listadas entre parênteses na declaração da função:

function saudar(nome) {
  console.log("Oi, " + nome);
}

Aqui, nome é um parâmetro. Dentro da função, ele funciona como uma variável comum, que começa valendo o que foi enviado na chamada.

Uma função pode ter vários parâmetros, separados por vírgula: function area(base, altura). A ordem importa: o primeiro valor enviado vai para o primeiro parâmetro, o segundo para o segundo, e assim por diante.

Outro detalhe importante: o parâmetro é uma variável local da função. Se você alterar o parâmetro dentro da função, a variável original, de fora, não muda (para números, textos e booleanos).

Pense no parâmetro como um espaço reservado na receita: "coloque X colheres de açúcar". O valor de X só é conhecido na hora de preparar.$c$, $c$function mostrar(nome) {
  console.log("Oi, " + nome);
}

mostrar("Ana");
mostrar("Bia");

Passo a passo:
1. nome é o parâmetro de mostrar: um espaço que receberá um valor.
2. Na primeira chamada, nome vale "Ana" e o programa mostra Oi, Ana.
3. Na segunda chamada, nome vale "Bia" e o programa mostra Oi, Bia.

A mesma função, com resultados diferentes.$c$, $c$- Parâmetros são as variáveis entre parênteses na declaração da função.
- Eles recebem os valores enviados na chamada, pela ordem.
- Uma função pode ter vários parâmetros, separados por vírgula.
- O parâmetro é local: alterá-lo não muda a variável de fora (números, textos e booleanos).
- Parâmetros tornam a função flexível: o mesmo código trabalha com valores diferentes.$c$, $c$mundo-7$c$, 704, false, $c$arquivo$c$),
  ($c$argumentos$c$, $c$Argumentos$c$, $c$Enviar valores na chamada da função$c$, $c$Argumentos são os valores que enviamos na chamada da função. Eles preenchem os parâmetros, pela ordem.

function somar(a, b) {      // a e b: parâmetros
  return a + b;
}
somar(2, 3);                // 2 e 3: argumentos

Resumindo a diferença: o parâmetro é o espaço da declaração; o argumento é o valor da chamada.

Os argumentos podem ser valores, variáveis ou expressões. As expressões são resolvidas antes de a função executar: somar(1 + 1, 3) envia 2 e 3.

O que acontece se a quantidade não bater?
- Faltou argumento: o parâmetro correspondente vale undefined. Em contas, isso produz NaN.
- Sobrou argumento: o valor extra é ignorado.

A correspondência é por posição, não por nome. Os nomes das variáveis que você usa na chamada não precisam ser iguais aos dos parâmetros:

const x = 5; const y = 2;
somar(y, x);   // envia 2 e 5; a recebe 2 e b recebe 5

Por isso, a ordem dos argumentos é um detalhe que muda o resultado (em subtrações e divisões, por exemplo).$c$, $c$function diferenca(a, b) {
  return a - b;
}

const x = 5;
const y = 2;
console.log(diferenca(x, y));
console.log(diferenca(y, x));

Passo a passo:
1. diferenca(x, y) envia 5 e 2: a vale 5, b vale 2 e o resultado é 3.
2. diferenca(y, x) envia 2 e 5: a vale 2, b vale 5 e o resultado é -3.

Os nomes x e y não importam: o que conta é a posição de cada argumento.$c$, $c$- Argumento: o valor enviado na chamada; parâmetro: a variável da declaração.
- Os argumentos preenchem os parâmetros pela ordem (posição), não pelo nome.
- Podem ser valores, variáveis ou expressões (resolvidas antes).
- Argumento faltando: o parâmetro vira undefined (e contas dão NaN).
- Argumento sobrando: é ignorado.$c$, $c$mundo-7$c$, 705, false, $c$arquivo$c$),
  ($c$retorno-com-return$c$, $c$Retorno com return$c$, $c$Devolver o resultado da função$c$, $c$O comando return devolve um valor para quem chamou a função e encerra a função na hora.

function dobro(n) {
  return n * 2;
}
const r = dobro(4);   // r recebe 8

Três pontos para não esquecer:

1. Devolver é diferente de mostrar. console.log mostra um valor na tela, mas o valor se perde; return entrega o valor ao programa, que pode guardá-lo, somá-lo, compará-lo. Uma função que só usa console.log devolve undefined.

2. Sem return, a função devolve undefined. Calcular n * 2 sem return não faz nada útil.

3. Depois do return, a função termina: nenhuma linha seguinte é executada. Por isso podemos usar return dentro de um if ou de um laço para sair assim que o resultado é conhecido:

function primeiroPar(v) {
  for (let i = 0; i < v.length; i++) {
    if (v[i] % 2 === 0) {
      return v[i];
    }
  }
  return -1;
}

Cada caminho possível da função deveria terminar em um return, para que ela sempre devolva algo.$c$, $c$function f(n) {
  console.log(n);
  return n * 2;
}

const r = f(3);
console.log(r);

Passo a passo:
1. f(3) executa: o console.log mostra 3.
2. return n * 2 devolve 6 e encerra a função.
3. r recebe 6.
4. O segundo console.log mostra 6.

O console.log mostrou 3 (efeito colateral); o return entregou 6 ao programa.$c$, $c$- return devolve um valor a quem chamou e encerra a função.
- console.log mostra na tela; return entrega o valor ao programa. Não são a mesma coisa.
- Sem return, a função devolve undefined.
- O que vem depois do return não executa.
- Use return dentro de if e laços para sair assim que o resultado for conhecido.$c$, $c$mundo-7$c$, 706, false, $c$arquivo$c$),
  ($c$funcoes-com-parametros-e-retornos$c$, $c$Funções com parâmetros e retornos$c$, $c$Combinar entrada e saída para criar funções reutilizáveis$c$, $c$As funções mais úteis combinam as duas ideias: recebem dados por parâmetros e devolvem o resultado com return. É como uma máquina: você coloca ingredientes na entrada (parâmetros) e recebe o produto na saída (retorno), sem precisar saber como ela funciona por dentro.

function calcularTotal(preco, quantidade) {
  return preco * quantidade;
}

Uma função assim é reutilizável porque:
- usa só o que recebeu por parâmetros (não depende de variáveis soltas pelo programa);
- devolve o resultado em vez de apenas mostrá-lo;
- sempre dá a mesma resposta para os mesmos argumentos.

Como o retorno é um valor, ele pode alimentar outra função:

console.log(dobro(soma(1, 2)));   // soma devolve 3; dobro devolve 6

Montar o programa em funções pequenas que se encaixam é a base da modularização: cada função resolve um pedaço do problema e o programa final junta os pedaços.

Cuidado: se a função tiver vários caminhos (if, else), todos devem terminar em um return. Um caminho sem return devolve undefined.$c$, $c$function media(a, b) {
  return (a + b) / 2;
}

function situacao(a, b) {
  return media(a, b) >= 7 ? "aprovado" : "reprovado";
}

console.log(situacao(8, 7));
console.log(situacao(4, 6));

Passo a passo:
1. situacao(8, 7) chama media(8, 7), que devolve 7.5.
2. 7.5 >= 7 é true: devolve "aprovado".
3. situacao(4, 6): media devolve 5, 5 >= 7 é false: devolve "reprovado".

Duas funções pequenas, cada uma com uma tarefa, resolvem o problema juntas.$c$, $c$- Parâmetros levam dados para dentro; return traz o resultado para fora.
- Uma função reutilizável depende só dos parâmetros e devolve o resultado.
- O retorno de uma função pode ser usado como argumento de outra.
- Todos os caminhos da função devem terminar em um return.
- Modularizar é dividir o problema em funções pequenas que se encaixam.$c$, $c$mundo-7$c$, 707, false, $c$arquivo$c$),
  ($c$escopo-global$c$, $c$Escopo global$c$, $c$Entender variáveis visíveis em todo o programa$c$, $c$O escopo é a região do programa onde uma variável pode ser usada. Uma variável declarada fora de qualquer função tem escopo global: ela existe em todo o programa e pode ser lida por qualquer função.

const taxa = 0.1;                 // global

function imposto(valor) {
  return valor * taxa;            // a função enxerga taxa
}

Funções podem não só ler, mas também alterar variáveis globais:

let contador = 0;
function incrementar() {
  contador = contador + 1;        // altera a variável de fora
}

Isso funciona, mas traz riscos. Quando uma variável pode ser mudada por qualquer função, fica difícil saber quem a alterou e quando. É a origem de muitos erros difíceis de achar: duas funções mexendo na mesma variável sem se darem conta.

A prática recomendada:
- use constantes globais para valores que nunca mudam (const taxa = 0.1);
- passe os dados que a função precisa por parâmetros e devolva o resultado com return, em vez de alterar variáveis globais;
- evite que funções dependam de valores soltos pelo programa.$c$, $c$let n = 1;

function dobrar() {
  n = n * 2;
}

dobrar();
dobrar();
console.log(n);

Passo a passo:
1. n é global e vale 1.
2. A primeira chamada de dobrar altera a variável de fora: n passa a valer 2.
3. A segunda chamada altera de novo: n passa a valer 4.
4. O console.log mostra 4.

Como a função mexeu na variável global, o valor ficou "lembrado" entre as chamadas.$c$, $c$- Escopo global: variável declarada fora de qualquer função, visível em todo o programa.
- Funções podem ler e também alterar variáveis globais.
- Alterar globais dentro de funções é arriscado: qualquer parte do programa pode mudar o valor sem querer.
- Prefira passar dados por parâmetros e devolver com return.
- Constantes globais (const) são seguras para valores que não mudam.$c$, $c$mundo-7$c$, 708, false, $c$arquivo$c$),
  ($c$escopo-local$c$, $c$Escopo local$c$, $c$Entender variáveis que só existem dentro da função$c$, $c$Uma variável declarada dentro de uma função tem escopo local: ela só existe dentro daquela função, e deixa de existir quando a função termina. Os parâmetros também são variáveis locais.

function calcular(n) {
  const dobro = n * 2;     // local: só existe aqui dentro
  return dobro;
}
calcular(4);
console.log(typeof dobro);  // "undefined": fora da função, dobro não existe

Consequências importantes:
- Fora da função, não dá para usar uma variável local. Para levar um valor para fora, use return.
- Cada chamada cria suas próprias variáveis locais, do zero. Um acumulador declarado dentro da função recomeça a cada chamada, e isso é bom: uma chamada não interfere na outra.
- Duas funções podem usar o mesmo nome de variável sem conflito: cada uma tem a sua.
- Se uma variável local tem o mesmo nome de uma global, dentro da função vale a local (ela "esconde" a global), e a global não é alterada.

O mesmo vale para blocos: uma variável declarada com let dentro de um if ou de um for só existe dentro dele (o i de um for não existe depois do laço).$c$, $c$let x = 1;

function f() {
  let x = 2;
  return x;
}

console.log(f(), x);

Passo a passo:
1. Existem duas variáveis diferentes chamadas x: a global (1) e a local de f (2).
2. Dentro de f, o nome x se refere à local: a função devolve 2.
3. Fora da função, x continua sendo a global: vale 1.
4. O programa mostra 2 1.$c$, $c$- Variável local: declarada dentro da função; só existe nela.
- Parâmetros também são locais.
- Para levar um valor para fora, use return.
- Cada chamada cria variáveis locais novas (acumuladores recomeçam).
- Uma local com o mesmo nome de uma global a esconde, sem alterá-la.
- let em blocos (if, for) só existe dentro do bloco.$c$, $c$mundo-7$c$, 709, false, $c$arquivo$c$),
  ($c$arrow-functions$c$, $c$Arrow functions$c$, $c$Conhecer uma forma mais curta de escrever funções$c$, $c$Este é um conteúdo complementar: ele não bloqueia a liberação do que vem a seguir. Vale estudar, mas você pode seguir em frente sem concluí-lo.

As arrow functions ("funções seta") são uma forma mais curta de escrever funções. Em vez da palavra function, usamos uma seta (=>) e guardamos a função em uma variável:

const dobro = (n) => n * 2;

É equivalente a:

function dobro(n) {
  return n * 2;
}

Regras da forma curta:
- Sem chaves, o valor depois da seta é devolvido automaticamente (retorno implícito): (n) => n * 2.
- Com chaves { }, você precisa escrever return: (n) => { return n * 2; }. Sem o return, a função devolve undefined.
- Com um único parâmetro, os parênteses são opcionais (n => n * 2); com vários ou nenhum, são obrigatórios: (a, b) => a + b, () => 5.

A chamada é igual à de qualquer função: dobro(4).

Quando usar? Em funções curtas, a seta deixa o código mais enxuto. Para funções maiores, a declaração com function costuma ser mais clara. O resultado é o mesmo.$c$, $c$const soma = (a, b) => a + b;
const dobrar = (n) => n * 2;

console.log(dobrar(soma(1, 2)));

Passo a passo:
1. soma é uma função que recebe a e b e devolve a + b (retorno implícito, sem chaves).
2. dobrar recebe n e devolve n * 2.
3. soma(1, 2) devolve 3 e dobrar(3) devolve 6.
4. O programa mostra 6.$c$, $c$- Arrow function: (parâmetros) => expressão, guardada em uma variável.
- Sem chaves, o valor da expressão é devolvido automaticamente.
- Com chaves, é preciso usar return (senão devolve undefined).
- Com um só parâmetro, os parênteses são opcionais.
- É uma forma mais curta: funciona como uma função comum.$c$, $c$mundo-7$c$, 710, true, $c$arquivo$c$),
  ($c$desafio-do-mundo-7$c$, $c$Desafio final do Mundo 7$c$, $c$Montar uma calculadora organizada em funções$c$, $c$Chegou o desafio final do curso: uma calculadora organizada em funções. Cada operação (somar, subtrair, multiplicar, dividir) vira uma função pequena e uma função principal escolhe qual usar. Esse é o exemplo clássico de modularização: peças simples que se encaixam.

Você vai reaproveitar tudo o que viu nos mundos anteriores: operadores (Mundo 3), decisões com if e switch (Mundo 4), leitura de entradas (Mundo 2) e, claro, funções com parâmetros e retornos (Mundo 7).

O desafio principal é o primeiro exercício. Os outros dois treinam usar uma função pronta e achar defeitos em funções que trabalham juntas.$c$, $c$Como montar a calculadora:
1. Crie uma função para cada operação, com dois parâmetros e return: somar, subtrair, multiplicar e dividir.
2. Na divisão, trate o divisor zero: devolva o texto "Divisão por zero" em vez de dividir.
3. Crie a função calcular(operacao, a, b) que escolhe a função certa com if/else if ou switch.
4. Para uma operação desconhecida, devolva "Operação inválida".
5. Teste cada operação, a divisão por zero e uma operação desconhecida.

Dica: se uma função já resolve a conta, a outra só precisa chamá-la.$c$, $c$- Uma função por tarefa: cada operação tem a sua.
- Uma função principal decide qual usar (if/else if ou switch).
- Todos os caminhos devolvem um valor com return.
- Trate os casos especiais (divisão por zero, operação desconhecida).
- Reaproveite funções prontas chamando-as de outras funções.$c$, $c$mundo-7$c$, 711, false, $c$arquivo$c$)
on conflict (id) do update set title = excluded.title, focus = excluded.focus, intro = excluded.intro,
  example = excluded.example, review = excluded.review, world_id = excluded.world_id, position = excluded.position,
  optional = excluded.optional
  where public.modules.origem = 'arquivo';

