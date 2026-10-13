# Gabarito dos exercícios extras (migration 0006)

Todos os 31 exercícios entram como **rascunho**. Revise o enunciado, publique os que quiser e altere o que for preciso em **Professor → Exercícios**.

- **Múltipla escolha e lacunas:** abra o exercício (Editar) e clique em *Salvar e publicar*. O gabarito já está cadastrado.
- **Código:** abra o exercício, cole a solução de referência abaixo no campo *Solução de referência*, clique em *Validar testes* e depois em *Salvar e publicar*.

> Este arquivo contém respostas. Não o compartilhe com os alunos.

## Primeiros passos

### Qual é o tipo do valor? — Múltipla escolha, Fácil

`tipos-de-dados`

> Em JavaScript, qual é o tipo do valor "42" (escrito entre aspas)?

-  Número
- **✓** Texto (string)
-  Lógico (boolean)
-  Vetor

Explicação ao acertar: As aspas fazem de "42" um texto. Sem aspas, 42 seria um número.

### Quem calcula primeiro? — Múltipla escolha, Fácil

`precedencia-operadores`

> Qual é o resultado de 2 + 3 * 4?

-  20
- **✓** 14
-  24
-  10

Explicação ao acertar: A multiplicação vem primeiro: 3 * 4 = 12, e depois 2 + 12 = 14. Com parênteses, (2 + 3) * 4 daria 20.

### Resto da divisão — Múltipla escolha, Fácil

`resto-da-divisao`

> Quanto vale 17 % 5?

-  3
- **✓** 2
-  12
-  3,4

Explicação ao acertar: 17 = 3 * 5 + 2, então o resto é 2.

## Fundamentos

### Quadrado de um número — Código, Fácil

`quadrado`

> Escreva `quadrado(n)` que retorna n multiplicado por ele mesmo.

Função: `quadrado(n)`. Testes: `quadrado(2)` → `4`; `quadrado(0)` → `0`; `quadrado(-3)` → `9`; `quadrado(1.5)` → `2.25`.

Solução de referência:

```js
function quadrado(n) { return n * n; }
```

### Média ponderada — Código, Médio

`media-ponderada`

> Escreva `mediaPonderada(a, b)` que calcula a média em que a nota `a` tem peso 3 e a nota `b` tem peso 7 (some os pesos: 3 + 7 = 10).

Função: `mediaPonderada(a, b)`. Testes: `mediaPonderada(10, 10)` → `10`; `mediaPonderada(0, 10)` → `7`; `mediaPonderada(10, 0)` → `3`; `mediaPonderada(5, 5)` → `5`; `mediaPonderada(6, 8)` → `7.4`; `mediaPonderada(9, 4)` → `5.5`.

Solução de referência:

```js
function mediaPonderada(a, b) { return (a * 3 + b * 7) / 10; }
```

### Complete o cálculo da média — Completar a lacuna, Fácil

`completar-media`

> Complete as lacunas para que a função retorne a média de dois números.

```js
function media(a, b) {
  return (a {{1}} b) {{2}} 2;
}
```

Respostas aceitas: lacuna 1: `+`; lacuna 2: `/`.

Explicação ao acertar: Primeiro somamos os dois valores e depois dividimos a soma por 2.

## Condicionais

### E, OU e NÃO — Múltipla escolha, Fácil

`operadores-logicos`

> Se idade = 20 e temCarteira = false, quanto vale a expressão (idade >= 18 && temCarteira)?

-  true
- **✓** false
-  20
-  dá erro

Explicação ao acertar: idade >= 18 é true, mas temCarteira é false. Com &&, as duas precisam ser verdadeiras, então o resultado é false.

### Complete a classificação — Completar a lacuna, Médio

`completar-else-if`

> Complete as lacunas para classificar a nota em A (9 ou mais), B (7 ou mais) ou C (as demais).

```js
function conceito(nota) {
  if (nota >= 9) {
    return "A";
  } {{1}} (nota >= 7) {
    return "B";
  } {{2}} {
    return "C";
  }
}
```

Respostas aceitas: lacuna 1: `else if`; lacuna 2: `else`.

Explicação ao acertar: Depois do primeiro "if", usamos "else if" para a segunda condição e "else" para o que sobrou.

### Dentro do intervalo — Código, Fácil

`dentro-do-intervalo`

> Escreva `dentroDoIntervalo(n, min, max)` que retorna true se n está entre min e max (incluindo os extremos) e false caso contrário.

Função: `dentroDoIntervalo(n, min, max)`. Testes: `dentroDoIntervalo(5, 1, 10)` → `true`; `dentroDoIntervalo(1, 1, 10)` → `true`; `dentroDoIntervalo(10, 1, 10)` → `true`; `dentroDoIntervalo(0, 1, 10)` → `false`; `dentroDoIntervalo(11, 1, 10)` → `false`.

Solução de referência:

```js
function dentroDoIntervalo(n, min, max) { return n >= min && n <= max; }
```

### Tipo de triângulo — Código, Médio

`tipo-de-triangulo`

> Escreva `tipoTriangulo(a, b, c)` que recebe os três lados e retorna "equilatero" (três lados iguais), "isosceles" (exatamente dois iguais) ou "escaleno" (todos diferentes).

Função: `tipoTriangulo(a, b, c)`. Testes: `tipoTriangulo(3, 3, 3)` → `"equilatero"`; `tipoTriangulo(3, 3, 4)` → `"isosceles"`; `tipoTriangulo(3, 4, 3)` → `"isosceles"`; `tipoTriangulo(4, 3, 3)` → `"isosceles"`; `tipoTriangulo(3, 4, 5)` → `"escaleno"`.

Solução de referência:

```js
function tipoTriangulo(a, b, c) { if (a === b && b === c) return 'equilatero'; if (a === b || a === c || b === c) return 'isosceles'; return 'escaleno'; }
```

## Estruturas de repetição

### Quantas vezes o laço executa? — Múltipla escolha, Fácil

`quantas-vezes`

> for (let i = 0; i < 4; i++) {
>   // bloco
> }
> 
> Quantas vezes o bloco executa?

-  3
- **✓** 4
-  5
-  Infinitas vezes

Explicação ao acertar: i vale 0, 1, 2 e 3, ou seja, 4 voltas. Quando i chega a 4, a condição i < 4 deixa de ser verdadeira.

### Complete o while — Completar a lacuna, Médio

`completar-while`

> Complete as lacunas para calcular 5! (5 × 4 × 3 × 2 × 1) em fatorial.

```js
let n = 5;
let fatorial = 1;
{{1}} (n > 1) {
  fatorial = fatorial * n;
  n{{2}};
}
```

Respostas aceitas: lacuna 1: `while`; lacuna 2: `--` ou `-= 1` ou `-=1`.

Explicação ao acertar: O while repete enquanto n > 1, e n-- diminui n em 1 a cada volta, até a condição ficar falsa.

### Soma dos números pares — Código, Médio

`soma-dos-pares`

> Escreva `somaPares(n)` que retorna a soma de todos os números pares de 1 até n (incluindo n, se for par). Para n menor que 2, o resultado é 0.

Função: `somaPares(n)`. Testes: `somaPares(10)` → `30`; `somaPares(1)` → `0`; `somaPares(0)` → `0`; `somaPares(7)` → `12`; `somaPares(2)` → `2`.

Solução de referência:

```js
function somaPares(n) { let s = 0; for (let i = 2; i <= n; i += 2) s += i; return s; }
```

### Potência — Código, Médio

`potencia`

> Escreva `potencia(base, exp)` que retorna base elevada a exp (um inteiro maior ou igual a 0), usando um laço. Não use `Math.pow` nem o operador `**`.

Função: `potencia(base, exp)`. Testes: `potencia(2, 3)` → `8`; `potencia(5, 0)` → `1`; `potencia(3, 1)` → `3`; `potencia(10, 4)` → `10000`; `potencia(0, 5)` → `0`.

Solução de referência:

```js
function potencia(base, exp) { let r = 1; for (let i = 0; i < exp; i++) r *= base; return r; }
```

### Quantos dígitos? — Código, Médio

`conta-digitos`

> Escreva `contaDigitos(n)` que retorna quantos dígitos tem o inteiro n (maior ou igual a 0), sem converter para texto. O número 0 tem 1 dígito.

Função: `contaDigitos(n)`. Testes: `contaDigitos(0)` → `1`; `contaDigitos(7)` → `1`; `contaDigitos(10)` → `2`; `contaDigitos(12345)` → `5`; `contaDigitos(100)` → `3`.

Solução de referência:

```js
function contaDigitos(n) { let c = 1; while (n >= 10) { n = Math.floor(n / 10); c++; } return c; }
```

### Máximo divisor comum — Código, Difícil

`mdc`

> Escreva `mdc(a, b)` que retorna o maior número que divide a e b ao mesmo tempo (a e b inteiros positivos). Dica: o algoritmo de Euclides troca (a, b) por (b, a % b) até o resto ser 0.

Função: `mdc(a, b)`. Testes: `mdc(12, 18)` → `6`; `mdc(7, 13)` → `1`; `mdc(100, 25)` → `25`; `mdc(48, 36)` → `12`; `mdc(17, 17)` → `17`.

Solução de referência:

```js
function mdc(a, b) { while (b !== 0) { const r = a % b; a = b; b = r; } return a; }
```

## Vetores

### O primeiro elemento — Múltipla escolha, Fácil

`indice-do-vetor`

> Em let v = [10, 20, 30, 40], quanto vale v[2]?

-  20
- **✓** 30
-  40
-  10

Explicação ao acertar: Os índices são v[0] = 10, v[1] = 20, v[2] = 30 e v[3] = 40.

### Percorrer o vetor — Completar a lacuna, Fácil

`completar-percorrer`

> Complete as lacunas para somar todos os elementos do vetor v.

```js
let soma = 0;
for (let i = 0; i < v{{1}}; i++) {
  soma += v{{2}};
}
```

Respostas aceitas: lacuna 1: `.length`; lacuna 2: `[i]`.

Explicação ao acertar: O laço vai de 0 até v.length - 1, e a cada volta somamos o elemento da posição i, que é v[i].

### Quantos pares? — Código, Fácil

`conta-pares`

> Escreva `contaPares(v)` que retorna quantos elementos pares existem no vetor de inteiros `v`.

Função: `contaPares(v)`. Testes: `contaPares([1,2,3,4])` → `2`; `contaPares([])` → `0`; `contaPares([1,3,5])` → `0`; `contaPares([2,4,6,8])` → `4`; `contaPares([0])` → `1`.

Solução de referência:

```js
function contaPares(v) { let c = 0; for (const x of v) if (x % 2 === 0) c++; return c; }
```

### Média do vetor — Código, Médio

`media-do-vetor`

> Escreva `mediaVetor(v)` que retorna a média dos números do vetor `v`, que tem pelo menos um elemento.

Função: `mediaVetor(v)`. Testes: `mediaVetor([1,2,3])` → `2`; `mediaVetor([10])` → `10`; `mediaVetor([1,2])` → `1.5`; `mediaVetor([0,0,6])` → `2`; `mediaVetor([-2,2])` → `0`.

Solução de referência:

```js
function mediaVetor(v) { let s = 0; for (const x of v) s += x; return s / v.length; }
```

### Segundo maior valor — Código, Difícil

`segundo-maior`

> Escreva `segundoMaior(v)` que retorna o segundo maior valor DISTINTO do vetor `v` (que tem pelo menos dois valores diferentes). Por exemplo, em [10, 9, 10, 8] o segundo maior é 9.

Função: `segundoMaior(v)`. Testes: `segundoMaior([3,1,2])` → `2`; `segundoMaior([5,5,4])` → `4`; `segundoMaior([1,2])` → `1`; `segundoMaior([10,9,10,8])` → `9`; `segundoMaior([-1,-5,-3])` → `-3`.

Solução de referência:

```js
function segundoMaior(v) { let a = -Infinity, b = -Infinity; for (const x of v) { if (x > a) { b = a; a = x; } else if (x < a && x > b) { b = x; } } return b; }
```

## Funções

### Parâmetro e retorno — Múltipla escolha, Fácil

`parametro-e-retorno`

> Na função abaixo, o que é n?
> 
> function dobro(n) {
>   return n * 2;
> }

-  O resultado da função
- **✓** Um parâmetro: o valor de entrada
-  O nome da função
-  Um erro

Explicação ao acertar: n é o parâmetro: o valor que a função recebe. O resultado é o que ela devolve com return.

### Complete a função — Completar a lacuna, Fácil

`completar-funcao`

> Complete as lacunas para definir uma função que devolve a área de um retângulo.

```js
{{1}} area(base, altura) {
  {{2}} base * altura;
}
```

Respostas aceitas: lacuna 1: `function`; lacuna 2: `return`.

Explicação ao acertar: "function" declara a função e "return" devolve o resultado para quem a chamou.

### Onde a variável existe? — Múltipla escolha, Médio

`escopo-de-variavel`

> O que acontece ao executar o código abaixo?
> 
> function f() {
>   let x = 5;
> }
> f();
> console.log(x);

-  Mostra 5
- **✓** Dá erro: x não existe fora da função
-  Mostra undefined
-  Mostra 0

Explicação ao acertar: x foi criada dentro de f, então só existe ali. Fora da função, usar x causa um erro (ReferenceError).

### Maior de dois — Código, Fácil

`maior-de-dois`

> Escreva `maiorDeDois(a, b)` que retorna o maior entre os dois números.

Função: `maiorDeDois(a, b)`. Testes: `maiorDeDois(1, 2)` → `2`; `maiorDeDois(5, 3)` → `5`; `maiorDeDois(4, 4)` → `4`; `maiorDeDois(-1, -2)` → `-1`; `maiorDeDois(0, -7)` → `0`.

Solução de referência:

```js
function maiorDeDois(a, b) { return a > b ? a : b; }
```

### Hipotenusa — Código, Médio

`hipotenusa`

> Escreva `hipotenusa(a, b)` que retorna o comprimento da hipotenusa de um triângulo retângulo com catetos a e b (teorema de Pitágoras). Você pode usar `Math.sqrt`.

Função: `hipotenusa(a, b)`. Testes: `hipotenusa(3, 4)` → `5`; `hipotenusa(5, 12)` → `13`; `hipotenusa(0, 0)` → `0`; `hipotenusa(8, 15)` → `17`; `hipotenusa(1, 1)` → `1.4142135623730951`.

Solução de referência:

```js
function hipotenusa(a, b) { return Math.sqrt(a * a + b * b); }
```

## Textos

### Letras e índices — Múltipla escolha, Fácil

`tamanho-do-texto`

> Em let s = "lógica";, quanto vale s.length?

-  5
- **✓** 6
-  7
-  4

Explicação ao acertar: "lógica" tem 6 letras (l, ó, g, i, c, a), então s.length vale 6.

### Complete as consultas ao texto — Completar a lacuna, Fácil

`completar-texto`

> Complete as lacunas para obter o tamanho do texto e a sua primeira letra.

```js
let nome = "Ana";
let tamanho = nome{{1}};
let primeira = nome{{2}};
```

Respostas aceitas: lacuna 1: `.length`; lacuna 2: `[0]` ou `.charAt(0)`.

Explicação ao acertar: nome.length dá o tamanho (3) e nome[0] dá a primeira letra ("A").

### Inverter um texto — Código, Médio

`inverter-texto`

> Escreva `inverterTexto(s)` que retorna o texto `s` de trás para frente. Por exemplo, "abc" vira "cba".

Função: `inverterTexto(s)`. Testes: `inverterTexto("abc")` → `"cba"`; `inverterTexto("")` → `""`; `inverterTexto("a")` → `"a"`; `inverterTexto("lógica")` → `"acigól"`; `inverterTexto("ab ba")` → `"ab ba"`.

Solução de referência:

```js
function inverterTexto(s) { let r = ''; for (let i = s.length - 1; i >= 0; i--) r += s[i]; return r; }
```

### Contar vogais — Código, Médio

`conta-vogais`

> Escreva `contaVogais(s)` que retorna quantas vogais (a, e, i, o, u) há no texto `s`. Os textos de teste têm só letras minúsculas e sem acentos.

Função: `contaVogais(s)`. Testes: `contaVogais("banana")` → `3`; `contaVogais("")` → `0`; `contaVogais("xyz")` → `0`; `contaVogais("aeiou")` → `5`; `contaVogais("programacao")` → `5`; `contaVogais("logica")` → `3`.

Solução de referência:

```js
function contaVogais(s) { let c = 0; for (const ch of s) if ('aeiou'.includes(ch)) c++; return c; }
```

### Palíndromo — Código, Difícil

`palindromo`

> Escreva `ehPalindromo(s)` que retorna true se o texto `s` é igual quando lido de trás para frente (por exemplo, "arara"). Os testes usam só letras minúsculas, sem espaços. O texto vazio é um palíndromo.

Função: `ehPalindromo(s)`. Testes: `ehPalindromo("arara")` → `true`; `ehPalindromo("casa")` → `false`; `ehPalindromo("a")` → `true`; `ehPalindromo("")` → `true`; `ehPalindromo("radar")` → `true`; `ehPalindromo("abca")` → `false`.

Solução de referência:

```js
function ehPalindromo(s) { for (let i = 0, j = s.length - 1; i < j; i++, j--) if (s[i] !== s[j]) return false; return true; }
```
