# Revisão do conteúdo — Operadores

> GERADO por `npm run content:review`. Não edite este arquivo: ele muda quando o conteúdo mudar.

**Objetivo do mundo:** Ensinar o aluno a realizar operações matemáticas e comparações utilizando operadores.

Este documento reúne tudo o que os alunos vão ver neste mundo: 7 lições e 54 exercícios. **Nada foi publicado:** os exercícios estão como rascunho e só o professor os vê.

## Como revisar
1. Leia cada lição (texto, exemplo, revisão e exercícios) como se fosse um aluno iniciante.
2. Confira o gabarito (✔) e as "confusões" das alternativas erradas: elas alimentam o painel de dificuldades.
3. Anote ajustes por lição. Peça a correção ao Claude, que altera os arquivos de `content/`.
4. Quando aprovar, publique com `npm run content:publish -- mundo-3` (gera o SQL para colar no Supabase).

## Resumo
| Lição | Exercícios | Fácil | Médio | Difícil | Tipos |
|---|---:|---:|---:|---:|---|
| Introdução aos operadores | 7 | 3 | 3 | 1 | 4 múltipla escolha, 1 completar a lacuna, 2 interpretação de código |
| Operadores aritméticos | 8 | 3 | 4 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Operadores de atribuição | 8 | 3 | 4 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 corrigir o erro, 1 código |
| Operadores relacionais | 9 | 3 | 4 | 2 | 2 múltipla escolha, 4 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Operadores lógicos | 10 | 4 | 4 | 2 | 3 múltipla escolha, 4 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Precedência dos operadores | 9 | 3 | 4 | 2 | 2 múltipla escolha, 4 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Desafio final do Mundo 3 | 3 | 0 | 0 | 3 | 1 desafio, 1 corrigir o erro, 1 interpretação de código |

---

## Lição 1 — Introdução aos operadores

**Foco:** Reconhecer operadores, operandos e os quatro grupos de operadores

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Um operador é um símbolo que faz uma operação com valores. Os valores sobre os quais ele atua se chamam operandos. Em 2 + 3, o + é o operador e 2 e 3 são os operandos. Uma expressão é qualquer combinação de valores e operadores que produz um resultado.
> 
> Os operadores se dividem em quatro grupos:
> - Aritméticos: fazem contas (+, -, *, /, %, **) e resultam em número.
> - De atribuição: guardam valores em variáveis (=, +=, ++...).
> - Relacionais: comparam dois valores (>, <, ===...) e resultam em true ou false.
> - Lógicos: combinam resultados true ou false (&&, ||, !).
> 
> A maioria usa dois operandos (2 + 3); alguns usam só um, como o ! em !true. Neste mundo você vai estudar cada grupo e, no final, a ordem em que o computador resolve tudo.

### Exemplo

```
const soma = 2 + 3;            // aritmético: resultado 5 (number)
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
5. O sinal - na frente de total usa um operando só: inverte o sinal do número.
```

### Revisão

- Operador é um símbolo que realiza uma operação; operandos são os valores usados por ele.
- Expressão é uma combinação de valores e operadores que produz um resultado.
- Aritméticos resultam em número; relacionais e lógicos resultam em boolean.
- Atribuição guarda um valor em uma variável.
- Alguns operadores usam um operando só (como o !).

### Exercícios

#### 1. Qual é o operador?

*Múltipla escolha · fácil · id `op-intro-quem-e-o-operador` · conceitos: Introdução aos operadores (peso 3)*

Na expressão 7 + 2, qual é o operador?

- ✗ 7 — *confusão: confunde operador com operando*
- ✔ **+** (correta)
- ✗ 2 — *confusão: confunde operador com operando*
- ✗ 7 + 2 — *confusão: chama a expressão inteira de operador*

**Dica:** O operador é o símbolo que manda fazer a operação.

**Ao acertar:** O operador é o +. Os números 7 e 2 são os operandos, e a expressão toda é 7 + 2.

#### 2. Qual grupo compara valores?

*Múltipla escolha · fácil · id `op-intro-grupo-relacional` · conceitos: Introdução aos operadores (peso 3)*

Qual grupo de operadores compara dois valores e resulta em true ou false?

- ✗ Aritméticos — *confusão: confunde comparar valores com fazer contas*
- ✗ De atribuição — *confusão: confunde comparar com guardar um valor em uma variável*
- ✗ Lógicos — *confusão: confunde comparar valores com combinar resultados booleanos*
- ✔ **Relacionais** (correta)

**Dica:** São os operadores de >, < e ===.

**Ao acertar:** Os operadores relacionais comparam dois valores e respondem com um boolean.

#### 3. Complete a conta

*Completar a lacuna · fácil · id `op-intro-complete-a-conta` · conceitos: Introdução aos operadores (peso 2)*

Complete a linha com o operador que faz o programa mostrar 12.

```
const resultado = 4 {{1}} 3;
console.log(resultado);
```

Respostas aceitas: lacuna 1: *

**Dica:** 4 e 3 dão 12 quando um é multiplicado pelo outro.

**Ao acertar:** O operador * multiplica: 4 * 3 vale 12.

#### 4. Conta e comparação

*Interpretação de código · médio · id `op-intro-soma-e-comparacao` · conceitos: Introdução aos operadores (peso 3); Operadores relacionais (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
const a = 4;
const b = 4;
console.log(a + b);
console.log(a > b);
```

- ✔ **8 / false** (correta)
- ✗ 8 / true — *confusão: acha que 4 é maior que 4*
- ✗ 44 / false — *confusão: junta os números como se fossem textos*
- ✗ false / 8 — *confusão: inverte a ordem dos resultados*

**Dica:** Uma linha faz uma conta; a outra, uma comparação.

**Ao acertar:** a + b vale 8 (número). a > b pergunta se 4 é maior que 4, e a resposta é false.

#### 5. Qual expressão resulta em boolean?

*Múltipla escolha · médio · id `op-intro-resultado-boolean` · conceitos: Introdução aos operadores (peso 3); Operadores relacionais (peso 1)*

Qual destas expressões resulta em um valor boolean?

- ✗ 3 + 4 — *confusão: acha que toda expressão com números resulta em boolean*
- ✗ 3 * 4 — *confusão: confunde uma conta com uma comparação*
- ✔ **3 < 4** (correta)
- ✗ 10 % 3 — *confusão: confunde o resto de uma divisão com uma comparação*

**Dica:** Procure a expressão que faz uma pergunta.

**Ao acertar:** 3 < 4 compara dois valores e resulta em true. As outras são contas e resultam em números.

#### 6. Um operando só

*Múltipla escolha · médio · id `op-intro-operador-unario` · conceitos: Introdução aos operadores (peso 3); Operadores lógicos (peso 1)*

Qual destes operadores é usado, normalmente, com um operando só?

- ✗ * — *confusão: acha que a multiplicação trabalha com um valor só*
- ✔ **!** (correta)
- ✗ && — *confusão: acha que o operador E trabalha com um valor só*
- ✗ === — *confusão: acha que a comparação trabalha com um valor só*

**Dica:** Pense em qual deles aparece na frente de um valor, como em !true.

**Ao acertar:** O ! (NÃO) inverte um valor boolean e usa um operando só. Os outros operadores precisam de dois operandos.

#### 7. Os grupos juntos

*Interpretação de código · difícil · id `op-intro-varios-grupos` · conceitos: Introdução aos operadores (peso 3); Operadores de atribuição (peso 1); Operadores relacionais (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
let x = 3;
x = x * 2;
console.log(x > 5);
console.log(x + 1);
```

- ✗ false / 4 — *confusão: esquece que x foi alterado para 6*
- ✗ true / 61 — *confusão: junta o 6 e o 1 como texto*
- ✗ true / 4 — *confusão: usa o valor antigo de x (3) na última linha*
- ✔ **true / 7** (correta)

**Dica:** Acompanhe o valor de x depois de cada linha.

**Ao acertar:** x passa a valer 6. Então x > 5 é true e x + 1 vale 7.

---

## Lição 2 — Operadores aritméticos

**Foco:** Fazer contas com +, -, *, /, % e **

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Os operadores aritméticos fazem as contas:
> - + soma, - subtração, * multiplicação;
> - / divisão: em JavaScript o resultado pode ser decimal (17 / 5 vale 3.4);
> - % resto da divisão: 17 % 5 vale 2, porque 17 = 3 * 5 + 2;
> - ** potência: 2 ** 10 vale 1024.
> 
> O resto é muito útil: n % 2 vale 0 quando n é par, e n % 10 dá o último dígito de n. Para obter só a parte inteira de uma divisão, use Math.floor(17 / 5), que vale 3.
> 
> Casos especiais: dividir por zero dá Infinity (ou -Infinity), e pedir o resto da divisão por zero ou fazer 0 / 0 dá NaN. Nenhum deles causa erro no programa.

### Exemplo

```
console.log(17 + 5);              // 22
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
5. Math.floor arredonda para baixo e dá a parte inteira da divisão.
```

### Revisão

- + - * / % ** são os operadores aritméticos.
- / dá resultado decimal; Math.floor dá a parte inteira da divisão.
- % dá o resto: n % 2 === 0 indica um número par; n % 10 dá o último dígito.
- ** é a potência. O símbolo ^ NÃO é potência em JavaScript.
- Dividir por zero dá Infinity; 0 / 0 e o resto por zero dão NaN.

### Exercícios

#### 1. Qual operador é a potência?

*Múltipla escolha · fácil · id `arit-operador-da-potencia` · conceitos: Operadores aritméticos (peso 3)*

Qual operador calcula uma potência (2 elevado a 3)?

- ✔ ****** (correta)
- ✗ ^ — *confusão: usa o símbolo da matemática escrita, mas em JavaScript ele faz outra operação*
- ✗ * — *confusão: confunde potência com multiplicação*
- ✗ % — *confusão: confunde potência com resto da divisão*

**Dica:** São dois asteriscos juntos.

**Ao acertar:** A potência usa **. Assim, 2 ** 3 vale 8. O ^ existe, mas faz outra operação (bit a bit).

#### 2. Quanto vale 20 % 6?

*Interpretação de código · fácil · id `arit-resto-de-vinte-por-seis` · conceitos: Operadores aritméticos (peso 3)*

O que o programa abaixo mostra na tela?

```
console.log(20 % 6);
```

- ✗ 3 — *confusão: mostra o quociente da divisão em vez do resto*
- ✗ 3.3333333333333335 — *confusão: mostra o resultado decimal da divisão*
- ✔ **2** (correta)
- ✗ 14 — *confusão: calcula a diferença em vez do resto*

**Dica:** Quantas vezes o 6 cabe no 20? E o que sobra?

**Ao acertar:** 6 cabe 3 vezes em 20 (18) e sobram 2. O % devolve essa sobra.

#### 3. Complete o resto

*Completar a lacuna · fácil · id `arit-complete-o-resto` · conceitos: Operadores aritméticos (peso 2)*

Complete a linha para mostrar o resto da divisão de 17 por 5.

```
console.log(17 {{1}} 5);
```

Respostas aceitas: lacuna 1: %

**Dica:** Esse operador lembra o símbolo de porcentagem.

**Ao acertar:** 17 % 5 vale 2, porque 5 cabe 3 vezes em 17 e sobram 2.

#### 4. Potência, produto e divisão

*Interpretação de código · médio · id `arit-tres-contas` · conceitos: Operadores aritméticos (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(2 ** 3);
console.log(2 * 3);
console.log(9 / 2);
```

- ✗ 6 / 6 / 4.5 — *confusão: acha que ** multiplica, como o **
- ✔ **8 / 6 / 4.5** (correta)
- ✗ 8 / 6 / 4 — *confusão: acha que a divisão arredonda para um número inteiro*
- ✗ 5 / 6 / 4.5 — *confusão: confunde a potência com a soma*

**Dica:** ** é potência: 2 multiplicado por ele mesmo 3 vezes.

**Ao acertar:** 2 ** 3 = 2 * 2 * 2 = 8, 2 * 3 = 6 e 9 / 2 = 4.5.

#### 5. Último dígito

*Código · médio · id `arit-ultimo-digito` · conceitos: Operadores aritméticos (peso 3)*

Escreva a função `ultimoDigito(n)` que devolve o último dígito de um número inteiro positivo (por exemplo, 123 devolve 3).

Função: `ultimoDigito`

Código inicial:

```js
function ultimoDigito(n) {
  // seu código aqui
}
```

Testes:

- entrada [123] → retorna 3
- entrada [40] → retorna 0
- entrada [7] → retorna 7
- entrada [2024] → retorna 4

Solução de referência:

```js
function ultimoDigito(n) {
  return n % 10;
}
```

**Dica:** O resto da divisão por 10 é o que sobra depois de tirar as dezenas, centenas...

**Solução comentada:** n % 10 devolve o que sobra da divisão por 10, que é exatamente o último dígito.

#### 6. Parte inteira da divisão

*Múltipla escolha · médio · id `arit-parte-inteira` · conceitos: Operadores aritméticos (peso 3)*

Qual expressão dá a parte inteira da divisão de 17 por 5 (isto é, 3)?

- ✗ 17 / 5 — *confusão: esquece que a divisão em JavaScript dá resultado decimal (3.4)*
- ✗ 17 % 5 — *confusão: confunde a parte inteira (quociente) com o resto da divisão*
- ✗ 17 // 5 — *confusão: usa o operador de divisão inteira de outras linguagens; em JavaScript o // começa um comentário*
- ✔ **Math.floor(17 / 5)** (correta)

**Dica:** Faça a divisão decimal e depois arredonde para baixo.

**Ao acertar:** 17 / 5 vale 3.4 e Math.floor arredonda para baixo, resultando em 3.

#### 7. Corrija o quadrado

*Corrigir o erro · médio · id `arit-corrija-o-quadrado` · conceitos: Operadores aritméticos (peso 3)*

A função `quadrado(n)` deveria devolver n elevado a 2, mas devolve valores errados (por exemplo, 1 para n = 3). Corrija o defeito.

Função: `quadrado`

Código inicial:

```js
function quadrado(n) {
  return n ^ 2;
}
```

Testes:

- entrada [3] → retorna 9
- entrada [5] → retorna 25
- entrada [0] → retorna 0
- entrada [2] → retorna 4

Solução de referência:

```js
function quadrado(n) {
  return n ** 2;
}
```

**Dica:** O sinal ^ não é o operador de potência em JavaScript.

**Solução comentada:** Em JavaScript, ^ é outro operador (bit a bit), por isso 3 ^ 2 dá 1. A potência é escrita com **: n ** 2.

#### 8. Divisões estranhas

*Interpretação de código · difícil · id `arit-divisao-por-zero` · conceitos: Operadores aritméticos (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(10 / 0);
console.log(10 % 0);
console.log(-10 / 0);
console.log(0 / 0);
```

- ✔ **Infinity / NaN / -Infinity / NaN** (correta)
- ✗ Erro / Erro / Erro / Erro — *confusão: acha que toda divisão por zero para o programa com erro*
- ✗ 0 / 0 / 0 / 0 — *confusão: acha que divisões por zero resultam em zero*
- ✗ Infinity / Infinity / -Infinity / 0 — *confusão: acha que o resto por zero e 0 / 0 dão resultados numéricos finitos*

**Dica:** Divisão por zero dá um infinito; o resto por zero e 0 / 0 não têm resultado válido.

**Ao acertar:** 10 / 0 vale Infinity e -10 / 0 vale -Infinity. Já 10 % 0 e 0 / 0 não têm resultado numérico: NaN. Nenhuma delas causa erro.

---

## Lição 3 — Operadores de atribuição

**Foco:** Guardar e atualizar valores com =, +=, -=, ++ e --

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O operador de atribuição = guarda um valor em uma variável. Para atualizar uma variável usando o valor que ela já tem, existem formas abreviadas:
> - x += 5 é o mesmo que x = x + 5;
> - x -= 5, x *= 5, x /= 5, x %= 5 e x **= 2 funcionam do mesmo jeito;
> - x++ aumenta x em 1 e x-- diminui x em 1.
> 
> Cuidados:
> - = guarda um valor; ele não compara. Para comparar usamos ===.
> - Com textos, += junta: se frase vale "Olá", frase += "!" resulta em "Olá!".
> - Só variáveis declaradas com let podem ser atualizadas; uma const dá erro.
> - Escreva += e não =+: x =+ 5 guarda o valor +5 em x, apagando o valor antigo.
> 
> Esses operadores serão muito usados nos contadores e acumuladores das estruturas de repetição.

### Exemplo

```
let pontos = 10;
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
3. Com um texto, += faz a concatenação.
```

### Revisão

- = guarda um valor; += -= *= /= %= atualizam usando o valor atual.
- x++ e x-- somam e subtraem 1.
- Com textos, += junta.
- const não pode ser atualizada.
- Não confunda = (guardar) com === (comparar).

### Exercícios

#### 1. O que faz x += 5?

*Múltipla escolha · fácil · id `atrib-o-que-faz-o-mais-igual` · conceitos: Operadores de atribuição (peso 3)*

O que a instrução x += 5 faz?

- ✗ Guarda o valor 5 em x, substituindo o que havia — *confusão: confunde += com a atribuição simples =*
- ✗ Compara x com 5 — *confusão: confunde atribuição com comparação*
- ✔ **Soma 5 ao valor atual de x e guarda o resultado em x** (correta)
- ✗ Mostra x + 5 sem alterar a variável — *confusão: acha que += só calcula e não guarda o resultado*

**Dica:** x += 5 é uma forma curta de escrever x = x + 5.

**Ao acertar:** O operador += usa o valor atual de x, soma 5 e guarda o resultado de volta em x.

#### 2. Quanto vale n?

*Interpretação de código · fácil · id `atrib-somar-cinco` · conceitos: Operadores de atribuição (peso 3)*

O que o programa abaixo mostra na tela?

```
let n = 10;
n += 5;
console.log(n);
```

- ✗ 5 — *confusão: acha que += substitui o valor em vez de somar*
- ✔ **15** (correta)
- ✗ 10 — *confusão: acha que += não altera a variável*
- ✗ n + 5 — *confusão: acha que o console.log mostra a expressão em vez do valor*

**Dica:** n começa em 10 e depois recebe uma soma.

**Ao acertar:** n += 5 faz n = n + 5, ou seja, 10 + 5 = 15.

#### 3. Some um ao contador

*Completar a lacuna · fácil · id `atrib-complete-o-contador` · conceitos: Operadores de atribuição (peso 2)*

Complete a linha para aumentar o contador em 1.

```
let contador = 0;
contador{{1}};
console.log(contador);
```

Respostas aceitas: lacuna 1: ++ ou += 1

**Dica:** Há uma forma bem curta de somar 1.

**Ao acertar:** contador++ aumenta o valor em 1. A forma contador += 1 faria o mesmo.

#### 4. Atualizações em sequência

*Interpretação de código · médio · id `atrib-varias-atualizacoes` · conceitos: Operadores de atribuição (peso 3)*

O que o programa abaixo mostra na tela?

```
let x = 8;
x -= 3;
x *= 2;
x /= 5;
console.log(x);
```

- ✗ 5 — *confusão: acha que só a primeira atualização altera a variável*
- ✗ 10 — *confusão: esquece da última atualização (a divisão)*
- ✗ 4.4 — *confusão: troca o -= por += na primeira atualização*
- ✔ **2** (correta)

**Dica:** Cada linha usa o valor que x tem naquele momento.

**Ao acertar:** x começa em 8; depois 8 - 3 = 5; depois 5 * 2 = 10; depois 10 / 5 = 2.

#### 5. Forma equivalente

*Múltipla escolha · médio · id `atrib-forma-equivalente` · conceitos: Operadores de atribuição (peso 3)*

Qual linha tem o mesmo efeito de total = total * 3?

- ✔ **total *= 3** (correta)
- ✗ total =* 3 — *confusão: escreve o operador composto com os símbolos invertidos*
- ✗ total * 3 — *confusão: esquece de guardar o resultado na variável*
- ✗ total == 3 — *confusão: confunde atribuição com comparação*

**Dica:** O operador composto começa com o símbolo da conta e termina com o =.

**Ao acertar:** total *= 3 multiplica o valor atual de total por 3 e guarda o resultado em total.

#### 6. Corrija a soma ao total

*Corrigir o erro · médio · id `atrib-corrija-o-total` · conceitos: Operadores de atribuição (peso 3)*

A função `somarAoTotal(n)` deveria somar n ao total inicial 10, mas devolve apenas n. Corrija o defeito.

Função: `somarAoTotal`

Código inicial:

```js
function somarAoTotal(n) {
  let total = 10;
  total =+ n;
  return total;
}
```

Testes:

- entrada [5] → retorna 15
- entrada [0] → retorna 10
- entrada [20] → retorna 30

Solução de referência:

```js
function somarAoTotal(n) {
  let total = 10;
  total += n;
  return total;
}
```

**Dica:** Compare a ordem dos dois símbolos: eles não são o mesmo operador.

**Solução comentada:** total =+ n guarda o valor +n em total, apagando o 10. O operador de soma e atribuição é +=.

#### 7. Aplicar desconto

*Código · médio · id `atrib-aplicar-desconto` · conceitos: Operadores de atribuição (peso 3); Operadores aritméticos (peso 2)*

Escreva a função `aplicarDesconto(preco, percentual)` que devolve o preço depois do desconto percentual (por exemplo, 200 com 10% devolve 180). Use -= na solução.

Função: `aplicarDesconto`

Código inicial:

```js
function aplicarDesconto(preco, percentual) {
  // seu código aqui
}
```

Testes:

- entrada [200,10] → retorna 180
- entrada [50,20] → retorna 40
- entrada [100,0] → retorna 100

Solução de referência:

```js
function aplicarDesconto(preco, percentual) {
  const desconto = preco * percentual / 100;
  preco -= desconto;
  return preco;
}
```

**Dica:** Calcule o valor do desconto e subtraia do preço com -=.

**Solução comentada:** O desconto é preco * percentual / 100. Com preco -= desconto, o preço é atualizado e devolvido.

#### 8. += com texto e com número

*Interpretação de código · difícil · id `atrib-texto-e-numero` · conceitos: Operadores de atribuição (peso 3); Concatenação (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
let texto = "5";
texto += 5;
texto += 5;
console.log(texto);
let numero = 5;
numero += 5;
numero += 5;
console.log(numero);
```

- ✗ 15 / 15 — *confusão: acha que += sempre soma, mesmo com textos*
- ✗ 555 / 555 — *confusão: acha que += sempre junta*
- ✔ **555 / 15** (correta)
- ✗ 55 / 15 — *confusão: aplica o += só uma vez no texto*

**Dica:** Com texto, += junta; com número, += soma.

**Ao acertar:** Com o texto "5", cada += junta mais um 5: "555". Com o número 5, cada += soma: 5 + 5 + 5 = 15.

---

## Lição 4 — Operadores relacionais

**Foco:** Comparar valores e obter true ou false

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Os operadores relacionais comparam dois valores e respondem com true ou false:
> - > maior, < menor, >= maior ou igual, <= menor ou igual;
> - === igual (mesmo valor e mesmo tipo) e !== diferente.
> 
> O erro mais comum: = guarda um valor, e === compara. Escrever idade = 18 onde se queria comparar muda a variável em vez de comparar.
> 
> Existe também o == (igual "frouxo"), que converte os tipos antes de comparar: 5 == "5" é true. Isso causa surpresas, então use sempre === e !==.
> 
> Textos também são comparados, seguindo a ordem das letras: "a" < "b" é true. As letras maiúsculas vêm antes das minúsculas, e textos de números não são comparados como números: "10" < "9" é true, porque o "1" vem antes do "9". Por fim, números decimais podem ter pequenas diferenças: 0.1 + 0.2 === 0.3 é false.

### Exemplo

```
console.log(5 > 3);          // true
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
5. Textos são comparados letra por letra, na ordem do alfabeto.
```

### Revisão

- > < >= <= comparam ordem; === e !== comparam igualdade e diferença, com o tipo.
- = guarda um valor; === compara.
- Prefira === e !== ao == e !=, que convertem tipos.
- Textos são comparados pela ordem das letras; "10" < "9" é true.
- Decimais podem ter pequenas diferenças: 0.1 + 0.2 === 0.3 é false.

### Exercícios

#### 1. Qual operador compara a igualdade?

*Múltipla escolha · fácil · id `rel-operador-de-igualdade` · conceitos: Operadores relacionais (peso 3)*

Qual operador verifica se dois valores são iguais e do mesmo tipo?

- ✗ = — *confusão: confunde comparação com atribuição*
- ✔ **===** (correta)
- ✗ == — *confusão: acha que o == também confere o tipo dos valores*
- ✗ !== — *confusão: confunde igualdade com diferença*

**Dica:** Tem três sinais de igual.

**Ao acertar:** === compara valor e tipo. O = guarda um valor, e o == converte os tipos antes de comparar.

#### 2. 7 >= 7

*Interpretação de código · fácil · id `rel-maior-ou-igual` · conceitos: Operadores relacionais (peso 3)*

O que o programa abaixo mostra na tela?

```
console.log(7 >= 7);
```

- ✗ false — *confusão: acha que >= exige que o primeiro valor seja estritamente maior*
- ✗ 7 — *confusão: mostra o valor em vez do resultado da comparação*
- ✗ 14 — *confusão: acha que o sinal >= faz uma soma*
- ✔ **true** (correta)

**Dica:** >= significa "maior ou igual".

**Ao acertar:** 7 é igual a 7, então 7 >= 7 é true.

#### 3. Maior de idade

*Completar a lacuna · fácil · id `rel-complete-a-comparacao` · conceitos: Operadores relacionais (peso 2)*

Complete a comparação para mostrar true se a idade for maior ou igual a 18.

```
const idade = 20;
console.log(idade {{1}} 18);
```

Respostas aceitas: lacuna 1: >=

**Dica:** O operador começa com o sinal de maior.

**Ao acertar:** idade >= 18 pergunta se a idade é maior ou igual a 18. Com 20, a resposta é true.

#### 4. === e ==

*Interpretação de código · médio · id `rel-igual-estrito-e-frouxo` · conceitos: Operadores relacionais (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(5 === "5");
console.log(5 == "5");
console.log(5 !== "5");
```

- ✔ **false / true / true** (correta)
- ✗ true / true / false — *confusão: acha que === ignora a diferença de tipo*
- ✗ false / false / true — *confusão: acha que == também diferencia os tipos*
- ✗ true / true / true — *confusão: acha que todas as comparações entre 5 e "5" são verdadeiras*

**Dica:** 5 é um número e "5" é um texto.

**Ao acertar:** === não aceita tipos diferentes (false). == converte o texto em número (true). !== diz que são diferentes (true).

#### 5. Qual linha compara de verdade?

*Múltipla escolha · médio · id `rel-qual-linha-compara` · conceitos: Operadores relacionais (peso 3); Operadores de atribuição (peso 1)*

Qual linha compara se idade é igual a 18, sem alterar a variável?

- ✗ idade = 18 — *confusão: usa = (atribuição) no lugar de uma comparação*
- ✗ idade := 18 — *confusão: usa um operador de outra linguagem*
- ✔ **idade === 18** (correta)
- ✗ 18 => idade — *confusão: troca o operador de comparação por outro símbolo*

**Dica:** Uma comparação não pode guardar nada na variável.

**Ao acertar:** idade === 18 compara e resulta em true ou false. idade = 18 guardaria o valor 18 na variável.

#### 6. Pode votar?

*Código · médio · id `rel-pode-votar` · conceitos: Operadores relacionais (peso 3)*

Escreva a função `podeVotar(idade)` que devolve true se a idade for 16 ou mais, e false caso contrário.

Função: `podeVotar`

Código inicial:

```js
function podeVotar(idade) {
  // seu código aqui
}
```

Testes:

- entrada [15] → retorna false
- entrada [16] → retorna true
- entrada [17] → retorna true
- entrada [70] → retorna true
- entrada [0] → retorna false

Solução de referência:

```js
function podeVotar(idade) {
  return idade >= 16;
}
```

**Dica:** Uma comparação já resulta em true ou false.

**Solução comentada:** idade >= 16 resulta em true ou false, que é exatamente o que a função deve devolver.

#### 7. Corrija a igualdade

*Corrigir o erro · médio · id `rel-corrija-a-igualdade` · conceitos: Operadores relacionais (peso 3)*

A função `saoIguais(a, b)` deveria dizer se dois valores são iguais e do mesmo tipo, mas diz true para 5 e "5". Corrija o defeito.

Função: `saoIguais`

Código inicial:

```js
function saoIguais(a, b) {
  return a == b;
}
```

Testes:

- entrada [5,5] → retorna true
- entrada [5,"5"] → retorna false
- entrada ["a","a"] → retorna true
- entrada [0,false] → retorna false

Solução de referência:

```js
function saoIguais(a, b) {
  return a === b;
}
```

**Dica:** Qual operador também confere o tipo dos valores?

**Solução comentada:** O == converte os tipos antes de comparar (5 == "5" e 0 == false são true). O === exige o mesmo tipo.

#### 8. Ordem dos textos

*Interpretação de código · difícil · id `rel-comparando-textos` · conceitos: Operadores relacionais (peso 3); Tipo String (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log("a" < "b");
console.log("banana" < "abacaxi");
console.log("Z" < "a");
```

- ✗ true / false / false — *confusão: acha que as letras maiúsculas vêm depois das minúsculas*
- ✔ **true / false / true** (correta)
- ✗ true / true / true — *confusão: ignora a ordem alfabética, comparando outra coisa, como o tamanho*
- ✗ false / true / true — *confusão: inverte a ordem alfabética*

**Dica:** Textos são comparados letra por letra; as maiúsculas vêm antes das minúsculas.

**Ao acertar:** "a" vem antes de "b" (true). "banana" começa com b, que vem depois de a (false). "Z" maiúsculo vem antes de "a" minúsculo (true).

#### 9. Cuidados na comparação

*Interpretação de código · difícil · id `rel-textos-de-numeros-e-decimais` · conceitos: Operadores relacionais (peso 3); Conversão de tipos (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(10 < 9);
console.log("10" < "9");
console.log(0.1 + 0.2 === 0.3);
```

- ✗ false / false / true — *confusão: acha que comparar textos funciona como comparar números e que 0.1 + 0.2 é exatamente 0.3*
- ✗ false / false / false — *confusão: compara "10" e "9" como números*
- ✗ true / true / false — *confusão: acha que 10 é menor que 9*
- ✔ **false / true / false** (correta)

**Dica:** Textos são comparados letra por letra; e o computador guarda decimais de forma aproximada.

**Ao acertar:** 10 < 9 é false (números). Já "10" < "9" compara textos: o "1" vem antes do "9", então é true. E 0.1 + 0.2 vale 0.30000000000000004, diferente de 0.3: false.

---

## Lição 5 — Operadores lógicos

**Foco:** Combinar valores true e false com &&, || e !

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Os operadores lógicos combinam valores booleanos:
> - && (E): true somente se os dois lados são true.
> - || (OU): true se pelo menos um dos lados é true.
> - ! (NÃO): inverte o valor: !true é false e !false é true.
> 
> Tabela-verdade (V = true, F = false):
>   A  B  | A && B | A || B
>   V  V  |   V    |   V
>   V  F  |   F    |   V
>   F  V  |   F    |   V
>   F  F  |   F    |   F
> 
> Na prática, combinamos comparações: idade >= 18 && temIngresso. Para saber se x está entre 1 e 10, escreva x >= 1 && x <= 10; a forma matemática 1 <= x <= 10 não funciona. Quando misturamos operadores, o ! é resolvido primeiro, depois o && e por último o ||; use parênteses para deixar a intenção clara.

### Exemplo

```
const idade = 20;
const temIngresso = true;
console.log(idade >= 18 && temIngresso);   // true
console.log(idade < 18 || temIngresso);    // true
console.log(!temIngresso);                 // false
console.log(idade >= 18 && !temIngresso);  // false

Passo a passo:
1. idade >= 18 é true e temIngresso é true: o && dá true.
2. idade < 18 é false, mas temIngresso é true: basta um true para o || dar true.
3. !temIngresso inverte true em false.
4. idade >= 18 é true, mas !temIngresso é false: o && dá false.
```

### Revisão

- && é E: precisa dos dois lados true. || é OU: basta um lado true. ! inverte.
- Combine comparações: idade >= 18 && temIngresso.
- "Entre 1 e 10" é x >= 1 && x <= 10 (não 1 <= x <= 10).
- Ordem: ! primeiro, depois &&, por último ||; parênteses deixam claro.
- Use a tabela-verdade para conferir o resultado.

### Exercícios

#### 1. Qual operador é o E?

*Múltipla escolha · fácil · id `log-qual-e-o-e` · conceitos: Operadores lógicos (peso 3)*

Qual operador lógico significa E (os dois lados precisam ser verdadeiros)?

- ✔ **&&** (correta)
- ✗ || — *confusão: confunde o operador E com o operador OU*
- ✗ ! — *confusão: confunde o operador E com o operador NÃO*
- ✗ & — *confusão: usa um único &, que é outro operador*

**Dica:** São dois símbolos iguais, que lembram o "e" comercial.

**Ao acertar:** && é o operador E: só resulta em true se os dois lados forem true.

#### 2. O que o || significa?

*Múltipla escolha · fácil · id `log-o-que-e-o-ou` · conceitos: Operadores lógicos (peso 3)*

O que o operador || faz?

- ✗ Resulta em true só se os dois lados forem true — *confusão: confunde o operador OU com o operador E*
- ✗ Inverte o valor de um boolean — *confusão: confunde o operador OU com o operador NÃO*
- ✔ **Resulta em true se pelo menos um dos lados for true** (correta)
- ✗ Compara se dois valores são iguais — *confusão: confunde um operador lógico com um relacional*

**Dica:** Pense na frase "tenho cartão OU dinheiro".

**Ao acertar:** O || é o OU: basta que um dos lados seja true para o resultado ser true.

#### 3. true && false

*Interpretação de código · fácil · id `log-true-e-false` · conceitos: Operadores lógicos (peso 3)*

O que o programa abaixo mostra na tela?

```
console.log(true && false);
```

- ✗ true — *confusão: acha que o && precisa de apenas um lado verdadeiro, como o ||*
- ✔ **false** (correta)
- ✗ true && false — *confusão: acha que o console.log mostra a expressão*
- ✗ undefined — *confusão: acha que combinar valores diferentes não tem resultado*

**Dica:** O E só dá true quando os dois lados são true.

**Ao acertar:** Como um dos lados é false, o && resulta em false.

#### 4. Cartão ou dinheiro

*Completar a lacuna · fácil · id `log-complete-o-ou` · conceitos: Operadores lógicos (peso 2)*

Complete a linha para mostrar true se o cliente tiver cartão OU dinheiro.

```
const temCartao = false;
const temDinheiro = true;
console.log(temCartao {{1}} temDinheiro);
```

Respostas aceitas: lacuna 1: ||

**Dica:** Use o operador que aceita que apenas um dos lados seja verdadeiro.

**Ao acertar:** temCartao || temDinheiro resulta em true, porque temDinheiro é true.

#### 5. Quatro combinações

*Interpretação de código · médio · id `log-quatro-combinacoes` · conceitos: Operadores lógicos (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(true || false);
console.log(false || false);
console.log(!true);
console.log(!false && true);
```

- ✗ true / true / true / true — *confusão: acha que o || sempre resulta em true*
- ✗ true / false / true / false — *confusão: ignora a inversão feita pelo !*
- ✗ false / false / false / true — *confusão: acha que o || precisa dos dois lados verdadeiros*
- ✔ **true / false / false / true** (correta)

**Dica:** Use a tabela-verdade e lembre que ! inverte o valor.

**Ao acertar:** true || false é true; false || false é false; !true é false; e !false vale true, então true && true é true.

#### 6. Pode entrar?

*Código · médio · id `log-pode-entrar` · conceitos: Operadores lógicos (peso 3); Operadores relacionais (peso 2)*

Escreva a função `podeEntrar(idade, temIngresso)` que devolve true apenas se a pessoa tiver 18 anos ou mais E tiver ingresso.

Função: `podeEntrar`

Código inicial:

```js
function podeEntrar(idade, temIngresso) {
  // seu código aqui
}
```

Testes:

- entrada [20,true] → retorna true
- entrada [17,true] → retorna false
- entrada [30,false] → retorna false
- entrada [18,true] → retorna true
- entrada [5,false] → retorna false

Solução de referência:

```js
function podeEntrar(idade, temIngresso) {
  return idade >= 18 && temIngresso;
}
```

**Dica:** Combine uma comparação com o valor temIngresso usando o operador E.

**Solução comentada:** idade >= 18 && temIngresso só é true quando a comparação e temIngresso forem verdadeiros ao mesmo tempo.

#### 7. Autorização

*Interpretação de código · médio · id `log-comparacoes-combinadas` · conceitos: Operadores lógicos (peso 3); Operadores relacionais (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
const idade = 16;
const temAutorizacao = true;
console.log(idade >= 18 && temAutorizacao);
console.log(idade >= 18 || temAutorizacao);
console.log(!(idade >= 18));
```

- ✔ **false / true / true** (correta)
- ✗ true / true / false — *confusão: avalia idade >= 18 como se fosse verdadeiro*
- ✗ false / false / true — *confusão: acha que o || exige que os dois lados sejam true*
- ✗ false / true / false — *confusão: esquece de inverter o resultado com o !*

**Dica:** idade >= 18 é false para 16. Aplique cada operador a partir desse resultado.

**Ao acertar:** idade >= 18 é false. false && true é false; false || true é true; e !(false) é true.

#### 8. Entre 1 e 10

*Múltipla escolha · médio · id `log-entre-dois-valores` · conceitos: Operadores lógicos (peso 3); Operadores relacionais (peso 2)*

Qual expressão é true quando x está entre 1 e 10 (inclusive)?

- ✗ x >= 1 || x <= 10 — *confusão: usa OU, que fica verdadeiro para qualquer número*
- ✗ 1 <= x <= 10 — *confusão: escreve como na matemática, mas o JavaScript avalia de outra forma*
- ✔ **x >= 1 && x <= 10** (correta)
- ✗ x === 1 && x === 10 — *confusão: exige que x seja igual aos dois valores ao mesmo tempo*

**Dica:** x precisa passar nas duas condições ao mesmo tempo.

**Ao acertar:** As duas comparações precisam ser verdadeiras: x >= 1 e x <= 10. Por isso usamos o &&.

#### 9. Corrija o intervalo

*Corrigir o erro · difícil · id `log-corrija-o-intervalo` · conceitos: Operadores lógicos (peso 3); Operadores relacionais (peso 2)*

A função `foraDoIntervalo(n)` deveria devolver true quando n é menor que 0 ou maior que 100, mas devolve sempre false. Corrija o defeito.

Função: `foraDoIntervalo`

Código inicial:

```js
function foraDoIntervalo(n) {
  return n < 0 && n > 100;
}
```

Testes:

- entrada [-5] → retorna true
- entrada [150] → retorna true
- entrada [50] → retorna false
- entrada [0] → retorna false
- entrada [100] → retorna false

Solução de referência:

```js
function foraDoIntervalo(n) {
  return n < 0 || n > 100;
}
```

**Dica:** Nenhum número é menor que 0 e maior que 100 ao mesmo tempo.

**Solução comentada:** Com &&, as duas condições precisam valer juntas, o que nunca acontece. Com ||, basta que uma delas seja verdadeira.

#### 10. Quem vem primeiro?

*Interpretação de código · difícil · id `log-precedencia-dos-logicos` · conceitos: Operadores lógicos (peso 3); Precedência dos operadores (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
const a = true;
const b = false;
const c = false;
console.log(a || b && c);
console.log((a || b) && c);
console.log(!a || b);
console.log(!(a || b));
```

- ✗ false / false / false / false — *confusão: resolve o || antes do && na primeira linha, ignorando a precedência*
- ✔ **true / false / false / false** (correta)
- ✗ true / true / false / false — *confusão: ignora o efeito dos parênteses na segunda linha*
- ✗ true / false / true / true — *confusão: ignora o efeito do ! nas duas últimas linhas*

**Dica:** O && é resolvido antes do ||, e os parênteses mudam essa ordem.

**Ao acertar:** Linha 1: b && c é false, então a || false é true. Linha 2: (a || b) é true, e true && c é false. Linha 3: !a é false, e false || b é false. Linha 4: (a || b) é true e o ! inverte para false.

---

## Lição 6 — Precedência dos operadores

**Foco:** Saber em que ordem o computador resolve uma expressão

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Quando uma expressão tem vários operadores, o computador segue uma ordem, chamada precedência (da mais alta para a mais baixa):
> 1. parênteses ( );
> 2. potência **;
> 3. ! (NÃO);
> 4. * / %;
> 5. + e -;
> 6. < <= > >=;
> 7. === !== (e == !=);
> 8. &&;
> 9. ||;
> 10. atribuições (=, +=, ...), por último.
> 
> Operadores do mesmo nível são resolvidos da esquerda para a direita (10 - 4 - 3 vale 3), exceto a potência, que vai da direita para a esquerda (2 ** 3 ** 2 vale 512).
> 
> Por isso 2 + 3 * 4 vale 14. Para mudar a ordem, use parênteses: (2 + 3) * 4 vale 20. Mesmo quando a ordem natural já resolve, os parênteses deixam o código mais fácil de ler.

### Exemplo

```
console.log(2 + 3 * 4);               // 14
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
6. false && false é false, e true || false é true.
```

### Revisão

- Ordem: parênteses, **, !, * / %, + -, comparações, ===, &&, ||, atribuição.
- Operadores do mesmo nível: da esquerda para a direita (a potência é da direita para a esquerda).
- Parênteses mudam a ordem e deixam o código mais claro.
- Aritméticos vêm antes das comparações, e as comparações antes de && e ||.

### Exercícios

#### 1. O que vem primeiro?

*Múltipla escolha · fácil · id `prec-o-que-vem-primeiro` · conceitos: Precedência dos operadores (peso 3)*

Em 2 + 3 * 4, qual operação é feita primeiro?

- ✗ 2 + 3 — *confusão: faz as operações da esquerda para a direita, ignorando a precedência*
- ✗ Todas ao mesmo tempo — *confusão: acha que o computador resolve tudo simultaneamente*
- ✗ A última da direita, sempre — *confusão: acha que a operação mais à direita é sempre a primeira*
- ✔ **3 * 4** (correta)

**Dica:** Como na matemática, uma das operações tem prioridade.

**Ao acertar:** A multiplicação tem precedência sobre a soma, então 3 * 4 é feito primeiro.

#### 2. Quanto vale 2 + 3 * 4?

*Interpretação de código · fácil · id `prec-dois-mais-tres-vezes-quatro` · conceitos: Precedência dos operadores (peso 3)*

O que o programa abaixo mostra na tela?

```
console.log(2 + 3 * 4);
```

- ✔ **14** (correta)
- ✗ 20 — *confusão: faz as operações da esquerda para a direita, ignorando a precedência*
- ✗ 9 — *confusão: soma todos os números*
- ✗ 234 — *confusão: junta os números como se fossem textos*

**Dica:** Primeiro a multiplicação, depois a soma.

**Ao acertar:** 3 * 4 = 12 e depois 2 + 12 = 14.

#### 3. Mude a ordem

*Completar a lacuna · fácil · id `prec-complete-os-parenteses` · conceitos: Precedência dos operadores (peso 2)*

Complete com parênteses para que o programa mostre 20 (a soma deve ser feita antes da multiplicação).

```
console.log({{1}}2 + 3{{2}} * 4);
```

Respostas aceitas: lacuna 1: (; lacuna 2: )

**Dica:** Os parênteses forçam uma conta a ser feita antes das outras.

**Ao acertar:** (2 + 3) * 4 faz primeiro a soma (5) e depois a multiplicação: 20.

#### 4. Esquerda para a direita

*Interpretação de código · médio · id `prec-esquerda-direita` · conceitos: Precedência dos operadores (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(10 - 4 - 3);
console.log(100 / 10 / 2);
console.log(2 ** 3 ** 2);
```

- ✗ 9 / 20 / 512 — *confusão: resolve subtração e divisão da direita para a esquerda*
- ✗ 3 / 5 / 64 — *confusão: acha que a potência também vai da esquerda para a direita*
- ✔ **3 / 5 / 512** (correta)
- ✗ 3 / 20 / 64 — *confusão: mistura a ordem das operações em cada linha*

**Dica:** A maioria dos operadores vai da esquerda para a direita; a potência é a exceção.

**Ao acertar:** 10 - 4 - 3 = 6 - 3 = 3; 100 / 10 / 2 = 10 / 2 = 5; e 2 ** 3 ** 2 = 2 ** 9 = 512 (a potência vai da direita para a esquerda).

#### 5. Contas antes das comparações

*Interpretação de código · difícil · id `prec-contas-e-comparacoes` · conceitos: Precedência dos operadores (peso 3); Operadores relacionais (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(5 + 3 > 7);
console.log(2 * 3 === 6);
console.log(10 - 2 * 3 > 5);
```

- ✗ true / true / true — *confusão: faz as contas da esquerda para a direita, antes de multiplicar*
- ✔ **true / true / false** (correta)
- ✗ true / false / false — *confusão: acha que 2 * 3 não é igual a 6*
- ✗ false / true / false — *confusão: avalia 5 + 3 > 7 como falso*

**Dica:** As contas são resolvidas antes das comparações, e a multiplicação antes da subtração.

**Ao acertar:** 5 + 3 > 7 vira 8 > 7 (true). 2 * 3 === 6 vira 6 === 6 (true). 10 - 2 * 3 > 5 vira 10 - 6 > 5, isto é 4 > 5 (false).

#### 6. Qual expressão dá 24?

*Múltipla escolha · médio · id `prec-qual-expressao-da-24` · conceitos: Precedência dos operadores (peso 3)*

Qual destas expressões tem como resultado 24?

- ✗ 2 + 4 * 4 — *confusão: ignora a precedência: a multiplicação vem antes da soma (resultado 18)*
- ✗ 2 * 4 + 4 — *confusão: multiplica primeiro e soma depois (resultado 12)*
- ✗ 2 + 4 + 4 — *confusão: soma tudo, em vez de multiplicar (resultado 10)*
- ✔ **(2 + 4) * 4** (correta)

**Dica:** Para a soma vir antes da multiplicação, é preciso parênteses.

**Ao acertar:** (2 + 4) * 4 = 6 * 4 = 24. Sem parênteses, 2 + 4 * 4 daria 18.

#### 7. Celsius para Fahrenheit

*Código · médio · id `prec-celsius-para-fahrenheit` · conceitos: Precedência dos operadores (peso 3); Operadores aritméticos (peso 2)*

Escreva a função `fahrenheit(c)` que converte graus Celsius em Fahrenheit: multiplique por 9, divida por 5 e some 32.

Função: `fahrenheit`

Código inicial:

```js
function fahrenheit(c) {
  // seu código aqui
}
```

Testes:

- entrada [0] → retorna 32
- entrada [100] → retorna 212
- entrada [10] → retorna 50
- entrada [-40] → retorna -40

Solução de referência:

```js
function fahrenheit(c) {
  return c * 9 / 5 + 32;
}
```

**Dica:** A multiplicação e a divisão vêm antes da soma, e parênteses só são necessários se você quiser mudar essa ordem.

**Solução comentada:** c * 9 / 5 + 32 faz a multiplicação e a divisão (da esquerda para a direita) antes de somar 32.

#### 8. Corrija a média

*Corrigir o erro · médio · id `prec-corrija-a-media` · conceitos: Precedência dos operadores (peso 3); Operadores aritméticos (peso 2)*

A função `media(a, b)` deveria devolver a média aritmética de dois números, mas devolve valores errados (por exemplo, 7 para 4 e 6). Corrija o defeito.

Função: `media`

Código inicial:

```js
function media(a, b) {
  return a + b / 2;
}
```

Testes:

- entrada [4,6] → retorna 5
- entrada [10,10] → retorna 10
- entrada [0,8] → retorna 4

Solução de referência:

```js
function media(a, b) {
  return (a + b) / 2;
}
```

**Dica:** A divisão é feita antes da soma. O que precisa ser dividido por 2?

**Solução comentada:** Sem parênteses, só o b é dividido por 2. A média é (a + b) / 2.

#### 9. Parênteses e lógica

*Interpretação de código · difícil · id `prec-logicos-e-parenteses` · conceitos: Precedência dos operadores (peso 3); Operadores lógicos (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
const a = 2;
const b = 10;
console.log(a > 3 && b < 5 || a === 2);
console.log(a > 3 && (b < 5 || a === 2));
console.log(!(a > 3) || b === 10 && a < 1);
```

- ✔ **true / false / true** (correta)
- ✗ false / false / true — *confusão: resolve o || antes do && na primeira linha*
- ✗ true / true / true — *confusão: ignora o efeito dos parênteses na segunda linha*
- ✗ true / false / false — *confusão: aplica o ! a toda a expressão da terceira linha, e não só ao que está entre parênteses*

**Dica:** O && vem antes do ||, e os parênteses mudam o agrupamento.

**Ao acertar:** Linha 1: (false && false) || true é true. Linha 2: false && (...) é false. Linha 3: !(false) é true, e true || (...) é true.

---

## Lição 7 — Desafio final do Mundo 3

**Foco:** Juntar os operadores em uma calculadora simples

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Chegou o desafio do Mundo 3: uma calculadora simples. Você vai usar operadores aritméticos, relacionais e lógicos, e vai cuidar dos casos especiais, como a divisão por zero.
> 
> O desafio principal é o primeiro exercício: um programa que lê dois números e mostra o resultado das principais operações, avisando quando a divisão for por zero. No Mundo 4 você vai aprender a tomar decisões (if/else) e poderá impedir a conta; por enquanto, o programa avisa usando uma comparação.
> 
> Os outros dois exercícios treinam a precedência e o acompanhamento de valores.

### Exemplo

```
Como montar uma calculadora:
1. Leia os dois números com lerEntrada() e converta cada um com Number().
2. Calcule cada operação: soma, subtração, multiplicação, divisão, resto.
3. Mostre cada resultado com um rótulo, em uma linha de console.log.
4. Para avisar sobre a divisão por zero, compare o divisor com 0 usando ===: o resultado é true ou false.
5. Teste com casos simples e com o caso especial (divisor igual a 0): o programa não pode "quebrar".
```

### Revisão

- Aritméticos fazem as contas; relacionais e lógicos respondem com true ou false.
- Atribuição guarda e atualiza valores (=, +=, ++...).
- A precedência define a ordem; parênteses deixam a intenção clara.
- Divisão por zero dá Infinity e o resto por zero dá NaN: vale testar o divisor antes.
- Em toda comparação, use === (e não =).

### Exercícios

#### 1. Desafio: calculadora simples

*Desafio · difícil · id `desafio3-calculadora` · conceitos: Operadores aritméticos (peso 2); Operadores relacionais (peso 2); Precedência dos operadores (peso 1); Entrada e saída de informações (peso 1); Conversão de tipos (peso 1)*

Escreva a função `calculadora()`: leia dois números com `lerEntrada()` (chegam como texto) e mostre seis linhas com `console.log`: Soma, Subtração, Multiplicação, Divisão, Resto e Divisão por zero? (true ou false, comparando o segundo número com 0). Use o formato `Rótulo: valor`.

Função: `calculadora`

Código inicial:

```js
function calculadora() {
  // leia os dois números e mostre as seis linhas
}
```

Testes:

- entrada [], lê ["12","4"] → imprime ["Soma: 16","Subtração: 8","Multiplicação: 48","Divisão: 3","Resto: 0","Divisão por zero? false"]
- entrada [], lê ["7","2"] → imprime ["Soma: 9","Subtração: 5","Multiplicação: 14","Divisão: 3.5","Resto: 1","Divisão por zero? false"]
- entrada [], lê ["10","0"] → imprime ["Soma: 10","Subtração: 10","Multiplicação: 0","Divisão: Infinity","Resto: NaN","Divisão por zero? true"]

Solução de referência:

```js
function calculadora() {
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  console.log("Soma:", a + b);
  console.log("Subtração:", a - b);
  console.log("Multiplicação:", a * b);
  console.log("Divisão:", a / b);
  console.log("Resto:", a % b);
  console.log("Divisão por zero?", b === 0);
}
```

**Dica:** Converta as duas entradas com Number() e use o segundo número em uma comparação com ===.

**Solução comentada:** O programa converte as entradas, calcula cada operação e mostra o resultado. Com divisor 0 a divisão dá Infinity e o resto dá NaN, e a comparação b === 0 avisa o problema.

#### 2. Desafio: corrija a aprovação

*Corrigir o erro · difícil · id `desafio3-corrija-a-aprovacao` · conceitos: Precedência dos operadores (peso 3); Operadores lógicos (peso 2); Operadores relacionais (peso 1)*

A função `aprovado(n1, n2, frequencia)` deveria devolver true se a média das duas notas for 7 ou mais E a frequência for 75 ou mais. Hoje ela aprova alunos que não deveriam ser aprovados. Corrija o defeito.

Função: `aprovado`

Código inicial:

```js
function aprovado(n1, n2, frequencia) {
  const media = n1 + n2 / 2;
  return media >= 7 && frequencia >= 75;
}
```

Testes:

- entrada [6,8,80] → retorna true
- entrada [6,8,70] → retorna false
- entrada [5,5,90] → retorna false
- entrada [10,4,75] → retorna true
- entrada [8,8,60] → retorna false

Solução de referência:

```js
function aprovado(n1, n2, frequencia) {
  const media = (n1 + n2) / 2;
  return media >= 7 && frequencia >= 75;
}
```

**Dica:** Olhe com atenção para o cálculo da média: o que a divisão afeta?

**Solução comentada:** Sem parênteses, só n2 era dividido por 2. A média correta é (n1 + n2) / 2, e o restante da função, com &&, já estava certo.

#### 3. Desafio: acompanhe o saldo

*Interpretação de código · difícil · id `desafio3-acompanhe-o-saldo` · conceitos: Operadores de atribuição (peso 2); Operadores relacionais (peso 2); Operadores lógicos (peso 2); Operadores aritméticos (peso 1)*

Acompanhe o valor de cada variável a cada linha. O que o programa abaixo mostra na tela, em ordem?

```
let saldo = 100;
const preco = 60;
saldo -= preco;
const podeComprarOutro = saldo >= preco;
saldo += 10 * 2;
console.log(saldo);
console.log(podeComprarOutro);
console.log(saldo >= preco && saldo % 2 === 0 || saldo === 0);
```

- ✗ 60 / true / true — *confusão: acha que podeComprarOutro acompanha o saldo e é recalculado*
- ✗ 40 / false / true — *confusão: esquece a atualização feita com += depois da comparação*
- ✔ **60 / false / true** (correta)
- ✗ 60 / false / false — *confusão: acha que >= exige que o primeiro valor seja estritamente maior*

**Dica:** podeComprarOutro guarda o resultado da comparação feita naquele momento, e não é atualizado depois.

**Ao acertar:** saldo vira 40 e podeComprarOutro é 40 >= 60, isto é, false (guardado nesse momento). Depois saldo += 20 deixa o saldo em 60. Na última linha: 60 >= 60 é true e 60 % 2 === 0 também, então o resultado é true.

