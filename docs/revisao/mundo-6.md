# Revisão do conteúdo — Vetores e Matrizes

> GERADO por `npm run content:review`. Não edite este arquivo: ele muda quando o conteúdo mudar.

**Objetivo do mundo:** Ensinar o aluno a armazenar e organizar vários valores em uma única estrutura.

Este documento reúne tudo o que os alunos vão ver neste mundo: 13 lições e 107 exercícios. **Nada foi publicado:** os exercícios estão como rascunho e só o professor os vê.

## Como revisar
1. Leia cada lição (texto, exemplo, revisão e exercícios) como se fosse um aluno iniciante.
2. Confira o gabarito (✔) e as "confusões" das alternativas erradas: elas alimentam o painel de dificuldades.
3. Anote ajustes por lição. Peça a correção ao Claude, que altera os arquivos de `content/`.
4. Quando aprovar, publique com `npm run content:publish -- mundo-6` (gera o SQL para colar no Supabase).

## Resumo
| Lição | Exercícios | Fácil | Médio | Difícil | Tipos |
|---|---:|---:|---:|---:|---|
| Introdução aos vetores | 8 | 4 | 3 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Arrays em JavaScript | 8 | 3 | 4 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Índices e posições | 8 | 4 | 3 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Propriedade length | 8 | 4 | 3 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Inserção de elementos com push() | 9 | 3 | 4 | 2 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 3 código, 1 corrigir o erro |
| Remoção de elementos com pop() | 7 | 3 | 3 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Utilização de shift() e unshift() | 8 | 3 | 4 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Percorrer arrays com for | 10 | 3 | 5 | 2 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 4 código, 1 corrigir o erro |
| Percorrer arrays com while | 9 | 3 | 4 | 2 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 3 código, 1 corrigir o erro |
| Introdução às matrizes | 8 | 4 | 3 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Arrays bidimensionais | 10 | 4 | 4 | 2 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 4 código, 1 corrigir o erro |
| Percorrer matrizes com laços aninhados | 11 | 3 | 5 | 3 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 5 código, 1 corrigir o erro |
| Desafio final do Mundo 6 | 3 | 0 | 0 | 3 | 1 desafio, 1 corrigir o erro, 1 interpretação de código |

---

## Lição 1 — Introdução aos vetores

**Foco:** Guardar vários valores em uma única variável

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Imagine guardar as notas de 30 alunos. Criar 30 variáveis (nota1, nota2, nota3...) seria trabalhoso e impossível de percorrer com um laço. Para isso existe o vetor: uma única variável que guarda vários valores, organizados em fila.
> 
> const notas = [7, 8.5, 6, 9];
> 
> Cada valor do vetor é um elemento e ocupa uma posição numerada. Em JavaScript, os vetores são chamados de arrays. A grande vantagem é tratar o conjunto como um todo: guardar, percorrer, somar, procurar.
> 
> Use um vetor quando tiver muitos valores do mesmo tipo de informação (as notas de uma turma, os preços de uma lista de compras, os nomes de vários alunos) e quiser processá-los do mesmo jeito.
> 
> Cuidado: um vetor é uma estrutura que guarda dados. Quando você atribui um vetor a outra variável, as duas passam a apontar para o mesmo conjunto (veremos isso adiante).

### Exemplo

```
const notas = [7, 8, 9];
console.log(notas[0] + notas[2]);

Passo a passo:
1. O vetor notas guarda três valores: 7, 8 e 9.
2. notas[0] é o valor da primeira posição: 7.
3. notas[2] é o valor da terceira posição: 9.
4. A soma 7 + 9 resulta em 16, que é mostrado.

As posições começam em 0: a primeira é 0, a segunda é 1, a terceira é 2.
```

### Revisão

- Um vetor (array) guarda vários valores em uma única variável.
- Cada valor é um elemento e fica em uma posição numerada.
- As posições começam em 0.
- Use vetores para muitos valores do mesmo tipo de informação que serão processados do mesmo jeito.
- Atribuir um vetor a outra variável não cria uma cópia dos dados.

### Exercícios

#### 1. Para que serve um vetor?

*Múltipla escolha · fácil · id `vet-intro-para-que-serve` · conceitos: Introdução aos vetores (peso 3)*

Para que serve um vetor?

- ✗ Para guardar apenas um valor muito grande — *confusão: acha que o vetor guarda um único valor*
- ✔ **Para guardar vários valores em uma única variável** (correta)
- ✗ Para repetir um trecho de código várias vezes — *confusão: confunde vetor com laço de repetição*
- ✗ Para decidir entre dois caminhos — *confusão: confunde vetor com estrutura condicional*

**Dica:** Pense nas notas de uma turma inteira.

**Ao acertar:** O vetor reúne vários valores sob um só nome, o que permite percorrê-los e processá-los em conjunto.

#### 2. Primeiro e último

*Interpretação de código · fácil · id `vet-intro-soma-das-pontas` · conceitos: Introdução aos vetores (peso 3); Índices e posições (peso 2)*

O que o programa abaixo mostra na tela?

```
const a = [10, 20, 30];
console.log(a[0] + a[2]);
```

- ✗ 30 — *confusão: acha que a primeira posição é a 1 e soma 10 + 20*
- ✗ 60 — *confusão: soma todos os elementos do vetor*
- ✗ 50 — *confusão: soma o segundo e o terceiro elementos*
- ✔ **40** (correta)

**Dica:** As posições começam em 0.

**Ao acertar:** a[0] vale 10 e a[2] vale 30: 10 + 30 = 40.

#### 3. Complete a declaração

*Completar a lacuna · fácil · id `vet-intro-complete-o-vetor` · conceitos: Introdução aos vetores (peso 2); Arrays em JavaScript (peso 1)*

Complete o símbolo que abre a lista de valores do vetor.

```
const dias = {{1}}"seg", "ter", "qua"];
```

Respostas aceitas: lacuna 1: [

**Dica:** Os vetores usam colchetes.

**Ao acertar:** Os valores do vetor ficam entre colchetes: ["seg", "ter", "qua"].

#### 4. Quando usar um vetor?

*Múltipla escolha · médio · id `vet-intro-quando-usar` · conceitos: Introdução aos vetores (peso 3)*

Em qual situação um vetor é a melhor escolha?

- ✔ **Para guardar as notas de 30 alunos e calcular a média da turma** (correta)
- ✗ Para guardar o nome de um único aluno — *confusão: acha que o vetor serve para um só valor*
- ✗ Para guardar um valor que nunca muda — *confusão: confunde vetor com constante*
- ✗ Para executar um código quando uma condição é verdadeira — *confusão: confunde vetor com if*

**Dica:** Vários valores do mesmo tipo de informação, tratados do mesmo jeito.

**Ao acertar:** Quando há muitos valores parecidos que serão processados da mesma forma, um vetor evita criar dezenas de variáveis.

#### 5. Tipos misturados

*Interpretação de código · médio · id `vet-intro-tipos-misturados` · conceitos: Introdução aos vetores (peso 2); Arrays em JavaScript (peso 2)*

O que o programa abaixo mostra na tela?

```
const mix = [1, "dois", true];
console.log(typeof mix[1]);
```

- ✗ number — *confusão: acha que todos os elementos do vetor viram números*
- ✗ boolean — *confusão: confunde a posição 1 com o último elemento*
- ✔ **string** (correta)
- ✗ array — *confusão: confunde o tipo do elemento com o tipo do vetor*

**Dica:** mix[1] é o segundo elemento.

**Ao acertar:** Um vetor pode misturar tipos. O elemento da posição 1 é "dois", que é uma string.

#### 6. Soma de três

*Código · fácil · id `vet-intro-soma-de-tres` · conceitos: Introdução aos vetores (peso 2); Índices e posições (peso 2)*

Escreva a função `somaDeTres(v)` que recebe um vetor com exatamente 3 números e devolve a soma deles.

Função: `somaDeTres`

Código inicial:

```js
function somaDeTres(v) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,3]] → retorna 6
- entrada [[10,20,30]] → retorna 60
- entrada [[-1,0,1]] → retorna 0

Solução de referência:

```js
function somaDeTres(v) {
  return v[0] + v[1] + v[2];
}
```

**Dica:** v[0], v[1] e v[2] são os três elementos.

**Solução comentada:** Os elementos ficam nas posições 0, 1 e 2; basta somá-los.

#### 7. Corrija as posições

*Corrigir o erro · médio · id `vet-intro-corrija-a-posicao` · conceitos: Introdução aos vetores (peso 2); Índices e posições (peso 3)*

A função `somaDosDois(v)` deveria devolver a soma dos dois elementos de um vetor de tamanho 2 (por exemplo, 3 para [1, 2]), mas devolve NaN. Corrija o defeito.

Função: `somaDosDois`

Código inicial:

```js
function somaDosDois(v) {
  return v[1] + v[2];
}
```

Testes:

- entrada [[1,2]] → retorna 3
- entrada [[10,5]] → retorna 15
- entrada [[0,0]] → retorna 0

Solução de referência:

```js
function somaDosDois(v) {
  return v[0] + v[1];
}
```

**Dica:** Qual é a posição do primeiro elemento?

**Solução comentada:** A contagem começa em 0: os elementos estão nas posições 0 e 1. Usar v[2] acessa uma posição que não existe (undefined).

#### 8. Dois nomes, um vetor

*Interpretação de código · difícil · id `vet-intro-mesmo-vetor` · conceitos: Introdução aos vetores (peso 2); Arrays em JavaScript (peso 3)*

O que o programa abaixo mostra na tela?

```
const a = [5, 10, 15];
const b = a;
b[0] = 99;
console.log(a[0]);
```

- ✗ 5 — *confusão: acha que atribuir o vetor a outra variável cria uma cópia dos dados*
- ✔ **99** (correta)
- ✗ 15 — *confusão: confunde a posição 0 com o último elemento*
- ✗ undefined — *confusão: acha que a variável a é apagada depois da atribuição*

**Dica:** b = a copia o vetor ou aponta para o mesmo conjunto?

**Ao acertar:** b e a apontam para o mesmo vetor. Alterar b[0] altera o que a enxerga: a[0] vale 99.

---

## Lição 2 — Arrays em JavaScript

**Foco:** Criar, ler e alterar elementos de um array

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Em JavaScript, criamos um array escrevendo os valores entre colchetes, separados por vírgula:
> 
> const frutas = ["maçã", "uva", "pera"];
> const vazio = [];
> 
> Para ler um elemento, escrevemos o nome do array e a posição entre colchetes: frutas[1] é "uva". Para alterar, atribuímos um novo valor àquela posição: frutas[1] = "kiwi".
> 
> Um array pode guardar qualquer tipo de valor (números, textos, booleanos) e até misturá-los, mas o mais comum é guardar valores do mesmo tipo.
> 
> Duas observações importantes:
> 1. Declarar com const não impede de mudar os elementos: const garante que a variável sempre aponta para o mesmo array, mas o conteúdo pode ser alterado.
> 2. Atribuir um array a outra variável (const b = a) não copia os dados: as duas variáveis apontam para o mesmo array. Para criar uma cópia, use [...a].

### Exemplo

```
const notas = [6, 8, 10];
notas[0] = 7;
console.log(notas[0]);

const copia = [...notas];
copia[1] = 0;
console.log(notas[1]);

Passo a passo:
1. notas começa com 6, 8 e 10.
2. notas[0] = 7 troca o primeiro elemento: o array passa a ter 7, 8 e 10. Mostra 7.
3. [...notas] cria um array novo com os mesmos valores.
4. Alterar copia[1] não afeta notas: notas[1] continua 8.
```

### Revisão

- Array: valores entre colchetes, separados por vírgula; [] é o array vazio.
- Ler: nome[posição]. Alterar: nome[posição] = valor.
- const impede trocar o array por outro, mas não impede alterar os elementos.
- Atribuir um array a outra variável não copia: as duas apontam para o mesmo array.
- Para copiar, use [...array].

### Exercícios

#### 1. Como declarar?

*Múltipla escolha · fácil · id `arr-como-declarar` · conceitos: Arrays em JavaScript (peso 3)*

Qual é a forma correta de declarar um array com os números 1, 2 e 3?

- ✗ const n = (1, 2, 3); — *confusão: usa parênteses no lugar de colchetes*
- ✗ const n = {1, 2, 3}; — *confusão: usa chaves, que não criam array*
- ✗ const n = <1, 2, 3>; — *confusão: usa sinais de menor e maior*
- ✔ **const n = [1, 2, 3];** (correta)

**Dica:** Os arrays usam colchetes.

**Ao acertar:** Os valores de um array ficam entre colchetes e separados por vírgula.

#### 2. Trocando um valor

*Interpretação de código · fácil · id `arr-alterar-elemento` · conceitos: Arrays em JavaScript (peso 3); Índices e posições (peso 1)*

O que o programa abaixo mostra na tela?

```
const n = [4, 5, 6];
n[1] = 50;
console.log(n[1]);
```

- ✔ **50** (correta)
- ✗ 5 — *confusão: acha que a atribuição não altera o array*
- ✗ 4 — *confusão: acha que n[1] é o primeiro elemento*
- ✗ 50, 5 — *confusão: acha que o valor novo é somado ao antigo*

**Dica:** n[1] = 50 guarda um novo valor naquela posição.

**Ao acertar:** A atribuição troca o valor da posição 1 (de 5 para 50), e o programa mostra 50.

#### 3. Array vazio

*Completar a lacuna · fácil · id `arr-complete-o-vazio` · conceitos: Arrays em JavaScript (peso 3)*

Complete a declaração de um array vazio.

```
const lista = {{1}};
```

Respostas aceitas: lacuna 1: [] ou [ ]

**Dica:** Colchetes sem nada dentro.

**Ao acertar:** [] cria um array sem elementos, pronto para receber valores depois.

#### 4. const e o conteúdo

*Interpretação de código · médio · id `arr-const-permite-alterar` · conceitos: Arrays em JavaScript (peso 3)*

O que o programa abaixo mostra na tela?

```
const a = [1, 2];
a[0] = 9;
console.log(a[0]);
```

- ✗ 1 — *confusão: acha que const impede alterar os elementos*
- ✗ Erro: a é constante — *confusão: acha que const trava também o conteúdo do array*
- ✔ **9** (correta)
- ✗ 2 — *confusão: acha que a[0] é o segundo elemento*

**Dica:** const impede trocar o array por outro. E alterar um elemento?

**Ao acertar:** const só impede reatribuir a variável (a = outroArray). Os elementos podem ser alterados: a[0] passa a valer 9.

#### 5. Inverter três

*Código · médio · id `arr-inverter-tres` · conceitos: Arrays em JavaScript (peso 3); Índices e posições (peso 2)*

Escreva a função `inverterTres(v)` que recebe um array com exatamente 3 elementos e devolve um array NOVO com os mesmos elementos na ordem inversa. Por exemplo, [1, 2, 3] vira [3, 2, 1].

Função: `inverterTres`

Código inicial:

```js
function inverterTres(v) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,3]] → retorna [3,2,1]
- entrada [["a","b","c"]] → retorna ["c","b","a"]
- entrada [[7,7,8]] → retorna [8,7,7]

Solução de referência:

```js
function inverterTres(v) {
  return [v[2], v[1], v[0]];
}
```

**Dica:** Monte um novo array com v[2], v[1] e v[0].

**Solução comentada:** Um novo array é criado com os elementos lidos das posições 2, 1 e 0.

#### 6. Corrija a atribuição

*Corrigir o erro · médio · id `arr-corrija-a-atribuicao` · conceitos: Arrays em JavaScript (peso 3)*

A função `dobrarSegundo(v)` deveria dobrar o segundo elemento do array e devolver o array (por exemplo, [1, 2, 3] vira [1, 4, 3]), mas o array volta igual. Corrija o defeito.

Função: `dobrarSegundo`

Código inicial:

```js
function dobrarSegundo(v) {
  v[1] * 2;
  return v;
}
```

Testes:

- entrada [[1,2,3]] → retorna [1,4,3]
- entrada [[0,5]] → retorna [0,10]
- entrada [[3,0,9]] → retorna [3,0,9]

Solução de referência:

```js
function dobrarSegundo(v) {
  v[1] = v[1] * 2;
  return v;
}
```

**Dica:** Calcular o dobro não guarda o resultado em lugar nenhum.

**Solução comentada:** v[1] * 2 só calcula o valor e o descarta. É preciso atribuir o resultado: v[1] = v[1] * 2.

#### 7. Copia ou aponta?

*Múltipla escolha · médio · id `arr-copia-ou-referencia` · conceitos: Arrays em JavaScript (peso 3)*

Depois de const b = a; (a é um array), o que acontece ao executar b[0] = 1?

- ✗ Só o array b muda; a continua igual — *confusão: acha que atribuir um array a outra variável cria uma cópia*
- ✔ **O array a também muda, porque a e b apontam para o mesmo array** (correta)
- ✗ Dá erro, porque b é constante — *confusão: acha que const proíbe alterar os elementos*
- ✗ O array a é apagado — *confusão: acha que a atribuição move o conteúdo de a para b*

**Dica:** Atribuir um array copia os dados ou só o "endereço"?

**Ao acertar:** a e b são dois nomes para o mesmo array. Alterar por um nome é visível pelo outro. Para copiar, use [...a].

#### 8. Fazendo uma cópia

*Interpretação de código · difícil · id `arr-copia-com-spread` · conceitos: Arrays em JavaScript (peso 3)*

O que o programa abaixo mostra na tela?

```
const a = [1, 2, 3];
const b = [...a];
b[0] = 9;
console.log(a[0], b[0]);
```

- ✗ 9 9 — *confusão: acha que [...a] não cria um array novo*
- ✗ 1 1 — *confusão: acha que a atribuição em b[0] não altera b*
- ✗ 9 1 — *confusão: troca os valores: o array alterado é b, não a*
- ✔ **1 9** (correta)

**Dica:** [...a] cria um array novo com os mesmos valores.

**Ao acertar:** b é uma cópia independente. Alterar b[0] não muda a: a[0] continua 1 e b[0] vale 9.

---

## Lição 3 — Índices e posições

**Foco:** Acessar elementos pela posição (índice)

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O índice é o número da posição de um elemento no array. Em JavaScript (e na maioria das linguagens), a contagem começa em 0: o primeiro elemento tem índice 0, o segundo tem índice 1, e assim por diante.
> 
> const cores = ["azul", "verde", "rosa"];
> //  índice:      0        1        2
> 
> cores[0] é "azul" e cores[2] é "rosa".
> 
> Se você pedir um índice que não existe (como cores[3]), o JavaScript não dá erro: devolve undefined, que significa "não há nada aí". Esse é um dos erros mais comuns: confiar que o valor existe e usar o undefined em uma conta (o resultado vira NaN).
> 
> O índice pode ser qualquer expressão numérica: cores[1 + 1], cores[i], cores[i - 1]. Isso será essencial para percorrer arrays com laços.
> 
> Atenção: o índice do último elemento é a quantidade de elementos menos 1 (veremos na próxima lição).

### Exemplo

```
const v = [10, 20, 30, 40];
const i = 2;
console.log(v[i]);
console.log(v[i - 1]);
console.log(v[4]);

Passo a passo:
1. v[i] com i valendo 2 acessa a terceira posição: mostra 30.
2. v[i - 1] é v[1], a segunda posição: mostra 20.
3. v[4] não existe (o último índice é 3): mostra undefined.
```

### Revisão

- O índice é a posição do elemento; o primeiro é o 0.
- cores[i] lê o elemento da posição i, e i pode ser uma variável ou uma conta.
- Um índice que não existe devolve undefined (sem erro).
- Usar undefined em uma conta resulta em NaN.
- O último índice é a quantidade de elementos menos 1.

### Exercícios

#### 1. O primeiro índice

*Múltipla escolha · fácil · id `ind-primeiro-indice` · conceitos: Índices e posições (peso 3)*

Qual é o índice do primeiro elemento de um array?

- ✔ **0** (correta)
- ✗ 1 — *confusão: acha que a contagem de posições começa em 1*
- ✗ -1 — *confusão: acha que a primeira posição usa índice negativo*
- ✗ O mesmo número da quantidade de elementos — *confusão: confunde o índice do primeiro com a quantidade*

**Dica:** Em programação, começamos a contar do zero.

**Ao acertar:** O primeiro elemento tem índice 0, o segundo 1, o terceiro 2, e assim por diante.

#### 2. Qual fruta?

*Interpretação de código · fácil · id `ind-uva` · conceitos: Índices e posições (peso 3)*

O que o programa abaixo mostra na tela?

```
const f = ["maçã", "uva", "pera"];
console.log(f[1]);
```

- ✗ maçã — *confusão: acha que o índice 1 é o primeiro elemento*
- ✗ pera — *confusão: confunde o índice 1 com o último elemento*
- ✔ **uva** (correta)
- ✗ 1 — *confusão: mostra o índice em vez do elemento*

**Dica:** Índice 0 é o primeiro; qual é o 1?

**Ao acertar:** O índice 1 é o segundo elemento: uva.

#### 3. Primeira cor

*Completar a lacuna · fácil · id `ind-complete-a-primeira-cor` · conceitos: Índices e posições (peso 3)*

Complete o índice para mostrar a primeira cor.

```
const cores = ["azul", "verde", "rosa"];
console.log(cores[{{1}}]);
```

Respostas aceitas: lacuna 1: 0

**Dica:** Qual é o índice do primeiro elemento?

**Ao acertar:** A primeira posição é a de índice 0.

#### 4. Fora do limite

*Interpretação de código · médio · id `ind-fora-do-limite` · conceitos: Índices e posições (peso 3)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2, 3];
console.log(v[3]);
```

- ✗ 3 — *confusão: acha que o índice 3 é o terceiro elemento*
- ✔ **undefined** (correta)
- ✗ Erro e o programa para — *confusão: acha que acessar um índice inexistente causa erro*
- ✗ 0 — *confusão: acha que posições vazias valem zero*

**Dica:** Os índices existentes são 0, 1 e 2.

**Ao acertar:** O índice 3 não existe: o JavaScript devolve undefined, sem erro.

#### 5. O segundo elemento

*Código · fácil · id `ind-segundo` · conceitos: Índices e posições (peso 3)*

Escreva a função `segundo(v)` que devolve o segundo elemento do array (o array tem pelo menos 2 elementos).

Função: `segundo`

Código inicial:

```js
function segundo(v) {
  // seu código aqui
}
```

Testes:

- entrada [[4,8,15]] → retorna 8
- entrada [["a","b"]] → retorna "b"
- entrada [[0,0,0,7]] → retorna 0

Solução de referência:

```js
function segundo(v) {
  return v[1];
}
```

**Dica:** O segundo elemento tem índice 1.

**Solução comentada:** O segundo elemento está na posição de índice 1: v[1].

#### 6. Trocar duas posições

*Código · médio · id `ind-trocar-duas-posicoes` · conceitos: Índices e posições (peso 3); Operadores de atribuição (peso 1)*

Escreva a função `trocar(v, i, j)` que troca de lugar os elementos das posições i e j do array e devolve o array. Por exemplo, trocar([1, 2, 3], 0, 2) devolve [3, 2, 1].

Função: `trocar`

Código inicial:

```js
function trocar(v, i, j) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,3],0,2] → retorna [3,2,1]
- entrada [["a","b","c","d"],1,3] → retorna ["a","d","c","b"]
- entrada [[5,6],1,1] → retorna [5,6]

Solução de referência:

```js
function trocar(v, i, j) {
  const auxiliar = v[i];
  v[i] = v[j];
  v[j] = auxiliar;
  return v;
}
```

**Dica:** Guarde um dos valores em uma variável auxiliar antes de sobrescrevê-lo.

**Solução comentada:** Com uma variável auxiliar guardando v[i], os dois valores podem ser trocados sem perder nenhum.

#### 7. Corrija o último

*Corrigir o erro · médio · id `ind-corrija-o-ultimo` · conceitos: Índices e posições (peso 3); Propriedade length (peso 2)*

A função `ultimo(v)` deveria devolver o último elemento do array, mas devolve undefined. Corrija o defeito.

Função: `ultimo`

Código inicial:

```js
function ultimo(v) {
  return v[v.length];
}
```

Testes:

- entrada [[1,2,3]] → retorna 3
- entrada [["x"]] → retorna "x"
- entrada [[9,8,7,6]] → retorna 6

Solução de referência:

```js
function ultimo(v) {
  return v[v.length - 1];
}
```

**Dica:** Se o array tem 3 elementos, qual é o índice do último?

**Solução comentada:** Os índices vão de 0 a length - 1. v[v.length] está uma posição além do fim; o certo é v[v.length - 1].

#### 8. Índice calculado

*Interpretação de código · difícil · id `ind-indice-calculado` · conceitos: Índices e posições (peso 3); Operadores aritméticos (peso 1)*

O que o programa abaixo mostra na tela?

```
const v = [10, 20, 30, 40];
const i = 2;
console.log(v[i - 1] + v[i + 1]);
```

- ✗ 50 — *confusão: soma o elemento do índice 1 com o do índice 2*
- ✗ 70 — *confusão: soma os elementos do índice 2 e do índice 3*
- ✗ 80 — *confusão: soma o primeiro e o último sem calcular os índices*
- ✔ **60** (correta)

**Dica:** Calcule primeiro i - 1 e i + 1.

**Ao acertar:** v[1] vale 20 e v[3] vale 40: 20 + 40 = 60.

---

## Lição 4 — Propriedade length

**Foco:** Descobrir quantos elementos o array tem

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Todo array tem uma propriedade chamada length (comprimento), que guarda a quantidade de elementos.
> 
> const notas = [7, 8, 9];
> console.log(notas.length);   // 3
> 
> Repare que length não leva parênteses: não é uma função, é uma informação do array.
> 
> Como os índices começam em 0, o último elemento tem índice length - 1. Em um array com 3 elementos, os índices são 0, 1 e 2, e o último é notas[notas.length - 1].
> 
> Cuidado com um erro clássico: notas[notas.length] não é o último elemento, é uma posição que não existe, e devolve undefined.
> 
> Um array vazio tem length 0. Por isso, antes de pegar o último elemento, vale conferir se o array não está vazio.
> 
> O length também acompanha as mudanças: quando adicionamos ou removemos elementos, ele se atualiza sozinho.

### Exemplo

```
const v = [5, 6, 7, 8];
console.log(v.length);
console.log(v[v.length - 1]);
console.log(v[v.length]);

Passo a passo:
1. O array tem 4 elementos: v.length mostra 4.
2. O último índice é 4 - 1 = 3: v[3] vale 8.
3. v[4] não existe: mostra undefined.
```

### Revisão

- array.length é a quantidade de elementos (sem parênteses).
- O último índice é length - 1.
- array[array.length] não existe: devolve undefined.
- Um array vazio tem length 0.
- length se atualiza quando o array cresce ou diminui.

### Exercícios

#### 1. O que é length?

*Múltipla escolha · fácil · id `len-o-que-e` · conceitos: Propriedade length (peso 3)*

O que a propriedade length de um array informa?

- ✔ **A quantidade de elementos do array** (correta)
- ✗ O índice do último elemento — *confusão: confunde a quantidade de elementos com o último índice*
- ✗ A soma dos elementos — *confusão: acha que length soma os valores*
- ✗ O primeiro elemento — *confusão: acha que length devolve um elemento*

**Dica:** Se o array tem 4 valores, length vale...?

**Ao acertar:** length é a quantidade de elementos. O último índice é length - 1.

#### 2. Quantos elementos?

*Interpretação de código · fácil · id `len-tamanho` · conceitos: Propriedade length (peso 3)*

O que o programa abaixo mostra na tela?

```
const v = [5, 6, 7, 8];
console.log(v.length);
```

- ✗ 3 — *confusão: confunde length com o último índice*
- ✗ 26 — *confusão: acha que length soma os elementos*
- ✔ **4** (correta)
- ✗ 5 — *confusão: conta uma posição a mais*

**Dica:** Conte os elementos.

**Ao acertar:** O array tem 4 elementos, então length vale 4.

#### 3. Complete o último índice

*Completar a lacuna · fácil · id `len-complete-o-ultimo` · conceitos: Propriedade length (peso 3); Índices e posições (peso 2)*

Complete a conta para obter o último elemento do array.

```
const ultimo = v[v.length - {{1}}];
```

Respostas aceitas: lacuna 1: 1

**Dica:** O último índice é uma unidade a menos que a quantidade.

**Ao acertar:** O último índice é length - 1.

#### 4. Passando do fim

*Interpretação de código · médio · id `len-fora-do-fim` · conceitos: Propriedade length (peso 3); Índices e posições (peso 2)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2, 3];
console.log(v[v.length]);
```

- ✗ 3 — *confusão: acha que v[v.length] é o último elemento*
- ✔ **undefined** (correta)
- ✗ Erro e o programa para — *confusão: acha que acessar um índice inexistente causa erro*
- ✗ 1 — *confusão: acha que o acesso volta ao início do array*

**Dica:** Com 3 elementos, os índices são 0, 1 e 2.

**Ao acertar:** v.length vale 3 e o índice 3 não existe: o resultado é undefined. O último é v[v.length - 1].

#### 5. Está vazio?

*Código · fácil · id `len-esta-vazio` · conceitos: Propriedade length (peso 3); Operadores relacionais (peso 1)*

Escreva a função `estaVazio(v)` que devolve true se o array não tem elementos e false caso contrário.

Função: `estaVazio`

Código inicial:

```js
function estaVazio(v) {
  // seu código aqui
}
```

Testes:

- entrada [[]] → retorna true
- entrada [[1]] → retorna false
- entrada [[1,2,3]] → retorna false

Solução de referência:

```js
function estaVazio(v) {
  return v.length === 0;
}
```

**Dica:** Um array vazio tem length igual a quanto?

**Solução comentada:** Um array vazio tem length 0; basta comparar v.length === 0.

#### 6. Último elemento

*Código · médio · id `len-ultimo-elemento` · conceitos: Propriedade length (peso 3); Índices e posições (peso 2); Estrutura if/else (peso 1)*

Escreva a função `ultimoElemento(v)` que devolve o último elemento do array. Se o array estiver vazio, devolve o texto "vazio".

Função: `ultimoElemento`

Código inicial:

```js
function ultimoElemento(v) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,3]] → retorna 3
- entrada [["a"]] → retorna "a"
- entrada [[]] → retorna "vazio"
- entrada [[9,8]] → retorna 8

Solução de referência:

```js
function ultimoElemento(v) {
  if (v.length === 0) {
    return "vazio";
  }
  return v[v.length - 1];
}
```

**Dica:** Confira o length antes de ler o último elemento.

**Solução comentada:** Se length é 0 devolvemos "vazio"; senão, o último elemento está em v[v.length - 1].

#### 7. Corrija o último índice

*Corrigir o erro · médio · id `len-corrija-o-ultimo-indice` · conceitos: Propriedade length (peso 3); Índices e posições (peso 2)*

A função `ultimoIndice(v)` deveria devolver o índice do último elemento (2 para um array de 3 elementos), mas devolve um valor a mais. Corrija o defeito.

Função: `ultimoIndice`

Código inicial:

```js
function ultimoIndice(v) {
  return v.length;
}
```

Testes:

- entrada [[4,5,6]] → retorna 2
- entrada [[9]] → retorna 0
- entrada [[1,2,3,4,5]] → retorna 4

Solução de referência:

```js
function ultimoIndice(v) {
  return v.length - 1;
}
```

**Dica:** length conta quantos elementos; os índices começam em 0.

**Solução comentada:** length é a quantidade; o último índice é length - 1.

#### 8. Posição distante

*Interpretação de código · difícil · id `len-posicao-distante` · conceitos: Propriedade length (peso 3); Índices e posições (peso 2)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2, 3];
v[5] = 9;
console.log(v.length);
```

- ✗ 4 — *confusão: acha que o elemento novo é colocado logo depois do último*
- ✗ 3 — *confusão: acha que a atribuição fora do limite é ignorada*
- ✗ 5 — *confusão: acha que length é o maior índice usado*
- ✔ **6** (correta)

**Dica:** length é o maior índice mais 1.

**Ao acertar:** Atribuir ao índice 5 faz o array crescer até essa posição: o maior índice é 5 e length passa a ser 6 (as posições 3 e 4 ficam vazias).

---

## Lição 5 — Inserção de elementos com push()

**Foco:** Adicionar elementos no fim do array

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O método push() adiciona um ou mais elementos no final do array.
> 
> const fila = ["Ana", "Bia"];
> fila.push("Caio");     // fila passa a ter Ana, Bia e Caio
> 
> Duas coisas importantes sobre o push:
> 1. Ele altera o próprio array (não cria um novo).
> 2. Ele devolve o novo tamanho do array, e não o array. Por isso, escrever lista = lista.push(5) é um erro: lista passaria a ser um número.
> 
> O push é a forma mais comum de construir um array aos poucos: começamos com um array vazio e, dentro de um laço, vamos adicionando os valores que interessam.
> 
> const pares = [];
> for (let i = 1; i <= 6; i++) {
>   if (i % 2 === 0) {
>     pares.push(i);
>   }
> }
> // pares: 2, 4 e 6

### Exemplo

```
const v = [1, 2];
const tamanho = v.push(9);
console.log(tamanho);
console.log(v[2]);

Passo a passo:
1. v tem 2 elementos.
2. v.push(9) adiciona 9 no fim, e o array passa a ter 3 elementos.
3. push devolve o novo tamanho: tamanho vale 3 (mostra 3).
4. O novo elemento está no índice 2: v[2] mostra 9.
```

### Revisão

- push(valor) adiciona no final do array.
- push altera o próprio array.
- push devolve o novo tamanho, não o array.
- Para construir um array aos poucos: comece com [] e use push dentro do laço.

### Exercícios

#### 1. O que o push faz?

*Múltipla escolha · fácil · id `push-o-que-faz` · conceitos: Inserção de elementos com push() (peso 3)*

O que o método push() faz?

- ✔ **Adiciona um elemento no final do array** (correta)
- ✗ Remove o último elemento do array — *confusão: confunde push com pop*
- ✗ Adiciona um elemento no início do array — *confusão: confunde push com unshift*
- ✗ Ordena os elementos do array — *confusão: acha que push organiza o array*

**Dica:** Pense em empurrar algo para o fim da fila.

**Ao acertar:** push acrescenta elementos no final do array e altera o próprio array.

#### 2. Depois do push

*Interpretação de código · fácil · id `push-novo-tamanho` · conceitos: Inserção de elementos com push() (peso 3); Propriedade length (peso 1)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2];
v.push(3);
console.log(v.length);
```

- ✗ 2 — *confusão: acha que o push não altera o array*
- ✗ 4 — *confusão: conta uma posição a mais depois do push*
- ✔ **3** (correta)
- ✗ 3, 1 — *confusão: mistura o valor adicionado com o tamanho*

**Dica:** O array tinha 2 elementos e ganhou mais um.

**Ao acertar:** Depois do push, o array tem 3 elementos.

#### 3. Complete o método

*Completar a lacuna · fácil · id `push-complete-o-metodo` · conceitos: Inserção de elementos com push() (peso 3)*

Complete o método que adiciona "Ana" no final da fila.

```
const fila = [];
fila.{{1}}("Ana");
```

Respostas aceitas: lacuna 1: push

**Dica:** Em inglês, "empurrar".

**Ao acertar:** push adiciona no final do array.

#### 4. O que o push devolve?

*Interpretação de código · médio · id `push-o-que-devolve` · conceitos: Inserção de elementos com push() (peso 3)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2];
const r = v.push(9);
console.log(r);
```

- ✗ 9 — *confusão: acha que push devolve o valor adicionado*
- ✔ **3** (correta)
- ✗ undefined — *confusão: acha que push não devolve nada*
- ✗ 2 — *confusão: acha que push devolve o tamanho antigo do array*

**Dica:** push devolve uma informação sobre o tamanho do array.

**Ao acertar:** push devolve o novo tamanho do array: depois de adicionar o 9, são 3 elementos.

#### 5. Lista de pares

*Código · médio · id `push-lista-de-pares` · conceitos: Inserção de elementos com push() (peso 3); Estrutura for (peso 2); Estrutura if (peso 1)*

Escreva a função `pares(n)` que devolve um array com os números pares de 1 até n, em ordem. Para n < 2, devolve um array vazio.

Função: `pares`

Código inicial:

```js
function pares(n) {
  // seu código aqui
}
```

Testes:

- entrada [6] → retorna [2,4,6]
- entrada [1] → retorna []
- entrada [7] → retorna [2,4,6]
- entrada [0] → retorna []

Solução de referência:

```js
function pares(n) {
  const resultado = [];
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      resultado.push(i);
    }
  }
  return resultado;
}
```

**Dica:** Comece com um array vazio e use push dentro do laço.

**Solução comentada:** O array começa vazio; a cada número par encontrado, push o adiciona no final.

#### 6. Copiar os positivos

*Código · médio · id `push-copiar-positivos` · conceitos: Inserção de elementos com push() (peso 3); Percorrer arrays com for (peso 2); Estrutura if (peso 1)*

Escreva a função `positivos(v)` que devolve um array NOVO só com os elementos maiores que zero de `v`, na mesma ordem.

Função: `positivos`

Código inicial:

```js
function positivos(v) {
  // seu código aqui
}
```

Testes:

- entrada [[1,-2,3,0]] → retorna [1,3]
- entrada [[-1,-2]] → retorna []
- entrada [[5,6]] → retorna [5,6]
- entrada [[]] → retorna []

Solução de referência:

```js
function positivos(v) {
  const resultado = [];
  for (let i = 0; i < v.length; i++) {
    if (v[i] > 0) {
      resultado.push(v[i]);
    }
  }
  return resultado;
}
```

**Dica:** Percorra v e adicione ao resultado só o que for maior que 0.

**Solução comentada:** O laço percorre v e push guarda no novo array apenas os elementos maiores que zero.

#### 7. Corrija os quadrados

*Corrigir o erro · médio · id `push-corrija-os-quadrados` · conceitos: Inserção de elementos com push() (peso 3); Estrutura for (peso 1)*

A função `quadrados(n)` deveria devolver um array com os quadrados de 1 até n (por exemplo, [1, 4, 9] para n = 3), mas devolve um número. Corrija o defeito.

Função: `quadrados`

Código inicial:

```js
function quadrados(n) {
  let resultado = [];
  for (let i = 1; i <= n; i++) {
    resultado = resultado.push(i * i);
  }
  return resultado;
}
```

Testes:

- entrada [3] → retorna [1,4,9]
- entrada [1] → retorna [1]
- entrada [0] → retorna []

Solução de referência:

```js
function quadrados(n) {
  const resultado = [];
  for (let i = 1; i <= n; i++) {
    resultado.push(i * i);
  }
  return resultado;
}
```

**Dica:** O que push devolve? E o que acontece ao guardar esse valor em resultado?

**Solução comentada:** push devolve o novo tamanho e não o array; atribuí-lo a resultado destrói o array. Basta chamar resultado.push(i * i) sem atribuir.

#### 8. Montando no laço

*Interpretação de código · difícil · id `push-montando-no-laco` · conceitos: Inserção de elementos com push() (peso 3); Propriedade length (peso 2); Estrutura for (peso 1)*

O que o programa abaixo mostra na tela?

```
const a = [];
for (let i = 0; i < 3; i++) {
  a.push(i * 2);
}
console.log(a[a.length - 1] + a.length);
```

- ✗ 4 — *confusão: esquece de somar a quantidade de elementos*
- ✗ 6 — *confusão: soma o último valor com o último índice em vez de length*
- ✗ 5 — *confusão: acha que o último valor é 2 em vez de 4*
- ✔ **7** (correta)

**Dica:** O array fica com 0, 2 e 4. Qual é o último valor? E o length?

**Ao acertar:** O array termina com 0, 2 e 4. O último valor é 4 e length é 3: 4 + 3 = 7.

#### 9. Sem repetidos

*Código · difícil · id `push-sem-repetidos` · conceitos: Inserção de elementos com push() (peso 3); Percorrer arrays com for (peso 2); Estrutura if (peso 2)*

Escreva a função `semRepetidos(v)` que devolve um array NOVO com os elementos de `v` sem repetições, mantendo a ordem da primeira aparição. Por exemplo, [1, 2, 1, 3, 2] vira [1, 2, 3].

Função: `semRepetidos`

Código inicial:

```js
function semRepetidos(v) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,1,3,2]] → retorna [1,2,3]
- entrada [[5,5,5]] → retorna [5]
- entrada [[]] → retorna []
- entrada [["a","b","a"]] → retorna ["a","b"]

Solução de referência:

```js
function semRepetidos(v) {
  const resultado = [];
  for (let i = 0; i < v.length; i++) {
    let jaTem = false;
    for (let j = 0; j < resultado.length; j++) {
      if (resultado[j] === v[i]) {
        jaTem = true;
      }
    }
    if (!jaTem) {
      resultado.push(v[i]);
    }
  }
  return resultado;
}
```

**Dica:** Antes de adicionar um valor, confira se ele já está no array novo.

**Solução comentada:** Para cada elemento, um laço (ou includes) verifica se ele já foi guardado; só se não foi, push o adiciona.

---

## Lição 6 — Remoção de elementos com pop()

**Foco:** Retirar o último elemento do array

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O método pop() remove o último elemento do array e devolve o elemento removido.
> 
> const pilha = ["a", "b", "c"];
> const retirado = pilha.pop();   // retirado vale "c"; pilha fica com "a" e "b"
> 
> Comparando com o push:
> - push(valor) acrescenta no final e devolve o novo tamanho;
> - pop() retira do final e devolve o elemento retirado.
> 
> Como os dois mexem no final do array, eles formam uma pilha: o último a entrar é o primeiro a sair, como uma pilha de pratos.
> 
> Se o array estiver vazio, pop() não dá erro: devolve undefined e o array continua vazio.
> 
> Atenção: pop altera o próprio array. Se você precisar do array original, faça uma cópia antes ([...v]).

### Exemplo

```
const v = [1, 2, 3];
const x = v.pop();
console.log(x);
console.log(v.length);

Passo a passo:
1. v tem 1, 2 e 3.
2. v.pop() remove o último (3) e o devolve: x vale 3 (mostra 3).
3. O array ficou com 1 e 2: v.length mostra 2.
```

### Revisão

- pop() remove o último elemento e devolve o elemento removido.
- pop altera o próprio array.
- Em um array vazio, pop() devolve undefined.
- push e pop trabalham no final: formam uma pilha (último a entrar, primeiro a sair).

### Exercícios

#### 1. O que o pop faz?

*Múltipla escolha · fácil · id `pop-o-que-faz` · conceitos: Remoção de elementos com pop() (peso 3)*

O que o método pop() faz?

- ✔ **Remove o último elemento e o devolve** (correta)
- ✗ Adiciona um elemento no final — *confusão: confunde pop com push*
- ✗ Remove o primeiro elemento — *confusão: confunde pop com shift*
- ✗ Esvazia o array inteiro — *confusão: acha que pop remove todos os elementos*

**Dica:** Pense em retirar o prato que está no topo da pilha.

**Ao acertar:** pop retira o último elemento do array e devolve o elemento retirado.

#### 2. Depois do pop

*Interpretação de código · fácil · id `pop-tamanho-depois` · conceitos: Remoção de elementos com pop() (peso 3); Propriedade length (peso 1)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2, 3];
v.pop();
console.log(v.length);
```

- ✗ 3 — *confusão: acha que o pop não altera o array*
- ✗ 1 — *confusão: acha que o pop remove todos os elementos menos um*
- ✔ **2** (correta)
- ✗ 0 — *confusão: acha que o pop esvazia o array*

**Dica:** pop remove um elemento.

**Ao acertar:** O array tinha 3 elementos e perdeu o último: sobram 2.

#### 3. Complete o método

*Completar a lacuna · fácil · id `pop-complete-o-metodo` · conceitos: Remoção de elementos com pop() (peso 3)*

Complete o método que retira o último elemento e o guarda em ultimo.

```
const ultimo = v.{{1}}();
```

Respostas aceitas: lacuna 1: pop

**Dica:** É o inverso de push.

**Ao acertar:** pop remove e devolve o último elemento.

#### 4. O que o pop devolve?

*Interpretação de código · médio · id `pop-o-que-devolve` · conceitos: Remoção de elementos com pop() (peso 3)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2, 3];
const x = v.pop();
console.log(x);
```

- ✗ 2 — *confusão: acha que pop devolve o novo último elemento*
- ✔ **3** (correta)
- ✗ undefined — *confusão: acha que pop não devolve nada*
- ✗ 1 — *confusão: acha que pop devolve o primeiro elemento*

**Dica:** pop devolve o que foi removido.

**Ao acertar:** pop devolve o elemento removido: o 3.

#### 5. Remover os últimos

*Código · médio · id `pop-remover-ultimos` · conceitos: Remoção de elementos com pop() (peso 3); Estrutura for (peso 1); Propriedade length (peso 1)*

Escreva a função `removerUltimos(v, n)` que remove os n últimos elementos do array e o devolve. Se n for maior que o tamanho, o array fica vazio.

Função: `removerUltimos`

Código inicial:

```js
function removerUltimos(v, n) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,3,4],2] → retorna [1,2]
- entrada [[1],5] → retorna []
- entrada [[7,8,9],0] → retorna [7,8,9]
- entrada [[],2] → retorna []

Solução de referência:

```js
function removerUltimos(v, n) {
  for (let i = 0; i < n && v.length > 0; i++) {
    v.pop();
  }
  return v;
}
```

**Dica:** Repita pop n vezes, parando se o array esvaziar.

**Solução comentada:** Um laço repete pop() n vezes (no máximo o tamanho do array); em array vazio pop não causa erro.

#### 6. Corrija o retorno

*Corrigir o erro · médio · id `pop-corrija-o-retorno` · conceitos: Remoção de elementos com pop() (peso 3)*

A função `retirarUltimo(v)` deveria devolver o elemento retirado do final do array (3 para [1, 2, 3]), mas devolve o array. Corrija o defeito.

Função: `retirarUltimo`

Código inicial:

```js
function retirarUltimo(v) {
  v.pop();
  return v;
}
```

Testes:

- entrada [[1,2,3]] → retorna 3
- entrada [["a","b"]] → retorna "b"
- entrada [[9]] → retorna 9

Solução de referência:

```js
function retirarUltimo(v) {
  return v.pop();
}
```

**Dica:** O que pop devolve? Guarde ou devolva esse valor.

**Solução comentada:** pop já devolve o elemento removido; basta retornar v.pop() (ou guardar o resultado e retorná-lo).

#### 7. Uma pilha

*Interpretação de código · difícil · id `pop-pilha` · conceitos: Remoção de elementos com pop() (peso 3); Inserção de elementos com push() (peso 3)*

O que o programa abaixo mostra na tela?

```
const p = [];
p.push(1);
p.push(2);
p.pop();
p.push(3);
console.log(p.pop() + p.pop());
```

- ✗ 5 — *confusão: esquece que o pop retirou o 2 antes do push(3)*
- ✗ 3 — *confusão: considera só o último valor que entrou*
- ✗ 6 — *confusão: soma todos os valores que passaram pelo array*
- ✔ **4** (correta)

**Dica:** Acompanhe o array a cada linha: [1], [1, 2], [1], [1, 3].

**Ao acertar:** No final o array é [1, 3]. O primeiro pop devolve 3 e o segundo devolve 1: 3 + 1 = 4.

---

## Lição 7 — Utilização de shift() e unshift()

**Foco:** Trabalhar com o início do array

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Enquanto push e pop mexem no final do array, shift e unshift mexem no início.
> 
> - shift() remove o primeiro elemento e devolve o elemento removido.
> - unshift(valor) adiciona um elemento no início e devolve o novo tamanho.
> 
> const fila = ["Ana", "Bia", "Caio"];
> const atendido = fila.shift();   // atendido vale "Ana"; fila: Bia, Caio
> fila.unshift("Zé");              // fila: Zé, Bia, Caio
> 
> Um resumo para não confundir:
> 
> | método       | onde mexe | o que faz   | o que devolve     |
> | push(x)      | final     | adiciona    | novo tamanho      |
> | pop()        | final     | remove      | o removido        |
> | unshift(x)   | início    | adiciona    | novo tamanho      |
> | shift()      | início    | remove      | o removido        |
> 
> Uma fila (primeiro a chegar, primeiro a ser atendido) usa push para entrar e shift para sair.
> 
> Todos esses métodos alteram o próprio array.

### Exemplo

```
const v = [1, 2, 3];
const x = v.shift();
const n = v.unshift(9);
console.log(x, n);
console.log(v[0]);

Passo a passo:
1. v.shift() remove o primeiro elemento (1) e devolve 1: x vale 1. v fica com 2 e 3.
2. v.unshift(9) adiciona 9 no início: v fica com 9, 2 e 3. Devolve o novo tamanho: n vale 3.
3. Mostra 1 3, e depois v[0], que é 9.
```

### Revisão

- shift() remove o primeiro elemento e devolve o removido.
- unshift(x) adiciona no início e devolve o novo tamanho.
- push/pop trabalham no final; unshift/shift trabalham no início.
- Os que adicionam (push, unshift) devolvem o novo tamanho; os que removem (pop, shift) devolvem o elemento removido.
- Uma fila usa push para entrar e shift para sair.

### Exercícios

#### 1. Qual remove do início?

*Múltipla escolha · fácil · id `shift-qual-remove-do-inicio` · conceitos: Utilização de shift() e unshift() (peso 3)*

Qual método remove o primeiro elemento de um array?

- ✔ **shift()** (correta)
- ✗ pop() — *confusão: confunde pop (final) com shift (início)*
- ✗ unshift() — *confusão: acha que unshift remove, mas ele adiciona no início*
- ✗ push() — *confusão: acha que push remove elementos*

**Dica:** Um deles remove do início, outro do final.

**Ao acertar:** shift remove o primeiro elemento; pop remove o último.

#### 2. Novo primeiro

*Interpretação de código · fácil · id `shift-novo-primeiro` · conceitos: Utilização de shift() e unshift() (peso 3); Índices e posições (peso 1)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2, 3];
v.shift();
console.log(v[0]);
```

- ✗ 1 — *confusão: acha que o shift não altera o array*
- ✗ 3 — *confusão: acha que o shift remove o último elemento*
- ✔ **2** (correta)
- ✗ undefined — *confusão: acha que a posição 0 fica vazia depois do shift*

**Dica:** Depois do shift, os elementos andam uma posição para a frente.

**Ao acertar:** shift remove o 1; o array fica [2, 3] e v[0] vale 2.

#### 3. Adicionar no início

*Completar a lacuna · fácil · id `shift-complete-o-unshift` · conceitos: Utilização de shift() e unshift() (peso 3)*

Complete o método que adiciona 0 no início do array.

```
const v = [1, 2];
v.{{1}}(0);
```

Respostas aceitas: lacuna 1: unshift

**Dica:** É o oposto de shift.

**Ao acertar:** unshift adiciona elementos no início do array.

#### 4. Ordem depois do unshift

*Interpretação de código · médio · id `shift-unshift-ordem` · conceitos: Utilização de shift() e unshift() (peso 3)*

O que o programa abaixo mostra na tela?

```
const v = [2, 3];
v.unshift(1);
console.log(v[0] + "," + v[1] + "," + v[2]);
```

- ✗ 2,3,1 — *confusão: acha que unshift adiciona no final*
- ✔ **1,2,3** (correta)
- ✗ 1,3,undefined — *confusão: acha que unshift substitui o primeiro elemento*
- ✗ 2,3,undefined — *confusão: acha que o unshift não altera o array*

**Dica:** unshift coloca o novo valor na frente.

**Ao acertar:** O 1 entra no início e os demais andam uma posição: [1, 2, 3].

#### 5. Retornos

*Interpretação de código · médio · id `shift-unshift-retornos` · conceitos: Utilização de shift() e unshift() (peso 3); Inserção de elementos com push() (peso 1)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2, 3];
const x = v.shift();
const n = v.unshift(9);
console.log(x, n);
```

- ✗ 1 2 — *confusão: acha que unshift devolve o tamanho antes da inserção*
- ✗ 3 3 — *confusão: acha que shift devolve o último elemento*
- ✗ undefined 3 — *confusão: acha que shift não devolve o elemento removido*
- ✔ **1 3** (correta)

**Dica:** shift devolve o removido; unshift devolve o novo tamanho.

**Ao acertar:** shift devolve 1. Depois v é [2, 3]; unshift(9) deixa [9, 2, 3] e devolve 3.

#### 6. Rotacionar

*Código · médio · id `shift-rotacionar` · conceitos: Utilização de shift() e unshift() (peso 3); Inserção de elementos com push() (peso 2)*

Escreva a função `rotacionar(v)` que move o primeiro elemento do array para o final e devolve o array. Por exemplo, [1, 2, 3] vira [2, 3, 1]. Se o array estiver vazio, devolve o array vazio.

Função: `rotacionar`

Código inicial:

```js
function rotacionar(v) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,3]] → retorna [2,3,1]
- entrada [[5]] → retorna [5]
- entrada [[]] → retorna []
- entrada [["a","b"]] → retorna ["b","a"]

Solução de referência:

```js
function rotacionar(v) {
  if (v.length > 0) {
    v.push(v.shift());
  }
  return v;
}
```

**Dica:** Retire o primeiro com shift e adicione no final com push (se houver elementos).

**Solução comentada:** shift tira o primeiro elemento e push o coloca no final. Com array vazio, nada é movido.

#### 7. Corrija o início

*Corrigir o erro · médio · id `shift-corrija-o-inicio` · conceitos: Utilização de shift() e unshift() (peso 3); Inserção de elementos com push() (peso 2)*

A função `adicionarNoInicio(v, x)` deveria colocar x no início do array e devolver o array (por exemplo, [1, 2, 3] para v = [2, 3] e x = 1), mas coloca no final. Corrija o defeito.

Função: `adicionarNoInicio`

Código inicial:

```js
function adicionarNoInicio(v, x) {
  v.push(x);
  return v;
}
```

Testes:

- entrada [[2,3],1] → retorna [1,2,3]
- entrada [[],5] → retorna [5]
- entrada [["b"],"a"] → retorna ["a","b"]

Solução de referência:

```js
function adicionarNoInicio(v, x) {
  v.unshift(x);
  return v;
}
```

**Dica:** Qual método trabalha no início do array?

**Solução comentada:** push adiciona no final. Para adicionar no início, use unshift.

#### 8. Retirar os primeiros

*Código · difícil · id `shift-primeiros-n` · conceitos: Utilização de shift() e unshift() (peso 3); Inserção de elementos com push() (peso 2); Estrutura for (peso 1)*

Escreva a função `retirarPrimeiros(v, n)` que remove os n primeiros elementos de v e devolve um array NOVO com os elementos removidos, na ordem original. Se houver menos de n elementos, devolve todos. Por exemplo, retirarPrimeiros([1, 2, 3, 4], 2) devolve [1, 2].

Função: `retirarPrimeiros`

Código inicial:

```js
function retirarPrimeiros(v, n) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,3,4],2] → retorna [1,2]
- entrada [[1],3] → retorna [1]
- entrada [[5,6,7],0] → retorna []
- entrada [[],2] → retorna []

Solução de referência:

```js
function retirarPrimeiros(v, n) {
  const retirados = [];
  for (let i = 0; i < n && v.length > 0; i++) {
    retirados.push(v.shift());
  }
  return retirados;
}
```

**Dica:** A cada volta, shift retira um elemento; guarde-o no array novo.

**Solução comentada:** Um laço repete até n vezes (ou até esvaziar): shift retira o primeiro e push o guarda no resultado.

---

## Lição 8 — Percorrer arrays com for

**Foco:** Visitar cada elemento com um laço for

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Percorrer um array é visitar cada um dos seus elementos, do primeiro ao último. O jeito mais comum é um for com um índice:
> 
> for (let i = 0; i < v.length; i++) {
>   // v[i] é o elemento da vez
> }
> 
> O índice i começa em 0 (primeira posição) e vai até v.length - 1 (última). Por isso a condição é i < v.length, e não i <= v.length: com <=, o laço tentaria acessar v[v.length], que não existe (undefined), e contas com ele dão NaN.
> 
> Com esse laço, você consegue:
> - somar os elementos (acumulador);
> - contar quantos atendem a uma regra (contador);
> - achar o maior ou o menor (guardando o melhor até agora);
> - construir outro array com push.
> 
> Para percorrer de trás para frente: for (let i = v.length - 1; i >= 0; i--).

### Exemplo

```
const v = [4, 8, 15];
let soma = 0;
for (let i = 0; i < v.length; i++) {
  soma += v[i];
}
console.log(soma);

Passo a passo:
1. soma começa em 0. O laço vai de i = 0 até i = 2 (v.length vale 3).
2. i = 0: soma = 4. i = 1: soma = 12. i = 2: soma = 27.
3. i = 3 não satisfaz i < 3: o laço termina e mostra 27.
```

### Revisão

- Para percorrer: for (let i = 0; i < v.length; i++) e use v[i].
- A condição é i < v.length; com <= o laço passa do fim.
- Ao passar do fim, v[i] é undefined e contas viram NaN.
- Combine o laço com acumuladores, contadores e push.
- De trás para frente: i começa em v.length - 1 e vai até 0.

### Exercícios

#### 1. A condição do laço

*Múltipla escolha · fácil · id `for-vet-condicao-correta` · conceitos: Percorrer arrays com for (peso 3)*

Qual condição percorre todos os elementos de v sem passar do fim?

- ✔ **i < v.length** (correta)
- ✗ i <= v.length — *confusão: ultrapassa o limite: v[v.length] não existe*
- ✗ i < v.length - 1 — *confusão: deixa o último elemento de fora*
- ✗ i <= v.length - 2 — *confusão: deixa de fora os dois últimos elementos*

**Dica:** O último índice válido é v.length - 1.

**Ao acertar:** i < v.length faz i valer de 0 até v.length - 1, exatamente os índices válidos.

#### 2. Mostrando os elementos

*Interpretação de código · fácil · id `for-vet-mostra-tudo` · conceitos: Percorrer arrays com for (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
const v = [3, 6, 9];
for (let i = 0; i < v.length; i++) {
  console.log(v[i]);
}
```

- ✗ 0 / 1 / 2 — *confusão: mostra os índices em vez dos elementos*
- ✗ 6 / 9 — *confusão: começa pelo índice 1, pulando o primeiro*
- ✔ **3 / 6 / 9** (correta)
- ✗ 3 / 6 / 9 / undefined — *confusão: acha que o laço também visita v[v.length]*

**Dica:** v[i] é o elemento; i é só o índice.

**Ao acertar:** O laço visita os índices 0, 1 e 2 e mostra os elementos 3, 6 e 9.

#### 3. Complete o limite

*Completar a lacuna · fácil · id `for-vet-complete-o-limite` · conceitos: Percorrer arrays com for (peso 3); Propriedade length (peso 2)*

Complete a condição para percorrer todo o array notas.

```
for (let i = 0; i < notas.{{1}}; i++) {
  console.log(notas[i]);
}
```

Respostas aceitas: lacuna 1: length

**Dica:** Quantos elementos o array tem?

**Ao acertar:** notas.length é a quantidade de elementos; i < notas.length percorre todos.

#### 4. Passando do fim

*Interpretação de código · médio · id `for-vet-passando-do-fim` · conceitos: Percorrer arrays com for (peso 3); Propriedade length (peso 2)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2, 3];
let s = 0;
for (let i = 0; i <= v.length; i++) {
  s += v[i];
}
console.log(s);
```

- ✗ 6 — *confusão: esquece que a volta extra soma undefined*
- ✔ **NaN** (correta)
- ✗ Erro e o programa para — *confusão: acha que acessar v[3] causa erro*
- ✗ 9 — *confusão: acha que a volta extra soma o último valor de novo*

**Dica:** Na última volta, i vale 3. O que existe em v[3]?

**Ao acertar:** Com <=, a última volta soma undefined, e 6 + undefined resulta em NaN.

#### 5. Somar os elementos

*Código · médio · id `for-vet-somar` · conceitos: Percorrer arrays com for (peso 3); Acumuladores (peso 2)*

Escreva a função `somar(v)` que devolve a soma de todos os elementos do array (0 para array vazio).

Função: `somar`

Código inicial:

```js
function somar(v) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,3]] → retorna 6
- entrada [[]] → retorna 0
- entrada [[-2,2,10]] → retorna 10

Solução de referência:

```js
function somar(v) {
  let soma = 0;
  for (let i = 0; i < v.length; i++) {
    soma += v[i];
  }
  return soma;
}
```

**Dica:** Um acumulador começa em 0 e soma v[i] a cada volta.

**Solução comentada:** O acumulador soma cada elemento durante o laço; com array vazio o laço não executa e o resultado é 0.

#### 6. O maior elemento

*Código · médio · id `for-vet-maior` · conceitos: Percorrer arrays com for (peso 3); Estrutura if (peso 1)*

Escreva a função `maior(v)` que devolve o maior elemento do array (o array tem pelo menos 1 elemento).

Função: `maior`

Código inicial:

```js
function maior(v) {
  // seu código aqui
}
```

Testes:

- entrada [[3,9,2]] → retorna 9
- entrada [[-5,-2,-9]] → retorna -2
- entrada [[7]] → retorna 7
- entrada [[1,1,1]] → retorna 1

Solução de referência:

```js
function maior(v) {
  let maior = v[0];
  for (let i = 1; i < v.length; i++) {
    if (v[i] > maior) {
      maior = v[i];
    }
  }
  return maior;
}
```

**Dica:** Comece supondo que o maior é o primeiro elemento.

**Solução comentada:** Guardamos o maior visto até agora (começando por v[0]) e o atualizamos sempre que um elemento maior aparece.

#### 7. Contar os maiores

*Código · médio · id `for-vet-contar-maiores` · conceitos: Percorrer arrays com for (peso 3); Contadores (peso 2)*

Escreva a função `contarMaiores(v, limite)` que devolve quantos elementos do array são maiores que `limite`.

Função: `contarMaiores`

Código inicial:

```js
function contarMaiores(v, limite) {
  // seu código aqui
}
```

Testes:

- entrada [[1,5,8,3],4] → retorna 2
- entrada [[1,2],10] → retorna 0
- entrada [[],0] → retorna 0
- entrada [[4,4],4] → retorna 0

Solução de referência:

```js
function contarMaiores(v, limite) {
  let contador = 0;
  for (let i = 0; i < v.length; i++) {
    if (v[i] > limite) {
      contador++;
    }
  }
  return contador;
}
```

**Dica:** Some 1 ao contador quando v[i] > limite.

**Solução comentada:** Um contador sobe 1 para cada elemento maior que o limite.

#### 8. Corrija a média

*Corrigir o erro · médio · id `for-vet-corrija-a-media` · conceitos: Percorrer arrays com for (peso 3); Propriedade length (peso 2); Acumuladores (peso 1)*

A função `media(v)` deveria devolver a média dos elementos do array, mas devolve NaN. Corrija o defeito.

Função: `media`

Código inicial:

```js
function media(v) {
  let soma = 0;
  for (let i = 0; i <= v.length; i++) {
    soma += v[i];
  }
  return soma / v.length;
}
```

Testes:

- entrada [[2,4,6]] → retorna 4
- entrada [[10]] → retorna 10
- entrada [[1,2]] → retorna 1.5

Solução de referência:

```js
function media(v) {
  let soma = 0;
  for (let i = 0; i < v.length; i++) {
    soma += v[i];
  }
  return soma / v.length;
}
```

**Dica:** Até qual índice o laço vai? Existe elemento nessa última volta?

**Solução comentada:** Com i <= v.length o laço soma undefined na última volta. A condição correta é i < v.length.

#### 9. De trás para frente

*Interpretação de código · difícil · id `for-vet-de-tras-para-frente` · conceitos: Percorrer arrays com for (peso 3); Concatenação (peso 1)*

O que o programa abaixo mostra na tela?

```
const v = [4, 8, 15];
let r = "";
for (let i = v.length - 1; i >= 0; i--) {
  r += v[i] + " ";
}
console.log(r.trim());
```

- ✗ 4 8 15 — *confusão: acha que o laço percorre na ordem normal*
- ✗ 15 8 — *confusão: acha que o laço para antes do primeiro elemento*
- ✗ 2 1 0 — *confusão: mostra os índices em vez dos elementos*
- ✔ **15 8 4** (correta)

**Dica:** O índice começa no último e vai diminuindo até 0.

**Ao acertar:** O laço visita os índices 2, 1 e 0 e junta 15, 8 e 4 nessa ordem.

#### 10. Segundo maior

*Código · difícil · id `for-vet-segundo-maior` · conceitos: Percorrer arrays com for (peso 3); Estrutura else if (peso 2)*

Escreva a função `segundoMaior(v)` que devolve o segundo maior elemento do array (o array tem pelo menos 2 elementos; elementos repetidos contam: no array [9, 9, 1] o segundo maior é 9).

Função: `segundoMaior`

Código inicial:

```js
function segundoMaior(v) {
  // seu código aqui
}
```

Testes:

- entrada [[5,9,7]] → retorna 7
- entrada [[9,9,1]] → retorna 9
- entrada [[1,2]] → retorna 1
- entrada [[3,3]] → retorna 3
- entrada [[-1,-5,-3]] → retorna -3

Solução de referência:

```js
function segundoMaior(v) {
  let primeiro = -Infinity;
  let segundo = -Infinity;
  for (let i = 0; i < v.length; i++) {
    if (v[i] > primeiro) {
      segundo = primeiro;
      primeiro = v[i];
    } else if (v[i] > segundo) {
      segundo = v[i];
    }
  }
  return segundo;
}
```

**Dica:** Guarde dois valores durante o laço: o maior e o segundo maior.

**Solução comentada:** O laço mantém o maior e o segundo maior vistos até agora, atualizando os dois conforme cada elemento.

---

## Lição 9 — Percorrer arrays com while

**Foco:** Percorrer um array enquanto uma condição valer

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O while também percorre arrays. Ele é a melhor escolha quando não sabemos até onde vamos: por exemplo, procurar um valor e parar assim que o encontrarmos.
> 
> let i = 0;
> while (i < v.length) {
>   // usa v[i]
>   i++;
> }
> 
> Diferente do for, aqui o índice é declarado antes do laço e atualizado dentro do corpo. Esquecer o i++ cria um laço infinito.
> 
> Podemos juntar duas condições com && para parar cedo:
> 
> let i = 0;
> while (i < v.length && v[i] !== 8) {
>   i++;
> }
> // ao sair, i é a posição do primeiro 8 (ou v.length, se não houver)
> 
> Repare na ordem: primeiro conferimos i < v.length (para não passar do fim) e só depois olhamos v[i].
> 
> Para percorrer de trás para frente, comece em v.length - 1 e use i--.

### Exemplo

```
const v = [3, 8, 5, 8];
let i = 0;
while (i < v.length && v[i] !== 8) {
  i++;
}
console.log(i);

Passo a passo:
1. i = 0: v[0] é 3 (diferente de 8): i passa a 1.
2. i = 1: v[1] é 8: a condição v[i] !== 8 é false e o laço termina.
3. Mostra 1, a posição do primeiro 8.
```

### Revisão

- while percorre arrays quando a parada depende de uma condição.
- O índice é declarado antes do laço e atualizado dentro dele (i++).
- Sem a atualização, o laço é infinito.
- Confira i < v.length antes de acessar v[i].
- Use && para parar quando achar o que procura.

### Exercícios

#### 1. O que não pode faltar?

*Múltipla escolha · fácil · id `while-vet-o-que-nao-pode-faltar` · conceitos: Percorrer arrays com while (peso 3); Estrutura while (peso 1)*

Em um while que percorre um array com o índice i, o que não pode faltar dentro do laço?

- ✔ **A atualização do índice (por exemplo, i++)** (correta)
- ✗ Um comando break em toda volta — *confusão: acha que o while precisa de break para terminar*
- ✗ A declaração do array — *confusão: acha que o array precisa ser declarado a cada volta*
- ✗ Um segundo laço — *confusão: acha que percorrer um array exige laços aninhados*

**Dica:** Sem mudar i, a condição nunca fica falsa.

**Ao acertar:** Se o índice não for atualizado, a condição não muda e o laço fica infinito.

#### 2. Mostrando com while

*Interpretação de código · fácil · id `while-vet-mostra-tudo` · conceitos: Percorrer arrays com while (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
const v = [2, 4, 6];
let i = 0;
while (i < v.length) {
  console.log(v[i]);
  i++;
}
```

- ✗ 0 / 1 / 2 — *confusão: mostra os índices em vez dos elementos*
- ✗ 4 / 6 — *confusão: começa pelo segundo elemento*
- ✔ **2 / 4 / 6** (correta)
- ✗ 2 / 4 / 6 / undefined — *confusão: acha que o laço visita v[v.length]*

**Dica:** v[i] é o elemento da vez.

**Ao acertar:** i vai de 0 a 2 e o laço mostra 2, 4 e 6.

#### 3. Complete a atualização

*Completar a lacuna · fácil · id `while-vet-complete-a-atualizacao` · conceitos: Percorrer arrays com while (peso 3); Estrutura while (peso 2)*

Complete a atualização do índice dentro do laço.

```
let i = 0;
while (i < v.length) {
  console.log(v[i]);
  {{1}};
}
```

Respostas aceitas: lacuna 1: i++ ou i += 1 ou i = i + 1 ou ++i

**Dica:** Sem essa linha, o laço seria infinito.

**Ao acertar:** i++ avança para a próxima posição do array.

#### 4. Parando no oito

*Interpretação de código · médio · id `while-vet-parar-no-oito` · conceitos: Percorrer arrays com while (peso 3); Operadores lógicos (peso 1)*

O que o programa abaixo mostra na tela?

```
const v = [3, 8, 5, 8];
let i = 0;
while (i < v.length && v[i] !== 8) {
  i++;
}
console.log(i);
```

- ✗ 3 — *confusão: acha que o laço encontra a última ocorrência do 8*
- ✔ **1** (correta)
- ✗ 2 — *confusão: conta a quantidade de elementos antes do 8 e erra uma posição*
- ✗ 0 — *confusão: acha que o laço para logo na primeira volta*

**Dica:** O laço para na primeira vez que v[i] é igual a 8.

**Ao acertar:** i avança de 0 para 1; em v[1] o valor é 8 e o laço termina. A primeira ocorrência está na posição 1.

#### 5. Primeiro negativo

*Código · médio · id `while-vet-primeiro-negativo` · conceitos: Percorrer arrays com while (peso 3); Operadores lógicos (peso 1)*

Escreva a função `primeiroNegativo(v)` que devolve o índice do primeiro elemento negativo do array, ou -1 se não houver nenhum. Use while.

Função: `primeiroNegativo`

Código inicial:

```js
function primeiroNegativo(v) {
  // seu código aqui
}
```

Testes:

- entrada [[3,-1,5,-2]] → retorna 1
- entrada [[1,2,3]] → retorna -1
- entrada [[-4]] → retorna 0
- entrada [[]] → retorna -1

Solução de referência:

```js
function primeiroNegativo(v) {
  let i = 0;
  while (i < v.length && v[i] >= 0) {
    i++;
  }
  return i < v.length ? i : -1;
}
```

**Dica:** Avance o índice enquanto não passar do fim e o elemento não for negativo.

**Solução comentada:** O laço avança i enquanto i < v.length e v[i] >= 0. Ao sair, se i < v.length achamos o negativo; senão, devolvemos -1.

#### 6. Somar até o zero

*Código · médio · id `while-vet-somar-ate-zero` · conceitos: Percorrer arrays com while (peso 3); Acumuladores (peso 2)*

Escreva a função `somarAteZero(v)` que soma os elementos do array até encontrar um 0 (o 0 e o que vem depois não entram na soma). Sem zero, soma todos.

Função: `somarAteZero`

Código inicial:

```js
function somarAteZero(v) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,0,5]] → retorna 3
- entrada [[0,4]] → retorna 0
- entrada [[4,4]] → retorna 8
- entrada [[]] → retorna 0

Solução de referência:

```js
function somarAteZero(v) {
  let i = 0;
  let soma = 0;
  while (i < v.length && v[i] !== 0) {
    soma += v[i];
    i++;
  }
  return soma;
}
```

**Dica:** O laço deve continuar enquanto houver elemento e ele não for 0.

**Solução comentada:** O while soma v[i] e avança i enquanto i < v.length e v[i] !== 0.

#### 7. Corrija a busca

*Corrigir o erro · médio · id `while-vet-corrija-a-busca` · conceitos: Percorrer arrays com while (peso 3); Estrutura while (peso 2)*

A função `posicaoDe(v, x)` deveria devolver o índice da primeira ocorrência de x (ou -1), mas o laço nunca termina quando x não está na primeira posição (o computador desiste por tempo esgotado). Corrija o defeito.

Função: `posicaoDe`

Código inicial:

```js
function posicaoDe(v, x) {
  let i = 0;
  while (i < v.length && v[i] !== x) {
  }
  return i < v.length ? i : -1;
}
```

Testes:

- entrada [[4,8,15],15] → retorna 2
- entrada [[1],1] → retorna 0
- entrada [[1,2],5] → retorna -1

Solução de referência:

```js
function posicaoDe(v, x) {
  let i = 0;
  while (i < v.length && v[i] !== x) {
    i++;
  }
  return i < v.length ? i : -1;
}
```

**Dica:** O que muda a cada volta do laço?

**Solução comentada:** Faltava avançar o índice dentro do laço: com i++ a condição eventualmente fica falsa.

#### 8. De dois em dois

*Interpretação de código · difícil · id `while-vet-pulando-de-dois-em-dois` · conceitos: Percorrer arrays com while (peso 3); Acumuladores (peso 1)*

O que o programa abaixo mostra na tela?

```
const v = [1, 2, 3, 4, 5];
let i = v.length - 1;
let s = 0;
while (i >= 0) {
  s += v[i];
  i -= 2;
}
console.log(s);
```

- ✗ 15 — *confusão: acha que o laço soma todos os elementos*
- ✗ 6 — *confusão: soma só os elementos de índice par começando de 0 e errando um*
- ✗ 12 — *confusão: soma os elementos das posições 3 e 1 e mais o último*
- ✔ **9** (correta)

**Dica:** i vale 4, 2 e 0.

**Ao acertar:** O laço soma v[4] = 5, v[2] = 3 e v[0] = 1: 9.

#### 9. Em ordem crescente?

*Código · difícil · id `while-vet-todos-crescentes` · conceitos: Percorrer arrays com while (peso 3); Operadores relacionais (peso 1); Estrutura if (peso 1)*

Escreva a função `crescente(v)` que devolve true se cada elemento do array é maior que o anterior (estritamente crescente) e false caso contrário. Arrays vazios ou com um elemento são considerados crescentes.

Função: `crescente`

Código inicial:

```js
function crescente(v) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,3]] → retorna true
- entrada [[1,3,2]] → retorna false
- entrada [[5]] → retorna true
- entrada [[]] → retorna true
- entrada [[1,1]] → retorna false

Solução de referência:

```js
function crescente(v) {
  let i = 1;
  while (i < v.length && v[i] > v[i - 1]) {
    i++;
  }
  return i >= v.length;
}
```

**Dica:** Compare v[i] com v[i - 1] e pare assim que achar um par fora de ordem.

**Solução comentada:** O laço avança enquanto cada par estiver em ordem; se algum par violar a regra, a resposta é false.

---

## Lição 10 — Introdução às matrizes

**Foco:** Organizar dados em linhas e colunas

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Algumas informações naturalmente formam uma tabela: as notas de vários alunos em várias provas, um tabuleiro de jogo, os assentos de um cinema. Para guardá-las, usamos uma matriz: uma tabela organizada em linhas e colunas.
> 
> Em JavaScript, uma matriz é um array de arrays: cada elemento do array de fora é uma linha, e cada linha é um array com os valores das colunas.
> 
> const notas = [
>   [7, 8, 9],     // linha 0: aluno 1
>   [5, 6, 10],    // linha 1: aluno 2
> ];
> 
> Essa matriz tem 2 linhas e 3 colunas, e portanto 2 × 3 = 6 elementos.
> 
> Como ler os tamanhos:
> - notas.length é o número de linhas (quantos arrays existem dentro);
> - notas[0].length é o número de colunas (quantos valores tem a primeira linha).
> 
> Cuidado para não confundir linha com coluna: linhas são horizontais, colunas são verticais.

### Exemplo

```
const m = [
  [1, 2, 3],
  [4, 5, 6],
];
console.log(m.length);
console.log(m[0].length);

Passo a passo:
1. m é um array com duas linhas: [1, 2, 3] e [4, 5, 6].
2. m.length conta as linhas: mostra 2.
3. m[0] é a primeira linha, [1, 2, 3]; m[0].length conta as colunas: mostra 3.
```

### Revisão

- Matriz: tabela com linhas e colunas.
- Em JavaScript, é um array de arrays: cada elemento é uma linha.
- matriz.length é o número de linhas; matriz[0].length é o número de colunas.
- Uma matriz com L linhas e C colunas tem L × C elementos.
- Não confunda linha (horizontal) com coluna (vertical).

### Exercícios

#### 1. O que é uma matriz?

*Múltipla escolha · fácil · id `mat-intro-o-que-e` · conceitos: Introdução às matrizes (peso 3)*

O que é uma matriz em programação?

- ✔ **Uma tabela de valores organizada em linhas e colunas** (correta)
- ✗ Um array com um único valor — *confusão: acha que a matriz tem apenas um elemento*
- ✗ Uma variável que guarda um número muito grande — *confusão: confunde matriz com número grande*
- ✗ Um laço que repete linhas de código — *confusão: confunde matriz com estrutura de repetição*

**Dica:** Pense em uma planilha ou em um tabuleiro.

**Ao acertar:** Uma matriz organiza valores em linhas e colunas; em JavaScript, é um array cujos elementos são outros arrays.

#### 2. Quantas linhas?

*Interpretação de código · fácil · id `mat-intro-numero-de-linhas` · conceitos: Introdução às matrizes (peso 3); Propriedade length (peso 1)*

O que o programa abaixo mostra na tela?

```
const m = [[1, 2], [3, 4]];
console.log(m.length);
```

- ✗ 4 — *confusão: acha que length conta todos os elementos da matriz*
- ✗ 1 — *confusão: acha que length mostra o número de colunas da primeira linha menos 1*
- ✔ **2** (correta)
- ✗ 3 — *confusão: confunde length com o último valor*

**Dica:** O array de fora tem quantos elementos?

**Ao acertar:** m.length é o número de linhas: a matriz tem duas linhas, [1, 2] e [3, 4].

#### 3. Complete a matriz

*Completar a lacuna · fácil · id `mat-intro-complete-a-segunda-linha` · conceitos: Introdução às matrizes (peso 2); Arrays em JavaScript (peso 1)*

Complete a segunda linha da matriz.

```
const tabela = [[1, 2], {{1}}];
```

Respostas aceitas: lacuna 1: [3, 4] ou [3,4]

**Dica:** Cada linha é um array entre colchetes.

**Ao acertar:** Cada linha de uma matriz é um array: aqui, a segunda linha é [3, 4].

#### 4. Quantas colunas?

*Interpretação de código · médio · id `mat-intro-numero-de-colunas` · conceitos: Introdução às matrizes (peso 3); Propriedade length (peso 1)*

O que o programa abaixo mostra na tela?

```
const m = [[1, 2, 3], [4, 5, 6]];
console.log(m[0].length);
```

- ✗ 2 — *confusão: confunde o número de colunas com o número de linhas*
- ✔ **3** (correta)
- ✗ 6 — *confusão: acha que length conta todos os elementos*
- ✗ 1 — *confusão: acha que m[0].length devolve o primeiro valor da linha*

**Dica:** m[0] é a primeira linha; quantos valores ela tem?

**Ao acertar:** m[0] é [1, 2, 3]. Seu length é 3: a matriz tem 3 colunas.

#### 5. Total de elementos

*Múltipla escolha · médio · id `mat-intro-total-de-elementos` · conceitos: Introdução às matrizes (peso 3); Operadores aritméticos (peso 1)*

Uma matriz tem 3 linhas e 4 colunas. Quantos elementos ela tem no total?

- ✗ 7 — *confusão: soma linhas e colunas em vez de multiplicar*
- ✗ 3 — *confusão: conta só as linhas*
- ✗ 4 — *confusão: conta só as colunas*
- ✔ **12** (correta)

**Dica:** Cada linha tem 4 valores, e há 3 linhas.

**Ao acertar:** O total é linhas × colunas: 3 × 4 = 12.

#### 6. Criar uma matriz 2×2

*Código · fácil · id `mat-intro-criar-2x2` · conceitos: Introdução às matrizes (peso 3); Arrays em JavaScript (peso 1)*

Escreva a função `criar2x2(a, b, c, d)` que devolve a matriz com duas linhas: [a, b] na primeira e [c, d] na segunda.

Função: `criar2x2`

Código inicial:

```js
function criar2x2(a, b, c, d) {
  // seu código aqui
}
```

Testes:

- entrada [1,2,3,4] → retorna [[1,2],[3,4]]
- entrada [0,0,0,0] → retorna [[0,0],[0,0]]
- entrada ["a","b","c","d"] → retorna [["a","b"],["c","d"]]

Solução de referência:

```js
function criar2x2(a, b, c, d) {
  return [[a, b], [c, d]];
}
```

**Dica:** Cada linha é um array; a matriz é um array de arrays.

**Solução comentada:** A matriz é um array cujos dois elementos são as linhas [a, b] e [c, d].

#### 7. Corrija a contagem de linhas

*Corrigir o erro · médio · id `mat-intro-corrija-contar-linhas` · conceitos: Introdução às matrizes (peso 3); Propriedade length (peso 2)*

A função `contarLinhas(m)` deveria devolver o número de linhas da matriz, mas devolve o número de colunas. Corrija o defeito.

Função: `contarLinhas`

Código inicial:

```js
function contarLinhas(m) {
  return m[0].length;
}
```

Testes:

- entrada [[[1,2,3],[4,5,6]]] → retorna 2
- entrada [[[1]]] → retorna 1
- entrada [[[1,2],[3,4],[5,6]]] → retorna 3

Solução de referência:

```js
function contarLinhas(m) {
  return m.length;
}
```

**Dica:** Quem representa as linhas: m ou m[0]?

**Solução comentada:** As linhas são os elementos de m, então m.length é o número de linhas. m[0].length conta as colunas.

#### 8. Dois índices

*Interpretação de código · difícil · id `mat-intro-dois-indices` · conceitos: Introdução às matrizes (peso 2); Arrays bidimensionais (peso 2)*

O que o programa abaixo mostra na tela?

```
const m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
console.log(m[1][2] + m[2][0]);
```

- ✔ **13** (correta)
- ✗ 11 — *confusão: troca linha e coluna: lê m[2][1] e m[0][2]*
- ✗ 9 — *confusão: soma os elementos de índices 1 e 2 da primeira linha*
- ✗ 15 — *confusão: soma o elemento do canto com o do centro*

**Dica:** m[linha][coluna]. Comece pela linha.

**Ao acertar:** m[1][2] é o elemento da linha 1, coluna 2: 6. m[2][0] é o da linha 2, coluna 0: 7. Soma: 13.

---

## Lição 11 — Arrays bidimensionais

**Foco:** Acessar e alterar elementos de uma matriz

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Um array bidimensional é o nome técnico da matriz: tem duas dimensões, linha e coluna. Para acessar um elemento, usamos dois índices:
> 
> matriz[linha][coluna]
> 
> O primeiro índice escolhe a linha; o segundo, a coluna dentro dela. Os dois começam em 0.
> 
> const m = [
>   [1, 2, 3],
>   [4, 5, 6],
> ];
> m[0][2]   // linha 0, coluna 2: 3
> m[1][0]   // linha 1, coluna 0: 4
> 
> Como ler: m[1] é a linha inteira (o array [4, 5, 6]) e m[1][0] é o primeiro elemento dessa linha.
> 
> Para alterar, atribuímos: m[1][0] = 40.
> 
> Truque para não confundir: pense "linha primeiro, coluna depois", como ao procurar uma casa em um mapa: primeiro a rua, depois o número.
> 
> As linhas não precisam ter o mesmo tamanho (matrizes irregulares), mas o mais comum é que tenham.

### Exemplo

```
const m = [[1, 2, 3], [4, 5, 6]];
m[1][0] = 40;
console.log(m[1][0] + m[0][2]);

Passo a passo:
1. m[1][0] é a linha 1, coluna 0: valia 4 e passa a valer 40.
2. m[0][2] é a linha 0, coluna 2: vale 3.
3. A soma 40 + 3 é 43, que é mostrada.
```

### Revisão

- Acesso: matriz[linha][coluna], os dois índices começam em 0.
- matriz[i] é a linha inteira (um array).
- Alterar: matriz[i][j] = valor.
- Pense: linha primeiro, coluna depois.
- As linhas podem ter tamanhos diferentes, mas em geral têm o mesmo.

### Exercícios

#### 1. Linha ou coluna?

*Múltipla escolha · fácil · id `bid-linha-ou-coluna` · conceitos: Arrays bidimensionais (peso 3)*

Em matriz[i][j], o que cada índice representa?

- ✗ i é a coluna e j é a linha — *confusão: troca linha e coluna*
- ✗ Os dois índices representam a linha — *confusão: acha que os dois índices escolhem a linha*
- ✔ **i é a linha e j é a coluna** (correta)
- ✗ i é o valor e j é a posição — *confusão: acha que i é o valor guardado*

**Dica:** Linha primeiro, coluna depois.

**Ao acertar:** O primeiro índice escolhe a linha e o segundo escolhe a coluna dentro dela.

#### 2. Qual elemento?

*Interpretação de código · fácil · id `bid-elemento` · conceitos: Arrays bidimensionais (peso 3)*

O que o programa abaixo mostra na tela?

```
const m = [[1, 2], [3, 4]];
console.log(m[0][1]);
```

- ✗ 3 — *confusão: troca linha e coluna: lê a linha 1, coluna 0*
- ✔ **2** (correta)
- ✗ 1 — *confusão: lê a primeira coluna em vez da segunda*
- ✗ 4 — *confusão: lê a última linha e a última coluna*

**Dica:** Linha 0, coluna 1.

**Ao acertar:** m[0] é [1, 2] e o elemento de índice 1 dessa linha é 2.

#### 3. Complete a linha

*Completar a lacuna · fácil · id `bid-complete-a-linha` · conceitos: Arrays bidimensionais (peso 3)*

Complete o índice para mostrar o primeiro elemento da SEGUNDA linha.

```
const m = [[1, 2], [3, 4]];
console.log(m[{{1}}][0]);
```

Respostas aceitas: lacuna 1: 1

**Dica:** A segunda linha tem índice 1.

**Ao acertar:** A segunda linha é a de índice 1: m[1][0] vale 3.

#### 4. Alterando um elemento

*Interpretação de código · médio · id `bid-alterar-e-somar` · conceitos: Arrays bidimensionais (peso 3); Operadores de atribuição (peso 1)*

O que o programa abaixo mostra na tela?

```
const m = [[1, 2, 3], [4, 5, 6]];
m[1][0] = 40;
console.log(m[1][0] + m[0][2]);
```

- ✗ 7 — *confusão: ignora a atribuição e usa o valor antigo (4 + 3)*
- ✗ 46 — *confusão: lê m[1][2] em vez de m[0][2]*
- ✗ 41 — *confusão: soma o valor novo com o primeiro elemento da primeira linha*
- ✔ **43** (correta)

**Dica:** m[1][0] passa a valer 40 antes da soma.

**Ao acertar:** m[1][0] foi trocado por 40 e m[0][2] vale 3: 40 + 3 = 43.

#### 5. Elemento da matriz

*Código · fácil · id `bid-elemento-em` · conceitos: Arrays bidimensionais (peso 3)*

Escreva a função `elementoEm(m, i, j)` que devolve o elemento da linha i e coluna j da matriz.

Função: `elementoEm`

Código inicial:

```js
function elementoEm(m, i, j) {
  // seu código aqui
}
```

Testes:

- entrada [[[1,2],[3,4]],0,1] → retorna 2
- entrada [[[1,2],[3,4]],1,0] → retorna 3
- entrada [[[9]],0,0] → retorna 9

Solução de referência:

```js
function elementoEm(m, i, j) {
  return m[i][j];
}
```

**Dica:** Primeiro a linha, depois a coluna.

**Solução comentada:** m[i][j] lê o elemento da linha i, coluna j.

#### 6. Soma de uma linha

*Código · médio · id `bid-soma-da-linha` · conceitos: Arrays bidimensionais (peso 3); Percorrer arrays com for (peso 2); Acumuladores (peso 1)*

Escreva a função `somaDaLinha(m, i)` que devolve a soma dos elementos da linha i da matriz.

Função: `somaDaLinha`

Código inicial:

```js
function somaDaLinha(m, i) {
  // seu código aqui
}
```

Testes:

- entrada [[[1,2,3],[4,5,6]],0] → retorna 6
- entrada [[[1,2,3],[4,5,6]],1] → retorna 15
- entrada [[[7]],0] → retorna 7

Solução de referência:

```js
function somaDaLinha(m, i) {
  let soma = 0;
  for (let j = 0; j < m[i].length; j++) {
    soma += m[i][j];
  }
  return soma;
}
```

**Dica:** m[i] é um array: percorra-o com um for.

**Solução comentada:** A linha m[i] é um array comum; um acumulador soma cada um dos seus elementos.

#### 7. Última linha

*Código · médio · id `bid-ultima-linha` · conceitos: Arrays bidimensionais (peso 3); Propriedade length (peso 2)*

Escreva a função `ultimaLinha(m)` que devolve a última linha da matriz (que tem pelo menos uma linha).

Função: `ultimaLinha`

Código inicial:

```js
function ultimaLinha(m) {
  // seu código aqui
}
```

Testes:

- entrada [[[1,2],[3,4]]] → retorna [3,4]
- entrada [[[5]]] → retorna [5]
- entrada [[[1],[2,3],[4,5,6]]] → retorna [4,5,6]

Solução de referência:

```js
function ultimaLinha(m) {
  return m[m.length - 1];
}
```

**Dica:** Quantas linhas existem? Qual é o índice da última?

**Solução comentada:** O número de linhas é m.length e o índice da última é m.length - 1.

#### 8. Corrija linha e coluna

*Corrigir o erro · médio · id `bid-corrija-linha-e-coluna` · conceitos: Arrays bidimensionais (peso 3)*

A função `valorEm(m, i, j)` deveria devolver o elemento da linha i e coluna j, mas devolve o elemento de outra posição quando i e j são diferentes. Corrija o defeito.

Função: `valorEm`

Código inicial:

```js
function valorEm(m, i, j) {
  return m[j][i];
}
```

Testes:

- entrada [[[1,2,3],[4,5,6]],0,2] → retorna 3
- entrada [[[1,2,3],[4,5,6]],1,0] → retorna 4
- entrada [[[7]],0,0] → retorna 7

Solução de referência:

```js
function valorEm(m, i, j) {
  return m[i][j];
}
```

**Dica:** O primeiro índice escolhe a linha ou a coluna?

**Solução comentada:** Os índices estavam trocados. A linha vem primeiro: m[i][j].

#### 9. Linhas de tamanhos diferentes

*Interpretação de código · difícil · id `bid-linhas-irregulares` · conceitos: Arrays bidimensionais (peso 3); Propriedade length (peso 2)*

O que o programa abaixo mostra na tela?

```
const m = [[1], [2, 3], [4, 5, 6]];
console.log(m[2].length + m[1][1]);
```

- ✔ **6** (correta)
- ✗ 5 — *confusão: usa m[1].length no lugar de m[2].length*
- ✗ 9 — *confusão: soma os elementos da última linha em vez de usar o length*
- ✗ 4 — *confusão: usa o número de linhas (3) mais 1*

**Dica:** m[2] é a terceira linha. Quantos elementos ela tem?

**Ao acertar:** m[2] é [4, 5, 6]: length 3. m[1][1] é 3. Soma: 6.

#### 10. Extrair uma coluna

*Código · difícil · id `bid-coluna` · conceitos: Arrays bidimensionais (peso 3); Inserção de elementos com push() (peso 2); Percorrer arrays com for (peso 2)*

Escreva a função `coluna(m, j)` que devolve um array com os elementos da coluna j, na ordem das linhas. Por exemplo, coluna([[1, 2], [3, 4]], 1) devolve [2, 4].

Função: `coluna`

Código inicial:

```js
function coluna(m, j) {
  // seu código aqui
}
```

Testes:

- entrada [[[1,2],[3,4]],1] → retorna [2,4]
- entrada [[[1,2,3],[4,5,6]],0] → retorna [1,4]
- entrada [[[7,8,9]],2] → retorna [9]

Solução de referência:

```js
function coluna(m, j) {
  const resultado = [];
  for (let i = 0; i < m.length; i++) {
    resultado.push(m[i][j]);
  }
  return resultado;
}
```

**Dica:** Percorra as linhas e pegue o elemento j de cada uma.

**Solução comentada:** Um laço visita cada linha i e adiciona m[i][j] ao resultado com push.

---

## Lição 12 — Percorrer matrizes com laços aninhados

**Foco:** Visitar todas as linhas e colunas com dois laços

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Para visitar todos os elementos de uma matriz, usamos dois laços aninhados: o de fora percorre as linhas e o de dentro percorre as colunas de cada linha.
> 
> for (let i = 0; i < m.length; i++) {          // linhas
>   for (let j = 0; j < m[i].length; j++) {     // colunas da linha i
>     // m[i][j] é o elemento da vez
>   }
> }
> 
> Os limites:
> - o laço das linhas vai até m.length;
> - o laço das colunas vai até m[i].length (o tamanho da linha atual).
> 
> Com esse padrão você faz o que fazia com arrays simples, mas em duas dimensões: somar todos os elementos, achar o maior, contar valores, mostrar a tabela linha a linha.
> 
> Atenção a dois cuidados:
> - inicialize acumuladores e contadores antes dos dois laços;
> - ao procurar o maior valor, não comece com 0: a matriz pode ter só números negativos. Comece com o primeiro elemento (m[0][0]).

### Exemplo

```
const m = [[1, 2], [3, 4]];
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
3. Os laços terminam e o programa mostra 10.
```

### Revisão

- Dois laços aninhados: o externo percorre as linhas, o interno percorre as colunas.
- Limites: i < m.length e j < m[i].length.
- m[i][j] é o elemento da vez.
- Declare acumuladores e contadores antes dos laços.
- Para achar o maior valor, comece pelo primeiro elemento, não por 0.

### Exercícios

#### 1. Os limites dos laços

*Múltipla escolha · fácil · id `pm-limites` · conceitos: Percorrer matrizes com laços aninhados (peso 3)*

Quais são os limites corretos para percorrer toda uma matriz m?

- ✗ i < m.length e j < m.length — *confusão: supõe que a matriz é sempre quadrada*
- ✗ i < m[0].length e j < m.length — *confusão: troca o limite de linhas pelo de colunas*
- ✔ **i < m.length e j < m[i].length** (correta)
- ✗ i <= m.length e j <= m[i].length — *confusão: ultrapassa o limite das duas dimensões (usa <=)*

**Dica:** O laço de fora conta linhas; o de dentro, colunas da linha atual.

**Ao acertar:** As linhas vão até m.length e, em cada linha i, as colunas vão até m[i].length.

#### 2. Soma da matriz

*Interpretação de código · fácil · id `pm-soma-total` · conceitos: Percorrer matrizes com laços aninhados (peso 3); Acumuladores (peso 1)*

O que o programa abaixo mostra na tela?

```
const m = [[1, 2], [3, 4]];
let s = 0;
for (let i = 0; i < m.length; i++) {
  for (let j = 0; j < m[i].length; j++) {
    s += m[i][j];
  }
}
console.log(s);
```

- ✗ 3 — *confusão: soma só a primeira linha*
- ✔ **10** (correta)
- ✗ 6 — *confusão: soma só a diagonal ou uma linha e esquece elementos*
- ✗ 4 — *confusão: acha que o laço soma só o último elemento*

**Dica:** Os dois laços visitam 1, 2, 3 e 4.

**Ao acertar:** Todos os elementos são visitados: 1 + 2 + 3 + 4 = 10.

#### 3. Complete o limite

*Completar a lacuna · fácil · id `pm-complete-o-limite` · conceitos: Percorrer matrizes com laços aninhados (peso 3); Propriedade length (peso 1)*

Complete o limite do laço das colunas.

```
for (let i = 0; i < m.length; i++) {
  for (let j = 0; j < m[i].{{1}}; j++) {
    console.log(m[i][j]);
  }
}
```

Respostas aceitas: lacuna 1: length

**Dica:** Quantos elementos tem a linha m[i]?

**Ao acertar:** m[i].length é a quantidade de colunas da linha atual.

#### 4. Contando as visitas

*Interpretação de código · médio · id `pm-conta-as-voltas` · conceitos: Percorrer matrizes com laços aninhados (peso 3); Contadores (peso 2)*

O que o programa abaixo mostra na tela?

```
const m = [[1, 2, 3], [4, 5, 6]];
let c = 0;
for (let i = 0; i < m.length; i++) {
  for (let j = 0; j < m[i].length; j++) {
    c++;
  }
}
console.log(c);
```

- ✗ 5 — *confusão: soma linhas e colunas em vez de multiplicar*
- ✗ 2 — *confusão: conta só as linhas*
- ✗ 3 — *confusão: conta só as colunas*
- ✔ **6** (correta)

**Dica:** 2 linhas com 3 colunas cada.

**Ao acertar:** O corpo interno executa uma vez para cada elemento: 2 × 3 = 6.

#### 5. Soma da matriz

*Código · médio · id `pm-soma-matriz` · conceitos: Percorrer matrizes com laços aninhados (peso 3); Acumuladores (peso 2)*

Escreva a função `somaMatriz(m)` que devolve a soma de todos os elementos da matriz.

Função: `somaMatriz`

Código inicial:

```js
function somaMatriz(m) {
  // seu código aqui
}
```

Testes:

- entrada [[[1,2],[3,4]]] → retorna 10
- entrada [[[5]]] → retorna 5
- entrada [[[1,2,3],[4,5,6]]] → retorna 21
- entrada [[]] → retorna 0

Solução de referência:

```js
function somaMatriz(m) {
  let soma = 0;
  for (let i = 0; i < m.length; i++) {
    for (let j = 0; j < m[i].length; j++) {
      soma += m[i][j];
    }
  }
  return soma;
}
```

**Dica:** Um acumulador antes dos laços; some m[i][j] dentro do laço interno.

**Solução comentada:** Dois laços visitam todas as posições e o acumulador soma cada elemento.

#### 6. Contar um valor

*Código · médio · id `pm-contar-valor` · conceitos: Percorrer matrizes com laços aninhados (peso 3); Contadores (peso 2); Estrutura if (peso 1)*

Escreva a função `contarValor(m, x)` que devolve quantas vezes o valor x aparece na matriz.

Função: `contarValor`

Código inicial:

```js
function contarValor(m, x) {
  // seu código aqui
}
```

Testes:

- entrada [[[1,2],[2,3]],2] → retorna 2
- entrada [[[1,1],[1,1]],1] → retorna 4
- entrada [[[5]],9] → retorna 0
- entrada [[]] → retorna 0

Solução de referência:

```js
function contarValor(m, x) {
  let contador = 0;
  for (let i = 0; i < m.length; i++) {
    for (let j = 0; j < m[i].length; j++) {
      if (m[i][j] === x) {
        contador++;
      }
    }
  }
  return contador;
}
```

**Dica:** Um contador sobe 1 quando m[i][j] é igual a x.

**Solução comentada:** O contador começa em 0 e sobe 1 sempre que o elemento visitado é igual a x.

#### 7. Mostrar a matriz

*Código · médio · id `pm-mostrar-matriz` · conceitos: Percorrer matrizes com laços aninhados (peso 3); Utilização de console.log() (peso 1); Concatenação (peso 1)*

Escreva a função `mostrarMatriz(m)` que mostra a matriz com `console.log`: uma linha de texto por linha da matriz, com os elementos separados por um espaço (por exemplo, "1 2" e depois "3 4").

Função: `mostrarMatriz`

Código inicial:

```js
function mostrarMatriz(m) {
  // seu código aqui
}
```

Testes:

- entrada [[[1,2],[3,4]]] → imprime ["1 2","3 4"]
- entrada [[[7]]] → imprime ["7"]
- entrada [[[1,2,3],[4,5,6]]] → imprime ["1 2 3","4 5 6"]

Solução de referência:

```js
function mostrarMatriz(m) {
  for (let i = 0; i < m.length; i++) {
    let linha = "";
    for (let j = 0; j < m[i].length; j++) {
      linha += (j === 0 ? "" : " ") + m[i][j];
    }
    console.log(linha);
  }
}
```

**Dica:** Monte um texto por linha, juntando os elementos, e mostre-o ao fim do laço das colunas.

**Solução comentada:** Para cada linha, o laço interno monta o texto com os elementos; depois de visitar a linha toda, o texto é mostrado.

#### 8. Corrija o maior da matriz

*Corrigir o erro · médio · id `pm-corrija-o-maior` · conceitos: Percorrer matrizes com laços aninhados (peso 3); Estrutura if (peso 1)*

A função `maiorDaMatriz(m)` deveria devolver o maior elemento da matriz, mas erra quando todos os números são negativos. Corrija o defeito.

Função: `maiorDaMatriz`

Código inicial:

```js
function maiorDaMatriz(m) {
  let maior = 0;
  for (let i = 0; i < m.length; i++) {
    for (let j = 0; j < m[i].length; j++) {
      if (m[i][j] > maior) {
        maior = m[i][j];
      }
    }
  }
  return maior;
}
```

Testes:

- entrada [[[1,5],[3,2]]] → retorna 5
- entrada [[[-5,-2],[-9,-3]]] → retorna -2
- entrada [[[-7]]] → retorna -7

Solução de referência:

```js
function maiorDaMatriz(m) {
  let maior = m[0][0];
  for (let i = 0; i < m.length; i++) {
    for (let j = 0; j < m[i].length; j++) {
      if (m[i][j] > maior) {
        maior = m[i][j];
      }
    }
  }
  return maior;
}
```

**Dica:** Com todos os valores negativos, nenhum é maior que 0.

**Solução comentada:** Começando em 0, o resultado nunca fica negativo. O maior deve começar com o primeiro elemento da matriz (m[0][0]).

#### 9. As duas diagonais

*Interpretação de código · difícil · id `pm-diagonais` · conceitos: Percorrer matrizes com laços aninhados (peso 3); Arrays bidimensionais (peso 2)*

O que o programa abaixo mostra na tela?

```
const m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
let s = 0;
for (let i = 0; i < 3; i++) {
  s += m[i][i] + m[i][2 - i];
}
console.log(s);
```

- ✔ **30** (correta)
- ✗ 25 — *confusão: conta o elemento central uma vez só*
- ✗ 15 — *confusão: soma só uma das diagonais*
- ✗ 45 — *confusão: soma todos os elementos da matriz*

**Dica:** m[i][i] é a diagonal principal e m[i][2 - i] é a outra. O 5 aparece nas duas.

**Ao acertar:** A diagonal principal soma 1 + 5 + 9 = 15 e a outra soma 3 + 5 + 7 = 15. O 5 é contado duas vezes: 30.

#### 10. Diagonal principal

*Código · difícil · id `pm-diagonal-principal` · conceitos: Percorrer matrizes com laços aninhados (peso 3); Arrays bidimensionais (peso 2); Acumuladores (peso 1)*

Escreva a função `somaDiagonal(m)` que devolve a soma da diagonal principal (elementos m[0][0], m[1][1], ...) de uma matriz quadrada (mesmo número de linhas e colunas).

Função: `somaDiagonal`

Código inicial:

```js
function somaDiagonal(m) {
  // seu código aqui
}
```

Testes:

- entrada [[[1,2],[3,4]]] → retorna 5
- entrada [[[5]]] → retorna 5
- entrada [[[1,2,3],[4,5,6],[7,8,9]]] → retorna 15

Solução de referência:

```js
function somaDiagonal(m) {
  let soma = 0;
  for (let i = 0; i < m.length; i++) {
    soma += m[i][i];
  }
  return soma;
}
```

**Dica:** Na diagonal, a linha e a coluna são iguais.

**Solução comentada:** Um único laço com m[i][i] soma os elementos em que linha e coluna coincidem.

#### 11. Matriz transposta

*Código · difícil · id `pm-transposta` · conceitos: Percorrer matrizes com laços aninhados (peso 3); Inserção de elementos com push() (peso 2); Arrays bidimensionais (peso 2)*

Escreva a função `transposta(m)` que devolve uma matriz NOVA em que as linhas viram colunas: o elemento da linha i, coluna j de m fica na linha j, coluna i do resultado. Por exemplo, a transposta de [[1, 2, 3], [4, 5, 6]] é [[1, 4], [2, 5], [3, 6]].

Função: `transposta`

Código inicial:

```js
function transposta(m) {
  // seu código aqui
}
```

Testes:

- entrada [[[1,2,3],[4,5,6]]] → retorna [[1,4],[2,5],[3,6]]
- entrada [[[1,2],[3,4]]] → retorna [[1,3],[2,4]]
- entrada [[[7,8]]] → retorna [[7],[8]]

Solução de referência:

```js
function transposta(m) {
  const resultado = [];
  for (let j = 0; j < m[0].length; j++) {
    const linha = [];
    for (let i = 0; i < m.length; i++) {
      linha.push(m[i][j]);
    }
    resultado.push(linha);
  }
  return resultado;
}
```

**Dica:** O resultado tem tantas linhas quanto m tem colunas. Monte cada nova linha coletando uma coluna de m.

**Solução comentada:** Para cada coluna j de m, monta-se uma nova linha com os elementos m[0][j], m[1][j], ... e ela é adicionada ao resultado.

---

## Lição 13 — Desafio final do Mundo 6

**Foco:** Guardar as notas da turma em um vetor e analisá-las

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Chegou o desafio do Mundo 6: um programa de notas da turma. Você vai ler as notas dos estudantes, guardá-las em um vetor e calcular a média da turma, a maior nota e quantos estudantes ficaram acima da média.
> 
> Aqui você junta tudo: vetor para guardar os valores, push para ir montando o vetor, laços para percorrê-lo, acumulador para a soma e variável auxiliar para a maior nota.
> 
> O desafio principal é o primeiro exercício. Os outros dois treinam a leitura de laços com vetores e a correção de um erro clássico no acumulador.

### Exemplo

```
Como montar o programa:
1. Leia a quantidade de notas com lerEntrada() e converta com Number().
2. Crie um vetor vazio e, em um laço, leia cada nota, converta e guarde com push.
3. Percorra o vetor para somar as notas e descobrir a maior.
4. Calcule a média: soma ÷ quantidade.
5. Percorra o vetor de novo, contando as notas maiores que a média.
6. Mostre os três resultados com console.log.
7. Teste um caso com notas repetidas e um caso em que ninguém passa da média.
```

### Revisão

- Vetor para guardar as notas; push para adicioná-las.
- Dois percursos: um para somar e achar a maior; outro para contar as acima da média (a média só é conhecida depois do primeiro).
- Acumulador começa em 0; a maior nota começa pela primeira nota.
- Média = soma ÷ quantidade.
- Teste os casos de fronteira.

### Exercícios

#### 1. Desafio: notas da turma

*Desafio · difícil · id `desafio6-notas-da-turma` · conceitos: Arrays em JavaScript (peso 2); Inserção de elementos com push() (peso 2); Percorrer arrays com for (peso 2); Acumuladores (peso 2); Contadores (peso 1); Entrada e saída de informações (peso 1)*

Escreva a função `analisarTurma()`: leia a quantidade de notas com `lerEntrada()` e depois cada nota (tudo chega como texto). Guarde as notas em um vetor e mostre três linhas com `console.log`: `Média: <valor>`, `Maior nota: <valor>` e `Acima da média: <quantidade>` (quantas notas são maiores que a média).

Função: `analisarTurma`

Código inicial:

```js
function analisarTurma() {
  // leia as notas, guarde em um vetor e mostre as três linhas
}
```

Testes:

- entrada [], lê ["3","7","9","5"] → imprime ["Média: 7","Maior nota: 9","Acima da média: 1"]
- entrada [], lê ["2","6","8"] → imprime ["Média: 7","Maior nota: 8","Acima da média: 1"]
- entrada [], lê ["1","10"] → imprime ["Média: 10","Maior nota: 10","Acima da média: 0"]
- entrada [], lê ["4","5","5","5","5"] → imprime ["Média: 5","Maior nota: 5","Acima da média: 0"]
- entrada [], lê ["2","5","6"] → imprime ["Média: 5.5","Maior nota: 6","Acima da média: 1"]

Solução de referência:

```js
function analisarTurma() {
  const quantidade = Number(lerEntrada());
  const notas = [];
  for (let i = 0; i < quantidade; i++) {
    notas.push(Number(lerEntrada()));
  }
  let soma = 0;
  let maior = notas[0];
  for (let i = 0; i < notas.length; i++) {
    soma += notas[i];
    if (notas[i] > maior) {
      maior = notas[i];
    }
  }
  const media = soma / notas.length;
  let acima = 0;
  for (let i = 0; i < notas.length; i++) {
    if (notas[i] > media) {
      acima++;
    }
  }
  console.log("Média:", media);
  console.log("Maior nota:", maior);
  console.log("Acima da média:", acima);
}
```

**Dica:** Guarde as notas com push. A média só é conhecida depois de somar tudo: use um segundo percurso para contar as acima da média.

**Solução comentada:** As notas vão para um vetor com push. Um primeiro laço soma e encontra a maior; com a média pronta, um segundo laço conta as notas maiores que ela.

#### 2. Desafio: corrija a média

*Corrigir o erro · difícil · id `desafio6-corrija-a-media` · conceitos: Percorrer arrays com for (peso 2); Acumuladores (peso 3); Propriedade length (peso 1)*

A função `mediaDaTurma(notas)` deveria devolver a média das notas do vetor (7 para [7, 9, 5]), mas devolve um valor muito menor. Corrija o defeito.

Função: `mediaDaTurma`

Código inicial:

```js
function mediaDaTurma(notas) {
  let soma = 0;
  for (let i = 0; i < notas.length; i++) {
    soma = notas[i];
  }
  return soma / notas.length;
}
```

Testes:

- entrada [[7,9,5]] → retorna 7
- entrada [[10]] → retorna 10
- entrada [[4,6]] → retorna 5
- entrada [[0,0,9]] → retorna 3

Solução de referência:

```js
function mediaDaTurma(notas) {
  let soma = 0;
  for (let i = 0; i < notas.length; i++) {
    soma += notas[i];
  }
  return soma / notas.length;
}
```

**Dica:** O acumulador está juntando as notas ou sendo substituído a cada volta?

**Solução comentada:** soma = notas[i] substitui o acumulador em cada volta. O correto é somar: soma += notas[i].

#### 3. Desafio: acompanhe as notas

*Interpretação de código · difícil · id `desafio6-acompanhe-as-notas` · conceitos: Percorrer arrays com for (peso 2); Acumuladores (peso 2); Índices e posições (peso 2)*

Acompanhe os valores das variáveis. O que o programa abaixo mostra na tela?

```
const notas = [6, 8, 10];
let soma = 0;
let maior = notas[0];
for (let i = 1; i < notas.length; i++) {
  soma += notas[i];
  if (notas[i] > maior) {
    maior = notas[i];
  }
}
console.log(soma, maior);
```

- ✗ 24 10 — *confusão: soma também a nota da posição 0, que o laço não visita*
- ✗ 18 8 — *confusão: para de procurar o maior antes do último elemento*
- ✔ **18 10** (correta)
- ✗ 8 10 — *confusão: mostra a segunda nota no lugar da soma*

**Dica:** O laço começa em i = 1: a nota da posição 0 só entra no maior, não na soma.

**Ao acertar:** O laço visita 8 e 10: soma = 8 + 10 = 18. O maior começa em 6 e vira 8 e depois 10.

