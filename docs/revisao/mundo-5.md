# Revisão do conteúdo — Estruturas de Repetição

> GERADO por `npm run content:review`. Não edite este arquivo: ele muda quando o conteúdo mudar.

**Objetivo do mundo:** Ensinar o aluno a automatizar tarefas repetitivas e compreender o funcionamento dos laços de repetição.

Este documento reúne tudo o que os alunos vão ver neste mundo: 10 lições e 86 exercícios. **Nada foi publicado:** os exercícios estão como rascunho e só o professor os vê.

## Como revisar
1. Leia cada lição (texto, exemplo, revisão e exercícios) como se fosse um aluno iniciante.
2. Confira o gabarito (✔) e as "confusões" das alternativas erradas: elas alimentam o painel de dificuldades.
3. Anote ajustes por lição. Peça a correção ao Claude, que altera os arquivos de `content/`.
4. Quando aprovar, publique com `npm run content:publish -- mundo-5` (gera o SQL para colar no Supabase).

## Resumo
| Lição | Exercícios | Fácil | Médio | Difícil | Tipos |
|---|---:|---:|---:|---:|---|
| Introdução às estruturas de repetição | 8 | 4 | 3 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 ordenação, 1 código, 1 corrigir o erro |
| Estrutura for | 10 | 4 | 4 | 2 | 1 completar a lacuna, 3 interpretação de código, 1 múltipla escolha, 3 código, 1 corrigir o erro, 1 ordenação |
| Estrutura while | 9 | 3 | 4 | 2 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro, 1 ordenação |
| Estrutura do...while | 10 | 3 | 6 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro, 1 ordenação |
| Contadores | 9 | 3 | 4 | 2 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 3 código, 1 corrigir o erro |
| Acumuladores | 9 | 3 | 4 | 2 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 3 código, 1 corrigir o erro |
| Comando break | 9 | 3 | 4 | 2 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 3 código, 1 corrigir o erro |
| Comando continue | 9 | 3 | 5 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Laços de repetição aninhados | 10 | 3 | 5 | 2 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 3 código, 1 corrigir o erro |
| Desafio final do Mundo 5 | 3 | 0 | 0 | 3 | 1 desafio, 1 corrigir o erro, 1 interpretação de código |

---

## Lição 1 — Introdução às estruturas de repetição

**Foco:** Entender por que e como repetir instruções

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Imagine ter de escrever "Bom dia!" cem vezes. Você não escreveria o mesmo texto cem vezes: faria uma regra do tipo "repita 100 vezes". É isso que uma estrutura de repetição (ou laço) faz: executa um trecho do código várias vezes, sem precisar escrevê-lo de novo.
> 
> Todo laço precisa de três coisas:
> - um ponto de partida (por exemplo, começar a contar em 1);
> - uma condição para continuar (por exemplo, enquanto a contagem for menor ou igual a 5);
> - uma atualização a cada volta (por exemplo, somar 1 à contagem).
> 
> Se a condição nunca deixar de ser verdadeira, o laço nunca termina: é o laço infinito, um dos erros mais comuns. Neste mundo você vai conhecer for, while e do...while, além de contadores, acumuladores e os comandos break e continue.

### Exemplo

```
for (let i = 1; i <= 3; i++) {
  console.log("Oi");
}

Passo a passo:
1. let i = 1: o contador começa em 1 (só acontece uma vez).
2. i <= 3 é testado: 1 <= 3 é true, então o corpo executa e mostra Oi.
3. i++ soma 1: i vale 2. A condição é testada de novo: true, mostra Oi.
4. i vale 3: true, mostra Oi.
5. i vale 4: 4 <= 3 é false, e o laço termina.

Resultado: Oi aparece 3 vezes.
```

### Revisão

- Um laço repete um trecho do código sem precisar escrevê-lo de novo.
- Ele precisa de ponto de partida, condição para continuar e atualização a cada volta.
- Enquanto a condição for verdadeira, o corpo do laço executa.
- Se a condição nunca ficar falsa, o laço é infinito.
- Cada execução do corpo é chamada de iteração (ou volta).

### Exercícios

#### 1. Para que serve um laço?

*Múltipla escolha · fácil · id `rep-intro-para-que-serve` · conceitos: Introdução às estruturas de repetição (peso 3)*

Para que serve uma estrutura de repetição?

- ✗ Para executar um trecho só uma vez, quando a condição for verdadeira — *confusão: confunde repetição com decisão (if)*
- ✔ **Para executar um trecho várias vezes sem escrevê-lo de novo** (correta)
- ✗ Para guardar um valor em uma variável — *confusão: confunde repetição com declaração de variáveis*
- ✗ Para mostrar um texto na tela — *confusão: confunde repetição com saída de dados*

**Dica:** Pense em "repita 100 vezes".

**Ao acertar:** Um laço executa o mesmo trecho de código várias vezes, evitando copiar e colar instruções.

#### 2. Quantos Oi?

*Interpretação de código · fácil · id `rep-intro-tres-ois` · conceitos: Introdução às estruturas de repetição (peso 3); Estrutura for (peso 1)*

O que o programa abaixo mostra na tela?

```
for (let i = 1; i <= 3; i++) {
  console.log("Oi");
}
```

- ✗ Oi — *confusão: acha que o laço executa só uma vez*
- ✗ Oi / Oi — *confusão: erra uma volta (erro de um)*
- ✗ Oi / Oi / Oi / Oi — *confusão: conta uma volta a mais (erro de um)*
- ✔ **Oi / Oi / Oi** (correta)

**Dica:** i vale 1, 2 e 3. Quando i vale 4, a condição é falsa.

**Ao acertar:** O corpo executa para i = 1, 2 e 3, três vezes, e termina quando i chega a 4.

#### 3. Complete o laço

*Completar a lacuna · fácil · id `rep-intro-complete-o-while` · conceitos: Introdução às estruturas de repetição (peso 2); Estrutura while (peso 1)*

Complete a palavra que inicia o laço que se repete enquanto n for maior que zero.

```
let n = 3;
{{1}} (n > 0) {
  console.log(n);
  n--;
}
```

Respostas aceitas: lacuna 1: while

**Dica:** Em inglês, "enquanto".

**Ao acertar:** while repete o bloco enquanto a condição for verdadeira.

#### 4. Ordem de um laço

*Ordenação · médio · id `rep-intro-ordem-do-laco` · conceitos: Introdução às estruturas de repetição (peso 3); Estrutura while (peso 1)*

Coloque na ordem em que o computador executa um laço que conta de 1 a 3.

Ordem correta:

1. Começar com contador = 1
2. Verificar se contador <= 3
3. Mostrar o contador
4. Somar 1 ao contador
5. Voltar a verificar a condição

**Dica:** O ponto de partida vem uma única vez, antes do teste.

**Ao acertar:** O laço começa com o ponto de partida, testa a condição, executa o corpo, atualiza o contador e volta ao teste.

#### 5. Falta o passo

*Interpretação de código · médio · id `rep-intro-laco-infinito` · conceitos: Introdução às estruturas de repetição (peso 3); Estrutura while (peso 1)*

O que acontece com o programa abaixo?

```
let i = 1;
while (i <= 3) {
  console.log(i);
}
```

- ✔ **Mostra 1 sem parar (laço infinito)** (correta)
- ✗ Mostra 1, 2 e 3 e termina — *confusão: acha que o contador avança sozinho*
- ✗ Mostra 1 e termina — *confusão: acha que o laço executa só uma vez*
- ✗ Dá erro e não mostra nada — *confusão: acha que o computador detecta o laço infinito antes de executar*

**Dica:** Alguma linha altera o valor de i dentro do laço?

**Ao acertar:** Como i nunca muda, a condição i <= 3 fica sempre verdadeira e o laço repete para sempre. Faltou i++.

#### 6. Repetir um texto

*Código · fácil · id `rep-intro-repetir-texto` · conceitos: Introdução às estruturas de repetição (peso 2); Estrutura for (peso 2); Concatenação (peso 1)*

Escreva a função `repetir(texto, vezes)` que devolve o texto escrito `vezes` vezes seguidas. Por exemplo, repetir("ab", 2) devolve "abab".

Função: `repetir`

Código inicial:

```js
function repetir(texto, vezes) {
  // seu código aqui
}
```

Testes:

- entrada ["a",3] → retorna "aaa"
- entrada ["ab",2] → retorna "abab"
- entrada ["x",1] → retorna "x"
- entrada ["x",0] → retorna ""

Solução de referência:

```js
function repetir(texto, vezes) {
  let resultado = "";
  for (let i = 0; i < vezes; i++) {
    resultado += texto;
  }
  return resultado;
}
```

**Dica:** Comece com um resultado vazio e junte o texto a ele a cada volta.

**Solução comentada:** Um laço que repete `vezes` vezes e, a cada volta, acrescenta o texto ao resultado. Com 0 vezes, o laço não executa e o resultado fica vazio.

#### 7. Corrija a contagem

*Corrigir o erro · médio · id `rep-intro-corrija-a-contagem` · conceitos: Introdução às estruturas de repetição (peso 2); Estrutura for (peso 2)*

A função `contagem(n)` deveria devolver os números de 1 até n separados por espaço (por exemplo, "1 2 3" para n = 3), mas devolve um número a menos. Corrija o defeito.

Função: `contagem`

Código inicial:

```js
function contagem(n) {
  let texto = "";
  for (let i = 1; i < n; i++) {
    texto += (texto === "" ? "" : " ") + i;
  }
  return texto;
}
```

Testes:

- entrada [3] → retorna "1 2 3"
- entrada [1] → retorna "1"
- entrada [5] → retorna "1 2 3 4 5"

Solução de referência:

```js
function contagem(n) {
  let texto = "";
  for (let i = 1; i <= n; i++) {
    texto += (texto === "" ? "" : " ") + i;
  }
  return texto;
}
```

**Dica:** O último número do laço é incluído ou não? Olhe a condição.

**Solução comentada:** Com i < n, o laço para antes de n. Trocando por i <= n, o último valor também entra (erro de um no limite).

#### 8. Acompanhe o valor

*Interpretação de código · difícil · id `rep-intro-acompanhe-o-x` · conceitos: Introdução às estruturas de repetição (peso 3); Estrutura for (peso 1); Operadores de atribuição (peso 1)*

O que o programa abaixo mostra na tela?

```
let x = 2;
for (let i = 0; i < 3; i++) {
  x = x * 2;
}
console.log(x);
```

- ✗ 8 — *confusão: acha que o laço executa apenas 2 vezes*
- ✗ 6 — *confusão: acha que o laço soma em vez de multiplicar*
- ✔ **16** (correta)
- ✗ 2 — *confusão: acha que o valor de x não muda dentro do laço*

**Dica:** Anote x a cada volta: i = 0, 1 e 2.

**Ao acertar:** O laço executa 3 vezes (i = 0, 1, 2): x vai de 2 para 4, depois 8 e por fim 16.

---

## Lição 2 — Estrutura for

**Foco:** Repetir um número conhecido de vezes

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O for é o laço ideal quando você já sabe quantas vezes quer repetir. Ele reúne as três partes do laço em uma só linha:
> 
> for (inicialização; condição; passo) {
>   // corpo do laço
> }
> 
> - Inicialização: executa uma única vez, antes da primeira volta (por exemplo, let i = 0).
> - Condição: é testada antes de cada volta. Se for falsa, o laço termina.
> - Passo: executa depois de cada volta (por exemplo, i++ soma 1; i += 2 soma 2; i-- subtrai 1).
> 
> Atenção ao limite: for (let i = 0; i < 3; i++) repete 3 vezes (0, 1 e 2), enquanto i <= 3 repetiria 4 vezes (0, 1, 2 e 3). Errar o limite por uma volta é o famoso "erro de um".
> 
> A ordem de execução é: inicialização → condição → corpo → passo → condição → corpo → passo... até a condição ficar falsa.

### Exemplo

```
for (let i = 1; i <= 10; i += 3) {
  console.log(i);
}

Passo a passo:
1. i começa em 1. A condição 1 <= 10 é true: mostra 1.
2. O passo i += 3 faz i valer 4: 4 <= 10 é true: mostra 4.
3. i vale 7: true, mostra 7.
4. i vale 10: true, mostra 10.
5. i vale 13: 13 <= 10 é false, o laço termina.

Resultado: 1, 4, 7 e 10.
```

### Revisão

- for (inicialização; condição; passo): três partes em uma linha.
- A inicialização executa uma vez; a condição é testada antes de cada volta; o passo roda depois de cada volta.
- i < n repete n vezes a partir de 0; i <= n inclui o valor n.
- O passo pode ser i++, i--, i += 2... conforme o que o problema pede.
- Cuidado com o erro de um no limite do laço.

### Exercícios

#### 1. Complete a condição

*Completar a lacuna · fácil · id `for-complete-a-condicao` · conceitos: Estrutura for (peso 3)*

Complete a condição para que o laço repita 3 vezes (com i valendo 0, 1 e 2).

```
for (let i = 0; {{1}}; i++) {
  console.log(i);
}
```

Respostas aceitas: lacuna 1: i < 3 ou i<3 ou i <= 2 ou i<=2

**Dica:** O laço deve parar quando i chegar a 3.

**Ao acertar:** i < 3 é verdadeira para 0, 1 e 2 e falsa quando i vale 3, resultando em 3 voltas.

#### 2. Quais números?

*Interpretação de código · fácil · id `for-mostra-o-indice` · conceitos: Estrutura for (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
for (let i = 0; i < 3; i++) {
  console.log(i);
}
```

- ✗ 1 / 2 / 3 — *confusão: acha que a contagem começa em 1*
- ✔ **0 / 1 / 2** (correta)
- ✗ 0 / 1 / 2 / 3 — *confusão: inclui o valor do limite (i < 3 deixa o 3 de fora)*
- ✗ 0 / 1 — *confusão: erra uma volta (erro de um)*

**Dica:** O laço começa com i = 0 e para quando i chega a 3.

**Ao acertar:** i vale 0, 1 e 2. Quando vale 3, a condição i < 3 é falsa e o laço termina sem mostrar o 3.

#### 3. As partes do for

*Múltipla escolha · fácil · id `for-partes-do-for` · conceitos: Estrutura for (peso 3)*

Em for (let i = 0; i < 5; i++), qual parte é executada uma única vez, antes da primeira volta?

- ✗ i < 5 — *confusão: acha que a condição é testada só no início*
- ✗ i++ — *confusão: acha que o passo executa antes do corpo*
- ✗ O corpo do laço — *confusão: acha que o corpo executa uma vez só*
- ✔ **let i = 0** (correta)

**Dica:** Qual parte prepara o contador?

**Ao acertar:** A inicialização executa uma única vez. A condição é testada antes de cada volta e o passo depois de cada volta.

#### 4. Passo de três

*Interpretação de código · médio · id `for-passo-de-tres` · conceitos: Estrutura for (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
for (let i = 1; i <= 10; i += 3) {
  console.log(i);
}
```

- ✔ **1 / 4 / 7 / 10** (correta)
- ✗ 1 / 2 / 3 / 4 / 5 / 6 / 7 / 8 / 9 / 10 — *confusão: ignora o passo e conta de 1 em 1*
- ✗ 1 / 4 / 7 — *confusão: para antes do 10, achando que o limite não é incluído*
- ✗ 3 / 6 / 9 — *confusão: acha que a contagem começa pelo passo*

**Dica:** Some 3 a cada volta e confira se ainda é menor ou igual a 10.

**Ao acertar:** i vale 1, 4, 7 e 10 (todos <= 10). O próximo seria 13, que torna a condição falsa.

#### 5. Tabuada

*Código · médio · id `for-tabuada` · conceitos: Estrutura for (peso 3); Entrada e saída de informações (peso 2); Conversão de tipos (peso 1)*

Escreva a função `tabuada()`: leia um número com `lerEntrada()` (chega como texto) e mostre a tabuada de 1 a 10, uma linha por multiplicação, no formato `5 x 1 = 5`.

Função: `tabuada`

Código inicial:

```js
function tabuada() {
  // leia o número e mostre as 10 linhas
}
```

Testes:

- entrada [], lê ["5"] → imprime ["5 x 1 = 5","5 x 2 = 10","5 x 3 = 15","5 x 4 = 20","5 x 5 = 25","5 x 6 = 30","5 x 7 = 35","5 x 8 = 40","5 x 9 = 45","5 x 10 = 50"]
- entrada [], lê ["2"] → imprime ["2 x 1 = 2","2 x 2 = 4","2 x 3 = 6","2 x 4 = 8","2 x 5 = 10","2 x 6 = 12","2 x 7 = 14","2 x 8 = 16","2 x 9 = 18","2 x 10 = 20"]

Solução de referência:

```js
function tabuada() {
  const n = Number(lerEntrada());
  for (let i = 1; i <= 10; i++) {
    console.log(n + " x " + i + " = " + n * i);
  }
}
```

**Dica:** Converta a entrada com Number() e repita de 1 a 10 com um for.

**Solução comentada:** Um for de 1 a 10 mostra uma linha por volta, usando o número lido e o valor do contador.

#### 6. Contagem regressiva

*Código · fácil · id `for-contagem-regressiva` · conceitos: Estrutura for (peso 3)*

Escreva a função `regressiva(n)` que devolve os números de n até 1, separados por espaço (por exemplo, "3 2 1"). Para n = 0, devolve texto vazio.

Função: `regressiva`

Código inicial:

```js
function regressiva(n) {
  // seu código aqui
}
```

Testes:

- entrada [3] → retorna "3 2 1"
- entrada [1] → retorna "1"
- entrada [0] → retorna ""
- entrada [5] → retorna "5 4 3 2 1"

Solução de referência:

```js
function regressiva(n) {
  let texto = "";
  for (let i = n; i >= 1; i--) {
    texto += (texto === "" ? "" : " ") + i;
  }
  return texto;
}
```

**Dica:** O passo pode diminuir: i--.

**Solução comentada:** Um for que começa em n e usa i-- enquanto i >= 1 percorre os números de trás para frente.

#### 7. Corrija a soma

*Corrigir o erro · médio · id `for-corrija-a-soma` · conceitos: Estrutura for (peso 2); Acumuladores (peso 1)*

A função `somarAte(n)` deveria devolver a soma de 1 até n (por exemplo, 10 para n = 4), mas devolve um valor menor. Corrija o defeito.

Função: `somarAte`

Código inicial:

```js
function somarAte(n) {
  let soma = 0;
  for (let i = 1; i < n; i++) {
    soma += i;
  }
  return soma;
}
```

Testes:

- entrada [4] → retorna 10
- entrada [1] → retorna 1
- entrada [0] → retorna 0
- entrada [10] → retorna 55

Solução de referência:

```js
function somarAte(n) {
  let soma = 0;
  for (let i = 1; i <= n; i++) {
    soma += i;
  }
  return soma;
}
```

**Dica:** O valor n está sendo somado?

**Solução comentada:** Com i < n, o último valor (n) fica de fora. Usando i <= n, a soma inclui todos os números de 1 a n.

#### 8. Ordem de execução do for

*Ordenação · médio · id `for-ordem-de-execucao` · conceitos: Estrutura for (peso 3)*

Coloque na ordem em que o computador executa as partes de um for.

Ordem correta:

1. Executa a inicialização (uma vez)
2. Testa a condição
3. Executa o corpo do laço
4. Executa o passo (i++)
5. Testa a condição de novo

**Dica:** A inicialização só acontece uma vez, antes de tudo.

**Ao acertar:** Inicialização, condição, corpo e passo; depois o computador volta a testar a condição até ela ficar falsa.

#### 9. De trás para frente

*Interpretação de código · difícil · id `for-de-tras-para-frente` · conceitos: Estrutura for (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
for (let i = 5; i > 0; i -= 2) {
  console.log(i);
}
```

- ✗ 5 / 4 / 3 / 2 / 1 — *confusão: ignora o passo de 2 e conta de 1 em 1*
- ✗ 5 / 3 — *confusão: para antes do 1, achando que i > 0 exclui o 1*
- ✔ **5 / 3 / 1** (correta)
- ✗ 5 / 3 / 1 / -1 — *confusão: acha que o laço continua depois de i chegar a 1*

**Dica:** Subtraia 2 a cada volta e confira se ainda é maior que 0.

**Ao acertar:** i vale 5, 3 e 1. Depois vem -1, que não é maior que 0: o laço termina.

#### 10. Fatorial

*Código · difícil · id `for-fatorial` · conceitos: Estrutura for (peso 3); Acumuladores (peso 2); Operadores aritméticos (peso 1)*

Escreva a função `fatorial(n)` que devolve o produto de 1 até n (o fatorial de 5 é 5 × 4 × 3 × 2 × 1 = 120). O fatorial de 0 é 1.

Função: `fatorial`

Código inicial:

```js
function fatorial(n) {
  // seu código aqui
}
```

Testes:

- entrada [0] → retorna 1
- entrada [1] → retorna 1
- entrada [5] → retorna 120
- entrada [6] → retorna 720

Solução de referência:

```js
function fatorial(n) {
  let resultado = 1;
  for (let i = 1; i <= n; i++) {
    resultado *= i;
  }
  return resultado;
}
```

**Dica:** Para multiplicar, o acumulador deve começar em 1, não em 0.

**Solução comentada:** O resultado começa em 1 e é multiplicado por cada valor de 1 até n. Para n = 0 o laço não executa e o resultado continua 1.

---

## Lição 3 — Estrutura while

**Foco:** Repetir enquanto uma condição for verdadeira

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O while ("enquanto") repete um bloco enquanto a condição for verdadeira. Ele é ideal quando você não sabe de antemão quantas voltas serão necessárias: o laço continua até que uma situação mude.
> 
> let n = 3;
> while (n > 0) {
>   console.log(n);
>   n--;
> }
> 
> Diferente do for, as três partes ficam separadas: o ponto de partida vem antes do laço, a condição fica nos parênteses e a atualização precisa estar dentro do corpo. Se você esquecer de atualizar a variável da condição, o laço será infinito.
> 
> Outra característica: a condição é testada antes de cada volta. Se ela já começar falsa, o corpo não executa nenhuma vez.
> 
> Use for quando souber a quantidade de voltas e while quando a repetição depender de uma condição (por exemplo, "dividir até chegar a zero").

### Exemplo

```
let n = 3;
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

Resultado: 3, 2, 1 e Fogo!
```

### Revisão

- while repete o bloco enquanto a condição for verdadeira.
- A condição é testada antes de cada volta: pode ser que o corpo nunca execute.
- Atualize dentro do laço a variável usada na condição, para não criar um laço infinito.
- Use for quando souber quantas voltas; while quando depender de uma condição.

### Exercícios

#### 1. Quando usar o while?

*Múltipla escolha · fácil · id `while-quando-usar` · conceitos: Estrutura while (peso 3)*

Em que situação o while é mais indicado do que o for?

- ✗ Quando sabemos exatamente quantas voltas serão feitas — *confusão: acha que o while serve só para quantidades conhecidas*
- ✔ **Quando a quantidade de voltas depende de uma condição** (correta)
- ✗ Quando queremos executar o código uma única vez — *confusão: confunde repetição com decisão*
- ✗ Quando queremos que o laço nunca termine — *confusão: acha que o while é sempre infinito*

**Dica:** Pense em "continue até que...".

**Ao acertar:** O while é ideal quando não sabemos de antemão quantas voltas serão necessárias: o laço segue enquanto a condição for verdadeira.

#### 2. Contagem regressiva

*Interpretação de código · fácil · id `while-conta-regressiva` · conceitos: Estrutura while (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
let n = 3;
while (n > 0) {
  console.log(n);
  n--;
}
```

- ✗ 1 / 2 / 3 — *confusão: inverte a ordem da contagem*
- ✗ 3 / 2 / 1 / 0 — *confusão: inclui o 0, achando que a condição aceita n igual a zero*
- ✗ 3 — *confusão: acha que o laço executa uma só vez*
- ✔ **3 / 2 / 1** (correta)

**Dica:** A cada volta n diminui 1. O laço para quando n deixa de ser maior que 0.

**Ao acertar:** n vale 3, 2 e 1 dentro do laço. Quando n chega a 0, a condição n > 0 é falsa.

#### 3. Complete o passo

*Completar a lacuna · fácil · id `while-complete-o-passo` · conceitos: Estrutura while (peso 2); Operadores de atribuição (peso 1)*

Complete a instrução que diminui n em 1 a cada volta.

```
let n = 3;
while (n > 0) {
  console.log(n);
  {{1}};
}
```

Respostas aceitas: lacuna 1: n-- ou n -= 1 ou n = n - 1 ou --n

**Dica:** Sem essa linha, o laço seria infinito.

**Ao acertar:** Diminuir n a cada volta faz a condição n > 0 ficar falsa em algum momento.

#### 4. Nenhuma volta

*Interpretação de código · médio · id `while-nenhuma-volta` · conceitos: Estrutura while (peso 3)*

O que o programa abaixo mostra na tela?

```
let x = 10;
while (x < 5) {
  console.log("dentro");
  x++;
}
console.log("fim");
```

- ✔ **fim** (correta)
- ✗ dentro / fim — *confusão: acha que o corpo executa pelo menos uma vez*
- ✗ dentro / dentro / dentro / dentro / dentro / fim — *confusão: acha que o laço conta até 5 mesmo com x começando em 10*
- ✗ Nada, o programa dá erro — *confusão: acha que um laço que não executa é erro*

**Dica:** A condição é testada antes da primeira volta.

**Ao acertar:** 10 < 5 é falso desde o início, então o corpo nunca executa. Só o que vem depois do laço aparece: fim.

#### 5. Contar dígitos

*Código · médio · id `while-contar-digitos` · conceitos: Estrutura while (peso 3); Operadores aritméticos (peso 2)*

Escreva a função `contarDigitos(n)` que devolve quantos dígitos tem o número inteiro positivo n (por exemplo, 120 tem 3). Dica: divida por 10 até chegar a zero.

Função: `contarDigitos`

Código inicial:

```js
function contarDigitos(n) {
  // seu código aqui
}
```

Testes:

- entrada [5] → retorna 1
- entrada [42] → retorna 2
- entrada [1000] → retorna 4
- entrada [99999] → retorna 5

Solução de referência:

```js
function contarDigitos(n) {
  let digitos = 0;
  while (n > 0) {
    n = Math.floor(n / 10);
    digitos++;
  }
  return digitos;
}
```

**Dica:** Math.floor(n / 10) descarta o último dígito.

**Solução comentada:** A cada volta o último dígito é removido (divisão inteira por 10) e o contador sobe um. O laço termina quando n chega a 0.

#### 6. Corrija a condição

*Corrigir o erro · médio · id `while-corrija-a-condicao` · conceitos: Estrutura while (peso 3); Operadores relacionais (peso 1)*

A função `somaDe1Ate(n)` deveria devolver a soma de 1 até n (por exemplo, 10 para n = 4), mas devolve sempre 0. Corrija o defeito.

Função: `somaDe1Ate`

Código inicial:

```js
function somaDe1Ate(n) {
  let i = 1;
  let soma = 0;
  while (i > n) {
    soma += i;
    i++;
  }
  return soma;
}
```

Testes:

- entrada [4] → retorna 10
- entrada [1] → retorna 1
- entrada [0] → retorna 0
- entrada [10] → retorna 55

Solução de referência:

```js
function somaDe1Ate(n) {
  let i = 1;
  let soma = 0;
  while (i <= n) {
    soma += i;
    i++;
  }
  return soma;
}
```

**Dica:** O laço executa alguma vez com i = 1 e n = 4?

**Solução comentada:** A condição i > n é falsa desde o início, então o corpo nunca roda. O correto é continuar enquanto i <= n.

#### 7. Passos até chegar a 1

*Código · difícil · id `while-passos-de-collatz` · conceitos: Estrutura while (peso 3); Estrutura if/else (peso 1); Operadores aritméticos (peso 1)*

Escreva a função `passos(n)`: a cada passo, se n for par divida por 2; se for ímpar, calcule 3 × n + 1. Devolva quantos passos são necessários para n chegar a 1 (n = 1 precisa de 0 passos).

Função: `passos`

Código inicial:

```js
function passos(n) {
  // seu código aqui
}
```

Testes:

- entrada [1] → retorna 0
- entrada [2] → retorna 1
- entrada [6] → retorna 8
- entrada [7] → retorna 16
- entrada [27] → retorna 111

Solução de referência:

```js
function passos(n) {
  let contador = 0;
  while (n !== 1) {
    if (n % 2 === 0) {
      n = n / 2;
    } else {
      n = 3 * n + 1;
    }
    contador++;
  }
  return contador;
}
```

**Dica:** Não sabemos quantas voltas: use while (n !== 1) e conte cada passo.

**Solução comentada:** Enquanto n for diferente de 1, aplica-se a regra (par ou ímpar) e conta-se um passo. Para n = 1 o laço não executa.

#### 8. Ordem de execução do while

*Ordenação · médio · id `while-ordem-de-execucao` · conceitos: Estrutura while (peso 3)*

Coloque na ordem em que o computador executa um while.

Ordem correta:

1. Testa a condição
2. Se for verdadeira, executa o corpo
3. Atualiza a variável da condição
4. Testa a condição de novo
5. Quando for falsa, sai do laço

**Dica:** O teste da condição vem antes de qualquer volta.

**Ao acertar:** O while testa a condição antes de cada volta; ela só sai do laço quando a condição se torna falsa.

#### 9. Dobrando até passar

*Interpretação de código · difícil · id `while-dobrando` · conceitos: Estrutura while (peso 3); Operadores de atribuição (peso 1)*

O que o programa abaixo mostra na tela?

```
let a = 1;
while (a < 20) {
  a = a * 2;
}
console.log(a);
```

- ✗ 16 — *confusão: para no último valor que ainda é menor que 20*
- ✗ 20 — *confusão: acha que o laço para exatamente quando chega a 20*
- ✔ **32** (correta)
- ✗ 19 — *confusão: acha que o valor sobe de 1 em 1*

**Dica:** Anote a: 1, 2, 4, 8, 16... e continue até a condição ficar falsa.

**Ao acertar:** a vale 1, 2, 4, 8 e 16 (todos < 20), e a próxima volta o torna 32. Como 32 < 20 é falso, o laço termina e mostra 32.

---

## Lição 4 — Estrutura do...while

**Foco:** Repetir com o teste no final do laço

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O do...while é parecido com o while, mas com uma diferença importante: o corpo executa primeiro e a condição é testada depois. Por isso, o corpo do do...while executa pelo menos uma vez, mesmo que a condição já comece falsa.
> 
> do {
>   // corpo do laço
> } while (condição);
> 
> Repare no ponto e vírgula depois do while(condição): ele faz parte da sintaxe.
> 
> Isso é útil quando precisamos fazer algo antes de decidir se repetimos, como pedir uma informação ao usuário e só depois conferir se ela é válida: "peça a nota; se não estiver entre 0 e 10, peça de novo".
> 
> Resumindo: no while o teste vem antes (pode executar zero vezes); no do...while o teste vem depois (executa ao menos uma vez).

### Exemplo

```
let n = 10;
do {
  console.log("Executou");
  n++;
} while (n < 5);

Passo a passo:
1. O computador executa o corpo primeiro: mostra Executou e n passa a 11.
2. Só então testa a condição: 11 < 5 é false.
3. O laço termina depois de uma única volta.

Com um while comum (while (n < 5)), o corpo não executaria nenhuma vez.
```

### Revisão

- do...while executa o corpo primeiro e testa a condição depois.
- O corpo executa pelo menos uma vez, mesmo com a condição falsa desde o início.
- A sintaxe termina com ponto e vírgula: do { ... } while (condição);
- Ótimo para validar entradas: pedir, conferir e repetir se for preciso.

### Exercícios

#### 1. A diferença para o while

*Múltipla escolha · fácil · id `dowhile-diferenca` · conceitos: Estrutura do...while (peso 3)*

Qual é a principal diferença entre o while e o do...while?

- ✗ O do...while não precisa de condição — *confusão: acha que o do...while repete sempre, sem condição*
- ✔ **O do...while executa o corpo pelo menos uma vez, antes de testar a condição** (correta)
- ✗ O while executa o corpo primeiro e testa a condição depois — *confusão: troca a ordem dos dois laços*
- ✗ O do...while só funciona com números — *confusão: acha que o laço depende do tipo do dado*

**Dica:** Onde fica o teste da condição em cada um?

**Ao acertar:** No do...while o corpo executa primeiro e a condição é testada no final, garantindo ao menos uma volta.

#### 2. Condição já falsa

*Interpretação de código · fácil · id `dowhile-condicao-falsa` · conceitos: Estrutura do...while (peso 3)*

O que o programa abaixo mostra na tela?

```
let n = 10;
do {
  console.log("oi");
  n++;
} while (n < 5);
```

- ✗ Nada, porque 10 < 5 é falso — *confusão: acha que o do...while também testa antes de executar*
- ✗ oi / oi / oi / oi / oi — *confusão: acha que o laço conta até 5*
- ✗ Dá erro — *confusão: acha que uma condição falsa no início é erro*
- ✔ **oi** (correta)

**Dica:** O corpo executa antes do primeiro teste.

**Ao acertar:** O corpo executa uma vez (oi), n vira 11 e a condição 11 < 5 é falsa: o laço termina.

#### 3. Complete o laço

*Completar a lacuna · fácil · id `dowhile-complete-o-fim` · conceitos: Estrutura do...while (peso 2)*

Complete a palavra que fecha o laço e testa a condição.

```
let n = 0;
do {
  n++;
} {{1}} (n < 3);
```

Respostas aceitas: lacuna 1: while

**Dica:** A mesma palavra que abre o laço while.

**Ao acertar:** O do...while termina com while (condição); depois do corpo.

#### 4. Conta até três

*Interpretação de código · médio · id `dowhile-conta-ate-tres` · conceitos: Estrutura do...while (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
let i = 1;
do {
  console.log(i);
  i++;
} while (i <= 3);
```

- ✔ **1 / 2 / 3** (correta)
- ✗ 1 / 2 — *confusão: para uma volta antes, achando que i <= 3 exclui o 3*
- ✗ 1 / 2 / 3 / 4 — *confusão: inclui o valor que torna a condição falsa*
- ✗ 2 / 3 — *confusão: acha que o corpo só executa depois de testar*

**Dica:** Depois de cada volta, i aumenta e a condição é testada.

**Ao acertar:** Mostra 1, 2 e 3. Depois do 3, i vale 4 e 4 <= 3 é falso.

#### 5. Somar até o zero

*Código · médio · id `dowhile-somar-ate-zero` · conceitos: Estrutura do...while (peso 3); Acumuladores (peso 1); Entrada e saída de informações (peso 2)*

Escreva a função `somarAteZero()`: leia números com `lerEntrada()` (chegam como texto) até aparecer o 0 e mostre a soma de todos os números lidos com `console.log`. O 0 encerra a leitura.

Função: `somarAteZero`

Código inicial:

```js
function somarAteZero() {
  // leia os números e mostre a soma
}
```

Testes:

- entrada [], lê ["5","3","0"] → imprime ["8"]
- entrada [], lê ["0"] → imprime ["0"]
- entrada [], lê ["10","20","30","0"] → imprime ["60"]

Solução de referência:

```js
function somarAteZero() {
  let soma = 0;
  let valor;
  do {
    valor = Number(lerEntrada());
    soma += valor;
  } while (valor !== 0);
  console.log(soma);
}
```

**Dica:** Você precisa ler pelo menos um valor antes de saber se é o 0.

**Solução comentada:** Um do...while lê o número, soma e só então confere se foi o 0. Assim a leitura acontece antes do teste, como o problema pede.

#### 6. Corrija o limite

*Corrigir o erro · médio · id `dowhile-corrija-o-limite` · conceitos: Estrutura do...while (peso 3); Operadores relacionais (peso 1)*

A função `contarAte(n)` deveria devolver os números de 1 até n separados por espaço ("1 2 3" para n = 3), mas deixa o último de fora. Corrija o defeito.

Função: `contarAte`

Código inicial:

```js
function contarAte(n) {
  let i = 1;
  let texto = "";
  do {
    texto += (texto === "" ? "" : " ") + i;
    i++;
  } while (i < n);
  return texto;
}
```

Testes:

- entrada [3] → retorna "1 2 3"
- entrada [1] → retorna "1"
- entrada [5] → retorna "1 2 3 4 5"

Solução de referência:

```js
function contarAte(n) {
  let i = 1;
  let texto = "";
  do {
    texto += (texto === "" ? "" : " ") + i;
    i++;
  } while (i <= n);
  return texto;
}
```

**Dica:** Depois de mostrar n, o laço deveria continuar?

**Solução comentada:** Com i < n o laço para antes de incluir n. A condição correta é i <= n.

#### 7. Quanto vale c?

*Interpretação de código · médio · id `dowhile-sempre-uma-vez` · conceitos: Estrutura do...while (peso 3)*

O que o programa abaixo mostra na tela?

```
let c = 0;
do {
  c++;
} while (c < 0);
console.log(c);
```

- ✗ 0 — *confusão: acha que o corpo não executa quando a condição já é falsa*
- ✗ -1 — *confusão: acha que o laço continua até c ficar negativo*
- ✔ **1** (correta)
- ✗ Nada, o laço nunca termina — *confusão: acha que a condição falsa causa laço infinito*

**Dica:** O corpo executa antes do primeiro teste.

**Ao acertar:** O corpo executa uma vez (c passa de 0 para 1) e a condição 1 < 0 é falsa.

#### 8. Quantas voltas, no mínimo?

*Múltipla escolha · médio · id `dowhile-minimo-de-voltas` · conceitos: Estrutura do...while (peso 3)*

Quantas vezes, no mínimo, o corpo de um do...while executa?

- ✗ Nenhuma, se a condição for falsa — *confusão: acha que o do...while pode não executar nenhuma vez*
- ✔ **Uma** (correta)
- ✗ Duas — *confusão: confunde o teste do final com uma segunda volta obrigatória*
- ✗ Depende do valor das variáveis — *confusão: acha que o mínimo varia conforme a condição*

**Dica:** O teste da condição só acontece depois da primeira execução.

**Ao acertar:** O corpo é executado antes do primeiro teste, então roda pelo menos uma vez.

#### 9. Validar a nota

*Código · difícil · id `dowhile-validar-nota` · conceitos: Estrutura do...while (peso 3); Operadores lógicos (peso 2); Entrada e saída de informações (peso 1)*

Escreva a função `validarNota()`: leia números com `lerEntrada()` até aparecer uma nota válida (de 0 a 10, inclusive) e mostre `Nota válida: <valor>`. Notas fora do intervalo são ignoradas e a leitura continua.

Função: `validarNota`

Código inicial:

```js
function validarNota() {
  // leia até uma nota válida e mostre a mensagem
}
```

Testes:

- entrada [], lê ["7"] → imprime ["Nota válida: 7"]
- entrada [], lê ["15","-2","7"] → imprime ["Nota válida: 7"]
- entrada [], lê ["11","10"] → imprime ["Nota válida: 10"]
- entrada [], lê ["-1","0"] → imprime ["Nota válida: 0"]

Solução de referência:

```js
function validarNota() {
  let nota;
  do {
    nota = Number(lerEntrada());
  } while (nota < 0 || nota > 10);
  console.log("Nota válida:", nota);
}
```

**Dica:** Continue lendo enquanto a nota for menor que 0 ou maior que 10.

**Solução comentada:** Um do...while lê a nota e repete enquanto ela for menor que 0 ou maior que 10. Quando sai do laço, a nota é válida.

#### 10. Ordem de execução do do...while

*Ordenação · médio · id `dowhile-ordem-de-execucao` · conceitos: Estrutura do...while (peso 3)*

Coloque na ordem em que o computador executa um do...while.

Ordem correta:

1. Executa o corpo do laço
2. Testa a condição
3. Se for verdadeira, volta ao corpo
4. Se for falsa, sai do laço

**Dica:** O corpo vem antes do primeiro teste.

**Ao acertar:** O do...while executa o corpo, testa a condição e repete se ela for verdadeira.

---

## Lição 5 — Contadores

**Foco:** Contar quantas vezes algo acontece

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Um contador é uma variável que guarda "quantas vezes" alguma coisa aconteceu. Ele começa em zero e aumenta de 1 em 1 (contador++) cada vez que o evento acontece.
> 
> let pares = 0;                // começa em zero
> for (let i = 1; i <= 10; i++) {
>   if (i % 2 === 0) {
>     pares++;                  // soma 1 só quando i é par
>   }
> }
> 
> Três cuidados:
> 1. Inicialize o contador antes do laço (geralmente com 0). Se declarar dentro do laço, ele volta a zero a cada volta.
> 2. Só some quando a situação acontecer: use um if para decidir.
> 3. Não confunda com acumulador: o contador conta ocorrências (sempre soma 1); o acumulador soma valores (veja a próxima lição).
> 
> Contadores servem para contar pares, vogais em um texto, aprovados em uma turma, tentativas e muito mais.

### Exemplo

```
let pares = 0;
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
4. Ao final, pares vale 3 e o programa mostra 3.
```

### Revisão

- Contador: variável que conta quantas vezes algo aconteceu (contador++).
- Inicialize antes do laço, normalmente com 0.
- Use um if para somar só quando a situação ocorrer.
- Contador conta ocorrências; acumulador soma valores.

### Exercícios

#### 1. O que é um contador?

*Múltipla escolha · fácil · id `contador-o-que-e` · conceitos: Contadores (peso 3)*

O que é um contador?

- ✗ Uma variável que soma valores diferentes a cada volta — *confusão: confunde contador com acumulador*
- ✗ Uma variável que guarda sempre o último valor lido — *confusão: confunde contador com uma variável comum*
- ✗ Uma variável que nunca muda — *confusão: acha que o contador é uma constante*
- ✔ **Uma variável que guarda quantas vezes algo aconteceu** (correta)

**Dica:** Pense em marcar um traço a cada ocorrência.

**Ao acertar:** O contador começa em zero e aumenta (geralmente de 1 em 1) a cada ocorrência que queremos contar.

#### 2. Quanto vale c?

*Interpretação de código · fácil · id `contador-cinco-voltas` · conceitos: Contadores (peso 3); Estrutura for (peso 1)*

O que o programa abaixo mostra na tela?

```
let c = 0;
for (let i = 1; i <= 5; i++) {
  c++;
}
console.log(c);
```

- ✔ **5** (correta)
- ✗ 4 — *confusão: erra uma volta (erro de um)*
- ✗ 15 — *confusão: acha que c acumula os valores de i*
- ✗ 0 — *confusão: acha que c não muda porque não aparece na condição*

**Dica:** c aumenta 1 a cada volta.

**Ao acertar:** O laço dá 5 voltas (i = 1 a 5) e c sobe 1 em cada uma, chegando a 5.

#### 3. Complete o contador

*Completar a lacuna · fácil · id `contador-complete-o-incremento` · conceitos: Contadores (peso 2); Estrutura if (peso 1)*

Complete a instrução que soma 1 ao contador quando o número é par.

```
let pares = 0;
for (let i = 1; i <= 10; i++) {
  if (i % 2 === 0) {
    {{1}};
  }
}
```

Respostas aceitas: lacuna 1: pares++ ou pares += 1 ou pares = pares + 1 ou ++pares

**Dica:** O contador soma 1 a cada ocorrência.

**Ao acertar:** Cada vez que o número é par, o contador pares aumenta 1.

#### 4. Múltiplos de três

*Interpretação de código · médio · id `contador-multiplos-de-tres` · conceitos: Contadores (peso 3); Estrutura if (peso 1)*

O que o programa abaixo mostra na tela?

```
let c = 0;
for (let i = 1; i <= 10; i++) {
  if (i % 3 === 0) {
    c++;
  }
}
console.log(c);
```

- ✗ 10 — *confusão: acha que o contador conta todas as voltas, ignorando o if*
- ✗ 9 — *confusão: confunde o último múltiplo com a quantidade de múltiplos*
- ✔ **3** (correta)
- ✗ 4 — *confusão: conta o 0 ou o 12 como múltiplos dentro do intervalo*

**Dica:** Quais números de 1 a 10 têm resto 0 na divisão por 3?

**Ao acertar:** Os múltiplos de 3 entre 1 e 10 são 3, 6 e 9: o contador sobe 3 vezes.

#### 5. Contar pares

*Código · médio · id `contador-contar-pares` · conceitos: Contadores (peso 3); Estrutura for (peso 2); Operadores aritméticos (peso 1)*

Escreva a função `contarPares(n)` que devolve quantos números pares existem de 1 até n.

Função: `contarPares`

Código inicial:

```js
function contarPares(n) {
  // seu código aqui
}
```

Testes:

- entrada [10] → retorna 5
- entrada [1] → retorna 0
- entrada [7] → retorna 3
- entrada [0] → retorna 0

Solução de referência:

```js
function contarPares(n) {
  let pares = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      pares++;
    }
  }
  return pares;
}
```

**Dica:** Um número é par quando n % 2 === 0.

**Solução comentada:** Um contador começa em 0 e sobe 1 para cada par encontrado entre 1 e n.

#### 6. Contar vogais

*Código · médio · id `contador-contar-vogais` · conceitos: Contadores (peso 3); Estrutura for (peso 1); Tipo String (peso 1)*

Escreva a função `contarVogais(texto)` que devolve quantas vogais (a, e, i, o, u, maiúsculas ou minúsculas) o texto tem.

Função: `contarVogais`

Código inicial:

```js
function contarVogais(texto) {
  // seu código aqui
}
```

Testes:

- entrada ["banana"] → retorna 3
- entrada ["Ola"] → retorna 2
- entrada ["sky"] → retorna 0
- entrada ["ARARA"] → retorna 3
- entrada [""] → retorna 0

Solução de referência:

```js
function contarVogais(texto) {
  let vogais = 0;
  for (let i = 0; i < texto.length; i++) {
    if ("aeiou".includes(texto[i].toLowerCase())) {
      vogais++;
    }
  }
  return vogais;
}
```

**Dica:** texto[i] devolve a letra da posição i; texto.length é o tamanho do texto.

**Solução comentada:** O laço percorre cada letra e, se ela é uma vogal, o contador sobe 1.

#### 7. Corrija o início do contador

*Corrigir o erro · médio · id `contador-corrija-o-inicio` · conceitos: Contadores (peso 3); Operadores de atribuição (peso 1)*

A função `contarMultiplos(n, k)` deveria devolver quantos múltiplos de k existem de 1 até n, mas devolve um a mais. Corrija o defeito.

Função: `contarMultiplos`

Código inicial:

```js
function contarMultiplos(n, k) {
  let contador = 1;
  for (let i = 1; i <= n; i++) {
    if (i % k === 0) {
      contador++;
    }
  }
  return contador;
}
```

Testes:

- entrada [10,3] → retorna 3
- entrada [10,5] → retorna 2
- entrada [4,7] → retorna 0
- entrada [12,1] → retorna 12

Solução de referência:

```js
function contarMultiplos(n, k) {
  let contador = 0;
  for (let i = 1; i <= n; i++) {
    if (i % k === 0) {
      contador++;
    }
  }
  return contador;
}
```

**Dica:** Com quantos múltiplos o contador deve começar, antes de olhar qualquer número?

**Solução comentada:** Um contador começa em 0: antes de olhar os números, nada foi contado. Começando em 1, o resultado fica sempre um a mais.

#### 8. Dois contadores

*Interpretação de código · difícil · id `contador-dois-contadores` · conceitos: Contadores (peso 3); Estrutura if/else (peso 2)*

O que o programa abaixo mostra na tela?

```
let a = 0;
let b = 0;
for (let i = 1; i <= 7; i++) {
  if (i % 2 === 0) {
    a++;
  } else {
    b++;
  }
}
console.log(a, b);
```

- ✗ 4 3 — *confusão: troca os contadores de pares e ímpares*
- ✔ **3 4** (correta)
- ✗ 3 3 — *confusão: acha que pares e ímpares aparecem na mesma quantidade*
- ✗ 7 0 — *confusão: acha que só o primeiro contador é atualizado*

**Dica:** a conta os pares e b os ímpares, de 1 a 7.

**Ao acertar:** Pares: 2, 4 e 6 (a = 3). Ímpares: 1, 3, 5 e 7 (b = 4).

#### 9. Contar divisores

*Código · difícil · id `contador-contar-divisores` · conceitos: Contadores (peso 3); Estrutura for (peso 2); Estrutura if (peso 1)*

Escreva a função `contarDivisores(n)` que devolve quantos números de 1 até n dividem n sem deixar resto (o 12 tem 6 divisores: 1, 2, 3, 4, 6 e 12).

Função: `contarDivisores`

Código inicial:

```js
function contarDivisores(n) {
  // seu código aqui
}
```

Testes:

- entrada [12] → retorna 6
- entrada [7] → retorna 2
- entrada [1] → retorna 1
- entrada [36] → retorna 9

Solução de referência:

```js
function contarDivisores(n) {
  let divisores = 0;
  for (let i = 1; i <= n; i++) {
    if (n % i === 0) {
      divisores++;
    }
  }
  return divisores;
}
```

**Dica:** n é divisível por i quando n % i === 0.

**Solução comentada:** Um contador sobe para cada i de 1 até n que divide n sem deixar resto.

---

## Lição 6 — Acumuladores

**Foco:** Somar ou multiplicar valores ao longo do laço

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Um acumulador é uma variável que vai juntando valores a cada volta do laço: a soma de várias notas, o total de uma compra, o produto de uma sequência.
> 
> let soma = 0;
> for (let i = 1; i <= 4; i++) {
>   soma += i;     // soma = soma + i
> }
> 
> Diferente do contador, que sempre soma 1, o acumulador soma (ou multiplica) o valor que aparece a cada volta.
> 
> Atenção ao valor inicial:
> - para somar, comece em 0 (elemento neutro da soma);
> - para multiplicar, comece em 1 (elemento neutro do produto): começando em 0, tudo vira 0.
> 
> E o erro mais comum: declarar o acumulador dentro do laço. Isso o reinicia a cada volta, e ele nunca acumula nada. Declare-o antes do laço.
> 
> Depois do laço, o acumulador guarda o total, e dá para calcular coisas como a média (soma ÷ quantidade).

### Exemplo

```
let soma = 0;
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
6. O laço termina e o programa mostra 10.
```

### Revisão

- Acumulador: variável que junta valores a cada volta (soma += valor).
- Para somar, comece em 0; para multiplicar, comece em 1.
- Declare o acumulador antes do laço, nunca dentro dele.
- Contador soma sempre 1; acumulador soma o valor da volta.
- Depois do laço, o acumulador guarda o total (e permite calcular médias).

### Exercícios

#### 1. Contador ou acumulador?

*Múltipla escolha · fácil · id `acumulador-contador-ou-acumulador` · conceitos: Acumuladores (peso 3); Contadores (peso 1)*

Qual é a diferença entre um contador e um acumulador?

- ✗ Não há diferença: os dois sempre somam 1 — *confusão: acha que contador e acumulador são a mesma coisa*
- ✗ O contador soma valores diferentes e o acumulador soma sempre 1 — *confusão: troca as definições*
- ✗ O acumulador só serve para multiplicar — *confusão: acha que o acumulador não soma*
- ✔ **O contador soma sempre 1 (conta ocorrências); o acumulador soma o valor de cada volta** (correta)

**Dica:** Um conta quantas vezes; o outro junta quanto.

**Ao acertar:** O contador conta ocorrências (+1), enquanto o acumulador junta valores (soma += valor ou produto *= valor).

#### 2. Quanto vale s?

*Interpretação de código · fácil · id `acumulador-soma-um-a-quatro` · conceitos: Acumuladores (peso 3); Estrutura for (peso 1)*

O que o programa abaixo mostra na tela?

```
let s = 0;
for (let i = 1; i <= 4; i++) {
  s += i;
}
console.log(s);
```

- ✔ **10** (correta)
- ✗ 4 — *confusão: acha que s guarda só o último valor ou a quantidade de voltas*
- ✗ 6 — *confusão: esquece o último valor (erro de um)*
- ✗ 24 — *confusão: acha que += multiplica*

**Dica:** s = 0 + 1 + 2 + 3 + 4.

**Ao acertar:** A cada volta s soma o valor de i: 1, 3, 6 e por fim 10.

#### 3. Valor inicial

*Completar a lacuna · fácil · id `acumulador-complete-o-inicio` · conceitos: Acumuladores (peso 3); Operadores de atribuição (peso 1)*

Complete com o valor inicial correto do acumulador de uma soma.

```
let soma = {{1}};
for (let i = 1; i <= 3; i++) {
  soma += i;
}
```

Respostas aceitas: lacuna 1: 0

**Dica:** Qual número não altera uma soma?

**Ao acertar:** Para somar, o acumulador começa em 0, o elemento neutro da soma.

#### 4. Acumulador reiniciado

*Interpretação de código · médio · id `acumulador-reiniciado` · conceitos: Acumuladores (peso 3); Operadores de atribuição (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
for (let i = 1; i <= 3; i++) {
  let s = 0;
  s += i;
  console.log(s);
}
```

- ✗ 1 / 3 / 6 — *confusão: acha que s acumula entre as voltas, mesmo sendo declarado dentro do laço*
- ✗ 6 — *confusão: acha que o resultado só aparece no final*
- ✔ **1 / 2 / 3** (correta)
- ✗ 0 / 0 / 0 — *confusão: acha que o += não altera s*

**Dica:** O que acontece com uma variável declarada dentro do laço a cada volta?

**Ao acertar:** s é recriada com 0 em toda volta, então só guarda o i da volta atual: 1, 2 e 3. Para acumular, declare s antes do laço.

#### 5. Soma dos pares

*Código · médio · id `acumulador-soma-dos-pares` · conceitos: Acumuladores (peso 3); Estrutura for (peso 2); Estrutura if (peso 1)*

Escreva a função `somaDosPares(n)` que devolve a soma dos números pares de 1 até n.

Função: `somaDosPares`

Código inicial:

```js
function somaDosPares(n) {
  // seu código aqui
}
```

Testes:

- entrada [10] → retorna 30
- entrada [1] → retorna 0
- entrada [7] → retorna 12
- entrada [0] → retorna 0

Solução de referência:

```js
function somaDosPares(n) {
  let soma = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      soma += i;
    }
  }
  return soma;
}
```

**Dica:** Some i ao acumulador só quando i % 2 === 0.

**Solução comentada:** O acumulador começa em 0 e soma cada par encontrado entre 1 e n.

#### 6. Somar três números

*Código · médio · id `acumulador-somar-tres-entradas` · conceitos: Acumuladores (peso 3); Estrutura for (peso 1); Entrada e saída de informações (peso 2)*

Escreva a função `somarTres()`: leia três números com `lerEntrada()` (chegam como texto) e mostre a soma deles com `console.log`. Use um laço.

Função: `somarTres`

Código inicial:

```js
function somarTres() {
  // leia três números e mostre a soma
}
```

Testes:

- entrada [], lê ["1","2","3"] → imprime ["6"]
- entrada [], lê ["10","20","30"] → imprime ["60"]
- entrada [], lê ["-5","5","0"] → imprime ["0"]

Solução de referência:

```js
function somarTres() {
  let soma = 0;
  for (let i = 0; i < 3; i++) {
    soma += Number(lerEntrada());
  }
  console.log(soma);
}
```

**Dica:** Converta cada entrada com Number() antes de somar.

**Solução comentada:** Um for de 3 voltas lê cada número, converte e soma ao acumulador. Ao final, mostra o total.

#### 7. Corrija o produto

*Corrigir o erro · médio · id `acumulador-corrija-o-produto` · conceitos: Acumuladores (peso 3); Operadores aritméticos (peso 1)*

A função `produtoAte(n)` deveria devolver o produto de 1 até n (24 para n = 4), mas devolve sempre 0. Corrija o defeito.

Função: `produtoAte`

Código inicial:

```js
function produtoAte(n) {
  let produto = 0;
  for (let i = 1; i <= n; i++) {
    produto *= i;
  }
  return produto;
}
```

Testes:

- entrada [4] → retorna 24
- entrada [1] → retorna 1
- entrada [5] → retorna 120

Solução de referência:

```js
function produtoAte(n) {
  let produto = 1;
  for (let i = 1; i <= n; i++) {
    produto *= i;
  }
  return produto;
}
```

**Dica:** Qualquer número multiplicado por zero vira zero.

**Solução comentada:** Para multiplicar, o acumulador deve começar em 1 (o elemento neutro do produto). Começando em 0, o resultado é sempre 0.

#### 8. Até passar de dez

*Interpretação de código · difícil · id `acumulador-ate-passar-de-dez` · conceitos: Acumuladores (peso 3); Estrutura while (peso 2)*

O que o programa abaixo mostra na tela?

```
let s = 0;
let i = 1;
while (s < 10) {
  s += i;
  i++;
}
console.log(i);
```

- ✗ 4 — *confusão: mostra o último número somado, esquecendo que i++ roda depois da soma*
- ✔ **5** (correta)
- ✗ 10 — *confusão: confunde o valor de s com o valor de i*
- ✗ 3 — *confusão: acha que o laço para assim que s passa de 6*

**Dica:** Anote s e i a cada volta. s: 1, 3, 6, 10...

**Ao acertar:** s vai de 0 a 1, 3, 6 e 10 enquanto i vai de 1 a 5. Quando s vale 10, a condição s < 10 é falsa e i já vale 5.

#### 9. Média das entradas

*Código · difícil · id `acumulador-media-das-entradas` · conceitos: Acumuladores (peso 3); Estrutura for (peso 2); Entrada e saída de informações (peso 2); Operadores aritméticos (peso 1)*

Escreva a função `media()`: leia primeiro a quantidade de números e depois cada número (tudo com `lerEntrada()`) e mostre a média com `console.log`.

Função: `media`

Código inicial:

```js
function media() {
  // leia a quantidade, some os números e mostre a média
}
```

Testes:

- entrada [], lê ["3","4","6","8"] → imprime ["6"]
- entrada [], lê ["2","5","10"] → imprime ["7.5"]
- entrada [], lê ["1","9"] → imprime ["9"]

Solução de referência:

```js
function media() {
  const quantidade = Number(lerEntrada());
  let soma = 0;
  for (let i = 0; i < quantidade; i++) {
    soma += Number(lerEntrada());
  }
  console.log(soma / quantidade);
}
```

**Dica:** A média é a soma dividida pela quantidade lida.

**Solução comentada:** O acumulador soma os números lidos em um for e, depois do laço, a soma é dividida pela quantidade.

---

## Lição 7 — Comando break

**Foco:** Interromper um laço antes da hora

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O comando break encerra o laço imediatamente, mesmo que a condição ainda fosse verdadeira. O programa continua na primeira instrução depois do laço.
> 
> for (let i = 1; i <= 5; i++) {
>   if (i === 3) {
>     break;       // sai do laço quando i vale 3
>   }
>   console.log(i);
> }
> 
> Ele é útil quando você encontrou o que procurava e não precisa continuar: achar o primeiro número que atende a uma regra, parar de ler quando aparecer um valor especial, ou sair de um laço "infinito" de propósito:
> 
> while (true) {
>   // ...
>   if (terminou) {
>     break;
>   }
> }
> 
> Cuidado: break não é o mesmo que continue. O break encerra o laço todo; o continue só pula a volta atual.

### Exemplo

```
for (let i = 1; i <= 5; i++) {
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

Resultado: 1, 2 e Fim.
```

### Revisão

- break encerra o laço imediatamente.
- O programa segue na primeira instrução depois do laço.
- Serve para parar quando já achamos o que procurávamos.
- while (true) com break é um laço que só termina quando a condição de saída acontece.
- break encerra o laço; continue só pula a volta atual.

### Exercícios

#### 1. O que o break faz?

*Múltipla escolha · fácil · id `break-o-que-faz` · conceitos: Comando break (peso 3)*

O que o comando break faz dentro de um laço?

- ✗ Pula só a volta atual e vai para a próxima — *confusão: confunde break com continue*
- ✗ Encerra o programa inteiro — *confusão: acha que o break termina o programa, e não o laço*
- ✗ Reinicia o laço do começo — *confusão: acha que o break volta o contador para o início*
- ✔ **Encerra o laço imediatamente** (correta)

**Dica:** Pense em "quebrar" o laço.

**Ao acertar:** O break interrompe o laço na hora; o programa continua na primeira instrução depois dele.

#### 2. Para no três

*Interpretação de código · fácil · id `break-para-no-tres` · conceitos: Comando break (peso 3); Estrutura for (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
for (let i = 1; i <= 5; i++) {
  if (i === 3) {
    break;
  }
  console.log(i);
}
```

- ✔ **1 / 2** (correta)
- ✗ 1 / 2 / 3 — *confusão: acha que o break só atua depois de mostrar o 3*
- ✗ 1 / 2 / 4 / 5 — *confusão: confunde break com continue (pula só o 3)*
- ✗ 1 / 2 / 3 / 4 / 5 — *confusão: acha que o break não interrompe o laço*

**Dica:** O break executa antes do console.log quando i vale 3.

**Ao acertar:** Para i = 1 e 2 o valor é mostrado. Em i = 3 o break encerra o laço antes de mostrar.

#### 3. Complete o comando

*Completar a lacuna · fácil · id `break-complete-o-comando` · conceitos: Comando break (peso 2); Estrutura if (peso 1)*

Complete o comando que encerra o laço quando i vale 3.

```
for (let i = 1; i <= 5; i++) {
  if (i === 3) {
    {{1}};
  }
}
```

Respostas aceitas: lacuna 1: break

**Dica:** Em inglês, "quebrar".

**Ao acertar:** break sai do laço na hora.

#### 4. Laço com saída

*Interpretação de código · médio · id `break-while-true` · conceitos: Comando break (peso 3); Estrutura while (peso 1)*

O que o programa abaixo mostra na tela?

```
let n = 0;
while (true) {
  n++;
  if (n >= 3) {
    break;
  }
}
console.log(n);
```

- ✗ Nada, porque while (true) nunca termina — *confusão: acha que o break não consegue sair de while (true)*
- ✗ 2 — *confusão: acha que o break sai antes de n chegar a 3*
- ✔ **3** (correta)
- ✗ 4 — *confusão: acha que o laço dá mais uma volta depois do break*

**Dica:** A condição while (true) é sempre verdadeira; o que encerra o laço?

**Ao acertar:** n sobe de 1 em 1 e, quando chega a 3, o break encerra o laço. O programa mostra 3.

#### 5. Primeiro divisor

*Código · médio · id `break-primeiro-divisor` · conceitos: Comando break (peso 3); Estrutura for (peso 2); Estrutura if (peso 1)*

Escreva a função `primeiroDivisor(n)` que devolve o menor número maior que 1 que divide n sem deixar resto (n é maior que 1). Para um número primo, devolve o próprio n. Use break para parar quando achar.

Função: `primeiroDivisor`

Código inicial:

```js
function primeiroDivisor(n) {
  // seu código aqui
}
```

Testes:

- entrada [15] → retorna 3
- entrada [7] → retorna 7
- entrada [49] → retorna 7
- entrada [10] → retorna 2

Solução de referência:

```js
function primeiroDivisor(n) {
  let divisor = n;
  for (let i = 2; i <= n; i++) {
    if (n % i === 0) {
      divisor = i;
      break;
    }
  }
  return divisor;
}
```

**Dica:** Teste os números a partir do 2 e pare no primeiro que dividir n.

**Solução comentada:** O laço testa 2, 3, 4... e o break encerra no primeiro divisor. Se nenhum antes de n divide, o próprio n é o primeiro divisor.

#### 6. Somar até um negativo

*Código · médio · id `break-somar-ate-negativo` · conceitos: Comando break (peso 3); Acumuladores (peso 2); Entrada e saída de informações (peso 2)*

Escreva a função `somarAteNegativo()`: leia números com `lerEntrada()` (chegam como texto) e some-os, parando quando aparecer um número negativo (que não entra na soma). Mostre a soma com `console.log`.

Função: `somarAteNegativo`

Código inicial:

```js
function somarAteNegativo() {
  // leia os números e mostre a soma
}
```

Testes:

- entrada [], lê ["4","6","-1","9"] → imprime ["10"]
- entrada [], lê ["-1"] → imprime ["0"]
- entrada [], lê ["1","2","3","-5"] → imprime ["6"]

Solução de referência:

```js
function somarAteNegativo() {
  let soma = 0;
  while (true) {
    const n = Number(lerEntrada());
    if (n < 0) {
      break;
    }
    soma += n;
  }
  console.log(soma);
}
```

**Dica:** Um while (true) lê números; o break acontece quando o número for menor que 0.

**Solução comentada:** O laço lê cada número e, ao encontrar um negativo, o break encerra antes de somá-lo.

#### 7. Corrija o primeiro múltiplo

*Corrigir o erro · médio · id `break-corrija-o-primeiro` · conceitos: Comando break (peso 3); Estrutura if (peso 1)*

A função `primeiroMultiploDe7(limite)` deveria devolver o primeiro múltiplo de 7 de 1 até o limite (ou -1 se não houver), mas devolve o último. Corrija o defeito.

Função: `primeiroMultiploDe7`

Código inicial:

```js
function primeiroMultiploDe7(limite) {
  let achado = -1;
  for (let i = 1; i <= limite; i++) {
    if (i % 7 === 0) {
      achado = i;
    }
  }
  return achado;
}
```

Testes:

- entrada [20] → retorna 7
- entrada [30] → retorna 7
- entrada [6] → retorna -1
- entrada [7] → retorna 7

Solução de referência:

```js
function primeiroMultiploDe7(limite) {
  let achado = -1;
  for (let i = 1; i <= limite; i++) {
    if (i % 7 === 0) {
      achado = i;
      break;
    }
  }
  return achado;
}
```

**Dica:** Depois de achar o primeiro, o laço deveria continuar?

**Solução comentada:** Sem break, o laço continua e sobrescreve achado com os múltiplos seguintes. O break encerra na primeira ocorrência.

#### 8. Soma limitada

*Interpretação de código · difícil · id `break-soma-limitada` · conceitos: Comando break (peso 3); Acumuladores (peso 2); Estrutura if (peso 1)*

O que o programa abaixo mostra na tela?

```
let s = 0;
for (let i = 1; i <= 10; i++) {
  if (s + i > 10) {
    break;
  }
  s += i;
}
console.log(s);
```

- ✗ 55 — *confusão: acha que o break não interrompe a soma*
- ✔ **10** (correta)
- ✗ 15 — *confusão: soma mais um valor depois de passar do limite*
- ✗ 6 — *confusão: para cedo demais, achando que s não pode chegar a 10*

**Dica:** Acompanhe s: 1, 3, 6, 10... e o que acontece com i = 5.

**Ao acertar:** s chega a 10 com i = 4. Em i = 5, s + i = 15 > 10, o break encerra e o programa mostra 10.

#### 9. É primo?

*Código · difícil · id `break-eh-primo` · conceitos: Comando break (peso 3); Estrutura for (peso 2); Estrutura if/else (peso 1)*

Escreva a função `ehPrimo(n)` que devolve true se n for primo (maior que 1 e divisível só por 1 e por ele mesmo) e false caso contrário.

Função: `ehPrimo`

Código inicial:

```js
function ehPrimo(n) {
  // seu código aqui
}
```

Testes:

- entrada [2] → retorna true
- entrada [13] → retorna true
- entrada [97] → retorna true
- entrada [1] → retorna false
- entrada [9] → retorna false
- entrada [25] → retorna false

Solução de referência:

```js
function ehPrimo(n) {
  if (n < 2) {
    return false;
  }
  let primo = true;
  for (let i = 2; i < n; i++) {
    if (n % i === 0) {
      primo = false;
      break;
    }
  }
  return primo;
}
```

**Dica:** Se algum número de 2 até n - 1 dividir n, já sabemos que não é primo: pode parar.

**Solução comentada:** O laço procura um divisor entre 2 e n - 1; ao achar um, o break (ou return) encerra. Se não achar e n > 1, n é primo.

---

## Lição 8 — Comando continue

**Foco:** Pular uma volta sem encerrar o laço

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O comando continue pula o resto da volta atual e passa direto para a próxima volta. Diferente do break, o laço não termina: só aquela volta é interrompida.
> 
> for (let i = 1; i <= 5; i++) {
>   if (i === 3) {
>     continue;     // pula o resto desta volta
>   }
>   console.log(i);
> }
> 
> No exemplo, o 3 não é mostrado, mas o laço segue com 4 e 5.
> 
> É útil para ignorar casos que não interessam: pular números pares, ignorar letras que não são vogais, desconsiderar valores inválidos.
> 
> Num for, depois do continue o passo (i++) executa normalmente. Num while, cuidado: se a atualização da variável estiver depois do continue, ela será pulada e o laço pode ficar infinito. Faça a atualização antes do continue.

### Exemplo

```
for (let i = 1; i <= 6; i++) {
  if (i % 2 === 0) {
    continue;
  }
  console.log(i);
}

Passo a passo:
1. i = 1: 1 % 2 é 1, a condição é false: mostra 1.
2. i = 2: par. O continue pula o console.log e vai para i = 3.
3. i = 3: mostra 3. i = 4: pulado. i = 5: mostra 5. i = 6: pulado.

Resultado: 1, 3 e 5 (só os ímpares).
```

### Revisão

- continue pula o resto da volta atual e vai para a próxima.
- O laço não termina: só aquela volta é interrompida.
- Útil para ignorar valores que não interessam.
- Num while, atualize a variável antes do continue para evitar laço infinito.
- break encerra o laço; continue apenas pula uma volta.

### Exercícios

#### 1. break ou continue?

*Múltipla escolha · fácil · id `continue-break-ou-continue` · conceitos: Comando continue (peso 3); Comando break (peso 1)*

Qual é a diferença entre break e continue?

- ✗ Não há diferença: os dois encerram o laço — *confusão: acha que break e continue fazem a mesma coisa*
- ✗ O continue encerra o laço e o break pula a volta — *confusão: troca o efeito dos dois comandos*
- ✗ O break só funciona em while e o continue só em for — *confusão: acha que cada comando é de um tipo de laço*
- ✔ **O break encerra o laço; o continue pula só a volta atual** (correta)

**Dica:** Um "quebra" o laço; o outro "continua" na próxima volta.

**Ao acertar:** O break encerra o laço inteiro. O continue interrompe apenas a volta atual e o laço segue.

#### 2. Pula o três

*Interpretação de código · fácil · id `continue-pula-o-tres` · conceitos: Comando continue (peso 3); Estrutura for (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
for (let i = 1; i <= 5; i++) {
  if (i === 3) {
    continue;
  }
  console.log(i);
}
```

- ✔ **1 / 2 / 4 / 5** (correta)
- ✗ 1 / 2 — *confusão: confunde continue com break (encerra o laço)*
- ✗ 1 / 2 / 3 / 4 / 5 — *confusão: acha que o continue não tem efeito*
- ✗ 3 — *confusão: acha que o continue mostra só o valor pulado*

**Dica:** O continue pula o console.log só quando i vale 3.

**Ao acertar:** Em i = 3, o continue pula o resto da volta; o laço segue e mostra 4 e 5.

#### 3. Complete o comando

*Completar a lacuna · fácil · id `continue-complete-o-comando` · conceitos: Comando continue (peso 2); Estrutura if (peso 1)*

Complete o comando que pula as voltas em que i é par, para mostrar só os ímpares.

```
for (let i = 1; i <= 5; i++) {
  if (i % 2 === 0) {
    {{1}};
  }
  console.log(i);
}
```

Respostas aceitas: lacuna 1: continue

**Dica:** Não queremos encerrar o laço, só pular.

**Ao acertar:** continue pula o resto da volta e passa para a próxima.

#### 4. Só os ímpares

*Interpretação de código · médio · id `continue-so-impares` · conceitos: Comando continue (peso 3); Operadores aritméticos (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
for (let i = 1; i <= 6; i++) {
  if (i % 2 === 0) {
    continue;
  }
  console.log(i);
}
```

- ✗ 2 / 4 / 6 — *confusão: inverte: acha que o continue seleciona os pares*
- ✗ 1 — *confusão: acha que o continue encerra o laço depois do primeiro valor*
- ✔ **1 / 3 / 5** (correta)
- ✗ 1 / 2 / 3 / 4 / 5 / 6 — *confusão: acha que o continue não pula nada*

**Dica:** Para os pares, o console.log é pulado.

**Ao acertar:** Os pares (2, 4 e 6) caem no continue e são pulados; os ímpares são mostrados.

#### 5. Soma sem múltiplos de 3

*Código · médio · id `continue-soma-sem-multiplos-de-tres` · conceitos: Comando continue (peso 3); Acumuladores (peso 2)*

Escreva a função `somaSemMultiplosDeTres(n)` que devolve a soma de 1 até n, ignorando os múltiplos de 3. Use continue.

Função: `somaSemMultiplosDeTres`

Código inicial:

```js
function somaSemMultiplosDeTres(n) {
  // seu código aqui
}
```

Testes:

- entrada [10] → retorna 37
- entrada [2] → retorna 3
- entrada [3] → retorna 3
- entrada [0] → retorna 0

Solução de referência:

```js
function somaSemMultiplosDeTres(n) {
  let soma = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 3 === 0) {
      continue;
    }
    soma += i;
  }
  return soma;
}
```

**Dica:** Quando i % 3 === 0, pule a volta.

**Solução comentada:** O laço soma cada i ao acumulador, exceto os múltiplos de 3, que caem no continue.

#### 6. Texto sem vogais

*Código · médio · id `continue-sem-vogais` · conceitos: Comando continue (peso 3); Concatenação (peso 1); Tipo String (peso 1)*

Escreva a função `semVogais(texto)` que devolve o texto sem as vogais (a, e, i, o, u, maiúsculas ou minúsculas). Use continue para pular as vogais.

Função: `semVogais`

Código inicial:

```js
function semVogais(texto) {
  // seu código aqui
}
```

Testes:

- entrada ["banana"] → retorna "bnn"
- entrada ["Sol"] → retorna "Sl"
- entrada ["aeiou"] → retorna ""
- entrada ["Ola"] → retorna "l"

Solução de referência:

```js
function semVogais(texto) {
  let resultado = "";
  for (let i = 0; i < texto.length; i++) {
    if ("aeiou".includes(texto[i].toLowerCase())) {
      continue;
    }
    resultado += texto[i];
  }
  return resultado;
}
```

**Dica:** Se a letra for vogal, pule; senão, acrescente ao resultado.

**Solução comentada:** O laço percorre as letras; vogais são puladas e as demais são acrescentadas ao resultado.

#### 7. Corrija o laço

*Corrigir o erro · médio · id `continue-corrija-o-laco` · conceitos: Comando continue (peso 3); Estrutura while (peso 2)*

A função `somarImpares(n)` deveria devolver a soma dos ímpares de 1 até n, mas o laço nunca termina (o computador desiste por tempo esgotado). Corrija o defeito.

Função: `somarImpares`

Código inicial:

```js
function somarImpares(n) {
  let i = 0;
  let soma = 0;
  while (i < n) {
    if (i % 2 === 0) {
      continue;
    }
    soma += i;
    i++;
  }
  return soma;
}
```

Testes:

- entrada [5] → retorna 9
- entrada [1] → retorna 1
- entrada [0] → retorna 0

Solução de referência:

```js
function somarImpares(n) {
  let i = 0;
  let soma = 0;
  while (i < n) {
    i++;
    if (i % 2 === 0) {
      continue;
    }
    soma += i;
  }
  return soma;
}
```

**Dica:** O i++ está depois do continue: ele chega a ser executado quando i é par?

**Solução comentada:** Com o continue antes de i++, quando i é par o contador nunca avança. Atualize i antes do continue (por exemplo, no início do laço, somando 1).

#### 8. continue e break juntos

*Interpretação de código · difícil · id `continue-e-break-juntos` · conceitos: Comando continue (peso 3); Comando break (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
for (let i = 1; i <= 10; i++) {
  if (i % 2 === 0) {
    continue;
  }
  if (i > 7) {
    break;
  }
  console.log(i);
}
```

- ✗ 1 / 3 / 5 / 7 / 9 — *confusão: esquece que o break encerra o laço quando i passa de 7*
- ✔ **1 / 3 / 5 / 7** (correta)
- ✗ 2 / 4 / 6 — *confusão: acha que o continue seleciona os pares*
- ✗ 1 / 3 / 5 / 7 / 9 / 11 — *confusão: acha que o laço segue depois do break*

**Dica:** Pares são pulados; quando i chega a 9 (ímpar), o break entra em ação.

**Ao acertar:** Os pares são pulados e os ímpares até 7 são mostrados. Em i = 9, o break encerra o laço.

#### 9. O que vem depois do continue?

*Múltipla escolha · médio · id `continue-o-que-acontece-depois` · conceitos: Comando continue (peso 3)*

Em uma volta em que o continue é executado, o que acontece com as instruções que vêm depois dele no corpo do laço?

- ✗ Elas executam normalmente, depois o laço continua — *confusão: acha que o continue não altera o fluxo da volta*
- ✗ O laço encerra e elas são ignoradas para sempre — *confusão: confunde continue com break*
- ✗ O laço recomeça do zero — *confusão: acha que o continue reinicia o laço*
- ✔ **Elas são ignoradas nessa volta, e o laço segue com a próxima volta** (correta)

**Dica:** O continue "pula" o restante da volta.

**Ao acertar:** O continue interrompe a volta atual: o que está depois dele é ignorado só nessa volta, e o laço continua.

---

## Lição 9 — Laços de repetição aninhados

**Foco:** Colocar um laço dentro de outro

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Laços aninhados são laços dentro de outros laços. Para cada volta do laço de fora, o laço de dentro roda por completo, do início ao fim.
> 
> for (let i = 1; i <= 3; i++) {        // laço externo: 3 voltas
>   for (let j = 1; j <= 4; j++) {      // laço interno: 4 voltas por volta externa
>     console.log(i, j);
>   }
> }
> 
> O corpo do laço interno executa 3 × 4 = 12 vezes: o número de execuções se multiplica, não se soma.
> 
> Pense num relógio: o ponteiro dos minutos dá 60 voltas completas enquanto o das horas avança uma casa.
> 
> Dicas:
> - use variáveis diferentes em cada laço (i e j);
> - o limite do laço interno pode depender do externo (por exemplo, j <= i para desenhar triângulos);
> - um break dentro do laço interno encerra somente o laço interno.
> 
> Laços aninhados servem para tabelas, desenhos com caracteres e para combinar todos os valores de dois conjuntos.

### Exemplo

```
for (let i = 1; i <= 2; i++) {
  for (let j = 1; j <= 3; j++) {
    console.log(i, j);
  }
}

Passo a passo:
1. i = 1: o laço interno roda por inteiro: j = 1, 2 e 3 (mostra 1 1, 1 2 e 1 3).
2. i = 2: o laço interno recomeça e roda de novo: 2 1, 2 2 e 2 3.
3. O corpo executou 2 × 3 = 6 vezes.

O laço de fora muda devagar; o de dentro muda a cada volta.
```

### Revisão

- Laço aninhado: um laço dentro de outro.
- Para cada volta do laço externo, o interno executa por completo.
- Total de execuções do corpo interno = voltas externas × voltas internas.
- Use variáveis diferentes (i e j) em cada laço.
- break dentro do laço interno encerra só o interno.

### Exercícios

#### 1. Quantas execuções?

*Múltipla escolha · fácil · id `aninhados-quantas-vezes` · conceitos: Laços de repetição aninhados (peso 3)*

Um laço externo dá 3 voltas e, em cada uma, um laço interno dá 4 voltas. Quantas vezes o corpo do laço interno executa no total?

- ✔ **12** (correta)
- ✗ 7 — *confusão: acha que as voltas se somam em vez de multiplicar*
- ✗ 4 — *confusão: conta só as voltas do laço interno*
- ✗ 3 — *confusão: conta só as voltas do laço externo*

**Dica:** Para cada volta externa, o interno roda inteiro.

**Ao acertar:** O número de execuções se multiplica: 3 × 4 = 12.

#### 2. Pares (i, j)

*Interpretação de código · fácil · id `aninhados-pares-de-valores` · conceitos: Laços de repetição aninhados (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
for (let i = 1; i <= 2; i++) {
  for (let j = 1; j <= 3; j++) {
    console.log(i, j);
  }
}
```

- ✗ 1 1 / 2 2 / 3 3 — *confusão: acha que os dois laços avançam juntos*
- ✗ 1 1 / 1 2 / 1 3 — *confusão: acha que o laço externo executa só uma vez*
- ✔ **1 1 / 1 2 / 1 3 / 2 1 / 2 2 / 2 3** (correta)
- ✗ 1 1 / 2 1 / 1 2 / 2 2 / 1 3 / 2 3 — *confusão: inverte quem muda mais rápido (o interno muda a cada volta)*

**Dica:** Enquanto i vale 1, j percorre todos os seus valores.

**Ao acertar:** Para i = 1, j vai de 1 a 3; só depois i passa a 2 e j recomeça de 1.

#### 3. Complete o laço interno

*Completar a lacuna · fácil · id `aninhados-complete-a-variavel` · conceitos: Laços de repetição aninhados (peso 2); Estrutura for (peso 1)*

Complete o nome da variável do laço interno, que deve ser diferente da do laço externo.

```
for (let i = 1; i <= 3; i++) {
  for (let {{1}} = 1; j <= 3; j++) {
    console.log(i, j);
  }
}
```

Respostas aceitas: lacuna 1: j

**Dica:** Olhe a condição do laço interno.

**Ao acertar:** O laço interno usa a variável j, diferente de i (usada pelo laço externo).

#### 4. Conta as voltas

*Interpretação de código · médio · id `aninhados-conta-as-voltas` · conceitos: Laços de repetição aninhados (peso 3); Contadores (peso 2)*

O que o programa abaixo mostra na tela?

```
let c = 0;
for (let i = 0; i < 3; i++) {
  for (let j = 0; j < 4; j++) {
    c++;
  }
}
console.log(c);
```

- ✗ 7 — *confusão: soma as voltas dos dois laços em vez de multiplicar*
- ✔ **12** (correta)
- ✗ 4 — *confusão: conta só as voltas do laço interno*
- ✗ 3 — *confusão: conta só as voltas do laço externo*

**Dica:** O c++ está dentro do laço interno.

**Ao acertar:** O corpo interno executa 3 × 4 = 12 vezes, e o contador sobe a cada execução.

#### 5. Retângulo de asteriscos

*Código · médio · id `aninhados-retangulo` · conceitos: Laços de repetição aninhados (peso 3); Estrutura for (peso 2); Utilização de console.log() (peso 1)*

Escreva a função `retangulo(linhas, colunas)` que mostra, com `console.log`, um retângulo de asteriscos: uma linha de texto para cada linha do retângulo, com `colunas` asteriscos. Por exemplo, retangulo(2, 3) mostra *** duas vezes.

Função: `retangulo`

Código inicial:

```js
function retangulo(linhas, colunas) {
  // seu código aqui
}
```

Testes:

- entrada [2,3] → imprime ["***","***"]
- entrada [3,1] → imprime ["*","*","*"]
- entrada [1,4] → imprime ["****"]
- entrada [2,2] → imprime ["**","**"]

Solução de referência:

```js
function retangulo(linhas, colunas) {
  for (let i = 0; i < linhas; i++) {
    let linha = "";
    for (let j = 0; j < colunas; j++) {
      linha += "*";
    }
    console.log(linha);
  }
}
```

**Dica:** Monte cada linha com um laço interno e mostre-a com um console.log depois dele.

**Solução comentada:** O laço externo percorre as linhas; o interno acrescenta um asterisco por coluna; ao fim de cada linha, ela é mostrada.

#### 6. Tabela de multiplicação

*Código · médio · id `aninhados-tabela-de-multiplicacao` · conceitos: Laços de repetição aninhados (peso 3); Estrutura for (peso 2); Concatenação (peso 1)*

Escreva a função `tabela()` que mostra a tabela de multiplicação de 1 a 3, uma linha por número, com os produtos separados por espaço (primeira linha: 1 2 3).

Função: `tabela`

Código inicial:

```js
function tabela() {
  // mostre as três linhas
}
```

Testes:

- entrada [] → imprime ["1 2 3","2 4 6","3 6 9"]

Solução de referência:

```js
function tabela() {
  for (let i = 1; i <= 3; i++) {
    let linha = "";
    for (let j = 1; j <= 3; j++) {
      linha += (j === 1 ? "" : " ") + i * j;
    }
    console.log(linha);
  }
}
```

**Dica:** Para cada linha i, o laço interno junta i × j para j de 1 a 3.

**Solução comentada:** O laço externo escolhe a linha (i) e o interno percorre as colunas (j), juntando os produtos em um texto que é mostrado ao fim da linha.

#### 7. Corrija o triângulo

*Corrigir o erro · médio · id `aninhados-corrija-o-triangulo` · conceitos: Laços de repetição aninhados (peso 3); Estrutura for (peso 1)*

A função `triangulo(n)` deveria mostrar um triângulo de asteriscos (a linha 1 tem 1 asterisco, a linha 2 tem 2, e assim por diante), mas mostra um retângulo. Corrija o defeito.

Função: `triangulo`

Código inicial:

```js
function triangulo(n) {
  for (let i = 1; i <= n; i++) {
    let linha = "";
    for (let j = 1; j <= n; j++) {
      linha += "*";
    }
    console.log(linha);
  }
}
```

Testes:

- entrada [3] → imprime ["*","**","***"]
- entrada [1] → imprime ["*"]
- entrada [4] → imprime ["*","**","***","****"]

Solução de referência:

```js
function triangulo(n) {
  for (let i = 1; i <= n; i++) {
    let linha = "";
    for (let j = 1; j <= i; j++) {
      linha += "*";
    }
    console.log(linha);
  }
}
```

**Dica:** O limite do laço interno deveria depender da linha atual.

**Solução comentada:** Com j <= n, todas as linhas têm n asteriscos. Com j <= i, a linha i tem i asteriscos.

#### 8. Linhas crescentes

*Interpretação de código · difícil · id `aninhados-linha-crescente` · conceitos: Laços de repetição aninhados (peso 3); Concatenação (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
for (let i = 1; i <= 3; i++) {
  let linha = "";
  for (let j = 1; j <= i; j++) {
    linha += j;
  }
  console.log(linha);
}
```

- ✗ 1 / 1 / 1 — *confusão: acha que o limite do laço interno não depende de i*
- ✗ 123 / 123 / 123 — *confusão: acha que o laço interno sempre vai até 3*
- ✗ 1 / 3 / 6 — *confusão: confunde concatenar com somar*
- ✔ **1 / 12 / 123** (correta)

**Dica:** O laço interno vai de 1 até i, e a linha é refeita em cada volta externa.

**Ao acertar:** Para i = 1, linha vira 1; para i = 2, 12; para i = 3, 123. Os números são juntados como texto.

#### 9. Pares de valores

*Código · difícil · id `aninhados-contar-pares` · conceitos: Laços de repetição aninhados (peso 3); Contadores (peso 2); Estrutura for (peso 1)*

Escreva a função `contarPares(n)` que devolve quantos pares (i, j) existem com 1 <= i < j <= n (o par (1, 2) conta, o par (2, 1) não). Use dois laços aninhados.

Função: `contarPares`

Código inicial:

```js
function contarPares(n) {
  // seu código aqui
}
```

Testes:

- entrada [1] → retorna 0
- entrada [3] → retorna 3
- entrada [4] → retorna 6
- entrada [5] → retorna 10

Solução de referência:

```js
function contarPares(n) {
  let pares = 0;
  for (let i = 1; i <= n; i++) {
    for (let j = i + 1; j <= n; j++) {
      pares++;
    }
  }
  return pares;
}
```

**Dica:** Para cada i, o laço interno começa em i + 1.

**Solução comentada:** O laço interno começa em i + 1, então cada par é contado uma só vez. Um contador soma 1 a cada par.

#### 10. break no laço interno

*Múltipla escolha · médio · id `aninhados-break-no-interno` · conceitos: Laços de repetição aninhados (peso 2); Comando break (peso 2)*

Em dois laços aninhados, o que um break dentro do laço interno encerra?

- ✔ **Apenas o laço interno; o externo segue para a próxima volta** (correta)
- ✗ Os dois laços — *confusão: acha que o break atinge também o laço externo*
- ✗ Só o laço externo — *confusão: inverte qual laço é encerrado*
- ✗ O programa inteiro — *confusão: acha que o break termina o programa*

**Dica:** O break atua no laço mais próximo.

**Ao acertar:** O break encerra só o laço em que está escrito (o mais interno); o externo continua normalmente.

---

## Lição 10 — Desafio final do Mundo 5

**Foco:** Juntar os laços em um jogo de adivinhação

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Chegou o desafio do Mundo 5: um jogo de adivinhação com tentativas limitadas. O computador "pensa" em um número secreto e o jogador tem um número máximo de tentativas para descobri-lo. A cada palpite errado, o programa dá uma dica: o número secreto é maior ou menor que o palpite.
> 
> Aqui você vai juntar o que aprendeu: laços para repetir as tentativas, contador para saber quantas foram usadas, condicionais (Mundo 4) para dar as dicas e break (ou uma condição no laço) para parar quando o jogador acertar.
> 
> O desafio principal é o primeiro exercício. Os outros dois treinam a leitura de laços combinados e a correção de um erro clássico.

### Exemplo

```
Como montar o jogo:
1. Use um laço de no máximo "tentativas" voltas e um contador (a volta atual).
2. A cada volta, leia o palpite com lerEntrada() e converta com Number().
3. Se o palpite for igual ao segredo, mostre Acertou! com o número de tentativas e encerre o laço (break ou return).
4. Se for menor que o segredo, mostre que o número é maior; se for maior, mostre que é menor.
5. Se o laço terminar sem acerto, mostre o fim de jogo revelando o número.
6. Teste o acerto na primeira tentativa, o acerto na última e o fim de jogo.
```

### Revisão

- Laço com limite de voltas: o número máximo de tentativas.
- Contador: quantas tentativas foram usadas.
- Condicionais dão as dicas (maior, menor, acertou).
- break (ou return) encerra o laço quando o jogador acerta.
- Teste os casos de fronteira: acertar de primeira, acertar na última tentativa e esgotar as tentativas.

### Exercícios

#### 1. Desafio: jogo de adivinhação

*Desafio · difícil · id `desafio5-adivinhacao` · conceitos: Estrutura for (peso 2); Comando break (peso 2); Contadores (peso 2); Estrutura else if (peso 2); Entrada e saída de informações (peso 1); Conversão de tipos (peso 1)*

Escreva a função `adivinhar(segredo, tentativas)`: leia até `tentativas` palpites com `lerEntrada()` (chegam como texto). Para cada palpite errado, mostre `O número é maior` (se o segredo for maior que o palpite) ou `O número é menor`. Se acertar, mostre `Acertou! Tentativas: N` (N = quantos palpites foram usados) e pare de ler. Se as tentativas acabarem sem acerto, mostre `Fim de jogo! O número era X`.

Função: `adivinhar`

Código inicial:

```js
function adivinhar(segredo, tentativas) {
  // leia os palpites e mostre as dicas
}
```

Testes:

- entrada [7,3], lê ["5","9","7"] → imprime ["O número é maior","O número é menor","Acertou! Tentativas: 3"]
- entrada [7,3], lê ["7"] → imprime ["Acertou! Tentativas: 1"]
- entrada [7,2], lê ["1","2"] → imprime ["O número é maior","O número é maior","Fim de jogo! O número era 7"]
- entrada [4,3], lê ["9","1","4"] → imprime ["O número é menor","O número é maior","Acertou! Tentativas: 3"]
- entrada [4,3], lê ["4","1"] → imprime ["Acertou! Tentativas: 1"]

Solução de referência:

```js
function adivinhar(segredo, tentativas) {
  for (let i = 1; i <= tentativas; i++) {
    const palpite = Number(lerEntrada());
    if (palpite === segredo) {
      console.log("Acertou! Tentativas: " + i);
      return;
    } else if (palpite < segredo) {
      console.log("O número é maior");
    } else {
      console.log("O número é menor");
    }
  }
  console.log("Fim de jogo! O número era " + segredo);
}
```

**Dica:** Use um for de 1 até tentativas. Se acertar, mostre a mensagem e use return (ou break); se o laço terminar, mostre o fim de jogo.

**Solução comentada:** Um for percorre as tentativas, lendo e comparando cada palpite. No acerto, o jogo encerra com o número de tentativas usadas; se o laço acaba, revela o número.

#### 2. Desafio: corrija o resumo

*Corrigir o erro · difícil · id `desafio5-corrija-o-resumo` · conceitos: Comando continue (peso 2); Contadores (peso 2); Acumuladores (peso 2)*

A função `resumo(n)` deveria devolver, em texto, a soma dos ímpares e a quantidade de pares de 1 até n (por exemplo, "9 3" para n = 6: ímpares 1 + 3 + 5 = 9 e três pares). Hoje a quantidade de pares sai sempre 0. Corrija o defeito.

Função: `resumo`

Código inicial:

```js
function resumo(n) {
  let soma = 0;
  let pares = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      continue;
      pares++;
    }
    soma += i;
  }
  return soma + " " + pares;
}
```

Testes:

- entrada [6] → retorna "9 3"
- entrada [1] → retorna "1 0"
- entrada [0] → retorna "0 0"
- entrada [10] → retorna "25 5"

Solução de referência:

```js
function resumo(n) {
  let soma = 0;
  let pares = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      pares++;
      continue;
    }
    soma += i;
  }
  return soma + " " + pares;
}
```

**Dica:** O que vem depois do continue na mesma volta é executado?

**Solução comentada:** O pares++ ficava depois do continue, então nunca executava. Colocando-o antes do continue, cada par é contado e depois a volta é pulada.

#### 3. Desafio: acompanhe os laços

*Interpretação de código · difícil · id `desafio5-acompanhe-os-lacos` · conceitos: Laços de repetição aninhados (peso 2); Comando continue (peso 2); Comando break (peso 2); Acumuladores (peso 1)*

Acompanhe os valores das variáveis. O que o programa abaixo mostra na tela?

```
let total = 0;
for (let i = 1; i <= 3; i++) {
  for (let j = 1; j <= 3; j++) {
    if (j === i) {
      continue;
    }
    if (j > 2) {
      break;
    }
    total += i * j;
  }
}
console.log(total);
```

- ✗ 12 — *confusão: esquece que o laço interno de i = 3 ainda soma 3 e 6 antes do continue*
- ✗ 18 — *confusão: ignora o break e o continue e soma todos os produtos*
- ✔ **13** (correta)
- ✗ 9 — *confusão: acha que o break encerra o laço externo também*

**Dica:** Faça uma tabela com i, j e total. O break só encerra o laço interno.

**Ao acertar:** i = 1: soma 1×2 = 2 (j = 1 é pulado, j = 3 faz break). i = 2: soma 2×1 = 2 (j = 2 pulado, j = 3 break). i = 3: soma 3×1 e 3×2 (j = 3 é pulado). Total: 2 + 2 + 3 + 6 = 13.

