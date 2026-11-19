# Revisão do conteúdo — Funções e Modularização

> GERADO por `npm run content:review`. Não edite este arquivo: ele muda quando o conteúdo mudar.

**Objetivo do mundo:** Ensinar o aluno a organizar programas em partes menores, reutilizar códigos e estruturar soluções.

Este documento reúne tudo o que os alunos vão ver neste mundo: 11 lições e 89 exercícios. **Nada foi publicado:** os exercícios estão como rascunho e só o professor os vê.

## Como revisar
1. Leia cada lição (texto, exemplo, revisão e exercícios) como se fosse um aluno iniciante.
2. Confira o gabarito (✔) e as "confusões" das alternativas erradas: elas alimentam o painel de dificuldades.
3. Anote ajustes por lição. Peça a correção ao Claude, que altera os arquivos de `content/`.
4. Quando aprovar, publique com `npm run content:publish -- mundo-7` (gera o SQL para colar no Supabase).

## Resumo
| Lição | Exercícios | Fácil | Médio | Difícil | Tipos |
|---|---:|---:|---:|---:|---|
| Introdução às funções | 8 | 4 | 3 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 ordenação, 1 código |
| Declaração de funções | 8 | 4 | 3 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código |
| Chamada de funções | 9 | 3 | 4 | 2 | 1 múltipla escolha, 4 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Parâmetros | 8 | 4 | 3 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Argumentos | 8 | 3 | 4 | 1 | 1 múltipla escolha, 4 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Retorno com return | 10 | 4 | 4 | 2 | 1 múltipla escolha, 4 interpretação de código, 1 completar a lacuna, 3 código, 1 corrigir o erro |
| Funções com parâmetros e retornos | 9 | 3 | 4 | 2 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 3 código, 1 corrigir o erro |
| Escopo global | 8 | 3 | 4 | 1 | 2 múltipla escolha, 4 interpretação de código, 1 completar a lacuna, 1 corrigir o erro |
| Escopo local | 9 | 3 | 5 | 1 | 1 múltipla escolha, 5 interpretação de código, 1 completar a lacuna, 2 corrigir o erro |
| Arrow functions | 8 | 3 | 4 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Desafio final do Mundo 7 | 4 | 0 | 0 | 4 | 2 desafio, 1 corrigir o erro, 1 interpretação de código |

---

## Lição 1 — Introdução às funções

**Foco:** Entender por que e como organizar o código em funções

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Uma receita de bolo não explica de novo como bater ovos toda vez que aparece "bata os ovos": ela dá um nome ao passo e o reaproveita. Uma função faz o mesmo no código: é um bloco de instruções com um nome, que você escreve uma vez e usa quantas vezes quiser.
> 
> Funções trazem três vantagens:
> - Reaproveitamento: o mesmo trecho é usado em vários lugares, sem copiar e colar.
> - Organização: o programa vira peças pequenas, cada uma com um nome que explica o que faz.
> - Manutenção: se algo precisa mudar, você corrige em um lugar só.
> 
> Usar uma função tem duas etapas:
> 1. Declarar: escrever a função (isso só ensina ao computador o que fazer, não executa nada).
> 2. Chamar: usar o nome da função com parênteses (aí o bloco é executado).
> 
> Esquecer a chamada é um erro comum: a função existe, mas nada acontece.
> 
> Nos mundos anteriores você já escreveu funções para resolver os exercícios. Agora vamos entender como elas funcionam por dentro.

### Exemplo

```
function saudar() {
  console.log("Olá!");
}

saudar();
saudar();

Passo a passo:
1. A declaração function saudar() { ... } ensina o computador o que é "saudar". Nada é mostrado ainda.
2. saudar(); é a primeira chamada: o bloco executa e mostra Olá!
3. saudar(); é a segunda chamada: o mesmo bloco executa de novo e mostra Olá!

Resultado: Olá! aparece duas vezes, sem repetir o console.log no código.
```

### Revisão

- Função: bloco de instruções com um nome, reaproveitável.
- Vantagens: reaproveitar código, organizar o programa e facilitar a manutenção.
- Declarar a função não a executa; é preciso chamá-la.
- Para chamar, use o nome seguido de parênteses.
- Uma função declarada e nunca chamada não faz nada.

### Exercícios

#### 1. Para que serve uma função?

*Múltipla escolha · fácil · id `func-intro-para-que-serve` · conceitos: Introdução às funções (peso 3)*

Para que serve uma função?

- ✗ Para guardar um valor que nunca muda — *confusão: confunde função com constante*
- ✔ **Para dar um nome a um bloco de código e reutilizá-lo quando quiser** (correta)
- ✗ Para repetir um trecho várias vezes dentro de um único laço — *confusão: confunde função com estrutura de repetição*
- ✗ Para guardar vários valores em fila — *confusão: confunde função com vetor*

**Dica:** Pense em uma receita com passos que você reaproveita.

**Ao acertar:** Uma função agrupa instruções sob um nome, permitindo reutilizá-las em vários pontos do programa.

#### 2. Duas chamadas

*Interpretação de código · fácil · id `func-intro-duas-chamadas` · conceitos: Introdução às funções (peso 3); Chamada de funções (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
function saudar() {
  console.log("Olá!");
}
saudar();
saudar();
```

- ✗ Olá! — *confusão: acha que a função só executa uma vez, apesar das duas chamadas*
- ✗ Olá! / Olá! / Olá! — *confusão: acha que a declaração também executa a função*
- ✗ Nada — *confusão: acha que a função não executa sem um laço*
- ✔ **Olá! / Olá!** (correta)

**Dica:** Conte as chamadas, não as declarações.

**Ao acertar:** A declaração não executa nada. Cada chamada executa o bloco: duas chamadas, duas mensagens.

#### 3. Complete a declaração

*Completar a lacuna · fácil · id `func-intro-complete-a-palavra` · conceitos: Introdução às funções (peso 2); Declaração de funções (peso 2)*

Complete a palavra que inicia a declaração de uma função.

```
{{1}} saudar() {
  console.log("Olá!");
}
```

Respostas aceitas: lacuna 1: function

**Dica:** Em inglês, "função".

**Ao acertar:** A palavra function inicia a declaração de uma função em JavaScript.

#### 4. Nunca chamada

*Interpretação de código · médio · id `func-intro-nunca-chamada` · conceitos: Introdução às funções (peso 3); Chamada de funções (peso 2)*

O que o programa abaixo mostra na tela?

```
function mostrar() {
  console.log("dentro");
}
console.log("fora");
```

- ✔ **fora** (correta)
- ✗ dentro / fora — *confusão: acha que declarar a função já executa o que está dentro dela*
- ✗ dentro — *confusão: acha que só o conteúdo da função aparece*
- ✗ Nada, porque a função tem erro — *confusão: acha que uma função declarada e não chamada é erro*

**Dica:** A função é chamada em algum lugar?

**Ao acertar:** A função foi declarada, mas nunca chamada: seu conteúdo não executa. Só o console.log de fora aparece.

#### 5. A vantagem de reutilizar

*Múltipla escolha · médio · id `func-intro-vantagem` · conceitos: Introdução às funções (peso 3)*

Você usa o mesmo cálculo em 5 lugares do programa. Qual é a principal vantagem de colocá-lo em uma função?

- ✗ O computador executa o cálculo mais rápido — *confusão: acha que a função melhora a velocidade do cálculo*
- ✗ O cálculo é executado automaticamente sem precisar ser chamado — *confusão: acha que a função executa sozinha*
- ✔ **O cálculo é escrito uma vez só e, se mudar, é corrigido em um lugar só** (correta)
- ✗ Não é mais preciso usar variáveis — *confusão: acha que a função elimina a necessidade de variáveis*

**Dica:** O que acontece se o cálculo precisar de uma correção?

**Ao acertar:** Com a função, o cálculo existe em um único lugar: reaproveitá-lo é fácil e corrigi-lo também.

#### 6. Como usar uma função

*Ordenação · médio · id `func-intro-ordem-de-uso` · conceitos: Introdução às funções (peso 3); Chamada de funções (peso 1)*

Coloque na ordem o que acontece quando o programa usa uma função.

Ordem correta:

1. Declarar a função com um nome
2. Escrever as instruções dentro da função
3. Chamar a função pelo nome, com parênteses
4. O computador executa as instruções da função
5. O programa continua depois da chamada

**Dica:** A função precisa existir antes de ser usada.

**Ao acertar:** Primeiro se declara e escreve a função; depois, cada chamada executa o bloco e o programa segue adiante.

#### 7. Primeira função

*Código · fácil · id `func-intro-ola-mundo` · conceitos: Introdução às funções (peso 3); Declaração de funções (peso 2)*

Escreva a função `ola()` que devolve o texto "Olá, mundo!".

Função: `ola`

Código inicial:

```js
function ola() {
  // seu código aqui
}
```

Testes:

- entrada [] → retorna "Olá, mundo!"

Solução de referência:

```js
function ola() {
  return "Olá, mundo!";
}
```

**Dica:** A função não recebe nada e devolve um texto.

**Solução comentada:** A função devolve o texto com return.

#### 8. Usando duas vezes

*Interpretação de código · difícil · id `func-intro-dobrar-duas-vezes` · conceitos: Introdução às funções (peso 3); Retorno com return (peso 2); Operadores aritméticos (peso 1)*

O que o programa abaixo mostra na tela?

```
function dobrar(x) {
  return x * 2;
}
console.log(dobrar(3) + dobrar(4));
```

- ✗ 7 — *confusão: soma os argumentos sem aplicar a função*
- ✔ **14** (correta)
- ✗ 24 — *confusão: multiplica os resultados em vez de somá-los*
- ✗ 10 — *confusão: dobra só o primeiro argumento e soma o segundo sem dobrar (6 + 4)*

**Dica:** Resolva cada chamada antes da soma.

**Ao acertar:** dobrar(3) devolve 6 e dobrar(4) devolve 8: 6 + 8 = 14.

---

## Lição 2 — Declaração de funções

**Foco:** Escrever a estrutura de uma função

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Declarar uma função é escrever a sua estrutura:
> 
> function nomeDaFuncao(parametros) {
>   // corpo: as instruções da função
> }
> 
> As partes:
> - a palavra function;
> - o nome, que deve dizer o que a função faz (calcularMedia, ehPar, mostrarMenu). Começa com letra minúscula e usa camelCase;
> - parênteses, com os parâmetros dentro (podem ser vazios);
> - chaves { }, que delimitam o corpo.
> 
> Boas práticas:
> - Dê nomes que descrevem uma ação: calcularArea é melhor que f1.
> - Cada função deve fazer uma coisa só.
> - Funções pequenas são mais fáceis de entender e testar.
> 
> Detalhe: em JavaScript, as declarações de função são "içadas": podemos chamar uma função antes da linha em que ela é declarada, desde que ela esteja declarada no mesmo arquivo. Mesmo assim, é mais claro declarar antes de usar.
> 
> Lembre-se: declarar não executa. O corpo só roda quando a função é chamada.

### Exemplo

```
console.log("A");

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

Resultado: A, C e B (nessa ordem).
```

### Revisão

- Estrutura: function nome(parâmetros) { corpo }.
- O nome deve descrever o que a função faz (camelCase, em geral começando por um verbo).
- Cada função deve fazer uma coisa só.
- Declarar não executa: o corpo só roda quando a função é chamada.
- Funções declaradas podem ser chamadas antes da linha da declaração (içamento).

### Exercícios

#### 1. A declaração correta

*Múltipla escolha · fácil · id `decl-forma-correta` · conceitos: Declaração de funções (peso 3)*

Qual é a forma correta de declarar uma função chamada somar com dois parâmetros?

- ✗ somar function(a, b) { return a + b; } — *confusão: coloca o nome antes da palavra function*
- ✗ function somar[a, b] { return a + b; } — *confusão: usa colchetes no lugar de parênteses*
- ✗ function somar(a, b) return a + b; — *confusão: esquece as chaves que delimitam o corpo*
- ✔ **function somar(a, b) { return a + b; }** (correta)

**Dica:** A ordem é: palavra function, nome, parênteses com parâmetros, chaves com o corpo.

**Ao acertar:** A declaração tem function, o nome, os parâmetros entre parênteses e o corpo entre chaves.

#### 2. Ordem de execução

*Interpretação de código · fácil · id `decl-ordem-de-execucao` · conceitos: Declaração de funções (peso 3); Chamada de funções (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log("A");
function mostrar() {
  console.log("B");
}
console.log("C");
mostrar();
```

- ✔ **A / C / B** (correta)
- ✗ A / B / C — *confusão: acha que a função executa no ponto em que é declarada*
- ✗ B / A / C — *confusão: acha que as funções executam antes do resto do programa*
- ✗ A / C — *confusão: acha que a função declarada nunca executa*

**Dica:** A função só executa quando é chamada.

**Ao acertar:** A e C aparecem na ordem do programa. B só aparece na chamada mostrar(), no final.

#### 3. Use o parâmetro

*Completar a lacuna · fácil · id `decl-complete-o-parametro` · conceitos: Declaração de funções (peso 2); Parâmetros (peso 2)*

Complete com o nome do parâmetro, para mostrar o nome recebido.

```
function saudar(nome) {
  console.log("Olá, " + {{1}});
}
```

Respostas aceitas: lacuna 1: nome

**Dica:** O parâmetro é a variável que aparece entre parênteses na declaração.

**Ao acertar:** Dentro da função, o parâmetro nome funciona como uma variável com o valor recebido.

#### 4. Um bom nome

*Múltipla escolha · médio · id `decl-bom-nome` · conceitos: Declaração de funções (peso 3)*

Qual é o melhor nome para uma função que calcula a média das notas?

- ✗ f1 — *confusão: usa um nome curto que não explica o que a função faz*
- ✗ funcao — *confusão: usa um nome genérico, igual ao de qualquer outra função*
- ✔ **calcularMedia** (correta)
- ✗ x — *confusão: usa um nome de uma só letra que nada diz*

**Dica:** O nome deve dizer a ação que a função realiza.

**Ao acertar:** Nomes como calcularMedia explicam a função sem precisar ler o corpo.

#### 5. Duas funções, uma chamada

*Interpretação de código · médio · id `decl-duas-funcoes` · conceitos: Declaração de funções (peso 3); Chamada de funções (peso 2)*

O que o programa abaixo mostra na tela?

```
function a() {
  console.log("A");
}
function b() {
  console.log("B");
}
b();
```

- ✗ A / B — *confusão: acha que todas as funções declaradas executam*
- ✔ **B** (correta)
- ✗ A — *confusão: confunde a primeira função declarada com a chamada*
- ✗ Nada — *confusão: acha que a função só executa com um laço*

**Dica:** Qual função é chamada no final?

**Ao acertar:** Apenas b() é chamada. A função a foi declarada, mas não executou.

#### 6. Triplo

*Código · fácil · id `decl-triplo` · conceitos: Declaração de funções (peso 3); Retorno com return (peso 2); Operadores aritméticos (peso 1)*

Escreva a função `triplo(n)` que devolve o triplo de n.

Função: `triplo`

Código inicial:

```js
function triplo(n) {
  // seu código aqui
}
```

Testes:

- entrada [4] → retorna 12
- entrada [0] → retorna 0
- entrada [-2] → retorna -6

Solução de referência:

```js
function triplo(n) {
  return n * 3;
}
```

**Dica:** Multiplique o parâmetro por 3 e devolva.

**Solução comentada:** A função devolve n * 3.

#### 7. É par?

*Código · médio · id `decl-eh-par` · conceitos: Declaração de funções (peso 3); Retorno com return (peso 2); Operadores relacionais (peso 1)*

Escreva a função `ehPar(n)` que devolve true se n for par e false caso contrário.

Função: `ehPar`

Código inicial:

```js
function ehPar(n) {
  // seu código aqui
}
```

Testes:

- entrada [4] → retorna true
- entrada [7] → retorna false
- entrada [0] → retorna true
- entrada [-3] → retorna false

Solução de referência:

```js
function ehPar(n) {
  return n % 2 === 0;
}
```

**Dica:** Um número é par quando o resto da divisão por 2 é zero.

**Solução comentada:** A função devolve o resultado da comparação n % 2 === 0, que já é true ou false.

#### 8. Chamada antes da declaração

*Interpretação de código · difícil · id `decl-chamada-antes` · conceitos: Declaração de funções (peso 3); Chamada de funções (peso 2)*

O que o programa abaixo mostra na tela?

```
console.log(dobro(4));

function dobro(n) {
  return n * 2;
}
```

- ✗ Erro: dobro ainda não foi declarada — *confusão: acha que a função só existe depois da linha da declaração*
- ✗ undefined — *confusão: acha que a chamada antes da declaração devolve undefined*
- ✗ 4 — *confusão: acha que a função devolve o argumento sem alteração*
- ✔ **8** (correta)

**Dica:** Em JavaScript, as declarações de função são içadas para o início.

**Ao acertar:** Funções declaradas com function podem ser chamadas antes da linha da declaração. dobro(4) devolve 8.

---

## Lição 3 — Chamada de funções

**Foco:** Executar uma função e usar o que ela devolve

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Chamar uma função é pedir para executá-la. Para isso, escrevemos o nome da função seguido de parênteses:
> 
> saudar();
> const resultado = dobro(5);
> 
> Os parênteses são obrigatórios. Sem eles, você não está chamando a função: está apenas se referindo a ela, como a um valor.
> 
> const x = dobro;      // x passa a ser a própria função (nada foi executado)
> const y = dobro(5);   // y recebe o valor devolvido pela chamada (10)
> 
> Quando a função devolve um valor, a chamada vira esse valor dentro da expressão. Por isso podemos usar a chamada em contas, comparações e até como argumento de outra chamada:
> 
> console.log(dobro(2) + dobro(3));   // 4 + 6
> console.log(dobro(dobro(2)));       // dobro(4)
> 
> Uma função também pode chamar outra função. Assim, construímos funções maiores combinando funções pequenas, cada uma com uma tarefa.

### Exemplo

```
function soma(a, b) {
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
4. O console.log mostra 10.
```

### Revisão

- Chamar: nome da função seguido de parênteses.
- Sem os parênteses, a função não executa: tem-se só uma referência a ela.
- Quando a função devolve um valor, a chamada vale esse valor na expressão.
- Uma chamada pode ser argumento de outra: dobro(dobro(2)).
- Uma função pode chamar outras funções.

### Exercícios

#### 1. Como chamar?

*Múltipla escolha · fácil · id `cham-como-chamar` · conceitos: Chamada de funções (peso 3)*

Qual linha chama (executa) a função mostrar?

- ✔ **mostrar();** (correta)
- ✗ mostrar; — *confusão: esquece os parênteses: só se refere à função*
- ✗ function mostrar(); — *confusão: usa a palavra function, que serve para declarar*
- ✗ call mostrar; — *confusão: usa uma palavra que não existe em JavaScript*

**Dica:** A chamada usa o nome e parênteses.

**Ao acertar:** Só mostrar() executa a função. Sem os parênteses, nada é executado.

#### 2. Chamadas com valores

*Interpretação de código · fácil · id `cham-duas-chamadas-com-valor` · conceitos: Chamada de funções (peso 3); Argumentos (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
function dizer(texto) {
  console.log(texto);
}
dizer("a");
dizer("b");
```

- ✗ a — *confusão: acha que só a primeira chamada executa*
- ✗ b — *confusão: acha que só a última chamada aparece*
- ✔ **a / b** (correta)
- ✗ a b — *confusão: junta as duas mensagens na mesma linha*

**Dica:** Cada chamada executa a função uma vez.

**Ao acertar:** A primeira chamada mostra a; a segunda, b, em linhas separadas.

#### 3. Complete a chamada

*Completar a lacuna · fácil · id `cham-complete-os-parenteses` · conceitos: Chamada de funções (peso 3)*

Complete o que falta para chamar a função saudar.

```
function saudar() {
  console.log("Oi!");
}
saudar{{1}};
```

Respostas aceitas: lacuna 1: () ou ( )

**Dica:** O que sempre acompanha o nome de uma função na chamada?

**Ao acertar:** A chamada exige parênteses: saudar().

#### 4. Sem os parênteses

*Interpretação de código · médio · id `cham-sem-parenteses` · conceitos: Chamada de funções (peso 3)*

O que o programa abaixo mostra na tela?

```
function f() {
  return 1;
}
const x = f;
console.log(typeof x);
```

- ✗ number — *confusão: acha que f sem parênteses já devolve o valor 1*
- ✔ **function** (correta)
- ✗ undefined — *confusão: acha que a referência à função não tem valor*
- ✗ object — *confusão: confunde função com outro tipo de dado*

**Dica:** x = f guarda o resultado da chamada ou a própria função?

**Ao acertar:** Sem parênteses, f não é chamada: x passa a ser a própria função, e typeof mostra function.

#### 5. Uma função chama outra

*Interpretação de código · médio · id `cham-funcao-chama-funcao` · conceitos: Chamada de funções (peso 3); Retorno com return (peso 2)*

O que o programa abaixo mostra na tela?

```
function soma(a, b) {
  return a + b;
}
function dobroDaSoma(a, b) {
  return soma(a, b) * 2;
}
console.log(dobroDaSoma(2, 3));
```

- ✗ 5 — *confusão: esquece de multiplicar por 2 depois da soma*
- ✗ 6 — *confusão: multiplica só o primeiro argumento por 2 e soma com 3*
- ✗ 12 — *confusão: dobra cada argumento antes de somar e erra a conta*
- ✔ **10** (correta)

**Dica:** Resolva primeiro soma(2, 3).

**Ao acertar:** soma(2, 3) devolve 5 e dobroDaSoma multiplica por 2: 10.

#### 6. Quádruplo com dobro

*Código · médio · id `cham-quadruplo` · conceitos: Chamada de funções (peso 3); Retorno com return (peso 2)*

A função `dobro(n)` já existe. Escreva a função `quadruplo(n)` que devolve o quádruplo de n chamando `dobro` duas vezes.

Função: `quadruplo`

Código inicial:

```js
function dobro(n) {
  return n * 2;
}

function quadruplo(n) {
  // seu código aqui
}
```

Testes:

- entrada [3] → retorna 12
- entrada [0] → retorna 0
- entrada [-5] → retorna -20

Solução de referência:

```js
function dobro(n) {
  return n * 2;
}

function quadruplo(n) {
  return dobro(dobro(n));
}
```

**Dica:** O resultado de uma chamada pode ser argumento de outra.

**Solução comentada:** dobro(dobro(n)) dobra o valor duas vezes, resultando no quádruplo.

#### 7. Corrija a chamada

*Corrigir o erro · médio · id `cham-corrija-a-chamada` · conceitos: Chamada de funções (peso 3)*

A função `quadruplo(n)` deveria devolver o quádruplo de n, mas o resultado sai errado. Corrija o defeito.

Função: `quadruplo`

Código inicial:

```js
function dobro(n) {
  return n * 2;
}

function quadruplo(n) {
  return dobro(n) + dobro;
}
```

Testes:

- entrada [3] → retorna 12
- entrada [0] → retorna 0
- entrada [-5] → retorna -20

Solução de referência:

```js
function dobro(n) {
  return n * 2;
}

function quadruplo(n) {
  return dobro(n) + dobro(n);
}
```

**Dica:** Todas as chamadas de dobro estão com parênteses e argumento?

**Solução comentada:** O segundo dobro estava sem parênteses: era só uma referência à função, e não uma chamada. O correto é dobro(n) + dobro(n).

#### 8. Chamadas aninhadas

*Interpretação de código · difícil · id `cham-chamadas-aninhadas` · conceitos: Chamada de funções (peso 3); Retorno com return (peso 2)*

O que o programa abaixo mostra na tela?

```
function f(x) {
  return x + 1;
}
console.log(f(f(f(1))));
```

- ✔ **4** (correta)
- ✗ 2 — *confusão: executa só a chamada de fora, sem resolver as de dentro*
- ✗ 3 — *confusão: executa só duas das três chamadas*
- ✗ 1 — *confusão: acha que o argumento não muda com as chamadas*

**Dica:** Resolva da chamada mais interna para a mais externa.

**Ao acertar:** f(1) = 2; f(2) = 3; f(3) = 4.

#### 9. Contar pares com uma ajudante

*Código · difícil · id `cham-contar-pares-com-ajudante` · conceitos: Chamada de funções (peso 3); Percorrer arrays com for (peso 2); Contadores (peso 2)*

A função `ehPar(n)` já existe. Escreva a função `contarPares(v)` que devolve quantos elementos pares o array `v` tem, usando `ehPar` para decidir.

Função: `contarPares`

Código inicial:

```js
function ehPar(n) {
  return n % 2 === 0;
}

function contarPares(v) {
  // seu código aqui
}
```

Testes:

- entrada [[1,2,3,4]] → retorna 2
- entrada [[1,3,5]] → retorna 0
- entrada [[]] → retorna 0
- entrada [[2,4,6,8]] → retorna 4

Solução de referência:

```js
function ehPar(n) {
  return n % 2 === 0;
}

function contarPares(v) {
  let contador = 0;
  for (let i = 0; i < v.length; i++) {
    if (ehPar(v[i])) {
      contador++;
    }
  }
  return contador;
}
```

**Dica:** Dentro do laço, chame ehPar(v[i]) na condição do if.

**Solução comentada:** O laço percorre o array e, para cada elemento, chama ehPar; um contador soma 1 quando ela devolve true.

---

## Lição 4 — Parâmetros

**Foco:** Receber dados de fora para dentro da função

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Até agora, nossas funções faziam sempre a mesma coisa. Com parâmetros, a função recebe informações de fora e pode trabalhar com valores diferentes a cada chamada.
> 
> Parâmetros são as variáveis listadas entre parênteses na declaração da função:
> 
> function saudar(nome) {
>   console.log("Oi, " + nome);
> }
> 
> Aqui, nome é um parâmetro. Dentro da função, ele funciona como uma variável comum, que começa valendo o que foi enviado na chamada.
> 
> Uma função pode ter vários parâmetros, separados por vírgula: function area(base, altura). A ordem importa: o primeiro valor enviado vai para o primeiro parâmetro, o segundo para o segundo, e assim por diante.
> 
> Outro detalhe importante: o parâmetro é uma variável local da função. Se você alterar o parâmetro dentro da função, a variável original, de fora, não muda (para números, textos e booleanos).
> 
> Pense no parâmetro como um espaço reservado na receita: "coloque X colheres de açúcar". O valor de X só é conhecido na hora de preparar.

### Exemplo

```
function mostrar(nome) {
  console.log("Oi, " + nome);
}

mostrar("Ana");
mostrar("Bia");

Passo a passo:
1. nome é o parâmetro de mostrar: um espaço que receberá um valor.
2. Na primeira chamada, nome vale "Ana" e o programa mostra Oi, Ana.
3. Na segunda chamada, nome vale "Bia" e o programa mostra Oi, Bia.

A mesma função, com resultados diferentes.
```

### Revisão

- Parâmetros são as variáveis entre parênteses na declaração da função.
- Eles recebem os valores enviados na chamada, pela ordem.
- Uma função pode ter vários parâmetros, separados por vírgula.
- O parâmetro é local: alterá-lo não muda a variável de fora (números, textos e booleanos).
- Parâmetros tornam a função flexível: o mesmo código trabalha com valores diferentes.

### Exercícios

#### 1. O que é um parâmetro?

*Múltipla escolha · fácil · id `par-o-que-e` · conceitos: Parâmetros (peso 3); Argumentos (peso 1)*

O que é um parâmetro?

- ✗ O valor enviado na chamada da função — *confusão: confunde parâmetro com argumento*
- ✗ O resultado que a função devolve — *confusão: confunde parâmetro com retorno*
- ✔ **Uma variável listada nos parênteses da declaração, que recebe o valor da chamada** (correta)
- ✗ O nome da função — *confusão: acha que o parâmetro é o nome da função*

**Dica:** Ele aparece na declaração, não na chamada.

**Ao acertar:** O parâmetro é a variável da declaração; o valor enviado na chamada é o argumento.

#### 2. Oi, Ana

*Interpretação de código · fácil · id `par-oi-ana` · conceitos: Parâmetros (peso 3)*

O que o programa abaixo mostra na tela?

```
function mostrar(nome) {
  console.log("Oi, " + nome);
}
mostrar("Ana");
```

- ✗ Oi, nome — *confusão: acha que o parâmetro é mostrado como texto literal*
- ✔ **Oi, Ana** (correta)
- ✗ Oi,  — *confusão: acha que o parâmetro fica vazio na chamada*
- ✗ Ana — *confusão: acha que a função mostra só o argumento*

**Dica:** Dentro da função, nome vale o que foi enviado.

**Ao acertar:** O parâmetro nome recebe "Ana", e a mensagem fica Oi, Ana.

#### 3. Complete o parâmetro

*Completar a lacuna · fácil · id `par-complete-o-primeiro` · conceitos: Parâmetros (peso 3)*

Complete o nome do primeiro parâmetro, usado no corpo da função.

```
function somar({{1}}, b) {
  return a + b;
}
```

Respostas aceitas: lacuna 1: a

**Dica:** Olhe o que é somado no corpo.

**Ao acertar:** O corpo usa a e b, então os parâmetros precisam ter esses nomes.

#### 4. A ordem importa

*Interpretação de código · médio · id `par-ordem-importa` · conceitos: Parâmetros (peso 3); Argumentos (peso 2)*

O que o programa abaixo mostra na tela?

```
function dividir(a, b) {
  return a / b;
}
console.log(dividir(10, 2));
```

- ✗ 0.2 — *confusão: troca a ordem: calcula 2 dividido por 10*
- ✗ 10 — *confusão: acha que a função devolve só o primeiro parâmetro*
- ✗ 12 — *confusão: soma os parâmetros em vez de dividir*
- ✔ **5** (correta)

**Dica:** O primeiro valor vai para a e o segundo para b.

**Ao acertar:** a vale 10 e b vale 2: 10 / 2 = 5.

#### 5. Área do retângulo

*Código · fácil · id `par-area-do-retangulo` · conceitos: Parâmetros (peso 3); Operadores aritméticos (peso 1)*

Escreva a função `area(base, altura)` que devolve a área do retângulo (base vezes altura).

Função: `area`

Código inicial:

```js
function area(base, altura) {
  // seu código aqui
}
```

Testes:

- entrada [3,4] → retorna 12
- entrada [5,5] → retorna 25
- entrada [0,8] → retorna 0

Solução de referência:

```js
function area(base, altura) {
  return base * altura;
}
```

**Dica:** Use os dois parâmetros na conta.

**Solução comentada:** A função multiplica base por altura.

#### 6. Média de três

*Código · médio · id `par-media-de-tres` · conceitos: Parâmetros (peso 3); Precedência dos operadores (peso 2)*

Escreva a função `mediaDeTres(a, b, c)` que devolve a média aritmética dos três números.

Função: `mediaDeTres`

Código inicial:

```js
function mediaDeTres(a, b, c) {
  // seu código aqui
}
```

Testes:

- entrada [4,6,8] → retorna 6
- entrada [10,10,10] → retorna 10
- entrada [0,0,9] → retorna 3

Solução de referência:

```js
function mediaDeTres(a, b, c) {
  return (a + b + c) / 3;
}
```

**Dica:** Não esqueça dos parênteses na soma antes de dividir.

**Solução comentada:** (a + b + c) / 3: os parênteses garantem que a soma é feita antes da divisão.

#### 7. Corrija o parâmetro

*Corrigir o erro · médio · id `par-corrija-o-parametro` · conceitos: Parâmetros (peso 3)*

A função `calcularArea(base, altura)` deveria devolver a área do retângulo, mas ignora um dos parâmetros. Corrija o defeito.

Função: `calcularArea`

Código inicial:

```js
function calcularArea(base, altura) {
  return base * base;
}
```

Testes:

- entrada [3,4] → retorna 12
- entrada [5,2] → retorna 10
- entrada [6,6] → retorna 36

Solução de referência:

```js
function calcularArea(base, altura) {
  return base * altura;
}
```

**Dica:** Todos os parâmetros estão sendo usados?

**Solução comentada:** O corpo usava base duas vezes e deixava altura de fora. O correto é base * altura.

#### 8. O parâmetro é uma cópia

*Interpretação de código · difícil · id `par-parametro-e-copia` · conceitos: Parâmetros (peso 3); Escopo local (peso 2)*

O que o programa abaixo mostra na tela?

```
function mudar(x) {
  x = x + 1;
  return x;
}
let n = 5;
mudar(n);
console.log(n);
```

- ✔ **5** (correta)
- ✗ 6 — *confusão: acha que alterar o parâmetro altera a variável de fora*
- ✗ 1 — *confusão: acha que a chamada zera a variável original*
- ✗ undefined — *confusão: acha que a variável n deixa de existir depois da chamada*

**Dica:** O parâmetro x é uma variável da função, separada de n.

**Ao acertar:** x recebe uma cópia do valor de n. Alterar x não muda n, que continua valendo 5.

---

## Lição 5 — Argumentos

**Foco:** Enviar valores na chamada da função

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Argumentos são os valores que enviamos na chamada da função. Eles preenchem os parâmetros, pela ordem.
> 
> function somar(a, b) {      // a e b: parâmetros
>   return a + b;
> }
> somar(2, 3);                // 2 e 3: argumentos
> 
> Resumindo a diferença: o parâmetro é o espaço da declaração; o argumento é o valor da chamada.
> 
> Os argumentos podem ser valores, variáveis ou expressões. As expressões são resolvidas antes de a função executar: somar(1 + 1, 3) envia 2 e 3.
> 
> O que acontece se a quantidade não bater?
> - Faltou argumento: o parâmetro correspondente vale undefined. Em contas, isso produz NaN.
> - Sobrou argumento: o valor extra é ignorado.
> 
> A correspondência é por posição, não por nome. Os nomes das variáveis que você usa na chamada não precisam ser iguais aos dos parâmetros:
> 
> const x = 5; const y = 2;
> somar(y, x);   // envia 2 e 5; a recebe 2 e b recebe 5
> 
> Por isso, a ordem dos argumentos é um detalhe que muda o resultado (em subtrações e divisões, por exemplo).

### Exemplo

```
function diferenca(a, b) {
  return a - b;
}

const x = 5;
const y = 2;
console.log(diferenca(x, y));
console.log(diferenca(y, x));

Passo a passo:
1. diferenca(x, y) envia 5 e 2: a vale 5, b vale 2 e o resultado é 3.
2. diferenca(y, x) envia 2 e 5: a vale 2, b vale 5 e o resultado é -3.

Os nomes x e y não importam: o que conta é a posição de cada argumento.
```

### Revisão

- Argumento: o valor enviado na chamada; parâmetro: a variável da declaração.
- Os argumentos preenchem os parâmetros pela ordem (posição), não pelo nome.
- Podem ser valores, variáveis ou expressões (resolvidas antes).
- Argumento faltando: o parâmetro vira undefined (e contas dão NaN).
- Argumento sobrando: é ignorado.

### Exercícios

#### 1. Parâmetro ou argumento?

*Múltipla escolha · fácil · id `arg-parametro-ou-argumento` · conceitos: Argumentos (peso 3); Parâmetros (peso 2)*

Em function f(a) { ... } e na chamada f(10), qual afirmação é correta?

- ✗ a é um argumento e 10 é um parâmetro — *confusão: troca os conceitos de parâmetro e argumento*
- ✗ a e 10 são parâmetros — *confusão: acha que tudo que aparece nos parênteses é parâmetro*
- ✔ **a é um parâmetro e 10 é um argumento** (correta)
- ✗ a e 10 são argumentos — *confusão: acha que tudo que aparece nos parênteses é argumento*

**Dica:** O parâmetro fica na declaração; o argumento, na chamada.

**Ao acertar:** a é o parâmetro (variável da declaração) e 10 é o argumento (valor enviado na chamada).

#### 2. Argumento é uma conta

*Interpretação de código · fácil · id `arg-expressao` · conceitos: Argumentos (peso 3); Precedência dos operadores (peso 1)*

O que o programa abaixo mostra na tela?

```
function dobro(n) {
  return n * 2;
}
console.log(dobro(2 + 3));
```

- ✗ 7 — *confusão: multiplica só o 3 por 2 e soma o 2, sem resolver o argumento antes*
- ✔ **10** (correta)
- ✗ 5 — *confusão: acha que a função não dobra o valor recebido*
- ✗ 4 — *confusão: usa apenas o primeiro número do argumento*

**Dica:** O argumento 2 + 3 é calculado antes da função executar.

**Ao acertar:** O argumento vale 5 antes de entrar na função, e dobro(5) devolve 10.

#### 3. Complete o argumento

*Completar a lacuna · fácil · id `arg-complete-o-segundo` · conceitos: Argumentos (peso 3)*

Complete o segundo argumento para que o resultado seja 7.

```
function somar(a, b) {
  return a + b;
}
const resultado = somar(2, {{1}});
```

Respostas aceitas: lacuna 1: 5

**Dica:** 2 + ? = 7.

**Ao acertar:** Com o segundo argumento 5, a soma 2 + 5 resulta em 7.

#### 4. Argumento faltando

*Interpretação de código · médio · id `arg-faltando` · conceitos: Argumentos (peso 3); Parâmetros (peso 2)*

O que o programa abaixo mostra na tela?

```
function somar(a, b) {
  return a + b;
}
console.log(somar(1));
```

- ✗ 1 — *confusão: acha que o parâmetro sem valor conta como zero*
- ✗ 0 — *confusão: acha que um argumento faltando vale zero*
- ✗ Erro e o programa para — *confusão: acha que faltar um argumento causa erro*
- ✔ **NaN** (correta)

**Dica:** Que valor tem o parâmetro b quando não recebe nada?

**Ao acertar:** b vale undefined. A conta 1 + undefined resulta em NaN.

#### 5. Argumentos sobrando

*Interpretação de código · médio · id `arg-sobrando` · conceitos: Argumentos (peso 3)*

O que o programa abaixo mostra na tela?

```
function mostrar(a) {
  console.log(a);
}
mostrar(1, 2, 3);
```

- ✔ **1** (correta)
- ✗ 1 2 3 — *confusão: acha que todos os argumentos aparecem mesmo sem parâmetro*
- ✗ 3 — *confusão: acha que o último argumento é o que vale*
- ✗ undefined — *confusão: acha que o excesso de argumentos anula o valor*

**Dica:** Quantos parâmetros a função tem?

**Ao acertar:** Só existe o parâmetro a, que recebe o primeiro argumento. Os outros são ignorados.

#### 6. Potência

*Código · médio · id `arg-potencia` · conceitos: Argumentos (peso 3); Estrutura for (peso 2); Acumuladores (peso 2)*

Escreva a função `potencia(base, expoente)` que devolve a base elevada ao expoente (inteiro, maior ou igual a zero), usando um laço (sem o operador **). Qualquer número elevado a 0 é 1.

Função: `potencia`

Código inicial:

```js
function potencia(base, expoente) {
  // seu código aqui
}
```

Testes:

- entrada [2,3] → retorna 8
- entrada [5,0] → retorna 1
- entrada [3,1] → retorna 3
- entrada [10,4] → retorna 10000

Solução de referência:

```js
function potencia(base, expoente) {
  let resultado = 1;
  for (let i = 0; i < expoente; i++) {
    resultado *= base;
  }
  return resultado;
}
```

**Dica:** Multiplique um acumulador que começa em 1, expoente vezes.

**Solução comentada:** Um acumulador começa em 1 e é multiplicado pela base a cada volta, expoente vezes.

#### 7. Corrija a ordem

*Corrigir o erro · médio · id `arg-corrija-a-ordem` · conceitos: Argumentos (peso 3); Parâmetros (peso 2)*

A função `faltaPara10(n)` deveria devolver quanto falta para chegar a 10 (por exemplo, 7 para n = 3), mas devolve o valor com o sinal trocado. Corrija o defeito.

Função: `faltaPara10`

Código inicial:

```js
function diferenca(a, b) {
  return a - b;
}

function faltaPara10(n) {
  return diferenca(n, 10);
}
```

Testes:

- entrada [3] → retorna 7
- entrada [10] → retorna 0
- entrada [0] → retorna 10

Solução de referência:

```js
function diferenca(a, b) {
  return a - b;
}

function faltaPara10(n) {
  return diferenca(10, n);
}
```

**Dica:** O primeiro argumento vai para a, o segundo para b: qual deve ser o minuendo?

**Solução comentada:** A ordem dos argumentos estava invertida. diferenca(10, n) calcula 10 - n.

#### 8. Por posição, não por nome

*Interpretação de código · difícil · id `arg-por-posicao` · conceitos: Argumentos (peso 3); Parâmetros (peso 2)*

O que o programa abaixo mostra na tela?

```
function f(a, b) {
  return a - b;
}
const x = 5;
const y = 2;
console.log(f(y, x));
```

- ✗ 3 — *confusão: acha que os nomes x e y têm relação com os parâmetros a e b*
- ✗ 7 — *confusão: soma os argumentos em vez de subtrair*
- ✔ **-3** (correta)
- ✗ 2 — *confusão: acha que a função devolve o primeiro argumento*

**Dica:** O primeiro argumento (y) vai para a; o segundo (x) vai para b.

**Ao acertar:** f(y, x) envia 2 e 5: a vale 2, b vale 5 e 2 - 5 = -3.

---

## Lição 6 — Retorno com return

**Foco:** Devolver o resultado da função

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O comando return devolve um valor para quem chamou a função e encerra a função na hora.
> 
> function dobro(n) {
>   return n * 2;
> }
> const r = dobro(4);   // r recebe 8
> 
> Três pontos para não esquecer:
> 
> 1. Devolver é diferente de mostrar. console.log mostra um valor na tela, mas o valor se perde; return entrega o valor ao programa, que pode guardá-lo, somá-lo, compará-lo. Uma função que só usa console.log devolve undefined.
> 
> 2. Sem return, a função devolve undefined. Calcular n * 2 sem return não faz nada útil.
> 
> 3. Depois do return, a função termina: nenhuma linha seguinte é executada. Por isso podemos usar return dentro de um if ou de um laço para sair assim que o resultado é conhecido:
> 
> function primeiroPar(v) {
>   for (let i = 0; i < v.length; i++) {
>     if (v[i] % 2 === 0) {
>       return v[i];
>     }
>   }
>   return -1;
> }
> 
> Cada caminho possível da função deveria terminar em um return, para que ela sempre devolva algo.

### Exemplo

```
function f(n) {
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

O console.log mostrou 3 (efeito colateral); o return entregou 6 ao programa.
```

### Revisão

- return devolve um valor a quem chamou e encerra a função.
- console.log mostra na tela; return entrega o valor ao programa. Não são a mesma coisa.
- Sem return, a função devolve undefined.
- O que vem depois do return não executa.
- Use return dentro de if e laços para sair assim que o resultado for conhecido.

### Exercícios

#### 1. O que o return faz?

*Múltipla escolha · fácil · id `ret-o-que-faz` · conceitos: Retorno com return (peso 3)*

O que o comando return faz?

- ✗ Mostra um valor na tela — *confusão: confunde return com console.log*
- ✔ **Devolve um valor a quem chamou a função e encerra a função** (correta)
- ✗ Repete a função — *confusão: acha que return volta ao início da função*
- ✗ Apaga a variável — *confusão: acha que return remove uma variável*

**Dica:** Pense em entregar o resultado.

**Ao acertar:** return entrega o valor ao ponto onde a função foi chamada e termina a função.

#### 2. Guardando o resultado

*Interpretação de código · fácil · id `ret-guardar-o-resultado` · conceitos: Retorno com return (peso 3); Chamada de funções (peso 2)*

O que o programa abaixo mostra na tela?

```
function dobro(n) {
  return n * 2;
}
const r = dobro(4);
console.log(r);
```

- ✗ 4 — *confusão: acha que a função devolve o argumento sem alterar*
- ✗ undefined — *confusão: acha que a variável r não recebe o valor devolvido*
- ✗ dobro(4) — *confusão: acha que r guarda o texto da chamada*
- ✔ **8** (correta)

**Dica:** r recebe o valor devolvido pela função.

**Ao acertar:** dobro(4) devolve 8 e esse valor é guardado em r.

#### 3. Complete o retorno

*Completar a lacuna · fácil · id `ret-complete-o-comando` · conceitos: Retorno com return (peso 3)*

Complete a palavra que devolve a soma.

```
function somar(a, b) {
  {{1}} a + b;
}
```

Respostas aceitas: lacuna 1: return

**Dica:** Em inglês, "retornar".

**Ao acertar:** return devolve o resultado da soma a quem chamou a função.

#### 4. Sem return

*Interpretação de código · médio · id `ret-sem-return` · conceitos: Retorno com return (peso 3)*

O que o programa abaixo mostra na tela?

```
function dobro(n) {
  n * 2;
}
console.log(dobro(4));
```

- ✔ **undefined** (correta)
- ✗ 8 — *confusão: acha que a função devolve o resultado da última conta sozinha*
- ✗ 4 — *confusão: acha que a função devolve o argumento*
- ✗ Erro e o programa para — *confusão: acha que faltar o return é erro de execução*

**Dica:** A função tem algum return?

**Ao acertar:** Sem return, a função devolve undefined. A conta n * 2 é feita e descartada.

#### 5. Depois do return

*Interpretação de código · médio · id `ret-apos-o-return` · conceitos: Retorno com return (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
function f() {
  return 1;
  console.log("x");
}
console.log(f());
```

- ✗ x / 1 — *confusão: acha que as linhas depois do return também executam*
- ✗ x — *confusão: acha que a função mostra o texto e esquece o return*
- ✔ **1** (correta)
- ✗ undefined — *confusão: acha que o valor do return é descartado*

**Dica:** O que acontece com as linhas depois de um return?

**Ao acertar:** O return encerra a função na hora: o console.log("x") nunca executa. Mostra só o 1 devolvido.

#### 6. Maior de idade?

*Código · fácil · id `ret-maior-de-idade` · conceitos: Retorno com return (peso 3); Operadores relacionais (peso 1)*

Escreva a função `ehMaiorDeIdade(idade)` que devolve true se a idade for 18 ou mais e false caso contrário.

Função: `ehMaiorDeIdade`

Código inicial:

```js
function ehMaiorDeIdade(idade) {
  // seu código aqui
}
```

Testes:

- entrada [18] → retorna true
- entrada [17] → retorna false
- entrada [40] → retorna true
- entrada [0] → retorna false

Solução de referência:

```js
function ehMaiorDeIdade(idade) {
  return idade >= 18;
}
```

**Dica:** A própria comparação já é um valor true ou false.

**Solução comentada:** return idade >= 18 devolve o resultado da comparação.

#### 7. Mostrar não é devolver

*Corrigir o erro · médio · id `ret-corrija-o-return` · conceitos: Retorno com return (peso 3)*

A função `dobro(n)` deveria devolver o dobro de n, mas só o mostra na tela (e devolve undefined). Corrija o defeito.

Função: `dobro`

Código inicial:

```js
function dobro(n) {
  console.log(n * 2);
}
```

Testes:

- entrada [4] → retorna 8
- entrada [0] → retorna 0
- entrada [-3] → retorna -6

Solução de referência:

```js
function dobro(n) {
  return n * 2;
}
```

**Dica:** Quem chamou a função consegue guardar o que foi mostrado na tela?

**Solução comentada:** console.log só mostra o valor. Para entregá-lo a quem chamou, use return n * 2.

#### 8. Classificar a nota

*Código · médio · id `ret-classificar-nota` · conceitos: Retorno com return (peso 3); Estrutura else if (peso 2)*

Escreva a função `classificar(nota)` que devolve "aprovado" para nota 7 ou mais, "recuperacao" para nota de 5 até menos de 7 e "reprovado" para menos de 5. Use return dentro dos if.

Função: `classificar`

Código inicial:

```js
function classificar(nota) {
  // seu código aqui
}
```

Testes:

- entrada [9] → retorna "aprovado"
- entrada [7] → retorna "aprovado"
- entrada [6] → retorna "recuperacao"
- entrada [5] → retorna "recuperacao"
- entrada [4.9] → retorna "reprovado"

Solução de referência:

```js
function classificar(nota) {
  if (nota >= 7) {
    return "aprovado";
  } else if (nota >= 5) {
    return "recuperacao";
  } else {
    return "reprovado";
  }
}
```

**Dica:** Cada caminho do if pode terminar com um return.

**Solução comentada:** Os if/else if devolvem o texto da faixa correspondente e o return encerra a função.

#### 9. Mostrar e devolver

*Interpretação de código · difícil · id `ret-mostrar-e-devolver` · conceitos: Retorno com return (peso 3); Utilização de console.log() (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
function f(n) {
  console.log(n);
  return n * 2;
}
const r = f(3);
console.log(r);
```

- ✗ 6 — *confusão: esquece que o console.log dentro da função também mostra o valor*
- ✔ **3 / 6** (correta)
- ✗ 3 — *confusão: acha que o return mostra o valor na tela*
- ✗ 3 / 3 — *confusão: acha que o valor devolvido é igual ao argumento*

**Dica:** A função mostra e devolve: são duas coisas diferentes.

**Ao acertar:** Dentro de f, o console.log mostra 3. O return entrega 6, guardado em r e mostrado depois.

#### 10. Primeiro par

*Código · difícil · id `ret-primeiro-par` · conceitos: Retorno com return (peso 3); Percorrer arrays com for (peso 2); Estrutura if (peso 1)*

Escreva a função `primeiroPar(v)` que devolve o primeiro número par do array `v`, ou -1 se não houver nenhum. Use return dentro do laço para sair assim que achar.

Função: `primeiroPar`

Código inicial:

```js
function primeiroPar(v) {
  // seu código aqui
}
```

Testes:

- entrada [[3,5,8,10]] → retorna 8
- entrada [[1,3,5]] → retorna -1
- entrada [[]] → retorna -1
- entrada [[4]] → retorna 4

Solução de referência:

```js
function primeiroPar(v) {
  for (let i = 0; i < v.length; i++) {
    if (v[i] % 2 === 0) {
      return v[i];
    }
  }
  return -1;
}
```

**Dica:** Dentro do laço, ao achar um par, devolva-o; depois do laço, devolva -1.

**Solução comentada:** O return dentro do if encerra a função no primeiro par. Se o laço termina sem achar, o return -1 final é executado.

---

## Lição 7 — Funções com parâmetros e retornos

**Foco:** Combinar entrada e saída para criar funções reutilizáveis

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> As funções mais úteis combinam as duas ideias: recebem dados por parâmetros e devolvem o resultado com return. É como uma máquina: você coloca ingredientes na entrada (parâmetros) e recebe o produto na saída (retorno), sem precisar saber como ela funciona por dentro.
> 
> function calcularTotal(preco, quantidade) {
>   return preco * quantidade;
> }
> 
> Uma função assim é reutilizável porque:
> - usa só o que recebeu por parâmetros (não depende de variáveis soltas pelo programa);
> - devolve o resultado em vez de apenas mostrá-lo;
> - sempre dá a mesma resposta para os mesmos argumentos.
> 
> Como o retorno é um valor, ele pode alimentar outra função:
> 
> console.log(dobro(soma(1, 2)));   // soma devolve 3; dobro devolve 6
> 
> Montar o programa em funções pequenas que se encaixam é a base da modularização: cada função resolve um pedaço do problema e o programa final junta os pedaços.
> 
> Cuidado: se a função tiver vários caminhos (if, else), todos devem terminar em um return. Um caminho sem return devolve undefined.

### Exemplo

```
function media(a, b) {
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

Duas funções pequenas, cada uma com uma tarefa, resolvem o problema juntas.
```

### Revisão

- Parâmetros levam dados para dentro; return traz o resultado para fora.
- Uma função reutilizável depende só dos parâmetros e devolve o resultado.
- O retorno de uma função pode ser usado como argumento de outra.
- Todos os caminhos da função devem terminar em um return.
- Modularizar é dividir o problema em funções pequenas que se encaixam.

### Exercícios

#### 1. Função reutilizável

*Múltipla escolha · fácil · id `pr-o-que-torna-reutilizavel` · conceitos: Funções com parâmetros e retornos (peso 3)*

O que torna uma função fácil de reutilizar em vários lugares?

- ✗ Usar variáveis soltas do programa em vez de parâmetros — *confusão: acha que depender de variáveis externas facilita o reaproveitamento*
- ✗ Só mostrar o resultado na tela com console.log — *confusão: confunde mostrar com devolver o resultado*
- ✗ Ter o maior número possível de instruções — *confusão: acha que funções maiores são mais reutilizáveis*
- ✔ **Receber os dados por parâmetros e devolver o resultado com return** (correta)

**Dica:** Pense em uma máquina com entrada e saída.

**Ao acertar:** Com parâmetros e return, a função funciona com quaisquer valores e entrega o resultado a quem a chamar.

#### 2. Média de dois

*Interpretação de código · fácil · id `pr-media` · conceitos: Funções com parâmetros e retornos (peso 3); Precedência dos operadores (peso 1)*

O que o programa abaixo mostra na tela?

```
function media(a, b) {
  return (a + b) / 2;
}
console.log(media(4, 8));
```

- ✔ **6** (correta)
- ✗ 12 — *confusão: soma os valores e esquece de dividir*
- ✗ 10 — *confusão: calcula 4 + 8 / 2 sem os parênteses*
- ✗ 2 — *confusão: divide só o primeiro parâmetro por 2*

**Dica:** Os parênteses fazem a soma acontecer primeiro.

**Ao acertar:** (4 + 8) / 2 = 6.

#### 3. Complete o retorno

*Completar a lacuna · fácil · id `pr-complete-o-retorno` · conceitos: Funções com parâmetros e retornos (peso 3); Estrutura if (peso 1)*

Complete o valor devolvido quando a é maior que b.

```
function maior(a, b) {
  if (a > b) {
    return {{1}};
  }
  return b;
}
```

Respostas aceitas: lacuna 1: a

**Dica:** Se a é maior, é ele que a função deve devolver.

**Ao acertar:** Quando a > b, devolvemos a; caso contrário, o return final devolve b.

#### 4. Total da compra

*Código · médio · id `pr-calcular-total` · conceitos: Funções com parâmetros e retornos (peso 3); Estrutura if/else (peso 2); Operadores aritméticos (peso 1)*

Escreva a função `calcularTotal(preco, quantidade)` que devolve o total da compra. Se a quantidade for 10 ou mais, o cliente ganha 10% de desconto sobre o total.

Função: `calcularTotal`

Código inicial:

```js
function calcularTotal(preco, quantidade) {
  // seu código aqui
}
```

Testes:

- entrada [5,2] → retorna 10
- entrada [5,10] → retorna 45
- entrada [2.5,4] → retorna 10
- entrada [0,20] → retorna 0

Solução de referência:

```js
function calcularTotal(preco, quantidade) {
  let total = preco * quantidade;
  if (quantidade >= 10) {
    total = total - total / 10;
  }
  return total;
}
```

**Dica:** Calcule o total primeiro; depois aplique o desconto se a quantidade chegar a 10.

**Solução comentada:** O total é preco * quantidade. Com 10 ou mais, subtrai-se 10% dele; os dois caminhos terminam em return.

#### 5. Vogais com uma ajudante

*Código · médio · id `pr-contar-vogais-com-ajudante` · conceitos: Funções com parâmetros e retornos (peso 3); Percorrer arrays com for (peso 1); Contadores (peso 2)*

A função `ehVogal(letra)` já existe. Escreva a função `contarVogais(texto)` que devolve quantas vogais o texto tem, usando `ehVogal`.

Função: `contarVogais`

Código inicial:

```js
function ehVogal(letra) {
  return "aeiou".includes(letra.toLowerCase());
}

function contarVogais(texto) {
  // seu código aqui
}
```

Testes:

- entrada ["banana"] → retorna 3
- entrada ["Ola"] → retorna 2
- entrada ["sky"] → retorna 0
- entrada [""] → retorna 0

Solução de referência:

```js
function ehVogal(letra) {
  return "aeiou".includes(letra.toLowerCase());
}

function contarVogais(texto) {
  let vogais = 0;
  for (let i = 0; i < texto.length; i++) {
    if (ehVogal(texto[i])) {
      vogais++;
    }
  }
  return vogais;
}
```

**Dica:** Percorra o texto e conte quando ehVogal(texto[i]) for true.

**Solução comentada:** O laço percorre as letras e um contador soma 1 sempre que ehVogal devolve true.

#### 6. Resultado como argumento

*Interpretação de código · médio · id `pr-composicao` · conceitos: Funções com parâmetros e retornos (peso 3); Chamada de funções (peso 2)*

O que o programa abaixo mostra na tela?

```
function soma(a, b) {
  return a + b;
}
function dobro(n) {
  return n * 2;
}
console.log(dobro(soma(1, 2)));
```

- ✗ 5 — *confusão: dobra só o segundo argumento e soma com o primeiro*
- ✗ 3 — *confusão: esquece de aplicar a função dobro*
- ✔ **6** (correta)
- ✗ 4 — *confusão: dobra o 1 e soma 2 sem resolver a chamada de dentro*

**Dica:** Resolva primeiro a chamada de dentro.

**Ao acertar:** soma(1, 2) devolve 3; dobro(3) devolve 6.

#### 7. Um caminho sem retorno

*Corrigir o erro · médio · id `pr-corrija-o-caminho` · conceitos: Funções com parâmetros e retornos (peso 3); Retorno com return (peso 3)*

A função `ehPar(n)` deveria devolver true para pares e false para ímpares, mas devolve undefined para os ímpares. Corrija o defeito.

Função: `ehPar`

Código inicial:

```js
function ehPar(n) {
  if (n % 2 === 0) {
    return true;
  }
}
```

Testes:

- entrada [4] → retorna true
- entrada [7] → retorna false
- entrada [0] → retorna true
- entrada [-3] → retorna false

Solução de referência:

```js
function ehPar(n) {
  if (n % 2 === 0) {
    return true;
  }
  return false;
}
```

**Dica:** O que a função devolve quando o if não entra?

**Solução comentada:** Quando n é ímpar, nenhum return é executado e a função devolve undefined. Falta devolver false nesse caminho.

#### 8. Funções e ternário

*Interpretação de código · difícil · id `pr-duas-funcoes-com-ternario` · conceitos: Funções com parâmetros e retornos (peso 3); Operador ternário (conteúdo complementar) (peso 1); Chamada de funções (peso 2)*

O que o programa abaixo mostra na tela?

```
function f(x) {
  return x > 5 ? "alto" : "baixo";
}
function g(x) {
  return f(x) + f(x + 5);
}
console.log(g(1));
```

- ✗ baixobaixo — *confusão: usa x = 1 nas duas chamadas e esquece o x + 5*
- ✔ **baixoalto** (correta)
- ✗ altoalto — *confusão: avalia as duas chamadas como "alto"*
- ✗ altobaixo — *confusão: inverte a ordem das duas chamadas*

**Dica:** Calcule f(1) e f(6) separadamente.

**Ao acertar:** f(1) devolve "baixo" (1 não é maior que 5) e f(6) devolve "alto". Os textos são juntados: baixoalto.

#### 9. Menor e maior

*Código · difícil · id `pr-menor-e-maior` · conceitos: Funções com parâmetros e retornos (peso 3); Percorrer arrays com for (peso 2); Arrays em JavaScript (peso 1)*

Escreva a função `menorEMaior(v)` que devolve um array com dois elementos: o menor e o maior valor do array `v` (que tem pelo menos 1 elemento). Por exemplo, menorEMaior([3, 1, 2]) devolve [1, 3].

Função: `menorEMaior`

Código inicial:

```js
function menorEMaior(v) {
  // seu código aqui
}
```

Testes:

- entrada [[3,1,2]] → retorna [1,3]
- entrada [[5]] → retorna [5,5]
- entrada [[-1,-9,4]] → retorna [-9,4]
- entrada [[2,2,2]] → retorna [2,2]

Solução de referência:

```js
function menorEMaior(v) {
  let menor = v[0];
  let maior = v[0];
  for (let i = 1; i < v.length; i++) {
    if (v[i] < menor) {
      menor = v[i];
    }
    if (v[i] > maior) {
      maior = v[i];
    }
  }
  return [menor, maior];
}
```

**Dica:** Guarde o menor e o maior vistos até agora, começando pelo primeiro elemento.

**Solução comentada:** O laço atualiza o menor e o maior valor; no final, a função devolve os dois em um array.

---

## Lição 8 — Escopo global

**Foco:** Entender variáveis visíveis em todo o programa

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O escopo é a região do programa onde uma variável pode ser usada. Uma variável declarada fora de qualquer função tem escopo global: ela existe em todo o programa e pode ser lida por qualquer função.
> 
> const taxa = 0.1;                 // global
> 
> function imposto(valor) {
>   return valor * taxa;            // a função enxerga taxa
> }
> 
> Funções podem não só ler, mas também alterar variáveis globais:
> 
> let contador = 0;
> function incrementar() {
>   contador = contador + 1;        // altera a variável de fora
> }
> 
> Isso funciona, mas traz riscos. Quando uma variável pode ser mudada por qualquer função, fica difícil saber quem a alterou e quando. É a origem de muitos erros difíceis de achar: duas funções mexendo na mesma variável sem se darem conta.
> 
> A prática recomendada:
> - use constantes globais para valores que nunca mudam (const taxa = 0.1);
> - passe os dados que a função precisa por parâmetros e devolva o resultado com return, em vez de alterar variáveis globais;
> - evite que funções dependam de valores soltos pelo programa.

### Exemplo

```
let n = 1;

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

Como a função mexeu na variável global, o valor ficou "lembrado" entre as chamadas.
```

### Revisão

- Escopo global: variável declarada fora de qualquer função, visível em todo o programa.
- Funções podem ler e também alterar variáveis globais.
- Alterar globais dentro de funções é arriscado: qualquer parte do programa pode mudar o valor sem querer.
- Prefira passar dados por parâmetros e devolver com return.
- Constantes globais (const) são seguras para valores que não mudam.

### Exercícios

#### 1. O que é uma variável global?

*Múltipla escolha · fácil · id `glob-o-que-e` · conceitos: Escopo global (peso 3)*

O que é uma variável global?

- ✗ Uma variável declarada dentro de uma função — *confusão: confunde variável global com variável local*
- ✗ Uma variável que só existe durante uma chamada da função — *confusão: descreve uma variável local, não uma global*
- ✗ Um parâmetro de uma função — *confusão: acha que todo parâmetro é global*
- ✔ **Uma variável declarada fora de qualquer função, visível em todo o programa** (correta)

**Dica:** Onde ela é declarada?

**Ao acertar:** A variável global é declarada fora das funções e pode ser usada em qualquer parte do programa.

#### 2. Lendo uma global

*Interpretação de código · fácil · id `glob-ler-uma-global` · conceitos: Escopo global (peso 3)*

O que o programa abaixo mostra na tela?

```
const taxa = 0.1;
function imposto(valor) {
  return valor * taxa;
}
console.log(imposto(100));
```

- ✔ **10** (correta)
- ✗ 100 — *confusão: acha que a função não enxerga a variável global taxa*
- ✗ 0.1 — *confusão: acha que a função devolve o valor da taxa*
- ✗ undefined — *confusão: acha que a variável global não existe dentro da função*

**Dica:** A função consegue ler a variável de fora?

**Ao acertar:** A função enxerga a variável global taxa: 100 * 0.1 = 10.

#### 3. Complete o comentário

*Completar a lacuna · fácil · id `glob-complete-o-nome` · conceitos: Escopo global (peso 3)*

Complete com o tipo de escopo da variável total.

```
// variável {{1}}: declarada fora de qualquer função
let total = 0;
```

Respostas aceitas: lacuna 1: global

**Dica:** Fora das funções, ela vale para todo o programa.

**Ao acertar:** Uma variável declarada fora de qualquer função tem escopo global.

#### 4. Alterada pela função

*Interpretação de código · médio · id `glob-alterada-pela-funcao` · conceitos: Escopo global (peso 3)*

O que o programa abaixo mostra na tela?

```
let n = 1;
function incrementar() {
  n = n + 1;
}
incrementar();
incrementar();
console.log(n);
```

- ✗ 1 — *confusão: acha que a função não consegue alterar a variável de fora*
- ✗ 2 — *confusão: acha que só a primeira chamada altera a variável*
- ✔ **3** (correta)
- ✗ 4 — *confusão: acha que cada chamada dobra o valor*

**Dica:** Cada chamada altera a mesma variável global.

**Ao acertar:** n começa em 1 e a função soma 1 a cada chamada: duas chamadas levam n a 3.

#### 5. O valor na hora da chamada

*Interpretação de código · médio · id `glob-valor-atual` · conceitos: Escopo global (peso 3)*

O que o programa abaixo mostra na tela?

```
let a = 5;
function f() {
  return a * 2;
}
a = 10;
console.log(f());
```

- ✗ 10 — *confusão: acha que a função guarda o valor de a do momento em que foi declarada*
- ✔ **20** (correta)
- ✗ 5 — *confusão: acha que a função usa o primeiro valor atribuído a a*
- ✗ 15 — *confusão: soma os dois valores de a*

**Dica:** A função lê a variável quando é chamada.

**Ao acertar:** f lê a no momento da chamada, quando a vale 10: 10 * 2 = 20.

#### 6. O risco das globais

*Múltipla escolha · médio · id `glob-risco` · conceitos: Escopo global (peso 3)*

Por que é arriscado alterar variáveis globais dentro de funções?

- ✗ Porque o JavaScript proíbe alterar variáveis globais — *confusão: acha que alterar globais é um erro da linguagem*
- ✗ Porque a função fica mais lenta a cada alteração — *confusão: acha que o risco é de desempenho*
- ✗ Porque a variável global é apagada ao fim da função — *confusão: acha que o valor alterado se perde no fim da chamada*
- ✔ **Porque qualquer parte do programa pode mudar o valor sem que percebamos, dificultando achar erros** (correta)

**Dica:** Quem mais pode estar mexendo na mesma variável?

**Ao acertar:** Com globais alteráveis, várias funções podem modificá-las sem aviso, o que torna os erros difíceis de localizar.

#### 7. Dependência escondida

*Corrigir o erro · médio · id `glob-corrija-a-dependencia` · conceitos: Escopo global (peso 3); Parâmetros (peso 2)*

A função `precoFinal(valor, taxa)` deveria somar ao valor a taxa recebida (por exemplo, 120 para valor 100 e taxa 0.2), mas usa uma variável global em vez do parâmetro. Corrija o defeito.

Função: `precoFinal`

Código inicial:

```js
let taxa = 0.1;

function precoFinal(valor, taxa2) {
  return valor + valor * taxa;
}
```

Testes:

- entrada [100,0.2] → retorna 120
- entrada [200,0.5] → retorna 300
- entrada [50,0] → retorna 50

Solução de referência:

```js
let taxa = 0.1;

function precoFinal(valor, taxa2) {
  return valor + valor * taxa2;
}
```

**Dica:** A taxa que vale é a recebida na chamada ou a global?

**Solução comentada:** A função ignorava o parâmetro e lia a variável global taxa (0.1). Usando o parâmetro, ela depende só do que recebe.

#### 8. Duas funções, uma variável

*Interpretação de código · difícil · id `glob-duas-funcoes-uma-variavel` · conceitos: Escopo global (peso 3); Chamada de funções (peso 2)*

O que o programa abaixo mostra na tela?

```
let x = 1;
function a() {
  x = x * 2;
}
function b() {
  x = x + 3;
}
a();
b();
a();
console.log(x);
```

- ✔ **10** (correta)
- ✗ 5 — *confusão: esquece a última chamada de a()*
- ✗ 8 — *confusão: calcula 1 * 2 * 2 + 3 + 1, errando a ordem das operações*
- ✗ 7 — *confusão: soma 3 duas vezes em vez de dobrar de novo*

**Dica:** Acompanhe x depois de cada chamada: 2, 5, 10.

**Ao acertar:** x vale 1; a() leva a 2; b() leva a 5; a() leva a 10.

---

## Lição 9 — Escopo local

**Foco:** Entender variáveis que só existem dentro da função

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Uma variável declarada dentro de uma função tem escopo local: ela só existe dentro daquela função, e deixa de existir quando a função termina. Os parâmetros também são variáveis locais.
> 
> function calcular(n) {
>   const dobro = n * 2;     // local: só existe aqui dentro
>   return dobro;
> }
> calcular(4);
> console.log(typeof dobro);  // "undefined": fora da função, dobro não existe
> 
> Consequências importantes:
> - Fora da função, não dá para usar uma variável local. Para levar um valor para fora, use return.
> - Cada chamada cria suas próprias variáveis locais, do zero. Um acumulador declarado dentro da função recomeça a cada chamada, e isso é bom: uma chamada não interfere na outra.
> - Duas funções podem usar o mesmo nome de variável sem conflito: cada uma tem a sua.
> - Se uma variável local tem o mesmo nome de uma global, dentro da função vale a local (ela "esconde" a global), e a global não é alterada.
> 
> O mesmo vale para blocos: uma variável declarada com let dentro de um if ou de um for só existe dentro dele (o i de um for não existe depois do laço).

### Exemplo

```
let x = 1;

function f() {
  let x = 2;
  return x;
}

console.log(f(), x);

Passo a passo:
1. Existem duas variáveis diferentes chamadas x: a global (1) e a local de f (2).
2. Dentro de f, o nome x se refere à local: a função devolve 2.
3. Fora da função, x continua sendo a global: vale 1.
4. O programa mostra 2 1.
```

### Revisão

- Variável local: declarada dentro da função; só existe nela.
- Parâmetros também são locais.
- Para levar um valor para fora, use return.
- Cada chamada cria variáveis locais novas (acumuladores recomeçam).
- Uma local com o mesmo nome de uma global a esconde, sem alterá-la.
- let em blocos (if, for) só existe dentro do bloco.

### Exercícios

#### 1. Onde existe?

*Múltipla escolha · fácil · id `loc-onde-existe` · conceitos: Escopo local (peso 3)*

Onde uma variável declarada dentro de uma função pode ser usada?

- ✗ Em qualquer parte do programa — *confusão: acha que variáveis locais são visíveis em todo o programa*
- ✗ Só na primeira linha da função — *confusão: acha que a variável vale só na linha em que foi declarada*
- ✔ **Somente dentro da própria função** (correta)
- ✗ Em todas as funções do programa — *confusão: acha que as outras funções enxergam as variáveis locais*

**Dica:** O escopo local é restrito.

**Ao acertar:** A variável local só existe dentro da função em que foi declarada.

#### 2. Valor local

*Interpretação de código · fácil · id `loc-valor-dentro` · conceitos: Escopo local (peso 3)*

O que o programa abaixo mostra na tela?

```
function f() {
  let x = 5;
  console.log(x);
}
f();
```

- ✗ undefined — *confusão: acha que a variável local não existe dentro da própria função*
- ✔ **5** (correta)
- ✗ x — *confusão: acha que o console.log mostra o nome da variável*
- ✗ Nada — *confusão: acha que a função não executa sem retorno*

**Dica:** Dentro da função, x existe.

**Ao acertar:** x é local, mas existe dentro de f: o console.log mostra 5.

#### 3. Complete o comentário

*Completar a lacuna · fácil · id `loc-complete-o-escopo` · conceitos: Escopo local (peso 3)*

Complete com o tipo de escopo da variável resultado.

```
function dobro(n) {
  const resultado = n * 2;   // variável {{1}}
  return resultado;
}
```

Respostas aceitas: lacuna 1: local

**Dica:** Ela só existe dentro da função.

**Ao acertar:** Uma variável declarada dentro da função tem escopo local.

#### 4. Fora da função

*Interpretação de código · médio · id `loc-fora-da-funcao` · conceitos: Escopo local (peso 3)*

O que o programa abaixo mostra na tela?

```
function f() {
  let msg = "oi";
}
f();
console.log(typeof msg);
```

- ✗ string — *confusão: acha que a variável local continua existindo depois da função*
- ✗ oi — *confusão: acha que typeof mostra o valor da variável*
- ✗ Erro e o programa para — *confusão: acha que typeof de uma variável inexistente causa erro*
- ✔ **undefined** (correta)

**Dica:** Depois que a função termina, a variável msg ainda existe?

**Ao acertar:** msg só existia dentro de f. Fora dela, typeof msg resulta em undefined.

#### 5. Mesmo nome, variáveis diferentes

*Interpretação de código · médio · id `loc-mesmo-nome` · conceitos: Escopo local (peso 3); Escopo global (peso 2)*

O que o programa abaixo mostra na tela?

```
let x = 1;
function f() {
  let x = 2;
  return x;
}
console.log(f(), x);
```

- ✔ **2 1** (correta)
- ✗ 2 2 — *confusão: acha que a variável local altera a global de mesmo nome*
- ✗ 1 1 — *confusão: acha que a função devolve a variável global*
- ✗ 1 2 — *confusão: inverte quem devolve o quê*

**Dica:** Dentro de f, x se refere a qual variável?

**Ao acertar:** A variável local x (2) esconde a global dentro de f. A global continua valendo 1.

#### 6. A variável do for

*Interpretação de código · médio · id `loc-variavel-do-for` · conceitos: Escopo local (peso 3); Estrutura for (peso 1)*

O que o programa abaixo mostra na tela?

```
for (let i = 0; i < 3; i++) {
}
console.log(typeof i);
```

- ✗ number — *confusão: acha que o contador do for continua existindo depois do laço*
- ✗ 3 — *confusão: acha que typeof mostra o último valor do contador*
- ✔ **undefined** (correta)
- ✗ 0 — *confusão: acha que o contador volta ao valor inicial*

**Dica:** Onde a variável i foi declarada?

**Ao acertar:** Com let no for, i só existe dentro do laço. Depois dele, typeof i é undefined.

#### 7. Variável de outra função

*Corrigir o erro · médio · id `loc-corrija-o-uso-fora` · conceitos: Escopo local (peso 3); Retorno com return (peso 2)*

A função `mostrarDobro(n)` deveria devolver o dobro de n usando a função `calcular`, mas tenta usar uma variável que só existe dentro de `calcular` e dá erro. Corrija o defeito.

Função: `mostrarDobro`

Código inicial:

```js
function calcular(n) {
  const dobro = n * 2;
  return dobro;
}

function mostrarDobro(n) {
  calcular(n);
  return dobro;
}
```

Testes:

- entrada [4] → retorna 8
- entrada [0] → retorna 0
- entrada [-1] → retorna -2

Solução de referência:

```js
function calcular(n) {
  const dobro = n * 2;
  return dobro;
}

function mostrarDobro(n) {
  return calcular(n);
}
```

**Dica:** Como levar o valor de dentro de calcular para fora dela?

**Solução comentada:** dobro é local de calcular. Para usar o valor, é preciso guardar (ou devolver) o resultado da chamada: return calcular(n).

#### 8. Acumulador que não reinicia

*Corrigir o erro · médio · id `loc-corrija-o-acumulador` · conceitos: Escopo local (peso 3); Acumuladores (peso 2)*

A função `somaDosQuadrados(n)` deveria devolver a soma dos quadrados de 1 até n (14 para n = 3), mas na segunda chamada o resultado vem acumulado com o da primeira. Corrija o defeito.

Função: `somaDosQuadrados`

Código inicial:

```js
let total = 0;

function somaDosQuadrados(n) {
  for (let i = 1; i <= n; i++) {
    total += i * i;
  }
  return total;
}
```

Testes:

- entrada [3] → retorna 14
- entrada [1] → retorna 1
- entrada [0] → retorna 0
- entrada [2] → retorna 5

Solução de referência:

```js
function somaDosQuadrados(n) {
  let total = 0;
  for (let i = 1; i <= n; i++) {
    total += i * i;
  }
  return total;
}
```

**Dica:** Onde o acumulador deveria ser declarado para recomeçar a cada chamada?

**Solução comentada:** total era global e guardava o resultado das chamadas anteriores. Declarado dentro da função, ele recomeça em 0 a cada chamada.

#### 9. O parâmetro esconde a global

*Interpretação de código · difícil · id `loc-parametro-esconde-global` · conceitos: Escopo local (peso 3); Parâmetros (peso 2); Escopo global (peso 2)*

O que o programa abaixo mostra na tela?

```
let n = 10;
function f(n) {
  n = n + 1;
  return n;
}
console.log(f(1), n);
```

- ✗ 11 11 — *confusão: acha que alterar o parâmetro altera a variável global de mesmo nome*
- ✔ **2 10** (correta)
- ✗ 2 2 — *confusão: acha que a global também passa a valer o resultado da função*
- ✗ 11 10 — *confusão: usa o valor da variável global dentro da função em vez do argumento*

**Dica:** Dentro de f, n é o parâmetro. Fora, n é a global.

**Ao acertar:** O parâmetro n recebe 1 e vira 2; isso não toca na global. A função devolve 2 e a global continua valendo 10.

---

## Lição 10 — Arrow functions

**Foco:** Conhecer uma forma mais curta de escrever funções

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Este é um conteúdo complementar: ele não bloqueia a liberação do que vem a seguir. Vale estudar, mas você pode seguir em frente sem concluí-lo.
> 
> As arrow functions ("funções seta") são uma forma mais curta de escrever funções. Em vez da palavra function, usamos uma seta (=>) e guardamos a função em uma variável:
> 
> const dobro = (n) => n * 2;
> 
> É equivalente a:
> 
> function dobro(n) {
>   return n * 2;
> }
> 
> Regras da forma curta:
> - Sem chaves, o valor depois da seta é devolvido automaticamente (retorno implícito): (n) => n * 2.
> - Com chaves { }, você precisa escrever return: (n) => { return n * 2; }. Sem o return, a função devolve undefined.
> - Com um único parâmetro, os parênteses são opcionais (n => n * 2); com vários ou nenhum, são obrigatórios: (a, b) => a + b, () => 5.
> 
> A chamada é igual à de qualquer função: dobro(4).
> 
> Quando usar? Em funções curtas, a seta deixa o código mais enxuto. Para funções maiores, a declaração com function costuma ser mais clara. O resultado é o mesmo.

### Exemplo

```
const soma = (a, b) => a + b;
const dobrar = (n) => n * 2;

console.log(dobrar(soma(1, 2)));

Passo a passo:
1. soma é uma função que recebe a e b e devolve a + b (retorno implícito, sem chaves).
2. dobrar recebe n e devolve n * 2.
3. soma(1, 2) devolve 3 e dobrar(3) devolve 6.
4. O programa mostra 6.
```

### Revisão

- Arrow function: (parâmetros) => expressão, guardada em uma variável.
- Sem chaves, o valor da expressão é devolvido automaticamente.
- Com chaves, é preciso usar return (senão devolve undefined).
- Com um só parâmetro, os parênteses são opcionais.
- É uma forma mais curta: funciona como uma função comum.

### Exercícios

#### 1. A forma equivalente

*Múltipla escolha · fácil · id `arrow-equivalente` · conceitos: Arrow functions (conteúdo complementar) (peso 3)*

Qual arrow function é equivalente a function dobro(n) { return n * 2; }?

- ✗ const dobro = (n) => { n * 2 }; — *confusão: usa chaves sem return: a função devolve undefined*
- ✗ const dobro => (n) n * 2; — *confusão: coloca a seta e os parênteses na ordem errada*
- ✗ const dobro = function => n * 2; — *confusão: mistura a palavra function com a seta*
- ✔ **const dobro = (n) => n * 2;** (correta)

**Dica:** Sem chaves, o resultado é devolvido sozinho.

**Ao acertar:** (n) => n * 2 tem retorno implícito e equivale à função com return n * 2.

#### 2. Soma com seta

*Interpretação de código · fácil · id `arrow-soma` · conceitos: Arrow functions (conteúdo complementar) (peso 3); Chamada de funções (peso 2)*

O que o programa abaixo mostra na tela?

```
const soma = (a, b) => a + b;
console.log(soma(2, 3));
```

- ✔ **5** (correta)
- ✗ 23 — *confusão: acha que os valores são juntados como texto*
- ✗ undefined — *confusão: acha que a função não devolve nada sem a palavra return*
- ✗ a + b — *confusão: acha que a função devolve o texto da expressão*

**Dica:** Sem chaves, o valor depois da seta é devolvido.

**Ao acertar:** A arrow function devolve a + b automaticamente: 2 + 3 = 5.

#### 3. Complete a seta

*Completar a lacuna · fácil · id `arrow-complete-a-seta` · conceitos: Arrow functions (conteúdo complementar) (peso 3)*

Complete o símbolo que separa os parâmetros do corpo da arrow function.

```
const triplo = (n) {{1}} n * 3;
```

Respostas aceitas: lacuna 1: => ou = >

**Dica:** É a "seta" que dá nome a este tipo de função.

**Ao acertar:** O símbolo => separa os parâmetros do que a função devolve.

#### 4. Chaves sem return

*Interpretação de código · médio · id `arrow-chaves-sem-return` · conceitos: Arrow functions (conteúdo complementar) (peso 3); Retorno com return (peso 2)*

O que o programa abaixo mostra na tela?

```
const f = (n) => { n * 2 };
console.log(f(4));
```

- ✗ 8 — *confusão: acha que o retorno implícito vale também quando há chaves*
- ✗ 4 — *confusão: acha que a função devolve o argumento*
- ✔ **undefined** (correta)
- ✗ Erro e o programa para — *confusão: acha que chaves sem return é erro de sintaxe*

**Dica:** Com chaves, a função precisa de return.

**Ao acertar:** Com chaves não há retorno implícito. Sem o return, a função devolve undefined.

#### 5. Quadrado com seta

*Código · médio · id `arrow-quadrado` · conceitos: Arrow functions (conteúdo complementar) (peso 3); Retorno com return (peso 2)*

Escreva a arrow function `quadrado` que recebe um número e devolve o quadrado dele.

Função: `quadrado`

Código inicial:

```js
const quadrado = (n) => {
  // seu código aqui
};
```

Testes:

- entrada [3] → retorna 9
- entrada [0] → retorna 0
- entrada [-4] → retorna 16

Solução de referência:

```js
const quadrado = (n) => n * n;
```

**Dica:** Com chaves, use return; sem chaves, escreva só a expressão.

**Solução comentada:** (n) => n * n devolve o quadrado de n.

#### 6. Par ou ímpar com seta

*Código · médio · id `arrow-par-ou-impar` · conceitos: Arrow functions (conteúdo complementar) (peso 3); Operador ternário (conteúdo complementar) (peso 2)*

Escreva a arrow function `parOuImpar` que recebe um número e devolve o texto "par" ou "impar".

Função: `parOuImpar`

Código inicial:

```js
const parOuImpar = (n) => {
  // seu código aqui
};
```

Testes:

- entrada [4] → retorna "par"
- entrada [7] → retorna "impar"
- entrada [0] → retorna "par"

Solução de referência:

```js
const parOuImpar = (n) => (n % 2 === 0 ? "par" : "impar");
```

**Dica:** O operador ternário cabe bem em uma arrow function curta.

**Solução comentada:** (n) => n % 2 === 0 ? "par" : "impar" devolve o texto conforme a condição.

#### 7. Corrija o retorno

*Corrigir o erro · médio · id `arrow-corrija-o-retorno` · conceitos: Arrow functions (conteúdo complementar) (peso 3); Retorno com return (peso 2)*

A função `dobro(n)` usa uma arrow function interna para calcular o dobro de n, mas devolve undefined. Corrija o defeito.

Função: `dobro`

Código inicial:

```js
function dobro(n) {
  const calcular = (x) => { x * 2 };
  return calcular(n);
}
```

Testes:

- entrada [4] → retorna 8
- entrada [0] → retorna 0
- entrada [-3] → retorna -6

Solução de referência:

```js
function dobro(n) {
  const calcular = (x) => x * 2;
  return calcular(n);
}
```

**Dica:** O que muda com as chaves: o retorno é implícito?

**Solução comentada:** Com chaves, o return é obrigatório. Basta remover as chaves ((n) => n * 2) ou escrever return n * 2.

#### 8. Compondo setas

*Interpretação de código · difícil · id `arrow-compondo` · conceitos: Arrow functions (conteúdo complementar) (peso 3); Chamada de funções (peso 2); Funções com parâmetros e retornos (peso 2)*

O que o programa abaixo mostra na tela?

```
const somar1 = (n) => n + 1;
const dobrar = (n) => n * 2;
console.log(dobrar(somar1(3)));
```

- ✗ 7 — *confusão: calcula somar1(dobrar(3)), invertendo a ordem das funções*
- ✔ **8** (correta)
- ✗ 6 — *confusão: aplica só a função dobrar ao argumento original*
- ✗ 4 — *confusão: aplica só a função somar1 e esquece de dobrar*

**Dica:** Resolva primeiro a chamada de dentro.

**Ao acertar:** somar1(3) devolve 4; dobrar(4) devolve 8.

---

## Lição 11 — Desafio final do Mundo 7

**Foco:** Montar uma calculadora organizada em funções

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Chegou o desafio final do curso: uma calculadora organizada em funções. Cada operação (somar, subtrair, multiplicar, dividir) vira uma função pequena e uma função principal escolhe qual usar. Esse é o exemplo clássico de modularização: peças simples que se encaixam.
> 
> Você vai reaproveitar tudo o que viu nos mundos anteriores: operadores (Mundo 3), decisões com if e switch (Mundo 4), leitura de entradas (Mundo 2) e, claro, funções com parâmetros e retornos (Mundo 7).
> 
> O desafio principal é o primeiro exercício. Os outros dois treinam usar uma função pronta e achar defeitos em funções que trabalham juntas.

### Exemplo

```
Como montar a calculadora:
1. Crie uma função para cada operação, com dois parâmetros e return: somar, subtrair, multiplicar e dividir.
2. Na divisão, trate o divisor zero: devolva o texto "Divisão por zero" em vez de dividir.
3. Crie a função calcular(operacao, a, b) que escolhe a função certa com if/else if ou switch.
4. Para uma operação desconhecida, devolva "Operação inválida".
5. Teste cada operação, a divisão por zero e uma operação desconhecida.

Dica: se uma função já resolve a conta, a outra só precisa chamá-la.
```

### Revisão

- Uma função por tarefa: cada operação tem a sua.
- Uma função principal decide qual usar (if/else if ou switch).
- Todos os caminhos devolvem um valor com return.
- Trate os casos especiais (divisão por zero, operação desconhecida).
- Reaproveite funções prontas chamando-as de outras funções.

### Exercícios

#### 1. Desafio: calculadora em funções

*Desafio · difícil · id `desafio7-calculadora` · conceitos: Funções com parâmetros e retornos (peso 3); Chamada de funções (peso 2); Estrutura switch (peso 2); Estrutura if/else (peso 1); Operadores aritméticos (peso 2)*

Escreva a função `calcular(operacao, a, b)` e, para organizar o código, crie também as funções `somar`, `subtrair`, `multiplicar` e `dividir` (cada uma recebe dois números e devolve o resultado). `calcular` recebe a operação ("+", "-", "*" ou "/") e devolve o resultado chamando a função certa. Divisão com divisor zero devolve o texto "Divisão por zero", e uma operação desconhecida devolve "Operação inválida".

Função: `calcular`

Código inicial:

```js
// crie aqui as funções somar, subtrair, multiplicar e dividir

function calcular(operacao, a, b) {
  // escolha a função certa e devolva o resultado
}
```

Testes:

- entrada ["+",2,3] → retorna 5
- entrada ["-",2,3] → retorna -1
- entrada ["*",4,5] → retorna 20
- entrada ["/",10,4] → retorna 2.5
- entrada ["/",5,0] → retorna "Divisão por zero"
- entrada ["%",1,2] → retorna "Operação inválida"

Solução de referência:

```js
function somar(a, b) {
  return a + b;
}

function subtrair(a, b) {
  return a - b;
}

function multiplicar(a, b) {
  return a * b;
}

function dividir(a, b) {
  if (b === 0) {
    return "Divisão por zero";
  }
  return a / b;
}

function calcular(operacao, a, b) {
  switch (operacao) {
    case "+":
      return somar(a, b);
    case "-":
      return subtrair(a, b);
    case "*":
      return multiplicar(a, b);
    case "/":
      return dividir(a, b);
    default:
      return "Operação inválida";
  }
}
```

**Dica:** Cada operação é uma função pequena; calcular só escolhe qual chamar (switch ou if/else if) e devolve o resultado.

**Solução comentada:** As quatro funções fazem as contas e dividir trata o divisor zero. calcular usa um switch (ou if/else if) para chamar a função certa e devolve o resultado, com um caminho final para operações inválidas.

#### 2. Desafio: usando a calculadora

*Desafio · difícil · id `desafio7-executar-calculadora` · conceitos: Chamada de funções (peso 3); Funções com parâmetros e retornos (peso 2); Entrada e saída de informações (peso 2); Conversão de tipos (peso 1)*

A função `calcular(operacao, a, b)` já existe. Escreva a função `executar()`: leia com `lerEntrada()` a operação, o primeiro número e o segundo número (os números chegam como texto) e mostre `Resultado: <valor>` com `console.log`, usando `calcular`.

Função: `executar`

Código inicial:

```js
function calcular(operacao, a, b) {
  switch (operacao) {
    case "+":
      return a + b;
    case "-":
      return a - b;
    case "*":
      return a * b;
    case "/":
      return b === 0 ? "Divisão por zero" : a / b;
    default:
      return "Operação inválida";
  }
}

function executar() {
  // leia as entradas e mostre o resultado
}
```

Testes:

- entrada [], lê ["+","2","3"] → imprime ["Resultado: 5"]
- entrada [], lê ["/","5","0"] → imprime ["Resultado: Divisão por zero"]
- entrada [], lê ["x","1","1"] → imprime ["Resultado: Operação inválida"]
- entrada [], lê ["*","4","2.5"] → imprime ["Resultado: 10"]

Solução de referência:

```js
function calcular(operacao, a, b) {
  switch (operacao) {
    case "+":
      return a + b;
    case "-":
      return a - b;
    case "*":
      return a * b;
    case "/":
      return b === 0 ? "Divisão por zero" : a / b;
    default:
      return "Operação inválida";
  }
}

function executar() {
  const operacao = lerEntrada();
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  console.log("Resultado:", calcular(operacao, a, b));
}
```

**Dica:** Converta os números com Number() antes de chamar calcular.

**Solução comentada:** executar lê a operação e os dois números (convertidos com Number), chama calcular e mostra o valor devolvido.

#### 3. Desafio: corrija a calculadora

*Corrigir o erro · difícil · id `desafio7-corrija-a-calculadora` · conceitos: Retorno com return (peso 3); Parâmetros (peso 2); Argumentos (peso 2); Estrutura else if (peso 1)*

A função `calcular(operacao, a, b)` deveria devolver o resultado de cada operação, mas há dois defeitos: a subtração sai com o sinal trocado e a multiplicação não devolve nada. Corrija os defeitos.

Função: `calcular`

Código inicial:

```js
function somar(a, b) {
  return a + b;
}

function subtrair(a, b) {
  return b - a;
}

function multiplicar(a, b) {
  console.log(a * b);
}

function calcular(operacao, a, b) {
  if (operacao === "+") {
    return somar(a, b);
  } else if (operacao === "-") {
    return subtrair(a, b);
  } else if (operacao === "*") {
    return multiplicar(a, b);
  }
  return "Operação inválida";
}
```

Testes:

- entrada ["+",2,3] → retorna 5
- entrada ["-",5,2] → retorna 3
- entrada ["*",4,5] → retorna 20
- entrada ["x",1,1] → retorna "Operação inválida"

Solução de referência:

```js
function somar(a, b) {
  return a + b;
}

function subtrair(a, b) {
  return a - b;
}

function multiplicar(a, b) {
  return a * b;
}

function calcular(operacao, a, b) {
  if (operacao === "+") {
    return somar(a, b);
  } else if (operacao === "-") {
    return subtrair(a, b);
  } else if (operacao === "*") {
    return multiplicar(a, b);
  }
  return "Operação inválida";
}
```

**Dica:** Confira a ordem dos parâmetros em subtrair e o que multiplicar devolve (ou só mostra).

**Solução comentada:** subtrair calculava b - a (ordem trocada) e multiplicar só mostrava o valor com console.log, devolvendo undefined. Corrigindo para a - b e return a * b, as duas passam a devolver o resultado.

#### 4. Desafio: acompanhe as funções

*Interpretação de código · difícil · id `desafio7-acompanhe-as-funcoes` · conceitos: Escopo global (peso 3); Funções com parâmetros e retornos (peso 2); Chamada de funções (peso 2)*

Acompanhe os valores das variáveis. O que o programa abaixo mostra na tela?

```
let total = 0;
function somar(a, b) {
  return a + b;
}
function acumular(n) {
  total = somar(total, n);
  return total;
}
acumular(2);
acumular(3);
console.log(acumular(4) + total);
```

- ✗ 9 — *confusão: esquece de somar o valor de total depois da última chamada*
- ✗ 13 — *confusão: soma o argumento 4 ao valor devolvido, em vez do total*
- ✗ 20 — *confusão: soma os argumentos das três chamadas ao total de cada uma*
- ✔ **18** (correta)

**Dica:** acumular altera a variável global total a cada chamada.

**Ao acertar:** total vira 2, depois 5, e na última chamada vira 9 (acumular(4) devolve 9). Então a soma é 9 + total, que já vale 9: 18.

