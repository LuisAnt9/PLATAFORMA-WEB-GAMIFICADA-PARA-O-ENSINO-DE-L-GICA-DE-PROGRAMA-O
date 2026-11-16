# Revisão do conteúdo — Introdução à Lógica de Programação

> GERADO por `npm run content:review`. Não edite este arquivo: ele muda quando o conteúdo mudar.

**Objetivo do mundo:** Fazer o aluno compreender o que é programação e como organizar instruções para resolver problemas.

Este documento reúne tudo o que os alunos vão ver neste mundo: 8 lições e 47 exercícios. **Nada foi publicado:** os exercícios estão como rascunho e só o professor os vê.

## Como revisar
1. Leia cada lição (texto, exemplo, revisão e exercícios) como se fosse um aluno iniciante.
2. Confira o gabarito (✔) e as "confusões" das alternativas erradas: elas alimentam o painel de dificuldades.
3. Anote ajustes por lição. Peça a correção ao Claude, que altera os arquivos de `content/`.
4. Quando aprovar, publique com `npm run content:publish -- mundo-1` (gera o SQL para colar no Supabase).

## Resumo
| Lição | Exercícios | Fácil | Médio | Difícil | Tipos |
|---|---:|---:|---:|---:|---|
| O que é programação? | 6 | 3 | 2 | 1 | 3 múltipla escolha, 1 completar a lacuna, 2 interpretação de código |
| O que é lógica de programação? | 7 | 3 | 3 | 1 | 3 múltipla escolha, 1 completar a lacuna, 2 interpretação de código, 1 ordenação |
| O que são algoritmos? | 6 | 3 | 2 | 1 | 3 múltipla escolha, 1 ordenação, 2 interpretação de código |
| Sequência lógica | 6 | 2 | 3 | 1 | 3 ordenação, 1 múltipla escolha, 2 interpretação de código |
| Entrada, processamento e saída | 7 | 3 | 3 | 1 | 3 múltipla escolha, 2 código, 2 interpretação de código |
| Pseudocódigo | 6 | 3 | 2 | 1 | 2 múltipla escolha, 1 completar a lacuna, 2 interpretação de código, 1 ordenação |
| Fluxogramas | 6 | 3 | 2 | 1 | 4 múltipla escolha, 2 interpretação de código |
| Desafio final do Mundo 1 | 3 | 0 | 0 | 3 | 1 ordenação, 1 completar a lacuna, 1 interpretação de código |

---

## Lição 1 — O que é programação?

**Foco:** Entender que programar é escrever instruções para o computador executar

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Programar é escrever instruções para que o computador faça uma tarefa. O computador é muito rápido e não se cansa, mas não pensa por conta própria: ele só faz exatamente o que mandamos, na ordem em que mandamos.
> 
> Três palavras aparecem o tempo todo:
> - Programador: a pessoa que escreve as instruções.
> - Programa: o conjunto de instruções escrito pelo programador (um jogo, um aplicativo de banco, o semáforo de uma rua).
> - Linguagem de programação: a "língua" usada para escrever as instruções de um jeito que o computador entenda. Neste curso, a linguagem é o JavaScript.
> 
> Por isso as instruções precisam ser claras e completas. Dizer "faça um café" funciona entre pessoas, mas o computador precisa de cada passo, sem nada subentendido.

### Exemplo

```
Este é um programa de uma única instrução, escrito em JavaScript:

console.log("Olá, mundo!");

Passo a passo:
1. console.log é o comando que manda o computador mostrar algo na tela.
2. O que está entre parênteses é o que será mostrado. O que está entre aspas é um texto e aparece exatamente como foi escrito.
3. O ponto e vírgula (;) marca o fim da instrução.

Ao executar, o computador mostra: Olá, mundo!

Com duas instruções, o computador as executa de cima para baixo, uma de cada vez:

console.log("Bom dia");
console.log("Tudo bem?");

Resultado: primeiro Bom dia, depois Tudo bem?.
```

### Revisão

- Programar é escrever instruções para o computador executar.
- O programador escreve o programa; a linguagem de programação é a "língua" usada para escrevê-lo.
- O computador não pensa sozinho: segue as instruções, em ordem, do jeito que foram escritas.
- Instruções precisam ser claras e completas.
- console.log mostra um resultado na tela.

### Exercícios

#### 1. O que é programar?

*Múltipla escolha · fácil · id `prog-o-que-e-programar` · conceitos: O que é programação? (peso 3)*

Qual alternativa descreve melhor o que é programar?

- ✗ Consertar computadores que quebraram — *confusão: confunde programar com fazer manutenção de equipamentos*
- ✔ **Escrever instruções para o computador executar** (correta)
- ✗ Usar aplicativos prontos, como o WhatsApp — *confusão: confunde usar um programa com criar um programa*
- ✗ Digitar textos em um editor de documentos — *confusão: acha que programar é só digitar*

**Dica:** Pense em quem cria o aplicativo, e não em quem o usa.

**Ao acertar:** Programar é escrever instruções que o computador consegue executar. Quem usa um aplicativo não está programando: está usando o resultado de um programa.

#### 2. Linguagem, programa e programador

*Múltipla escolha · fácil · id `prog-quem-e-quem` · conceitos: O que é programação? (peso 3)*

Na frase "o programador escreve um programa em JavaScript", o que é o JavaScript?

- ✗ O computador que executa as instruções — *confusão: confunde a linguagem com a máquina*
- ✗ O programa que foi escrito — *confusão: confunde a linguagem com o resultado escrito nela*
- ✗ A pessoa que escreve as instruções — *confusão: confunde a linguagem com o programador*
- ✔ **A linguagem de programação usada para escrever o programa** (correta)

**Dica:** Quem escreve, o que é escrito e a língua em que se escreve são três coisas diferentes.

**Ao acertar:** O JavaScript é a linguagem: a "língua" em que as instruções são escritas. O programador escreve, o programa é o resultado e o computador o executa.

#### 3. Complete o primeiro programa

*Completar a lacuna · fácil · id `prog-complete-ola-mundo` · conceitos: O que é programação? (peso 2)*

Complete o programa para que o computador mostre a mensagem Olá, mundo! na tela.

```
{{1}}.{{2}}("Olá, mundo!");
```

Respostas aceitas: lacuna 1: console; lacuna 2: log

**Dica:** O comando que mostra algo na tela tem duas partes separadas por um ponto.

**Ao acertar:** console.log é o comando que manda o computador mostrar o que está entre parênteses.

#### 4. O que aparece na tela?

*Interpretação de código · médio · id `prog-ordem-das-instrucoes` · conceitos: O que é programação? (peso 2); Sequência lógica (peso 1)*

O computador executa o programa abaixo. O que ele mostra na tela, em ordem?

```
console.log("Bom dia");
console.log("Boa tarde");
```

- ✔ **Bom dia e depois Boa tarde** (correta)
- ✗ Boa tarde e depois Bom dia — *confusão: acha que o computador executa as instruções de baixo para cima*
- ✗ Apenas Boa tarde — *confusão: acha que a última instrução apaga o resultado das anteriores*
- ✗ As duas frases, em qualquer ordem — *confusão: acha que a ordem das instruções não importa*

**Dica:** O computador lê o programa de cima para baixo.

**Ao acertar:** Cada console.log mostra uma linha, e as instruções são executadas na ordem em que aparecem: primeiro Bom dia, depois Boa tarde.

#### 5. Texto ou conta?

*Interpretação de código · médio · id `prog-texto-ou-conta` · conceitos: O que é programação? (peso 2)*

Veja o programa abaixo. O que o computador mostra, em ordem?

```
console.log("2 + 3");
console.log(2 + 3);
```

- ✗ 5 e depois 5 — *confusão: acha que o texto entre aspas também é calculado*
- ✗ 2 + 3 e depois 2 + 3 — *confusão: acha que o computador não faz contas*
- ✔ **2 + 3 e depois 5** (correta)
- ✗ 5 e depois 2 + 3 — *confusão: acha que o computador executa as instruções de baixo para cima*

**Dica:** O que está entre aspas é um texto e é mostrado exatamente como foi escrito.

**Ao acertar:** Com aspas, o computador mostra o texto como está: 2 + 3. Sem aspas, ele calcula a conta e mostra o resultado: 5.

#### 6. De quem é o erro?

*Múltipla escolha · difícil · id `prog-quem-responde-pelo-erro` · conceitos: O que é programação? (peso 3); O que é lógica de programação? (peso 1)*

O programa de um semáforo mostra as cores na ordem errada e causa confusão no cruzamento. Quem deve corrigir o problema?

- ✗ O próprio computador, que decidiu errar — *confusão: acha que o computador toma decisões próprias*
- ✔ **Quem escreveu o programa, revisando as instruções** (correta)
- ✗ A linguagem JavaScript, que estava com defeito — *confusão: culpa a linguagem em vez de rever as instruções escritas*
- ✗ Ninguém: programas não têm erros — *confusão: acha que programas não podem conter erros*

**Dica:** Lembre que o computador só faz o que foi mandado.

**Ao acertar:** O computador obedece às instruções exatamente como foram escritas. Se a ordem das cores está errada, o erro está nas instruções, e quem as escreveu precisa revisá-las.

---

## Lição 2 — O que é lógica de programação?

**Foco:** Organizar o raciocínio em passos claros e coerentes antes de programar

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Lógica é pensar de forma organizada, sem contradições, para chegar a uma conclusão. Lógica de programação é aplicar esse raciocínio para planejar a solução de um problema em passos claros, antes de escrever qualquer código.
> 
> Antes de programar, vale responder quatro perguntas:
> 1. Qual é o problema?
> 2. Que informações eu tenho?
> 3. O que eu quero obter no final?
> 4. Em que passos chego lá?
> 
> Usamos lógica o tempo todo: "se estiver chovendo, levo o guarda-chuva; senão, não levo". Também há raciocínios com premissas e conclusão: "Todo gato é animal. Mimi é um gato. Logo, Mimi é um animal."
> 
> Aprender lógica de programação não exige ser bom em matemática avançada: exige ordem, atenção e vontade de testar o raciocínio.

### Exemplo

```
Problema: decidir se devo levar o guarda-chuva.

1. Informação que eu tenho: está chovendo ou não está chovendo.
2. O que eu quero obter: a decisão de levar ou não o guarda-chuva.
3. Raciocínio em passos:
   - Verificar se está chovendo.
   - Se estiver, levar o guarda-chuva.
   - Se não estiver, deixar o guarda-chuva em casa.

Repare que ainda não escrevemos nenhum código. Primeiro organizamos o raciocínio; depois, será fácil transformá-lo em programa. Quem pula essa etapa costuma escrever instruções confusas ou incompletas.
```

### Revisão

- Lógica de programação é organizar o raciocínio em passos claros e coerentes.
- Antes de programar: qual é o problema, que informações tenho, o que quero obter e em quais passos.
- Um bom raciocínio não tem contradições.
- Cuidado ao inverter regras: "todo A é B" não significa "todo B é A".
- Não é preciso decorar comandos para começar: é preciso treinar o raciocínio.

### Exercícios

#### 1. O que é lógica de programação?

*Múltipla escolha · fácil · id `logica-o-que-e` · conceitos: O que é lógica de programação? (peso 3)*

Qual alternativa descreve melhor a lógica de programação?

- ✗ Decorar todos os comandos de uma linguagem — *confusão: confunde lógica com memorizar a sintaxe da linguagem*
- ✗ Ser bom em matemática avançada — *confusão: acha que lógica de programação exige matemática avançada*
- ✗ Usar um computador mais rápido — *confusão: associa a lógica à velocidade da máquina*
- ✔ **Organizar o raciocínio em passos claros para resolver um problema** (correta)

**Dica:** Pense no que você faz antes de escrever qualquer código.

**Ao acertar:** Lógica de programação é o raciocínio organizado que planeja a solução em passos. A linguagem é só a forma de escrever esse plano para o computador.

#### 2. O que podemos concluir?

*Múltipla escolha · fácil · id `logica-deducao-simples` · conceitos: O que é lógica de programação? (peso 3)*

Todo aluno do curso estuda lógica. Ana é aluna do curso. O que podemos concluir?

- ✔ **Ana estuda lógica** (correta)
- ✗ Todos que estudam lógica são alunos do curso — *confusão: inverte a regra, confundindo "todo A é B" com "todo B é A"*
- ✗ Ana não estuda lógica — *confusão: contradiz uma informação que foi dada*
- ✗ Não dá para concluir nada — *confusão: não aplica as informações que foram dadas*

**Dica:** Aplique a regra geral ao caso da Ana.

**Ao acertar:** A regra vale para todos os alunos do curso. Como Ana é aluna, a regra vale para ela: Ana estuda lógica.

#### 3. Complete o raciocínio

*Completar a lacuna · fácil · id `logica-se-entao-senao` · conceitos: O que é lógica de programação? (peso 2)*

Complete a frase com as palavras que faltam.

```
Se estiver chovendo, {{1}} levo o guarda-chuva; {{2}} não levo.
```

Respostas aceitas: lacuna 1: então ou ENTÃO ou Então; lacuna 2: senão ou SENÃO ou Senão

**Dica:** Uma palavra indica a consequência; a outra, o que acontece no caso contrário.

**Ao acertar:** "Se... então... senão..." é a estrutura básica de uma decisão: o que fazer se a condição for verdadeira e o que fazer se não for.

#### 4. Qual é o troco?

*Interpretação de código · médio · id `logica-calculo-do-troco` · conceitos: O que é lógica de programação? (peso 2); O que são algoritmos? (peso 1)*

Leia o raciocínio abaixo e responda: qual é o valor do troco?

```
Problema: pagar um lanche de R$ 8,00 com uma nota de R$ 10,00.
1. Receber a nota de R$ 10,00.
2. Calcular o troco: 10 - 8.
3. Devolver o troco.
```

- ✗ R$ 18,00 — *confusão: soma os valores em vez de subtrair*
- ✗ R$ 8,00 — *confusão: confunde o troco com o valor do lanche*
- ✔ **R$ 2,00** (correta)
- ✗ R$ 10,00 — *confusão: confunde o troco com o valor entregue*

**Dica:** Siga o passo 2 com os números do problema.

**Ao acertar:** O troco é a diferença entre o que foi pago e o que foi gasto: 10 - 8 = 2.

#### 5. Quem pode entrar?

*Interpretação de código · médio · id `logica-quem-pode-entrar` · conceitos: O que é lógica de programação? (peso 3)*

Leia as informações abaixo e responda: quem pode entrar no cinema?

```
Regra: só entra no cinema quem tem ingresso.
João tem ingresso.
Maria não tem ingresso.
```

- ✗ Só Maria — *confusão: inverte a regra, acreditando que quem não tem ingresso é quem entra*
- ✔ **Só João** (correta)
- ✗ João e Maria — *confusão: ignora a condição da regra*
- ✗ Ninguém — *confusão: acha que a regra só vale se todos a cumprirem ao mesmo tempo*

**Dica:** Aplique a regra a cada pessoa, uma de cada vez.

**Ao acertar:** A regra exige ingresso. João tem, então pode entrar; Maria não tem, então não pode.

#### 6. Ordene o raciocínio

*Ordenação · médio · id `logica-etapas-do-raciocinio` · conceitos: O que é lógica de programação? (peso 3)*

Coloque na ordem certa as etapas para resolver um problema com lógica.

Ordem correta:

1. Entender qual é o problema
2. Identificar as informações que temos
3. Definir o que queremos obter
4. Planejar os passos da solução
5. Testar se a solução funciona

**Dica:** Só dá para testar uma solução depois de planejá-la.

**Ao acertar:** Primeiro entendemos o problema e reunimos as informações; depois definimos o objetivo, planejamos os passos e, por fim, testamos.

#### 7. Encontre o erro no raciocínio

*Múltipla escolha · difícil · id `logica-raciocinio-invertido` · conceitos: O que é lógica de programação? (peso 3)*

Um colega diz: "Todo programador usa computador, então quem usa computador é programador". Qual é o erro desse raciocínio?

- ✗ Não há erro: a conclusão está correta — *confusão: confunde "todo A é B" com "todo B é A"*
- ✗ O erro é dizer "computador" em vez de "celular" — *confusão: olha para as palavras usadas e não para a estrutura do raciocínio*
- ✗ A premissa é falsa, porque programadores não usam computador — *confusão: contesta a premissa em vez de analisar o raciocínio*
- ✔ **Ele inverteu a regra: usar computador não torna ninguém programador** (correta)

**Dica:** A regra vale em um sentido. Ela vale também no sentido contrário?

**Ao acertar:** A regra diz que todo programador usa computador, mas não diz que todo usuário de computador programa. Inverter regras é um erro de lógica muito comum.

---

## Lição 3 — O que são algoritmos?

**Foco:** Reconhecer um algoritmo e suas características

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Um algoritmo é uma sequência finita de passos, claros e ordenados, que resolve um problema ou realiza uma tarefa. Uma receita de bolo, as instruções para montar um móvel e o caminho de casa até a escola são algoritmos.
> 
> Um bom algoritmo tem quatro características:
> - Finito: termina em algum momento.
> - Claro: cada passo é preciso, sem dar margem a dúvidas ("adicione 2 colheres de açúcar", e não "adicione um pouco").
> - Ordenado: os passos seguem uma ordem que faz sentido.
> - Tem objetivo: parte de informações iniciais e chega a um resultado.
> 
> Algoritmo e programa não são a mesma coisa. O algoritmo é a ideia, o plano de solução. O programa é esse plano escrito em uma linguagem de programação para o computador executar.

### Exemplo

```
Algoritmo: trocar uma lâmpada queimada.

1. Desligar o interruptor.
2. Esperar a lâmpada esfriar.
3. Desenroscar a lâmpada queimada.
4. Enroscar a lâmpada nova.
5. Ligar o interruptor para testar.

Por que isso é um bom algoritmo?
- Tem fim: depois do passo 5, a tarefa termina.
- Cada passo é uma ação clara.
- A ordem importa: não dá para enroscar a lâmpada nova antes de tirar a velha, nem mexer nela com o interruptor ligado.
- Parte de uma situação inicial (lâmpada queimada) e chega a um resultado (lâmpada nova funcionando).
```

### Revisão

- Algoritmo é uma sequência finita de passos claros e ordenados que resolve um problema.
- Um algoritmo precisa ter fim, passos precisos e uma ordem que faça sentido.
- Receitas, manuais e trajetos são algoritmos do dia a dia.
- O algoritmo é a ideia; o programa é o algoritmo escrito em uma linguagem de programação.

### Exercícios

#### 1. Qual deles é um algoritmo?

*Múltipla escolha · fácil · id `algoritmo-qual-e-algoritmo` · conceitos: O que são algoritmos? (peso 3)*

Qual das opções é um algoritmo?

- ✔ **Uma receita de bolo com os passos numerados** (correta)
- ✗ Uma lista de ingredientes, sem os passos — *confusão: confunde dados com os passos que devem ser executados*
- ✗ A vontade de fazer um bolo — *confusão: confunde o objetivo com os passos para alcançá-lo*
- ✗ A foto do bolo pronto — *confusão: confunde o resultado com o caminho até ele*

**Dica:** Um algoritmo diz o que fazer, e em que ordem.

**Ao acertar:** Um algoritmo é uma sequência de passos. A lista de ingredientes é apenas um dado, e o bolo pronto é o resultado, não o caminho até ele.

#### 2. O que um algoritmo não precisa ter?

*Múltipla escolha · fácil · id `algoritmo-o-que-nao-precisa` · conceitos: O que são algoritmos? (peso 3)*

Qual destas características um algoritmo NÃO precisa ter?

- ✗ Terminar depois de um número finito de passos — *confusão: acha que um algoritmo pode ficar executando para sempre*
- ✗ Ter passos claros e sem ambiguidade — *confusão: acha que o algoritmo pode deixar passos vagos*
- ✔ **Ser escrito em uma linguagem de programação** (correta)
- ✗ Seguir uma ordem definida — *confusão: acha que a ordem dos passos é livre*

**Dica:** Receitas de bolo também são algoritmos.

**Ao acertar:** Um algoritmo pode estar escrito em português, em desenhos ou em uma linguagem de programação. O que importa é ser finito, claro e ordenado.

#### 3. Ordene o algoritmo da lâmpada

*Ordenação · fácil · id `algoritmo-trocar-lampada` · conceitos: O que são algoritmos? (peso 2); Sequência lógica (peso 1)*

Coloque na ordem certa os passos para trocar uma lâmpada queimada.

Ordem correta:

1. Desligar o interruptor
2. Esperar a lâmpada esfriar
3. Desenroscar a lâmpada queimada
4. Enroscar a lâmpada nova
5. Ligar o interruptor para testar

**Dica:** Segurança primeiro: o que deve acontecer antes de tocar na lâmpada?

**Ao acertar:** A ordem protege quem executa o algoritmo: primeiro desligamos a energia e esperamos a lâmpada esfriar; só então a trocamos e testamos.

#### 4. O que a pessoa diz?

*Interpretação de código · médio · id `algoritmo-contar-ate-tres` · conceitos: O que são algoritmos? (peso 2)*

Uma pessoa segue o algoritmo abaixo. O que ela diz, em ordem?

```
Algoritmo: contar até 3
1. Dizer "1"
2. Dizer "2"
3. Dizer "3"
4. Parar
```

- ✗ 3, 2, 1 — *confusão: lê os passos de baixo para cima*
- ✔ **1, 2, 3** (correta)
- ✗ 1, 2, 3, 4 — *confusão: confunde o número do passo com o que deve ser dito*
- ✗ Apenas 3 — *confusão: acha que só o último passo de dizer vale*

**Dica:** O número do passo não é o que a pessoa diz: leia o que cada passo manda fazer.

**Ao acertar:** Os passos 1, 2 e 3 mandam dizer "1", "2" e "3", nessa ordem. O passo 4 manda parar, e não dizer nada.

#### 5. Qual instrução é clara?

*Múltipla escolha · médio · id `algoritmo-instrucao-clara` · conceitos: O que são algoritmos? (peso 3)*

Qual destas instruções é clara o bastante para fazer parte de um algoritmo?

- ✗ Adicione um pouco de açúcar — *confusão: aceita instruções vagas, que cada pessoa interpreta de um jeito*
- ✗ Faça o bolo ficar gostoso — *confusão: confunde o objetivo com uma ação que pode ser executada*
- ✗ Adicione açúcar se der vontade — *confusão: aceita um passo que depende de opinião, e não de um critério claro*
- ✔ **Adicione 2 colheres de açúcar** (correta)

**Dica:** Duas pessoas diferentes fariam exatamente a mesma coisa?

**Ao acertar:** Uma instrução clara indica uma ação exata, que qualquer pessoa executa do mesmo jeito. "Um pouco" e "se der vontade" dependem de interpretação.

#### 6. Esse algoritmo é bom?

*Interpretação de código · difícil · id `algoritmo-que-nunca-termina` · conceitos: O que são algoritmos? (peso 3)*

Analise o conjunto de instruções abaixo. Ele é um bom algoritmo?

```
Algoritmo: caminhar
1. Dar um passo
2. Voltar ao passo 1
```

- ✔ **Não: ele nunca termina, e todo algoritmo precisa ter fim** (correta)
- ✗ Sim, porque tem passos e uma ordem — *confusão: ignora que um algoritmo precisa ser finito*
- ✗ Sim, porque caminhar é uma tarefa simples — *confusão: avalia a tarefa e não a estrutura do algoritmo*
- ✗ Não, porque faltou escrevê-lo em JavaScript — *confusão: acha que um algoritmo só existe em uma linguagem de programação*

**Dica:** Siga as instruções e veja se algum passo manda parar.

**Ao acertar:** O passo 2 sempre manda voltar ao passo 1, então a pessoa caminha para sempre. Um algoritmo precisa terminar depois de um número finito de passos.

---

## Lição 4 — Sequência lógica

**Foco:** Perceber que a ordem dos passos muda o resultado

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Sequência lógica é organizar os passos na ordem em que eles fazem sentido. Em geral, cada passo depende do que foi feito antes: não dá para calçar o sapato antes de vestir a meia.
> 
> Trocar a ordem pode:
> - impedir a tarefa de funcionar (despejar a água no filtro antes de colocar o pó);
> - ou mudar o resultado (colocar o macarrão antes de a água ferver).
> 
> O computador segue a mesma regra: ele executa as instruções de cima para baixo, uma de cada vez, na ordem em que foram escritas. Por isso, a ordem das instruções de um programa é tão importante quanto a ordem dos passos de uma receita.

### Exemplo

```
Observe estas três instruções:

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

As instruções continuam as mesmas, mas a ordem mudou e, com ela, o resultado. Nenhuma instrução foi "errada": a sequência é que determina o que o programa faz.
```

### Revisão

- Sequência lógica é a ordem em que os passos fazem sentido.
- Cada passo costuma depender dos anteriores.
- Mudar a ordem pode impedir a tarefa ou mudar o resultado.
- O computador executa as instruções de cima para baixo, uma por vez.

### Exercícios

#### 1. Ordene: escovar os dentes

*Ordenação · fácil · id `sequencia-escovar-os-dentes` · conceitos: Sequência lógica (peso 3)*

Coloque na ordem certa os passos para escovar os dentes.

Ordem correta:

1. Pegar a escova e a pasta
2. Colocar a pasta na escova
3. Escovar os dentes
4. Enxaguar a boca
5. Guardar a escova

**Dica:** Cada passo só pode acontecer depois de o anterior estar pronto.

**Ao acertar:** A pasta só vai para a escova depois de pegarmos os dois; enxaguamos depois de escovar; guardamos por último.

#### 2. Por que a ordem importa?

*Múltipla escolha · fácil · id `sequencia-por-que-importa` · conceitos: Sequência lógica (peso 3)*

Por que a ordem dos passos é importante em um algoritmo?

- ✗ Porque o computador gosta de organização — *confusão: acha que a ordem é só uma questão de estilo*
- ✗ Não é importante: o resultado é sempre o mesmo — *confusão: acha que a ordem dos passos não altera o resultado*
- ✔ **Porque cada passo pode depender do resultado do passo anterior** (correta)
- ✗ Porque o computador executa tudo ao mesmo tempo — *confusão: acha que o computador executa todas as instruções ao mesmo tempo*

**Dica:** Pense na meia e no sapato.

**Ao acertar:** Muitos passos dependem do que foi feito antes. Por isso o computador os executa um de cada vez, na ordem escrita.

#### 3. Em que ordem aparece?

*Interpretação de código · médio · id `sequencia-abc` · conceitos: Sequência lógica (peso 3)*

O computador executa o programa abaixo. O que ele mostra na tela?

```
console.log("A");
console.log("B");
console.log("C");
```

- ✗ C, B e A — *confusão: acha que o computador começa pela última instrução*
- ✔ **A, B e C, nessa ordem, cada um em uma linha** (correta)
- ✗ Apenas C — *confusão: acha que cada instrução apaga a anterior*
- ✗ A, B e C em ordem sorteada — *confusão: acha que o computador escolhe a ordem de forma aleatória*

**Dica:** Leia de cima para baixo, como o computador faz.

**Ao acertar:** As instruções são executadas na ordem em que aparecem, e cada console.log mostra uma linha: A, depois B, depois C.

#### 4. Ordene o programa

*Ordenação · médio · id `sequencia-ordem-do-programa` · conceitos: Sequência lógica (peso 3); O que é programação? (peso 1)*

Coloque as instruções na ordem certa para o programa mostrar Olá, depois Tudo bem? e, por fim, Até logo.

Ordem correta:

1. console.log("Olá");
2. console.log("Tudo bem?");
3. console.log("Até logo");

**Dica:** O programa mostra as frases na ordem em que as instruções aparecem.

**Ao acertar:** Como o computador executa de cima para baixo, a primeira instrução deve ser a que mostra Olá e a última, a que mostra Até logo.

#### 5. E se trocássemos os passos?

*Interpretação de código · médio · id `sequencia-macarrao` · conceitos: Sequência lógica (peso 3)*

Veja o algoritmo abaixo. O que aconteceria se trocássemos os passos 3 e 4 de lugar?

```
Algoritmo: cozinhar macarrão
1. Encher a panela com água
2. Colocar a panela no fogo
3. Esperar a água ferver
4. Colocar o macarrão
```

- ✗ Nada: o resultado seria o mesmo — *confusão: acha que a ordem dos passos não altera o resultado*
- ✗ O fogo apagaria — *confusão: inventa uma consequência que não tem relação com a ordem dos passos*
- ✗ O algoritmo deixaria de ter passos — *confusão: acha que trocar a ordem apaga os passos*
- ✔ **O macarrão seria colocado antes de a água ferver, e o resultado mudaria** (correta)

**Dica:** Pense no que cada passo precisa que já tenha acontecido.

**Ao acertar:** Trocar os passos 3 e 4 faz o macarrão entrar na água ainda fria. Os passos continuam existindo, mas a ordem muda o resultado.

#### 6. Ordene o saque no caixa eletrônico

*Ordenação · difícil · id `sequencia-saque-no-caixa` · conceitos: Sequência lógica (peso 3); O que são algoritmos? (peso 1)*

Coloque na ordem certa os passos para sacar dinheiro em um caixa eletrônico.

Ordem correta:

1. Chegar ao caixa eletrônico
2. Inserir o cartão
3. Digitar a senha
4. Escolher a opção Saque
5. Digitar o valor desejado
6. Retirar as notas e o cartão

**Dica:** O caixa só libera o saque depois de reconhecer você.

**Ao acertar:** O cartão vem antes da senha, e a senha antes de qualquer operação. Só depois de escolher o saque e o valor o caixa entrega o dinheiro.

---

## Lição 5 — Entrada, processamento e saída

**Foco:** Identificar as três etapas de qualquer programa

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Quase todo programa segue o mesmo caminho em três etapas:
> - Entrada: os dados que o programa recebe (o que a pessoa digita, clica ou informa).
> - Processamento: o que o programa faz com esses dados (cálculos, comparações, decisões).
> - Saída: o resultado que o programa entrega (algo mostrado na tela, por exemplo).
> 
> Na calculadora, você digita 2 + 3 (entrada), o aparelho faz a conta (processamento) e mostra 5 (saída). No caixa do supermercado, o código de barras é a entrada, a busca do preço é o processamento e o valor na tela é a saída.
> 
> Nos exercícios de código desta plataforma, a entrada vem de uma função chamada lerEntrada(), e a saída é mostrada com console.log().

### Exemplo

```
Este programa lê um nome e mostra uma saudação:

// ENTRADA: lê o nome da pessoa
const nome = lerEntrada();
// PROCESSAMENTO: monta a frase juntando "Olá, " ao nome
const frase = "Olá, " + nome + "!";
// SAÍDA: mostra a frase na tela
console.log(frase);

Se a entrada for Ana, a saída será: Olá, Ana!

Não se preocupe com os detalhes de const e do sinal de +: você vai estudá-los no Mundo 2. Por ora, observe as três etapas, que aparecem em quase todos os programas: receber, processar e mostrar.
```

### Revisão

- Entrada: dados que o programa recebe.
- Processamento: o que o programa faz com os dados.
- Saída: o resultado que o programa entrega.
- Em JavaScript, aqui na plataforma: lerEntrada() lê a entrada e console.log() mostra a saída.
- Mostrar um resultado é saída; calcular é processamento; receber um valor é entrada.

### Exercícios

#### 1. O que é a entrada?

*Múltipla escolha · fácil · id `eps-o-que-e-entrada` · conceitos: Entrada, processamento e saída (peso 3)*

Em uma calculadora, você digita 2 + 3 e a tela mostra 5. O que é a ENTRADA nesse caso?

- ✔ **Os números 2 e 3 e a operação que foram digitados** (correta)
- ✗ O resultado 5 — *confusão: confunde entrada com saída*
- ✗ A conta que a calculadora faz internamente — *confusão: confunde entrada com processamento*
- ✗ A tela da calculadora — *confusão: confunde os dados com o aparelho que os mostra*

**Dica:** Entrada é o que o programa recebe antes de fazer qualquer coisa.

**Ao acertar:** A entrada são os dados fornecidos ao programa: 2, 3 e a operação. A conta é o processamento e o 5 na tela é a saída.

#### 2. Entrada, processamento ou saída?

*Múltipla escolha · fácil · id `eps-classificar-saida` · conceitos: Entrada, processamento e saída (peso 3)*

Mostrar o valor do troco na tela do caixa é um exemplo de:

- ✗ Entrada — *confusão: confunde mostrar um resultado com receber dados*
- ✗ Processamento — *confusão: confunde exibir o resultado com calculá-lo*
- ✔ **Saída** (correta)
- ✗ Linguagem de programação — *confusão: confunde uma etapa do programa com a linguagem em que ele é escrito*

**Dica:** O resultado chegou à pessoa. Em qual etapa isso acontece?

**Ao acertar:** Saída é o resultado que o programa entrega. Quando o valor do troco aparece na tela, o programa está fazendo uma saída.

#### 3. Mostre o que foi lido

*Código · fácil · id `eps-eco` · conceitos: Entrada, processamento e saída (peso 3)*

Escreva a função `eco()`: ela deve ler um valor com `lerEntrada()` e mostrá-lo na tela, do mesmo jeito, com `console.log`.

Função: `eco`

Código inicial:

```js
function eco() {
  // leia o valor com lerEntrada() e mostre com console.log
}
```

Testes:

- entrada [], lê ["Olá"] → imprime ["Olá"]
- entrada [], lê ["Ana"] → imprime ["Ana"]

Solução de referência:

```js
function eco() {
  const valor = lerEntrada();
  console.log(valor);
}
```

**Dica:** Guarde o que lerEntrada() devolve e mostre com console.log.

**Solução comentada:** O programa tem só duas etapas: a entrada (lerEntrada) e a saída (console.log). Aqui não há processamento, porque o valor é mostrado do jeito que chegou.

#### 4. Quais passos são de entrada?

*Interpretação de código · médio · id `eps-quais-sao-entrada` · conceitos: Entrada, processamento e saída (peso 3)*

Leia o algoritmo abaixo. Quais passos são de ENTRADA?

```
1. Ler o preço do produto
2. Ler o desconto, em reais
3. Calcular: preço - desconto
4. Mostrar o resultado
```

- ✗ O passo 3 — *confusão: acha que calcular é receber dados*
- ✔ **Os passos 1 e 2** (correta)
- ✗ O passo 4 — *confusão: confunde saída com entrada*
- ✗ Os passos 1, 2 e 4 — *confusão: agrupa mostrar o resultado com receber dados*

**Dica:** Entrada é tudo o que o programa lê antes de calcular.

**Ao acertar:** Os passos 1 e 2 recebem dados (entrada). O passo 3 é processamento e o passo 4 é saída.

#### 5. Onde está o processamento?

*Múltipla escolha · médio · id `eps-qual-e-o-processamento` · conceitos: Entrada, processamento e saída (peso 3)*

Um programa lê o nome de uma pessoa e mostra "Olá, NOME!". Qual parte é o processamento?

- ✗ Digitar o nome — *confusão: confunde processamento com entrada*
- ✗ Ver a frase aparecer na tela — *confusão: confunde processamento com saída*
- ✗ Ligar o computador — *confusão: inclui uma ação que não faz parte do programa*
- ✔ **Montar a frase juntando "Olá" ao nome** (correta)

**Dica:** Processamento é o que o programa faz com os dados que recebeu.

**Ao acertar:** Montar a frase com o nome é o que o programa faz com a entrada. Digitar é entrada e ver a frase na tela é saída.

#### 6. Leia um número e mostre o dobro

*Código · médio · id `eps-dobro` · conceitos: Entrada, processamento e saída (peso 3)*

Escreva a função `dobro()`: ela deve ler um número com `lerEntrada()` e mostrar o dobro dele com `console.log`.

Função: `dobro`

Código inicial:

```js
function dobro() {
  // leia o número, calcule o dobro e mostre o resultado
}
```

Testes:

- entrada [], lê [4] → imprime ["8"]
- entrada [], lê [10] → imprime ["20"]
- entrada [], lê [0] → imprime ["0"]

Solução de referência:

```js
function dobro() {
  const n = lerEntrada();
  console.log(n * 2);
}
```

**Dica:** O dobro de um número é ele multiplicado por 2. Use * para multiplicar.

**Solução comentada:** Agora o programa tem as três etapas: lê o número (entrada), multiplica por 2 (processamento) e mostra o resultado (saída).

#### 7. Qual será a saída?

*Interpretação de código · difícil · id `eps-soma-de-entradas` · conceitos: Entrada, processamento e saída (peso 3)*

O programa abaixo recebe as entradas 4 e 6, nessa ordem. O que ele mostra na tela?

```
const a = lerEntrada();
const b = lerEntrada();
console.log(a + b);
```

- ✔ **10** (correta)
- ✗ 4 e 6, em linhas separadas — *confusão: acha que console.log mostra as entradas, e não o resultado do processamento*
- ✗ a + b — *confusão: confunde o nome das variáveis com o resultado do cálculo*
- ✗ 46 — *confusão: confunde a soma de números com juntar os dois como texto*

**Dica:** Os dois valores são lidos, somados e só então mostrados.

**Ao acertar:** Cada lerEntrada() lê um valor: a recebe 4 e b recebe 6. O processamento soma os dois e console.log mostra o resultado: 10.

---

## Lição 6 — Pseudocódigo

**Foco:** Escrever algoritmos em linguagem próxima do português

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Pseudocódigo é uma forma de escrever algoritmos com palavras do nosso dia a dia, sem as regras rígidas de uma linguagem de programação. O computador não executa pseudocódigo: ele serve para planejar e conversar sobre a solução antes de programar.
> 
> Nesta plataforma usamos estas palavras:
> - INÍCIO e FIM: abrem e fecham o algoritmo.
> - LEIA x: recebe um valor (entrada) e guarda em x.
> - ESCREVA x: mostra um valor (saída).
> - x ← valor: guarda o resultado de uma conta em x (a seta significa "recebe").
> 
> Cada instrução fica em uma linha, e o algoritmo é lido de cima para baixo.

### Exemplo

```
Pseudocódigo para calcular a média de duas notas:

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

Se as notas forem 6 e 8, o algoritmo escreve 7.
```

### Revisão

- Pseudocódigo é um algoritmo escrito em linguagem próxima do português.
- O computador não executa pseudocódigo: ele serve para planejar.
- LEIA recebe dados; ESCREVA mostra resultados; a seta (←) guarda o valor de uma conta.
- INÍCIO e FIM delimitam o algoritmo, que é lido de cima para baixo.

### Exercícios

#### 1. O que é pseudocódigo?

*Múltipla escolha · fácil · id `pseudo-o-que-e` · conceitos: Pseudocódigo (peso 3)*

O que é pseudocódigo?

- ✗ Uma linguagem de programação que o computador executa diretamente — *confusão: acha que o pseudocódigo roda no computador*
- ✗ Um código falso, que não serve para nada — *confusão: acha que "pseudo" significa inútil*
- ✔ **Uma forma de escrever algoritmos em linguagem próxima do português, para planejar a solução** (correta)
- ✗ Um programa escrito em JavaScript — *confusão: confunde pseudocódigo com uma linguagem de programação real*

**Dica:** Pense em para que ele serve: planejar antes de programar.

**Ao acertar:** Pseudocódigo descreve o algoritmo com palavras comuns e sem regras rígidas. Para o computador executar, é preciso reescrevê-lo em uma linguagem de programação.

#### 2. Qual palavra mostra o resultado?

*Múltipla escolha · fácil · id `pseudo-comando-de-saida` · conceitos: Pseudocódigo (peso 3); Entrada, processamento e saída (peso 1)*

No pseudocódigo desta plataforma, qual comando mostra um resultado ao usuário?

- ✗ LEIA — *confusão: confunde mostrar um dado com receber um dado*
- ✔ **ESCREVA** (correta)
- ✗ INÍCIO — *confusão: confunde o começo do algoritmo com mostrar resultado*
- ✗ FIM — *confusão: confunde encerrar o algoritmo com mostrar o resultado*

**Dica:** O resultado é uma saída.

**Ao acertar:** ESCREVA é o comando de saída. LEIA é de entrada, e INÍCIO e FIM apenas marcam onde o algoritmo começa e termina.

#### 3. Complete o pseudocódigo

*Completar a lacuna · fácil · id `pseudo-complete-saudacao` · conceitos: Pseudocódigo (peso 2); Entrada, processamento e saída (peso 1)*

Complete o pseudocódigo que lê um nome e escreve uma saudação.

```
INÍCIO
  {{1}} nome
  ESCREVA "Olá, ", nome
{{2}}
```

Respostas aceitas: lacuna 1: LEIA ou leia ou Leia; lacuna 2: FIM ou fim ou Fim

**Dica:** Uma palavra recebe o nome; a outra encerra o algoritmo.

**Ao acertar:** LEIA recebe o nome (entrada), ESCREVA mostra a saudação (saída) e FIM encerra o algoritmo.

#### 4. O que será escrito?

*Interpretação de código · médio · id `pseudo-soma` · conceitos: Pseudocódigo (peso 3)*

O usuário digita 3 e depois 4. O que o algoritmo abaixo escreve?

```
INÍCIO
  LEIA a
  LEIA b
  soma ← a + b
  ESCREVA soma
FIM
```

- ✗ 34 — *confusão: junta os valores em vez de somá-los*
- ✗ a + b — *confusão: escreve a fórmula em vez do resultado da conta*
- ✗ 3 e 4 — *confusão: acha que ESCREVA mostra as entradas lidas*
- ✔ **7** (correta)

**Dica:** Siga as linhas de cima para baixo, guardando o valor de cada variável.

**Ao acertar:** a recebe 3 e b recebe 4. A linha soma ← a + b guarda 7 em soma, e ESCREVA mostra esse valor.

#### 5. Qual é o total?

*Interpretação de código · médio · id `pseudo-desconto` · conceitos: Pseudocódigo (peso 3); Entrada, processamento e saída (peso 1)*

O usuário digita 200. O que o algoritmo abaixo escreve?

```
INÍCIO
  LEIA preco
  desconto ← preco * 0,1
  total ← preco - desconto
  ESCREVA total
FIM
```

- ✔ **180** (correta)
- ✗ 20 — *confusão: mostra o desconto em vez do total*
- ✗ 200 — *confusão: ignora as contas e mostra a entrada*
- ✗ 220 — *confusão: soma o desconto em vez de subtraí-lo*

**Dica:** Calcule primeiro o desconto e depois o total.

**Ao acertar:** O desconto é 200 * 0,1 = 20. O total é 200 - 20 = 180, e é isso que ESCREVA mostra.

#### 6. Ordene as linhas do pseudocódigo

*Ordenação · difícil · id `pseudo-ordene-o-algoritmo` · conceitos: Pseudocódigo (peso 3); Sequência lógica (peso 2)*

Coloque as linhas na ordem certa para calcular o preço com desconto de 10%.

Ordem correta:

1. INÍCIO
2. LEIA preco
3. desconto ← preco * 0,1
4. total ← preco - desconto
5. ESCREVA total
6. FIM

**Dica:** Cada linha usa um valor que precisa ter sido calculado antes.

**Ao acertar:** Só dá para calcular o desconto depois de ler o preço, e o total só depois do desconto. O resultado é escrito por último, antes do FIM.

---

## Lição 7 — Fluxogramas

**Foco:** Ler e interpretar algoritmos desenhados com símbolos

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Um fluxograma é um desenho que mostra o algoritmo com símbolos e setas. Cada símbolo tem um significado:
> - Oval, escrito (INÍCIO) ou (FIM): onde o algoritmo começa e termina.
> - Paralelogramo, escrito / Ler idade /: entrada ou saída de dados.
> - Retângulo, escrito [ dobro ← n * 2 ]: processamento (uma conta ou uma ação).
> - Losango, escrito < idade ≥ 18? >: decisão, uma pergunta cuja resposta é Sim ou Não e que abre dois caminhos.
> - Setas: mostram a ordem em que os passos são seguidos.
> 
> Aqui usamos esses símbolos escritos em texto, para ler o fluxograma de cima para baixo, seguindo as setas.

### Exemplo

```
Fluxograma que lê um número e mostra o dobro:

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

Com a entrada 5, o fluxograma escreve 10.
```

### Revisão

- Fluxograma é um algoritmo desenhado com símbolos e setas.
- Oval: início e fim. Paralelogramo: entrada e saída. Retângulo: processamento. Losango: decisão (Sim ou Não).
- As setas indicam a ordem dos passos.
- Em uma decisão, só um dos caminhos é seguido, de acordo com a resposta.

### Exercícios

#### 1. Qual símbolo representa uma decisão?

*Múltipla escolha · fácil · id `fluxo-simbolo-da-decisao` · conceitos: Fluxogramas (peso 3)*

Qual símbolo do fluxograma representa uma decisão, isto é, uma pergunta com resposta Sim ou Não?

- ✗ Retângulo — *confusão: confunde processamento com decisão*
- ✗ Oval — *confusão: confunde o início e o fim do algoritmo com uma decisão*
- ✔ **Losango** (correta)
- ✗ Seta — *confusão: confunde o caminho do fluxo com a decisão*

**Dica:** É o símbolo que abre dois caminhos.

**Ao acertar:** O losango faz uma pergunta e, de acordo com a resposta, o fluxo segue por um de dois caminhos: Sim ou Não.

#### 2. O que as setas indicam?

*Múltipla escolha · fácil · id `fluxo-o-que-as-setas-indicam` · conceitos: Fluxogramas (peso 3); Sequência lógica (peso 1)*

O que as setas indicam em um fluxograma?

- ✗ A importância de cada passo — *confusão: acha que a seta indica prioridade*
- ✔ **A ordem, isto é, o caminho que o algoritmo segue** (correta)
- ✗ Que o passo anterior deve ser repetido — *confusão: confunde a seta de sequência com repetição*
- ✗ O tamanho do algoritmo — *confusão: associa as setas a uma medida e não ao fluxo*

**Dica:** Pense no que você faz para ler o fluxograma de um passo ao seguinte.

**Ao acertar:** As setas ligam um passo ao próximo e mostram a ordem de execução.

#### 3. Qual símbolo para ler um dado?

*Múltipla escolha · fácil · id `fluxo-simbolo-da-entrada` · conceitos: Fluxogramas (peso 3); Entrada, processamento e saída (peso 1)*

No fluxograma, "Ler idade" deve ser desenhado com qual símbolo?

- ✗ Losango — *confusão: confunde entrada de dados com decisão*
- ✗ Oval — *confusão: confunde entrada de dados com o início do algoritmo*
- ✗ Retângulo — *confusão: confunde entrada de dados com processamento*
- ✔ **Paralelogramo, o símbolo de entrada e saída** (correta)

**Dica:** Ler um dado é uma entrada.

**Ao acertar:** Entrada e saída de dados usam o paralelogramo. O retângulo é para cálculos e ações.

#### 4. O que será escrito?

*Interpretação de código · médio · id `fluxo-dobro` · conceitos: Fluxogramas (peso 3); Entrada, processamento e saída (peso 1)*

Siga as setas do fluxograma abaixo. Se numero for 5, o que será escrito?

```
(INÍCIO)
   ↓
/ Ler numero /
   ↓
[ dobro ← numero * 2 ]
   ↓
/ Escrever dobro /
   ↓
(FIM)
```

- ✔ **10** (correta)
- ✗ 5 — *confusão: acha que o fluxograma mostra a entrada e não o resultado do cálculo*
- ✗ 7 — *confusão: soma 2 em vez de multiplicar por 2*
- ✗ dobro — *confusão: escreve o nome da variável em vez do valor guardado nela*

**Dica:** Siga as setas e acompanhe o valor de cada variável.

**Ao acertar:** numero vale 5. O retângulo calcula dobro ← 5 * 2 = 10, e o paralelogramo de saída escreve esse valor.

#### 5. Qual caminho é seguido?

*Interpretação de código · médio · id `fluxo-maior-de-idade` · conceitos: Fluxogramas (peso 3); O que é lógica de programação? (peso 1)*

Siga o fluxograma abaixo. Se a idade digitada for 16, o que será escrito?

```
(INÍCIO)
   ↓
/ Ler idade /
   ↓
< idade ≥ 18? >
  Sim → / Escrever "Maior de idade" /
  Não → / Escrever "Menor de idade" /
   ↓
(FIM)
```

- ✗ Maior de idade — *confusão: segue o caminho do Sim sem avaliar a condição*
- ✗ Maior de idade e Menor de idade — *confusão: acha que os dois caminhos da decisão são executados*
- ✔ **Menor de idade** (correta)
- ✗ Nada: o fluxograma termina na decisão — *confusão: acha que a decisão não leva a nenhum caminho*

**Dica:** Responda à pergunta do losango com a idade 16.

**Ao acertar:** 16 não é maior ou igual a 18, então a resposta é Não e o fluxo segue pelo caminho do Não: Menor de idade.

#### 6. Qual fluxograma está correto?

*Múltipla escolha · difícil · id `fluxo-guarda-chuva` · conceitos: Fluxogramas (peso 3); O que é lógica de programação? (peso 2)*

Qual destes trechos de fluxograma representa corretamente: "se estiver chovendo, levo o guarda-chuva; senão, não levo"?

- ✗ [ Está chovendo? ] / Sim → [ Levar guarda-chuva ] / Não → [ Não levar guarda-chuva ] — *confusão: usa um retângulo (processamento) onde seria preciso um losango (decisão)*
- ✔ **< Está chovendo? > / Sim → [ Levar guarda-chuva ] / Não → [ Não levar guarda-chuva ]** (correta)
- ✗ < Está chovendo? > / Sim → [ Levar guarda-chuva ] — *confusão: esquece o caminho do Não: o que fazer se a resposta for outra?*
- ✗ [ Levar guarda-chuva ] / [ Não levar guarda-chuva ] — *confusão: coloca os dois passos em sequência, sem decisão: os dois seriam executados*

**Dica:** Uma decisão precisa de um losango e de um caminho para cada resposta.

**Ao acertar:** A decisão pede um losango com a pergunta e dois caminhos: um para Sim e outro para Não. Sem isso, o fluxo executaria passos que não deveriam ser executados.

---

## Lição 8 — Desafio final do Mundo 1

**Foco:** Juntar tudo: algoritmos, sequência, pseudocódigo e fluxogramas

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Chegou a hora de juntar o que você aprendeu no Mundo 1. Neste desafio, você vai usar lógica, sequência, entrada e saída, pseudocódigo e fluxogramas para resolver situações do dia a dia.
> 
> O desafio principal é o primeiro exercício: montar, na ordem certa, um algoritmo para uma tarefa cotidiana. Os outros dois exercícios aplicam o mesmo raciocínio a um pseudocódigo e a um fluxograma.
> 
> Dica: antes de responder, leia todos os passos e pense no que precisa ter acontecido antes de cada um.

### Exemplo

```
Como atacar um desafio de algoritmo:
1. Entenda o problema: qual é a tarefa e qual é o resultado esperado?
2. Liste os passos, sem se preocupar com a ordem.
3. Pergunte, para cada passo: o que precisa ter acontecido antes dele?
4. Organize a sequência e releia do começo ao fim, como se você fosse o computador executando cada passo.
5. Teste com um caso simples (por exemplo, notas 6 e 8) e veja se o resultado faz sentido.
```

### Revisão

- Um algoritmo resolve um problema em passos claros, finitos e ordenados.
- A ordem dos passos importa, porque cada passo costuma depender dos anteriores.
- Todo programa tem entrada, processamento e saída.
- Pseudocódigo e fluxogramas servem para planejar o algoritmo antes de programar.
- Testar o algoritmo com um caso simples ajuda a encontrar erros de raciocínio.

### Exercícios

#### 1. Desafio: trocar o pneu de um carro

*Ordenação · difícil · id `desafio1-trocar-o-pneu` · conceitos: O que são algoritmos? (peso 2); Sequência lógica (peso 2); O que é lógica de programação? (peso 1)*

Elabore o algoritmo para trocar o pneu furado de um carro: coloque os passos na ordem certa.

Ordem correta:

1. Estacionar em local plano e acionar o freio de mão
2. Afrouxar os parafusos da roda com a chave
3. Levantar o carro com o macaco
4. Retirar os parafusos e o pneu furado
5. Colocar o pneu novo e apertar levemente os parafusos
6. Abaixar o carro
7. Apertar totalmente os parafusos
8. Guardar o pneu furado e as ferramentas

**Dica:** Por segurança, os parafusos são afrouxados com o carro ainda no chão.

**Ao acertar:** Primeiro garantimos a segurança do carro e afrouxamos os parafusos com o pneu apoiado no chão; só depois levantamos o carro, trocamos o pneu, abaixamos e apertamos tudo.

#### 2. Desafio: pseudocódigo da média

*Completar a lacuna · difícil · id `desafio1-pseudocodigo-da-media` · conceitos: Pseudocódigo (peso 2); Entrada, processamento e saída (peso 2); Sequência lógica (peso 1)*

Complete o pseudocódigo que lê duas notas, calcula a média e escreve o resultado.

```
INÍCIO
  {{1}} nota1
  {{2}} nota2
  media {{3}} (nota1 + nota2) / 2
  {{4}} media
FIM
```

Respostas aceitas: lacuna 1: LEIA ou leia ou Leia; lacuna 2: LEIA ou leia ou Leia; lacuna 3: ← ou <-; lacuna 4: ESCREVA ou escreva ou Escreva

**Dica:** Duas linhas leem, uma guarda o resultado da conta e outra mostra o resultado.

**Ao acertar:** LEIA recebe as notas (entrada), a seta guarda o resultado da conta (processamento) e ESCREVA mostra a média (saída).

#### 3. Desafio: aprovado ou não?

*Interpretação de código · difícil · id `desafio1-aprovado-ou-nao` · conceitos: Fluxogramas (peso 2); O que é lógica de programação? (peso 2); Entrada, processamento e saída (peso 1)*

Siga o fluxograma abaixo. Se as notas digitadas forem 6 e 8, o que será escrito?

```
(INÍCIO)
   ↓
/ Ler nota1 /
/ Ler nota2 /
   ↓
[ media ← (nota1 + nota2) / 2 ]
   ↓
< media ≥ 7? >
  Sim → / Escrever "Aprovado" /
  Não → / Escrever "Reprovado" /
   ↓
(FIM)
```

- ✗ Reprovado — *confusão: trata o valor igual ao limite como se ficasse abaixo dele*
- ✗ 7 — *confusão: escreve a média em vez do resultado da decisão*
- ✗ Aprovado e Reprovado — *confusão: acha que os dois caminhos da decisão são executados*
- ✔ **Aprovado** (correta)

**Dica:** Calcule a média e responda à pergunta do losango: 7 é maior ou igual a 7?

**Ao acertar:** A média é (6 + 8) / 2 = 7. A condição é media ≥ 7, e 7 é igual a 7, então a resposta é Sim e o fluxo escreve Aprovado.

