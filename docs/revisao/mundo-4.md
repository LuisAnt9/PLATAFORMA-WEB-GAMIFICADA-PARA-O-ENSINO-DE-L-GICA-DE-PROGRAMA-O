# Revisão do conteúdo — Estruturas Condicionais

> GERADO por `npm run content:review`. Não edite este arquivo: ele muda quando o conteúdo mudar.

**Objetivo do mundo:** Ensinar o aluno a criar programas que tomam decisões de acordo com determinadas condições.

Este documento reúne tudo o que os alunos vão ver neste mundo: 10 lições e 72 exercícios. **Nada foi publicado:** os exercícios estão como rascunho e só o professor os vê.

## Como revisar
1. Leia cada lição (texto, exemplo, revisão e exercícios) como se fosse um aluno iniciante.
2. Confira o gabarito (✔) e as "confusões" das alternativas erradas: elas alimentam o painel de dificuldades.
3. Anote ajustes por lição. Peça a correção ao Claude, que altera os arquivos de `content/`.
4. Quando aprovar, publique com `npm run content:publish -- mundo-4` (gera o SQL para colar no Supabase).

## Resumo
| Lição | Exercícios | Fácil | Médio | Difícil | Tipos |
|---|---:|---:|---:|---:|---|
| Introdução às estruturas condicionais | 8 | 4 | 3 | 1 | 3 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 ordenação |
| Revisão dos operadores relacionais | 7 | 3 | 3 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 código, 1 corrigir o erro |
| Revisão dos operadores lógicos | 7 | 3 | 3 | 1 | 3 múltipla escolha, 2 interpretação de código, 1 código, 1 corrigir o erro |
| Estrutura if | 8 | 3 | 4 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 código, 2 corrigir o erro |
| Estrutura if/else | 8 | 3 | 4 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Estrutura else if | 8 | 3 | 4 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Condicionais aninhadas | 8 | 3 | 4 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Estrutura switch | 8 | 3 | 4 | 1 | 1 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Operador ternário | 7 | 3 | 3 | 1 | 1 múltipla escolha, 2 interpretação de código, 1 completar a lacuna, 2 código, 1 corrigir o erro |
| Desafio final do Mundo 4 | 3 | 0 | 0 | 3 | 1 desafio, 1 corrigir o erro, 1 interpretação de código |

---

## Lição 1 — Introdução às estruturas condicionais

**Foco:** Entender como um programa toma decisões

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Até agora, os programas executavam as instruções de cima para baixo, sempre do mesmo jeito. Na vida real, porém, decidimos o tempo todo: "se estiver chovendo, levo o guarda-chuva".
> 
> Uma estrutura condicional faz o programa decidir. Ela testa uma condição, uma expressão que resulta em true ou false (como as comparações do Mundo 3), e executa um trecho do código somente se a condição for verdadeira.
> 
> Com isso, o programa deixa de seguir um único caminho: o resultado depende dos dados. Neste mundo você vai conhecer as principais estruturas condicionais de JavaScript: if, if/else, else if, switch e o operador ternário.

### Exemplo

```
const idade = 20;

if (idade >= 18) {
  console.log("Pode entrar");
}
console.log("Fim");

Passo a passo:
1. A condição idade >= 18 é testada. Com idade 20, o resultado é true.
2. Como é verdadeira, o computador executa o bloco entre as chaves { } e mostra Pode entrar.
3. Depois, o programa segue normalmente e mostra Fim.

Se idade valesse 15, a condição seria false: o bloco seria ignorado e só Fim apareceria.
```

### Revisão

- Uma estrutura condicional executa um trecho do código só quando uma condição é verdadeira.
- A condição é uma expressão que resulta em true ou false.
- O bloco da condição fica entre chaves { }.
- O resultado do programa passa a depender dos dados.
- As principais estruturas: if, if/else, else if, switch e ternário.

### Exercícios

#### 1. Para que serve uma condicional?

*Múltipla escolha · fácil · id `cond-intro-para-que-serve` · conceitos: Introdução às estruturas condicionais (peso 3)*

Para que serve uma estrutura condicional?

- ✗ Para repetir um trecho do programa várias vezes — *confusão: confunde decisão com repetição*
- ✔ **Para executar um trecho só quando uma condição for verdadeira** (correta)
- ✗ Para guardar valores em variáveis — *confusão: confunde decisão com declaração de variáveis*
- ✗ Para mostrar um texto na tela — *confusão: confunde decisão com saída de dados*

**Dica:** Pense em "se... então...".

**Ao acertar:** A estrutura condicional faz o programa decidir: um trecho só é executado quando a condição é verdadeira.

#### 2. O resultado da condição

*Múltipla escolha · fácil · id `cond-intro-o-que-a-condicao-resulta` · conceitos: Introdução às estruturas condicionais (peso 3); Operadores relacionais (peso 1)*

A condição de uma estrutura condicional precisa resultar em quê?

- ✗ Em um texto — *confusão: acha que a condição precisa ser um texto*
- ✗ Em um número inteiro positivo — *confusão: acha que a condição precisa ser um número*
- ✗ Em uma atribuição, como x = 5 — *confusão: confunde condição com atribuição*
- ✔ **Em true ou false** (correta)

**Dica:** Lembre-se das comparações do Mundo 3.

**Ao acertar:** A condição é avaliada como verdadeira ou falsa (true ou false), como o resultado de uma comparação.

#### 3. Pode entrar?

*Interpretação de código · fácil · id `cond-intro-condicao-verdadeira` · conceitos: Introdução às estruturas condicionais (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
const idade = 20;
if (idade >= 18) {
  console.log("Pode entrar");
}
console.log("Fim");
```

- ✔ **Pode entrar / Fim** (correta)
- ✗ Fim — *confusão: acha que a mensagem do if não aparece*
- ✗ Pode entrar — *confusão: acha que o programa termina dentro do if*
- ✗ Fim / Pode entrar — *confusão: executa o bloco do if depois das linhas seguintes*

**Dica:** Com 20, a condição é verdadeira.

**Ao acertar:** 20 >= 18 é true, então o bloco do if executa. Depois, o programa continua e mostra Fim.

#### 4. Complete o if

*Completar a lacuna · fácil · id `cond-intro-complete-o-if` · conceitos: Introdução às estruturas condicionais (peso 2); Estrutura if (peso 1)*

Complete a palavra que inicia a estrutura condicional.

```
const temperatura = 35;
{{1}} (temperatura > 30) {
  console.log("Está quente");
}
```

Respostas aceitas: lacuna 1: if

**Dica:** A palavra vem do inglês e significa "se".

**Ao acertar:** if é a palavra que inicia a estrutura condicional: se a condição for verdadeira, o bloco executa.

#### 5. Menor de idade

*Interpretação de código · médio · id `cond-intro-condicao-falsa` · conceitos: Introdução às estruturas condicionais (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
const idade = 15;
if (idade >= 18) {
  console.log("Pode entrar");
}
console.log("Fim");
```

- ✗ Pode entrar / Fim — *confusão: executa o bloco sem avaliar a condição*
- ✗ Nada — *confusão: acha que o programa não mostra nada quando a condição é falsa*
- ✔ **Fim** (correta)
- ✗ Pode entrar — *confusão: acha que o bloco executa mesmo com a condição falsa e o programa termina*

**Dica:** Com 15, a condição é falsa. O que acontece com o bloco?

**Ao acertar:** 15 >= 18 é false, então o bloco é ignorado. O programa continua depois do if e mostra apenas Fim.

#### 6. Condição ou atribuição?

*Múltipla escolha · médio · id `cond-intro-condicao-invalida` · conceitos: Introdução às estruturas condicionais (peso 3); Operadores de atribuição (peso 1)*

Qual das alternativas NÃO é uma condição (isto é, não compara valores)?

- ✗ idade >= 18 — *confusão: acha que uma comparação não pode ser usada como condição*
- ✔ **idade = 18** (correta)
- ✗ idade === 18 — *confusão: acha que uma comparação de igualdade não pode ser usada como condição*
- ✗ idade !== 18 — *confusão: acha que uma comparação de diferença não pode ser usada como condição*

**Dica:** Uma delas guarda um valor em vez de comparar.

**Ao acertar:** idade = 18 é uma atribuição: guarda 18 em idade. As outras comparam e resultam em true ou false.

#### 7. Ordene o programa

*Ordenação · médio · id `cond-intro-ordene-o-if` · conceitos: Introdução às estruturas condicionais (peso 3); Sequência lógica (peso 1)*

Coloque as linhas na ordem certa para o programa mostrar Leve o guarda-chuva quando estiver chovendo.

Ordem correta:

1. const chovendo = true;
2. if (chovendo) {
3. console.log("Leve o guarda-chuva");
4. }

**Dica:** A variável precisa existir antes de ser testada, e o bloco fica entre a abertura e o fechamento das chaves.

**Ao acertar:** Primeiro a variável, depois o if com a condição, o comando dentro do bloco e, por fim, a chave que fecha o bloco.

#### 8. Dois ifs seguidos

*Interpretação de código · difícil · id `cond-intro-dois-ifs-seguidos` · conceitos: Introdução às estruturas condicionais (peso 3); Operadores relacionais (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
const nota = 6;
if (nota >= 7) {
  console.log("Aprovado");
}
if (nota < 7) {
  console.log("Estude mais");
}
console.log("Fim");
```

- ✗ Aprovado / Estude mais / Fim — *confusão: acha que todos os if executam, sem avaliar as condições*
- ✗ Aprovado / Fim — *confusão: avalia a primeira condição como verdadeira*
- ✗ Fim — *confusão: acha que nenhum dos ifs executa*
- ✔ **Estude mais / Fim** (correta)

**Dica:** Cada if tem a sua própria condição, testada separadamente.

**Ao acertar:** 6 >= 7 é false, então o primeiro bloco é ignorado. 6 < 7 é true, então o segundo bloco executa. Depois, Fim.

---

## Lição 2 — Revisão dos operadores relacionais

**Foco:** Revisar as comparações que formam as condições

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> As condições das estruturas condicionais quase sempre são comparações. Vamos revisar o que você viu no Mundo 3:
> - > maior, < menor, >= maior ou igual, <= menor ou igual;
> - === igual (mesmo valor e mesmo tipo) e !== diferente.
> 
> Traduzindo do português: "a idade é pelo menos 18" vira idade >= 18; "a nota é diferente de 10" vira nota !== 10.
> 
> Cuidados que valem ouro dentro de um if:
> - use === para comparar, e não =, que guarda um valor;
> - evite == e !=, que convertem os tipos;
> - textos diferenciam maiúsculas de minúsculas: "Ana" não é igual a "ana";
> - um número e um texto são valores de tipos diferentes: 10 === "10" é false.

### Exemplo

```
const idade = 17;
console.log(idade >= 18);               // false
console.log(idade === 17);              // true
console.log(idade !== 17);              // false

const nome = "Ana";
console.log(nome === "ana");            // false (as maiúsculas contam)
console.log(typeof idade === "number"); // true

Passo a passo:
1. Cada comparação resulta em true ou false, e é isso que um if vai usar como condição.
2. nome === "ana" é false: "A" maiúsculo e "a" minúsculo são caracteres diferentes.
3. typeof idade devolve o texto "number", e comparamos com === para conferir o tipo.
```

### Revisão

- Condições são, em geral, comparações: > < >= <= === !==.
- "Pelo menos" é >=; "no máximo" é <=; "diferente" é !==.
- Use === para comparar e = só para guardar valores.
- Textos diferenciam maiúsculas e minúsculas; número e texto têm tipos diferentes.

### Exercícios

#### 1. Pelo menos 18

*Múltipla escolha · fácil · id `revrel-pelo-menos` · conceitos: Revisão dos operadores relacionais (peso 3); Operadores relacionais (peso 1)*

Como se escreve a condição "a idade é pelo menos 18"?

- ✔ **idade >= 18** (correta)
- ✗ idade > 18 — *confusão: esquece que "pelo menos" inclui o próprio 18*
- ✗ idade <= 18 — *confusão: inverte o sentido da comparação*
- ✗ idade = 18 — *confusão: usa uma atribuição no lugar de uma comparação*

**Dica:** "Pelo menos" quer dizer "18 ou mais".

**Ao acertar:** "Pelo menos 18" é 18 ou mais: idade >= 18.

#### 2. Diferente de 10

*Múltipla escolha · fácil · id `revrel-diferente` · conceitos: Revisão dos operadores relacionais (peso 3)*

Como se escreve a condição "a nota é diferente de 10"?

- ✗ nota === 10 — *confusão: escreve a condição contrária*
- ✗ nota =! 10 — *confusão: inverte os símbolos do operador de diferença*
- ✔ **nota !== 10** (correta)
- ✗ nota <> 10 — *confusão: usa o operador de outras linguagens*

**Dica:** O operador de diferença começa com o ponto de exclamação.

**Ao acertar:** !== compara se dois valores são diferentes (em valor ou em tipo).

#### 3. Ana ou ana?

*Interpretação de código · fácil · id `revrel-maiusculas-contam` · conceitos: Revisão dos operadores relacionais (peso 3); Tipo String (peso 1)*

O que o programa abaixo mostra na tela?

```
const nome = "Ana";
console.log(nome === "ana");
```

- ✗ true — *confusão: acha que maiúsculas e minúsculas não fazem diferença*
- ✔ **false** (correta)
- ✗ Erro — *confusão: acha que comparar textos com === causa um erro*
- ✗ undefined — *confusão: acha que a comparação de textos não produz resultado*

**Dica:** Compare os dois textos letra por letra.

**Ao acertar:** "A" e "a" são caracteres diferentes, então os textos não são iguais: false.

#### 4. A nota passou?

*Código · médio · id `revrel-nota-passou` · conceitos: Revisão dos operadores relacionais (peso 3); Operadores relacionais (peso 2)*

Escreva a função `passou(nota)` que devolve true se a nota for 7 ou mais, e false caso contrário.

Função: `passou`

Código inicial:

```js
function passou(nota) {
  // seu código aqui
}
```

Testes:

- entrada [7] → retorna true
- entrada [6.9] → retorna false
- entrada [10] → retorna true
- entrada [0] → retorna false

Solução de referência:

```js
function passou(nota) {
  return nota >= 7;
}
```

**Dica:** Uma comparação já resulta em true ou false.

**Solução comentada:** nota >= 7 compara e devolve o booleano que a função deve retornar.

#### 5. Corrija a comparação

*Corrigir o erro · médio · id `revrel-corrija-o-igual` · conceitos: Revisão dos operadores relacionais (peso 3); Operadores de atribuição (peso 1)*

A função `ehDez(n)` deveria devolver true apenas quando n for 10, mas devolve outros valores. Corrija o defeito.

Função: `ehDez`

Código inicial:

```js
function ehDez(n) {
  return n = 10;
}
```

Testes:

- entrada [10] → retorna true
- entrada [5] → retorna false
- entrada [0] → retorna false

Solução de referência:

```js
function ehDez(n) {
  return n === 10;
}
```

**Dica:** Um dos sinais está guardando um valor em vez de comparar.

**Solução comentada:** n = 10 guarda 10 em n e devolve 10. Para comparar, usamos ===: n === 10.

#### 6. 10 e "10"

*Interpretação de código · médio · id `revrel-texto-ou-numero` · conceitos: Revisão dos operadores relacionais (peso 3); Operadores relacionais (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
const a = "10";
const b = 10;
console.log(a === b);
console.log(a == b);
console.log(Number(a) === b);
```

- ✗ true / true / true — *confusão: acha que o === ignora a diferença de tipo*
- ✗ false / false / true — *confusão: acha que o == também diferencia os tipos*
- ✗ false / true / false — *confusão: acha que Number() não converte o texto em número*
- ✔ **false / true / true** (correta)

**Dica:** a é um texto e b é um número.

**Ao acertar:** === não aceita tipos diferentes (false). == converte e diz true. Convertendo a com Number(), os dois são números iguais: true.

#### 7. Cuidados na comparação

*Interpretação de código · difícil · id `revrel-casos-estranhos` · conceitos: Revisão dos operadores relacionais (peso 3); Operadores relacionais (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(0.1 + 0.2 === 0.3);
console.log("apple" < "Banana");
console.log("10" < "9");
```

- ✔ **false / false / true** (correta)
- ✗ true / true / false — *confusão: acha que 0.1 + 0.2 é exatamente 0.3 e que as minúsculas vêm antes das maiúsculas*
- ✗ false / true / true — *confusão: acha que as letras minúsculas vêm antes das maiúsculas*
- ✗ false / false / false — *confusão: compara "10" e "9" como números*

**Dica:** Decimais são aproximados; textos são comparados letra por letra, com as maiúsculas antes das minúsculas.

**Ao acertar:** 0.1 + 0.2 vale 0.30000000000000004 (false). "apple" começa com a minúsculo, que vem depois do B maiúsculo (false). "10" < "9" compara textos: "1" vem antes de "9" (true).

---

## Lição 3 — Revisão dos operadores lógicos

**Foco:** Revisar &&, || e ! para montar condições com mais de uma regra

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Muitas decisões dependem de mais de uma regra. Os operadores lógicos, que você viu no Mundo 3, combinam condições:
> - && (E): true somente se as duas condições são true;
> - || (OU): true se pelo menos uma é true;
> - ! (NÃO): inverte o resultado.
> 
> Traduzindo: "idade entre 18 e 65" vira idade >= 18 && idade <= 65 (repita a variável nas duas comparações!); "criança ou idoso" vira idade < 12 || idade >= 60; "não é fim de semana" vira !ehFimDeSemana.
> 
> Uma regra útil, a lei de De Morgan, mostra que !(a && b) equivale a !a || !b, e que !(a || b) equivale a !a && !b: ao inverter uma combinação, trocamos E por OU e invertemos cada parte.

### Exemplo

```
const idade = 70;
const ehCrianca = idade < 12;
const ehIdoso = idade >= 60;
console.log(ehCrianca || ehIdoso);            // true  (tem desconto)
console.log(idade >= 18 && idade <= 65);      // false (fora da faixa)
console.log(!(idade >= 18 && idade <= 65));   // true

Passo a passo:
1. ehCrianca é false e ehIdoso é true: o || resulta em true.
2. 70 é maior que 18, mas não é menor ou igual a 65: o && resulta em false.
3. O ! inverte esse false em true.
```

### Revisão

- && exige as duas condições; || aceita uma delas; ! inverte.
- "Entre 18 e 65" é idade >= 18 && idade <= 65.
- "Criança ou idoso" é idade < 12 || idade >= 60.
- De Morgan: !(a && b) é !a || !b; !(a || b) é !a && !b.
- Use parênteses quando misturar && e ||.

### Exercícios

#### 1. Entre 18 e 65

*Múltipla escolha · fácil · id `revlog-entre-dois-valores` · conceitos: Revisão dos operadores lógicos (peso 3); Operadores lógicos (peso 1)*

Como se escreve "a idade está entre 18 e 65 (inclusive)"?

- ✗ idade >= 18 || idade <= 65 — *confusão: usa OU, que fica verdadeiro para quase qualquer número*
- ✗ 18 <= idade <= 65 — *confusão: escreve como na matemática, mas o JavaScript avalia de outra forma*
- ✔ **idade >= 18 && idade <= 65** (correta)
- ✗ idade >= 18 && <= 65 — *confusão: esquece de repetir a variável na segunda comparação*

**Dica:** As duas condições precisam valer ao mesmo tempo, cada uma com a variável.

**Ao acertar:** O && exige as duas comparações verdadeiras: idade >= 18 e idade <= 65.

#### 2. Criança ou idoso

*Múltipla escolha · fácil · id `revlog-crianca-ou-idoso` · conceitos: Revisão dos operadores lógicos (peso 3); Operadores lógicos (peso 1)*

Como se escreve "a idade é menor que 12 OU maior ou igual a 60"?

- ✗ idade < 12 && idade >= 60 — *confusão: usa E, que nenhum número satisfaz*
- ✔ **idade < 12 || idade >= 60** (correta)
- ✗ idade < 12 || 60 — *confusão: esquece de comparar a variável com o 60*
- ✗ !(idade < 12) || idade >= 60 — *confusão: inverte a primeira condição sem querer*

**Dica:** Basta uma das duas condições ser verdadeira.

**Ao acertar:** O || aceita que qualquer um dos lados seja verdadeiro: idade < 12 || idade >= 60.

#### 3. Combinações básicas

*Interpretação de código · fácil · id `revlog-tabela-verdade` · conceitos: Revisão dos operadores lógicos (peso 3); Operadores lógicos (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(true && true);
console.log(true && false);
console.log(false || true);
console.log(!true);
```

- ✗ true / true / true / true — *confusão: acha que o && só precisa de um lado verdadeiro*
- ✗ true / false / false / false — *confusão: acha que o || precisa dos dois lados verdadeiros*
- ✗ true / false / true / true — *confusão: esquece que o ! inverte o valor*
- ✔ **true / false / true / false** (correta)

**Dica:** Use a tabela-verdade do Mundo 3.

**Ao acertar:** true && true é true; true && false é false; false || true é true; e !true é false.

#### 4. Tem desconto?

*Código · médio · id `revlog-tem-desconto` · conceitos: Revisão dos operadores lógicos (peso 3); Operadores lógicos (peso 2); Operadores relacionais (peso 1)*

Escreva a função `temDesconto(idade)` que devolve true para crianças (menores de 12 anos) e para idosos (60 anos ou mais), e false para os demais.

Função: `temDesconto`

Código inicial:

```js
function temDesconto(idade) {
  // seu código aqui
}
```

Testes:

- entrada [10] → retorna true
- entrada [12] → retorna false
- entrada [59] → retorna false
- entrada [60] → retorna true
- entrada [70] → retorna true

Solução de referência:

```js
function temDesconto(idade) {
  return idade < 12 || idade >= 60;
}
```

**Dica:** As duas regras valem de forma independente: basta uma delas.

**Solução comentada:** idade < 12 || idade >= 60 é true quando a pessoa é criança ou idosa.

#### 5. Corrija o fim de semana

*Corrigir o erro · médio · id `revlog-corrija-o-fim-de-semana` · conceitos: Revisão dos operadores lógicos (peso 3); Operadores lógicos (peso 2)*

A função `ehFimDeSemana(dia)` deveria devolver true para "sábado" e "domingo", mas devolve sempre false. Corrija o defeito.

Função: `ehFimDeSemana`

Código inicial:

```js
function ehFimDeSemana(dia) {
  return dia === "sábado" && dia === "domingo";
}
```

Testes:

- entrada ["sábado"] → retorna true
- entrada ["domingo"] → retorna true
- entrada ["segunda"] → retorna false
- entrada ["sexta"] → retorna false

Solução de referência:

```js
function ehFimDeSemana(dia) {
  return dia === "sábado" || dia === "domingo";
}
```

**Dica:** Um dia não pode ser sábado e domingo ao mesmo tempo.

**Solução comentada:** Com &&, o dia teria que ser igual aos dois valores ao mesmo tempo, o que nunca acontece. Com ||, basta ser um dos dois.

#### 6. Parênteses e lógica

*Interpretação de código · médio · id `revlog-parenteses-mudam-o-resultado` · conceitos: Revisão dos operadores lógicos (peso 3); Precedência dos operadores (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
const temCartao = true;
const temDinheiro = false;
const estaAberto = false;
console.log((temCartao || temDinheiro) && estaAberto);
console.log(temCartao || temDinheiro && estaAberto);
console.log(!estaAberto);
```

- ✔ **false / true / true** (correta)
- ✗ true / true / true — *confusão: ignora o efeito dos parênteses na primeira linha*
- ✗ false / false / true — *confusão: resolve o || antes do && na segunda linha*
- ✗ false / true / false — *confusão: esquece que o ! inverte false em true*

**Dica:** Na segunda linha, o && é resolvido antes do ||.

**Ao acertar:** Linha 1: (true || false) é true e true && false é false. Linha 2: false && false é false, e true || false é true. Linha 3: !false é true.

#### 7. Invertendo uma combinação

*Múltipla escolha · difícil · id `revlog-de-morgan` · conceitos: Revisão dos operadores lógicos (peso 3); Operadores lógicos (peso 2)*

Qual expressão é equivalente a !(a && b)?

- ✗ !a && !b — *confusão: inverte os operandos, mas mantém o &&*
- ✗ a || b — *confusão: troca o && por || sem inverter os operandos*
- ✔ **!a || !b** (correta)
- ✗ !a || b — *confusão: inverte só um dos operandos*

**Dica:** Ao inverter uma combinação, o E vira OU e cada parte é invertida.

**Ao acertar:** Pela lei de De Morgan, !(a && b) equivale a !a || !b: o resultado é true quando pelo menos uma das partes é false.

---

## Lição 4 — Estrutura if

**Foco:** Escrever e entender a estrutura if

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> A estrutura if é a forma mais simples de decisão:
> 
> if (condição) {
>   // comandos que só executam se a condição for verdadeira
> }
> 
> Pontos importantes:
> - a condição fica entre parênteses;
> - o bloco de comandos fica entre chaves { }, com os comandos recuados (indentados) para facilitar a leitura;
> - se a condição for falsa, o bloco inteiro é ignorado e o programa segue adiante;
> - não se coloca ponto e vírgula logo depois do parêntese: if (x > 0); termina o if antes de começar e o bloco passa a executar sempre;
> - use === para comparar, e não =: if (x = 5) guarda 5 em x e a condição passa a valer sempre.
> 
> Um programa pode ter vários if seguidos. Cada um tem a sua condição e é testado de forma independente.

### Exemplo

```
const temperatura = 32;

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
3. O programa continua e mostra Fim.
```

### Revisão

- if (condição) { ... } executa o bloco só se a condição for verdadeira.
- Condição entre parênteses, comandos entre chaves e recuados.
- Condição falsa: o bloco é ignorado.
- Nada de ; depois do parêntese do if, e use === (e não =) para comparar.
- Vários if seguidos são avaliados independentemente.

### Exercícios

#### 1. Qual if está correto?

*Múltipla escolha · fácil · id `if-forma-correta` · conceitos: Estrutura if (peso 3)*

Qual das formas abaixo é um if escrito corretamente?

- ✗ if nota >= 7 { console.log("Aprovado"); } — *confusão: esquece os parênteses em volta da condição*
- ✔ **if (nota >= 7) { console.log("Aprovado"); }** (correta)
- ✗ if (nota >= 7) then console.log("Aprovado"); — *confusão: usa a sintaxe de outras linguagens, com then*
- ✗ if (nota >= 7); { console.log("Aprovado"); } — *confusão: coloca ponto e vírgula logo depois da condição*

**Dica:** Condição entre parênteses; comandos entre chaves.

**Ao acertar:** A forma correta tem a condição entre parênteses e o bloco entre chaves, sem ponto e vírgula depois do parêntese.

#### 2. Aprovado?

*Interpretação de código · fácil · id `if-nota-oito` · conceitos: Estrutura if (peso 3)*

O que o programa abaixo mostra na tela?

```
const nota = 8;
if (nota >= 7) {
  console.log("Aprovado");
}
```

- ✗ nota — *confusão: mostra o nome da variável em vez da mensagem*
- ✗ Nada — *confusão: acha que o programa não mostra nada quando o if é verdadeiro*
- ✗ Reprovado — *confusão: acha que a nota 8 não atinge o mínimo*
- ✔ **Aprovado** (correta)

**Dica:** 8 é maior ou igual a 7?

**Ao acertar:** 8 >= 7 é true, então o bloco executa e mostra Aprovado.

#### 3. Complete a condição

*Completar a lacuna · fácil · id `if-complete-a-condicao` · conceitos: Estrutura if (peso 2); Operadores relacionais (peso 1)*

Complete a condição com o nome da variável para mostrar Dez quando n for igual a 10.

```
const n = 10;
if ({{1}} === 10) {
  console.log("Dez");
}
```

Respostas aceitas: lacuna 1: n

**Dica:** A condição compara a própria variável com 10.

**Ao acertar:** n === 10 compara o valor guardado em n com 10. Como n vale 10, a condição é verdadeira.

#### 4. Calor ou frio?

*Interpretação de código · médio · id `if-dois-blocos-independentes` · conceitos: Estrutura if (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
const temperatura = 32;
if (temperatura > 30) {
  console.log("Está quente");
}
if (temperatura < 15) {
  console.log("Está frio");
}
console.log("Fim");
```

- ✔ **Está quente / Fim** (correta)
- ✗ Está quente / Está frio / Fim — *confusão: acha que todos os if executam*
- ✗ Está frio / Fim — *confusão: avalia a segunda condição como verdadeira*
- ✗ Fim — *confusão: acha que nenhum bloco executa*

**Dica:** Cada if é testado separadamente.

**Ao acertar:** 32 > 30 é true (Está quente); 32 < 15 é false (bloco ignorado); depois, Fim.

#### 5. Bônus de vendas

*Código · médio · id `if-bonus-de-vendas` · conceitos: Estrutura if (peso 3); Operadores relacionais (peso 1)*

Escreva a função `bonus(vendas)` que devolve 100 se as vendas forem 1000 ou mais, e 0 caso contrário. Use um if.

Função: `bonus`

Código inicial:

```js
function bonus(vendas) {
  let valor = 0;
  // use um if para mudar o valor quando as vendas forem 1000 ou mais
  return valor;
}
```

Testes:

- entrada [500] → retorna 0
- entrada [1000] → retorna 100
- entrada [2500] → retorna 100
- entrada [999] → retorna 0

Solução de referência:

```js
function bonus(vendas) {
  let valor = 0;
  if (vendas >= 1000) {
    valor = 100;
  }
  return valor;
}
```

**Dica:** Comece com valor = 0 e só mude se a condição for verdadeira.

**Solução comentada:** O valor começa em 0 e o if o troca por 100 apenas quando vendas >= 1000.

#### 6. Corrija o ponto e vírgula

*Corrigir o erro · médio · id `if-corrija-o-ponto-e-virgula` · conceitos: Estrutura if (peso 3)*

A função `classificar(idade)` deveria devolver "maior" para 18 anos ou mais e "menor" para os outros, mas devolve "maior" para todo mundo. Corrija o defeito.

Função: `classificar`

Código inicial:

```js
function classificar(idade) {
  let texto = "menor";
  if (idade >= 18);
  {
    texto = "maior";
  }
  return texto;
}
```

Testes:

- entrada [20] → retorna "maior"
- entrada [10] → retorna "menor"
- entrada [18] → retorna "maior"
- entrada [17] → retorna "menor"

Solução de referência:

```js
function classificar(idade) {
  let texto = "menor";
  if (idade >= 18) {
    texto = "maior";
  }
  return texto;
}
```

**Dica:** Repare no que vem logo depois do parêntese do if.

**Solução comentada:** O ; depois da condição encerra o if (vazio), e o bloco seguinte passa a executar sempre. Sem o ;, o bloco pertence ao if.

#### 7. Corrija a condição

*Corrigir o erro · médio · id `if-corrija-a-atribuicao` · conceitos: Estrutura if (peso 3); Operadores de atribuição (peso 1)*

A função `ehDezoito(idade)` deveria devolver true só para 18, mas devolve true para qualquer idade. Corrija o defeito.

Função: `ehDezoito`

Código inicial:

```js
function ehDezoito(idade) {
  if (idade = 18) {
    return true;
  }
  return false;
}
```

Testes:

- entrada [18] → retorna true
- entrada [20] → retorna false
- entrada [0] → retorna false

Solução de referência:

```js
function ehDezoito(idade) {
  if (idade === 18) {
    return true;
  }
  return false;
}
```

**Dica:** Um dos sinais guarda um valor em vez de comparar.

**Solução comentada:** idade = 18 guarda 18 na variável e a condição passa a valer 18 (verdadeira) sempre. Para comparar, use ===

#### 8. Acertos e pontos

*Interpretação de código · difícil · id `if-somando-pontos` · conceitos: Estrutura if (peso 3); Operadores de atribuição (peso 1)*

O que o programa abaixo mostra na tela?

```
let pontos = 0;
const acertos = 7;
if (acertos >= 5) {
  pontos += 10;
}
if (acertos >= 7) {
  pontos += 20;
}
if (acertos >= 10) {
  pontos += 50;
}
console.log(pontos);
```

- ✗ 10 — *confusão: acha que o programa para no primeiro if verdadeiro*
- ✗ 80 — *confusão: soma todos os blocos sem avaliar as condições*
- ✔ **30** (correta)
- ✗ 20 — *confusão: acha que só o último if verdadeiro conta*

**Dica:** Cada if é testado de forma independente, e os blocos verdadeiros se acumulam.

**Ao acertar:** 7 >= 5 soma 10 e 7 >= 7 soma 20; 7 >= 10 é falso. Total: 30.

---

## Lição 5 — Estrutura if/else

**Foco:** Escolher entre dois caminhos

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Muitas vezes precisamos de dois caminhos: um para quando a condição é verdadeira e outro para quando é falsa. A estrutura if/else faz isso:
> 
> if (condição) {
>   // executa se for verdadeira
> } else {
>   // executa se for falsa
> }
> 
> Exatamente um dos dois blocos é executado, nunca os dois e nunca nenhum. O else não tem condição: ele cobre "todo o resto".
> 
> Cuidado: dois if seguidos não são um if/else. Em if (x > 5) {...} if (x <= 5) {...}, as duas condições são testadas separadamente; com else, o segundo teste não é necessário.
> 
> Um uso clássico é separar par de ímpar: um número é par quando o resto da divisão por 2 é zero.

### Exemplo

```
const numero = 7;

if (numero % 2 === 0) {
  console.log("Par");
} else {
  console.log("Ímpar");
}

Passo a passo:
1. numero % 2 vale 1, e 1 === 0 é false.
2. Como a condição é falsa, o bloco do if é ignorado e o bloco do else executa.
3. O programa mostra Ímpar.

Com numero = 8, 8 % 2 é 0, a condição seria verdadeira e o programa mostraria Par.
```

### Revisão

- if/else escolhe entre dois caminhos: exatamente um dos blocos executa.
- O else não tem condição: vale quando a condição do if é falsa.
- Dois if seguidos são testes independentes; if/else são caminhos excludentes.
- Número par: n % 2 === 0.

### Exercícios

#### 1. O que faz o else?

*Múltipla escolha · fácil · id `ifelse-o-que-faz-o-else` · conceitos: Estrutura if/else (peso 3)*

O que o else faz em uma estrutura if/else?

- ✗ Executa um bloco sempre, depois do if — *confusão: acha que o else executa em qualquer caso*
- ✔ **Executa um bloco quando a condição do if for falsa** (correta)
- ✗ Testa uma segunda condição — *confusão: confunde else com else if*
- ✗ Repete o bloco do if — *confusão: confunde else com repetição*

**Dica:** O else cobre o "senão".

**Ao acertar:** O bloco do else só executa quando a condição do if é falsa.

#### 2. Par ou ímpar?

*Interpretação de código · fácil · id `ifelse-par-ou-impar` · conceitos: Estrutura if/else (peso 3); Operadores aritméticos (peso 1)*

O que o programa abaixo mostra na tela?

```
const numero = 7;
if (numero % 2 === 0) {
  console.log("Par");
} else {
  console.log("Ímpar");
}
```

- ✗ Par — *confusão: acha que 7 % 2 vale zero*
- ✗ Par / Ímpar — *confusão: acha que os dois blocos executam*
- ✗ 7 — *confusão: mostra o valor da variável em vez da mensagem*
- ✔ **Ímpar** (correta)

**Dica:** 7 % 2 é o resto de 7 dividido por 2.

**Ao acertar:** 7 % 2 vale 1, então a condição é falsa e o else executa: Ímpar.

#### 3. Complete o else

*Completar a lacuna · fácil · id `ifelse-complete-o-else` · conceitos: Estrutura if/else (peso 2)*

Complete a palavra que inicia o caminho alternativo.

```
const idade = 15;
if (idade >= 18) {
  console.log("Maior");
} {{1}} {
  console.log("Menor");
}
```

Respostas aceitas: lacuna 1: else

**Dica:** A palavra vem do inglês e significa "senão".

**Ao acertar:** else abre o bloco que executa quando a condição do if é falsa.

#### 4. Aprovado ou reprovado?

*Interpretação de código · médio · id `ifelse-reprovado` · conceitos: Estrutura if/else (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
const nota = 6;
if (nota >= 7) {
  console.log("Aprovado");
} else {
  console.log("Reprovado");
}
console.log("Fim");
```

- ✔ **Reprovado / Fim** (correta)
- ✗ Aprovado / Fim — *confusão: avalia 6 >= 7 como verdadeiro*
- ✗ Aprovado / Reprovado / Fim — *confusão: acha que os dois blocos executam*
- ✗ Reprovado — *confusão: acha que o programa termina dentro do else*

**Dica:** 6 >= 7 é falso. Depois do if/else, o programa continua.

**Ao acertar:** A condição é falsa, então executa o else (Reprovado). Depois do bloco, o programa mostra Fim.

#### 5. Par ou ímpar

*Código · médio · id `ifelse-par-ou-impar-funcao` · conceitos: Estrutura if/else (peso 3); Operadores aritméticos (peso 1)*

Escreva a função `parOuImpar(n)` que devolve "par" se n for par e "impar" caso contrário. Use if/else.

Função: `parOuImpar`

Código inicial:

```js
function parOuImpar(n) {
  // seu código aqui
}
```

Testes:

- entrada [4] → retorna "par"
- entrada [7] → retorna "impar"
- entrada [0] → retorna "par"
- entrada [-3] → retorna "impar"

Solução de referência:

```js
function parOuImpar(n) {
  if (n % 2 === 0) {
    return "par";
  } else {
    return "impar";
  }
}
```

**Dica:** Um número é par quando o resto da divisão por 2 é zero.

**Solução comentada:** n % 2 === 0 identifica os pares. O else cobre todos os outros números (inclusive negativos ímpares).

#### 6. O maior de dois

*Código · médio · id `ifelse-o-maior-de-dois` · conceitos: Estrutura if/else (peso 3); Operadores relacionais (peso 1)*

Escreva a função `maior(a, b)` que devolve o maior entre dois números. Use if/else.

Função: `maior`

Código inicial:

```js
function maior(a, b) {
  // seu código aqui
}
```

Testes:

- entrada [3,5] → retorna 5
- entrada [9,2] → retorna 9
- entrada [4,4] → retorna 4
- entrada [-1,-7] → retorna -1

Solução de referência:

```js
function maior(a, b) {
  if (a > b) {
    return a;
  } else {
    return b;
  }
}
```

**Dica:** Se a for maior, devolva a; senão, devolva b.

**Solução comentada:** Se a > b, o maior é a; no caso contrário (inclusive empate), b serve.

#### 7. Corrija o else que faltou

*Corrigir o erro · médio · id `ifelse-corrija-o-else-que-faltou` · conceitos: Estrutura if/else (peso 3)*

A função `situacao(nota)` deveria devolver "aprovado" para 7 ou mais e "reprovado" para os outros, mas devolve "reprovado" sempre. Corrija o defeito.

Função: `situacao`

Código inicial:

```js
function situacao(nota) {
  let texto = "";
  if (nota >= 7) {
    texto = "aprovado";
  }
  texto = "reprovado";
  return texto;
}
```

Testes:

- entrada [8] → retorna "aprovado"
- entrada [5] → retorna "reprovado"
- entrada [7] → retorna "aprovado"
- entrada [6.9] → retorna "reprovado"

Solução de referência:

```js
function situacao(nota) {
  let texto = "";
  if (nota >= 7) {
    texto = "aprovado";
  } else {
    texto = "reprovado";
  }
  return texto;
}
```

**Dica:** A linha que define "reprovado" está fora de qualquer else: ela executa sempre.

**Solução comentada:** A atribuição de "reprovado" ficava depois do if e sobrescrevia o resultado. Colocando-a dentro de um else, ela só executa quando a nota é menor que 7.

#### 8. Duas decisões

*Interpretação de código · difícil · id `ifelse-dois-pares-de-blocos` · conceitos: Estrutura if/else (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
const x = 7;
if (x > 5) {
  console.log("A");
} else {
  console.log("B");
}
if (x > 8) {
  console.log("C");
} else {
  console.log("D");
}
```

- ✗ A / B / C / D — *confusão: acha que todos os blocos executam*
- ✗ A / C — *confusão: avalia a segunda condição como verdadeira*
- ✔ **A / D** (correta)
- ✗ B / D — *confusão: avalia a primeira condição como falsa*

**Dica:** São dois if/else independentes: cada um escolhe o seu caminho.

**Ao acertar:** 7 > 5 é true (A). Já 7 > 8 é false, então o segundo executa o else (D).

---

## Lição 6 — Estrutura else if

**Foco:** Decidir entre várias faixas ou opções

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Quando há mais de dois caminhos, encadeamos condições com else if:
> 
> if (condição1) {
>   ...
> } else if (condição2) {
>   ...
> } else if (condição3) {
>   ...
> } else {
>   ...
> }
> 
> O computador testa as condições de cima para baixo. A primeira que for verdadeira executa o seu bloco, e todas as outras são ignoradas, mesmo que também fossem verdadeiras. O else final, que é opcional, cobre o que sobrou.
> 
> Por isso a ordem importa: coloque as condições mais específicas antes das mais gerais. Em uma escala de notas, se você testar nota >= 5 antes de nota >= 7, quem tirou 9 cai na primeira faixa e nunca chega à segunda.
> 
> E atenção: vários if seguidos não são a mesma coisa que else if: cada if é testado de forma independente.

### Exemplo

```
const nota = 7.5;

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
3. As condições seguintes nem são testadas, mesmo que 7.5 >= 5 também seja verdadeiro.
```

### Revisão

- else if encadeia várias condições: só o primeiro bloco verdadeiro executa.
- As condições são testadas de cima para baixo: a ordem importa.
- Coloque as faixas mais específicas antes das mais gerais.
- O else final cobre os demais casos.
- else if não é o mesmo que vários if seguidos.

### Exercícios

#### 1. Quantos blocos executam?

*Múltipla escolha · fácil · id `elseif-quantos-blocos-executam` · conceitos: Estrutura else if (peso 3)*

Em uma cadeia if / else if / else, quantos blocos são executados?

- ✗ Todos os blocos cujas condições forem verdadeiras — *confusão: acha que executa todos os blocos verdadeiros, como em vários if separados*
- ✔ **No máximo um: o primeiro com condição verdadeira (ou o else)** (correta)
- ✗ Todos os blocos, sempre — *confusão: acha que o else if não impede a execução dos blocos seguintes*
- ✗ Sempre o último bloco — *confusão: acha que a cadeia sempre termina no último bloco*

**Dica:** Depois que uma condição é verdadeira, o computador ignora o resto da cadeia.

**Ao acertar:** Em uma cadeia if / else if / else, só o primeiro bloco com condição verdadeira executa. Se nenhum for verdadeiro, o else executa.

#### 2. Qual faixa?

*Interpretação de código · fácil · id `elseif-escala-de-notas` · conceitos: Estrutura else if (peso 3)*

O que o programa abaixo mostra na tela?

```
const nota = 7.5;
if (nota >= 9) {
  console.log("Excelente");
} else if (nota >= 7) {
  console.log("Bom");
} else if (nota >= 5) {
  console.log("Regular");
} else {
  console.log("Insuficiente");
}
```

- ✗ Excelente — *confusão: acha que 7.5 é maior ou igual a 9*
- ✗ Bom / Regular — *confusão: acha que os blocos seguintes também executam*
- ✗ Regular — *confusão: pula a faixa correta*
- ✔ **Bom** (correta)

**Dica:** Teste as condições de cima para baixo e pare na primeira verdadeira.

**Ao acertar:** 7.5 >= 9 é falso; 7.5 >= 7 é verdadeiro, então mostra Bom e ignora o resto.

#### 3. Complete a cadeia

*Completar a lacuna · fácil · id `elseif-complete-a-cadeia` · conceitos: Estrutura else if (peso 2)*

Complete a palavra que liga a segunda condição à primeira.

```
const n = -4;
if (n > 0) {
  console.log("positivo");
} {{1}} if (n < 0) {
  console.log("negativo");
} else {
  console.log("zero");
}
```

Respostas aceitas: lacuna 1: else

**Dica:** A segunda condição só é testada se a primeira for falsa.

**Ao acertar:** else if testa uma nova condição quando a anterior foi falsa.

#### 4. A ordem importa

*Interpretação de código · médio · id `elseif-ordem-errada` · conceitos: Estrutura else if (peso 3)*

O que o programa abaixo mostra na tela?

```
const nota = 9.5;
if (nota >= 5) {
  console.log("Regular");
} else if (nota >= 7) {
  console.log("Bom");
} else if (nota >= 9) {
  console.log("Excelente");
}
```

- ✔ **Regular** (correta)
- ✗ Excelente — *confusão: acha que o computador escolhe a melhor faixa, e não a primeira verdadeira*
- ✗ Regular / Bom / Excelente — *confusão: acha que todas as condições verdadeiras executam*
- ✗ Nada — *confusão: acha que a nota não se encaixa em nenhuma faixa*

**Dica:** A primeira condição já é verdadeira para 9.5.

**Ao acertar:** 9.5 >= 5 é verdadeiro, então mostra Regular e as demais faixas nem são testadas. As faixas deveriam estar da maior para a menor.

#### 5. Classificar a nota

*Código · médio · id `elseif-classificar-nota` · conceitos: Estrutura else if (peso 3); Operadores relacionais (peso 1)*

Escreva a função `classificarNota(nota)` que devolve "A" para 9 ou mais, "B" para 7 ou mais, "C" para 5 ou mais e "D" para o resto.

Função: `classificarNota`

Código inicial:

```js
function classificarNota(nota) {
  // seu código aqui
}
```

Testes:

- entrada [9.5] → retorna "A"
- entrada [9] → retorna "A"
- entrada [8] → retorna "B"
- entrada [7] → retorna "B"
- entrada [6] → retorna "C"
- entrada [5] → retorna "C"
- entrada [4.9] → retorna "D"

Solução de referência:

```js
function classificarNota(nota) {
  if (nota >= 9) {
    return "A";
  } else if (nota >= 7) {
    return "B";
  } else if (nota >= 5) {
    return "C";
  } else {
    return "D";
  }
}
```

**Dica:** Comece pela faixa mais alta e vá descendo.

**Solução comentada:** As condições vão da maior faixa para a menor, e o else cobre as notas abaixo de 5.

#### 6. Sinal do número

*Código · médio · id `elseif-sinal-do-numero` · conceitos: Estrutura else if (peso 3)*

Escreva a função `sinal(n)` que devolve "positivo" se n for maior que zero, "negativo" se for menor que zero e "zero" se for zero.

Função: `sinal`

Código inicial:

```js
function sinal(n) {
  // seu código aqui
}
```

Testes:

- entrada [5] → retorna "positivo"
- entrada [-2] → retorna "negativo"
- entrada [0] → retorna "zero"
- entrada [0.1] → retorna "positivo"

Solução de referência:

```js
function sinal(n) {
  if (n > 0) {
    return "positivo";
  } else if (n < 0) {
    return "negativo";
  } else {
    return "zero";
  }
}
```

**Dica:** Três caminhos: positivo, negativo e o que sobrar.

**Solução comentada:** if (n > 0) cobre os positivos, else if (n < 0) os negativos, e o else, o zero.

#### 7. Corrija a ordem das faixas

*Corrigir o erro · médio · id `elseif-corrija-a-ordem` · conceitos: Estrutura else if (peso 3)*

A função `faixa(nota)` deveria devolver "Bom" para notas de 7 a 8.9, mas devolve "Regular" para quem tira 8. Corrija o defeito.

Função: `faixa`

Código inicial:

```js
function faixa(nota) {
  if (nota >= 5) {
    return "Regular";
  } else if (nota >= 7) {
    return "Bom";
  } else {
    return "Insuficiente";
  }
}
```

Testes:

- entrada [8] → retorna "Bom"
- entrada [6] → retorna "Regular"
- entrada [3] → retorna "Insuficiente"
- entrada [7] → retorna "Bom"
- entrada [5] → retorna "Regular"

Solução de referência:

```js
function faixa(nota) {
  if (nota >= 7) {
    return "Bom";
  } else if (nota >= 5) {
    return "Regular";
  } else {
    return "Insuficiente";
  }
}
```

**Dica:** Qual condição pega todo mundo que tem 7 ou mais antes da hora?

**Solução comentada:** nota >= 5 é verdadeira também para 8, então a faixa Bom nunca era alcançada. Testando >= 7 antes de >= 5, cada nota cai na faixa certa.

#### 8. else if e if separado

*Interpretação de código · difícil · id `elseif-versus-ifs-separados` · conceitos: Estrutura else if (peso 3); Estrutura if (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
const n = 15;
if (n % 3 === 0) {
  console.log("Fizz");
} else if (n % 5 === 0) {
  console.log("Buzz");
}
if (n % 3 === 0) {
  console.log("Fizz2");
}
if (n % 5 === 0) {
  console.log("Buzz2");
}
```

- ✗ Fizz / Buzz / Fizz2 / Buzz2 — *confusão: acha que o else if também executa quando o if anterior foi verdadeiro*
- ✗ Fizz / Fizz2 — *confusão: acha que só um bloco executa em todo o programa*
- ✔ **Fizz / Fizz2 / Buzz2** (correta)
- ✗ Buzz / Fizz2 / Buzz2 — *confusão: acha que o else if é testado antes do if*

**Dica:** A primeira cadeia executa um bloco só; os dois if finais são independentes.

**Ao acertar:** 15 é divisível por 3 e por 5. Na primeira cadeia, só o primeiro bloco verdadeiro executa (Fizz). Os dois if seguintes são testados separadamente, e os dois são verdadeiros (Fizz2 e Buzz2).

---

## Lição 7 — Condicionais aninhadas

**Foco:** Colocar uma decisão dentro de outra

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Condicionais aninhadas são condicionais dentro de outras: uma decisão que só faz sentido depois de outra. Por exemplo: só perguntamos se a pessoa tem ingresso depois de confirmar que ela é maior de idade.
> 
> O bloco interno só é testado se a condição externa for verdadeira. Se a externa for falsa, a interna nem é avaliada.
> 
> A indentação é essencial: a cada nível, recue o código mais um pouco para enxergar a quem cada else pertence. Um else sempre pertence ao if mais próximo, acima dele.
> 
> Muitos níveis deixam o código difícil de ler. Quando as duas condições levam ao mesmo resultado, uma alternativa é juntá-las com &&: if (a) { if (b) {...} } equivale a if (a && b) {...}.

### Exemplo

```
const idade = 20;
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
3. O programa mostra Compre um ingresso. O else externo (Menor de idade) não executa, porque a condição externa foi verdadeira.
```

### Revisão

- Condicional aninhada é uma condicional dentro do bloco de outra.
- A interna só é avaliada se a externa for verdadeira.
- Cada else pertence ao if mais próximo acima dele; a indentação ajuda a enxergar isso.
- if (a) { if (b) {...} } equivale a if (a && b) {...}.
- Evite muitos níveis: o código fica difícil de ler.

### Exercícios

#### 1. O que é aninhar?

*Múltipla escolha · fácil · id `aninhada-o-que-e` · conceitos: Condicionais aninhadas (peso 3)*

O que é uma condicional aninhada?

- ✗ Duas condicionais seguidas, uma depois da outra — *confusão: confunde aninhar com colocar condicionais em sequência*
- ✔ **Uma condicional escrita dentro do bloco de outra condicional** (correta)
- ✗ Uma condicional com mais de uma condição — *confusão: confunde aninhar com combinar condições com && ou ||*
- ✗ Um if sem else — *confusão: confunde aninhar com a ausência de else*

**Dica:** Pense em caixas dentro de caixas.

**Ao acertar:** Aninhar é colocar uma estrutura condicional dentro do bloco de outra.

#### 2. Tem ingresso?

*Interpretação de código · fácil · id `aninhada-sem-ingresso` · conceitos: Condicionais aninhadas (peso 3); Estrutura if/else (peso 1)*

O que o programa abaixo mostra na tela?

```
const idade = 20;
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
```

- ✗ Pode entrar — *confusão: acha que a pessoa entra só por ser maior de idade*
- ✗ Menor de idade — *confusão: ignora a condição externa, que é verdadeira*
- ✗ Compre um ingresso / Menor de idade — *confusão: acha que os dois else executam*
- ✔ **Compre um ingresso** (correta)

**Dica:** Entre primeiro no bloco externo; depois avalie o interno.

**Ao acertar:** A idade é suficiente (bloco externo). Dentro dele, a pessoa não tem ingresso, então executa o else interno.

#### 3. Complete o if interno

*Completar a lacuna · fácil · id `aninhada-complete-o-if-interno` · conceitos: Condicionais aninhadas (peso 2); Estrutura if (peso 1)*

Complete a palavra que inicia a condicional interna.

```
const a = 3;
const b = 5;
if (a > 0) {
  {{1}} (b > 0) {
    console.log("Os dois são positivos");
  }
}
```

Respostas aceitas: lacuna 1: if

**Dica:** A decisão interna usa a mesma palavra da externa.

**Ao acertar:** O if interno só é testado quando a condição externa (a > 0) é verdadeira.

#### 4. Menor de idade

*Interpretação de código · médio · id `aninhada-menor-de-idade` · conceitos: Condicionais aninhadas (peso 3)*

O que o programa abaixo mostra na tela?

```
const idade = 16;
const temIngresso = true;
if (idade >= 18) {
  if (temIngresso) {
    console.log("Pode entrar");
  } else {
    console.log("Compre um ingresso");
  }
} else {
  console.log("Menor de idade");
}
```

- ✔ **Menor de idade** (correta)
- ✗ Pode entrar — *confusão: avalia só a condição interna, ignorando a externa*
- ✗ Compre um ingresso — *confusão: acha que a condição interna é testada mesmo com a externa falsa*
- ✗ Nada — *confusão: acha que o programa não mostra nada para menores*

**Dica:** A condição externa é falsa. A interna é avaliada?

**Ao acertar:** 16 >= 18 é falso, então o bloco externo é ignorado e o else externo executa. A condição interna nem é avaliada.

#### 5. Desconto do ingresso

*Código · médio · id `aninhada-desconto-do-ingresso` · conceitos: Condicionais aninhadas (peso 3); Estrutura if/else (peso 1)*

Escreva a função `descontoDoIngresso(idade, estudante)`: menores de 18 anos têm 100 de desconto; maiores de idade estudantes têm 50; os demais, 0. Use condicionais aninhadas.

Função: `descontoDoIngresso`

Código inicial:

```js
function descontoDoIngresso(idade, estudante) {
  // seu código aqui
}
```

Testes:

- entrada [10,false] → retorna 100
- entrada [20,true] → retorna 50
- entrada [20,false] → retorna 0
- entrada [18,true] → retorna 50
- entrada [17,true] → retorna 100

Solução de referência:

```js
function descontoDoIngresso(idade, estudante) {
  if (idade < 18) {
    return 100;
  } else {
    if (estudante) {
      return 50;
    } else {
      return 0;
    }
  }
}
```

**Dica:** Primeiro decida pela idade; só para os maiores de idade pergunte se é estudante.

**Solução comentada:** Se a pessoa tem menos de 18 anos, o desconto é 100. Caso contrário, dentro do else, o desconto depende de ser estudante.

#### 6. Corrija o caminho que faltou

*Corrigir o erro · médio · id `aninhada-corrija-o-else-interno` · conceitos: Condicionais aninhadas (peso 3); Estrutura if/else (peso 1)*

A função `acesso(idade, temIngresso)` devolve undefined para um adulto sem ingresso, mas deveria devolver "sem ingresso". Corrija o defeito.

Função: `acesso`

Código inicial:

```js
function acesso(idade, temIngresso) {
  if (idade >= 18) {
    if (temIngresso) {
      return "entrou";
    }
  } else {
    return "menor";
  }
}
```

Testes:

- entrada [20,true] → retorna "entrou"
- entrada [20,false] → retorna "sem ingresso"
- entrada [15,true] → retorna "menor"
- entrada [15,false] → retorna "menor"

Solução de referência:

```js
function acesso(idade, temIngresso) {
  if (idade >= 18) {
    if (temIngresso) {
      return "entrou";
    } else {
      return "sem ingresso";
    }
  } else {
    return "menor";
  }
}
```

**Dica:** Que caminho cobre o adulto que não tem ingresso?

**Solução comentada:** Faltava um else para o if interno: sem ele, o adulto sem ingresso não passava por nenhum return.

#### 7. Juntando as condições

*Múltipla escolha · médio · id `aninhada-equivalente-com-e` · conceitos: Condicionais aninhadas (peso 3); Operadores lógicos (peso 1)*

Qual condição única equivale a if (a) { if (b) { ... } }?

- ✗ if (a || b) { ... } — *confusão: troca o E por OU*
- ✗ if (!a && b) { ... } — *confusão: inverte a primeira condição*
- ✔ **if (a && b) { ... }** (correta)
- ✗ if (a) if (b) { ... } else { ... } — *confusão: mantém o aninhamento e ainda acrescenta um else que não existia*

**Dica:** O bloco interno só executa quando as duas condições são verdadeiras.

**Ao acertar:** O bloco só executa quando a e b são verdadeiros ao mesmo tempo: a && b.

#### 8. Três níveis

*Interpretação de código · difícil · id `aninhada-tres-niveis` · conceitos: Condicionais aninhadas (peso 3); Estrutura if/else (peso 1)*

O que o programa abaixo mostra na tela?

```
const x = 5;
const y = 10;
if (x > 0) {
  if (y > 20) {
    console.log("A");
  } else {
    if (x < y) {
      console.log("B");
    } else {
      console.log("C");
    }
  }
} else {
  console.log("D");
}
```

- ✗ A — *confusão: avalia y > 20 como verdadeiro*
- ✔ **B** (correta)
- ✗ C — *confusão: avalia x < y como falso*
- ✗ D — *confusão: avalia x > 0 como falso*

**Dica:** Siga os blocos de fora para dentro, anotando a resposta de cada condição.

**Ao acertar:** x > 0 é verdadeiro; y > 20 é falso, então vai para o else; dentro dele, x < y (5 < 10) é verdadeiro: B.

---

## Lição 8 — Estrutura switch

**Foco:** Escolher entre várias opções exatas

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Quando queremos comparar uma mesma variável com vários valores exatos (como o número do dia da semana ou a opção de um menu), o switch deixa o código mais organizado que uma longa cadeia de else if.
> 
> switch (valor) {
>   case 1:
>     ...
>     break;
>   case 2:
>     ...
>     break;
>   default:
>     ...
> }
> 
> O computador compara o valor com cada case usando ===. Ao encontrar o primeiro igual, executa as instruções a partir dali. O break encerra o switch; sem ele, a execução "cai" nos cases seguintes (efeito cascata), mesmo que eles não combinem.
> 
> O default é opcional e funciona como o else: executa quando nenhum case combina. O switch só serve para igualdade exata: para faixas (nota >= 7), use if/else if.

### Exemplo

```
const dia = 3;

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
3. O break encerra o switch. Se ele faltasse, "Outro dia" também seria mostrado.
```

### Revisão

- switch compara um valor com vários cases usando === (igualdade exata).
- O break encerra o switch; sem ele, a execução cai nos cases seguintes.
- default executa quando nenhum case combina (é opcional).
- Para faixas de valores, use if/else if, não switch.

### Exercícios

#### 1. Quando usar o switch?

*Múltipla escolha · fácil · id `switch-quando-usar` · conceitos: Estrutura switch (peso 3)*

Em que situação o switch é mais indicado?

- ✗ Para testar faixas de valores, como nota >= 7 — *confusão: acha que o switch aceita comparações de faixa*
- ✗ Para repetir um bloco várias vezes — *confusão: confunde switch com repetição*
- ✗ Para combinar várias condições com E e OU — *confusão: confunde switch com operadores lógicos*
- ✔ **Para comparar uma variável com vários valores exatos** (correta)

**Dica:** O switch compara com ===, valor por valor.

**Ao acertar:** O switch é ideal para comparar uma variável com valores exatos, como a opção escolhida em um menu.

#### 2. Qual dia?

*Interpretação de código · fácil · id `switch-dia-da-semana` · conceitos: Estrutura switch (peso 3)*

O que o programa abaixo mostra na tela?

```
const dia = 2;
switch (dia) {
  case 1:
    console.log("Domingo");
    break;
  case 2:
    console.log("Segunda");
    break;
  default:
    console.log("Outro dia");
}
```

- ✔ **Segunda** (correta)
- ✗ Domingo — *confusão: acha que o switch executa sempre o primeiro case*
- ✗ Segunda / Outro dia — *confusão: acha que o default executa depois de um case que combinou*
- ✗ Outro dia — *confusão: acha que o default executa mesmo quando um case combina*

**Dica:** Procure o case que combina com 2.

**Ao acertar:** case 2 combina, mostra Segunda, e o break encerra o switch.

#### 3. Complete o break

*Completar a lacuna · fácil · id `switch-complete-o-break` · conceitos: Estrutura switch (peso 3)*

Complete a palavra que encerra o switch depois de um case.

```
const opcao = 1;
switch (opcao) {
  case 1:
    console.log("Novo jogo");
    {{1}};
  case 2:
    console.log("Sair");
    break;
}
```

Respostas aceitas: lacuna 1: break

**Dica:** Sem essa palavra, o código cai no case seguinte.

**Ao acertar:** break encerra o switch e impede que os cases seguintes também executem.

#### 4. Sem break

*Interpretação de código · médio · id `switch-sem-break` · conceitos: Estrutura switch (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
const n = 1;
switch (n) {
  case 1:
    console.log("Um");
  case 2:
    console.log("Dois");
    break;
  case 3:
    console.log("Três");
}
```

- ✗ Um — *confusão: acha que o switch encerra sozinho depois do case que combinou*
- ✗ Um / Dois / Três — *confusão: acha que o break não interrompe a execução*
- ✔ **Um / Dois** (correta)
- ✗ Dois — *confusão: acha que a execução começa no case seguinte*

**Dica:** O primeiro case não tem break.

**Ao acertar:** case 1 combina e mostra Um. Sem break, a execução cai no case 2 (Dois), onde o break finalmente encerra o switch.

#### 5. Nome do dia

*Código · médio · id `switch-nome-do-dia` · conceitos: Estrutura switch (peso 3)*

Escreva a função `nomeDoDia(numero)` que devolve o nome do dia da semana (1 = "domingo", 2 = "segunda", 3 = "terca", 4 = "quarta", 5 = "quinta", 6 = "sexta", 7 = "sabado") e "invalido" para qualquer outro número. Use switch.

Função: `nomeDoDia`

Código inicial:

```js
function nomeDoDia(numero) {
  // seu código aqui
}
```

Testes:

- entrada [1] → retorna "domingo"
- entrada [4] → retorna "quarta"
- entrada [7] → retorna "sabado"
- entrada [0] → retorna "invalido"
- entrada [9] → retorna "invalido"

Solução de referência:

```js
function nomeDoDia(numero) {
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
}
```

**Dica:** Um case para cada dia e um default para o resto.

**Solução comentada:** Cada case devolve o nome; como return já encerra a função, o break não é necessário. O default trata os números fora da lista.

#### 6. Operação escolhida

*Código · médio · id `switch-calculadora-de-operacao` · conceitos: Estrutura switch (peso 3); Operadores aritméticos (peso 1)*

Escreva a função `calcular(operacao, a, b)`: para "+" devolve a + b, para "-" devolve a - b, para "*" devolve a * b, para "/" devolve a / b. Para qualquer outra operação, devolve "operacao invalida". Use switch.

Função: `calcular`

Código inicial:

```js
function calcular(operacao, a, b) {
  // seu código aqui
}
```

Testes:

- entrada ["+",6,3] → retorna 9
- entrada ["-",6,3] → retorna 3
- entrada ["*",6,3] → retorna 18
- entrada ["/",6,3] → retorna 2
- entrada ["%",6,3] → retorna "operacao invalida"

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
      return a / b;
    default:
      return "operacao invalida";
  }
}
```

**Dica:** Compare a operação (um texto) com cada case.

**Solução comentada:** O switch compara o texto da operação com cada case. O default devolve a mensagem para operações desconhecidas.

#### 7. Corrija o break que faltou

*Corrigir o erro · médio · id `switch-corrija-o-break` · conceitos: Estrutura switch (peso 3)*

A função `tipo(codigo)` deveria devolver "fruta" para 1, "legume" para 2 e "outro" nos demais casos, mas devolve sempre "outro" para 1 e 2. Corrija o defeito.

Função: `tipo`

Código inicial:

```js
function tipo(codigo) {
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
```

Testes:

- entrada [1] → retorna "fruta"
- entrada [2] → retorna "legume"
- entrada [3] → retorna "outro"
- entrada [0] → retorna "outro"

Solução de referência:

```js
function tipo(codigo) {
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
}
```

**Dica:** O que acontece depois que um case termina sem break?

**Solução comentada:** Sem break, a execução cai para os cases seguintes e o último valor (outro) sobrescreve os anteriores. Um break depois de cada atribuição resolve.

#### 8. Igualdade estrita no switch

*Interpretação de código · difícil · id `switch-igualdade-estrita` · conceitos: Estrutura switch (peso 3); Conversão de tipos (peso 1)*

O que o programa abaixo mostra na tela?

```
const opcao = "2";
switch (opcao) {
  case 1:
    console.log("Um");
    break;
  case 2:
    console.log("Dois");
    break;
  default:
    console.log("Nenhuma");
}
```

- ✗ Um — *confusão: acha que o switch converte o texto e escolhe o primeiro case*
- ✔ **Nenhuma** (correta)
- ✗ Dois — *confusão: acha que o switch compara sem considerar o tipo (como ==)*
- ✗ Um / Dois — *confusão: acha que os dois cases combinam*

**Dica:** O switch compara usando ===: o texto "2" é igual ao número 2?

**Ao acertar:** O switch usa igualdade estrita (===). O texto "2" não é estritamente igual ao número 2, então nenhum case combina e o default executa.

---

## Lição 9 — Operador ternário

**Foco:** Escrever uma decisão simples em uma só linha

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Este é um conteúdo complementar: ele não bloqueia a liberação do que vem a seguir. Vale estudar, mas você pode seguir em frente sem concluí-lo.
> 
> O operador ternário é um atalho para um if/else simples que escolhe um valor:
> 
> condição ? valorSeVerdadeira : valorSeFalsa
> 
> Ele é uma expressão: produz um valor, que pode ser guardado em uma variável ou devolvido por uma função. Compare:
> 
> let texto;
> if (idade >= 18) { texto = "maior"; } else { texto = "menor"; }
> 
> const texto = idade >= 18 ? "maior" : "menor";
> 
> Use o ternário para decisões curtas. Quando houver muitos caminhos ou blocos com várias instruções, prefira if/else, que fica mais legível.

### Exemplo

```
const nota = 8;
const situacao = nota >= 7 ? "Aprovado" : "Reprovado";
console.log(situacao);

Passo a passo:
1. A condição nota >= 7 é testada: 8 >= 7 é true.
2. Como é verdadeira, o ternário resulta no valor antes dos dois-pontos: "Aprovado".
3. Esse valor é guardado em situacao e mostrado na tela.

Se a nota fosse 5, o resultado seria o valor depois dos dois-pontos: "Reprovado".
```

### Revisão

- condição ? valorSeVerdadeira : valorSeFalsa: um if/else que produz um valor.
- É uma expressão: pode ser guardada em variável ou usada em um return.
- Bom para decisões curtas; para muitos caminhos, prefira if/else.
- Esta lição é complementar e não bloqueia a liberação do que vem depois.

### Exercícios

#### 1. O que é o ternário?

*Múltipla escolha · fácil · id `ternario-o-que-e` · conceitos: Operador ternário (conteúdo complementar) (peso 3)*

O que é o operador ternário?

- ✗ Um operador que compara três valores ao mesmo tempo — *confusão: acha que "ternário" significa comparar três valores*
- ✗ Um laço que repete uma instrução três vezes — *confusão: confunde ternário com repetição*
- ✗ Uma forma de declarar uma variável com três valores — *confusão: confunde ternário com declaração*
- ✔ **Um atalho para um if/else simples que produz um valor** (correta)

**Dica:** Ele tem três partes: condição, valor se verdadeira e valor se falsa.

**Ao acertar:** O ternário é um if/else escrito em uma expressão só: condição ? valorSeVerdadeira : valorSeFalsa.

#### 2. Aprovado ou reprovado?

*Interpretação de código · fácil · id `ternario-situacao` · conceitos: Operador ternário (conteúdo complementar) (peso 3)*

O que o programa abaixo mostra na tela?

```
const nota = 5;
const situacao = nota >= 7 ? "Aprovado" : "Reprovado";
console.log(situacao);
```

- ✔ **Reprovado** (correta)
- ✗ Aprovado — *confusão: acha que o ternário devolve sempre o primeiro valor*
- ✗ true — *confusão: acha que o ternário devolve o resultado da condição*
- ✗ Aprovado Reprovado — *confusão: acha que o ternário devolve os dois valores*

**Dica:** 5 >= 7 é verdadeiro ou falso?

**Ao acertar:** A condição é falsa, então o ternário resulta no valor depois dos dois-pontos: Reprovado.

#### 3. Complete o ternário

*Completar a lacuna · fácil · id `ternario-complete-os-simbolos` · conceitos: Operador ternário (conteúdo complementar) (peso 2)*

Complete o símbolo que separa a condição do primeiro valor.

```
const idade = 20;
const texto = idade >= 18 {{1}} "maior" : "menor";
```

Respostas aceitas: lacuna 1: ?

**Dica:** Ele aparece logo depois da condição.

**Ao acertar:** O ponto de interrogação vem depois da condição e os dois-pontos separam os dois valores.

#### 4. Par ou ímpar em uma linha

*Código · médio · id `ternario-par-ou-impar` · conceitos: Operador ternário (conteúdo complementar) (peso 3); Operadores aritméticos (peso 1)*

Escreva a função `parOuImpar(n)` que devolve "par" ou "impar" usando o operador ternário, em um único return.

Função: `parOuImpar`

Código inicial:

```js
function parOuImpar(n) {
  // seu código aqui
}
```

Testes:

- entrada [2] → retorna "par"
- entrada [9] → retorna "impar"
- entrada [0] → retorna "par"

Solução de referência:

```js
function parOuImpar(n) {
  return n % 2 === 0 ? "par" : "impar";
}
```

**Dica:** return condição ? "par" : "impar";

**Solução comentada:** O ternário escolhe o valor a devolver conforme n % 2 === 0.

#### 5. Valor absoluto

*Código · médio · id `ternario-valor-absoluto` · conceitos: Operador ternário (conteúdo complementar) (peso 3); Operadores relacionais (peso 1)*

Escreva a função `absoluto(n)` que devolve o número sem sinal (por exemplo, -5 vira 5). Use o operador ternário e não use Math.abs.

Função: `absoluto`

Código inicial:

```js
function absoluto(n) {
  // seu código aqui
}
```

Testes:

- entrada [5] → retorna 5
- entrada [-5] → retorna 5
- entrada [0] → retorna 0
- entrada [-2.5] → retorna 2.5

Solução de referência:

```js
function absoluto(n) {
  return n < 0 ? -n : n;
}
```

**Dica:** Se n for negativo, devolva -n; senão, devolva n.

**Solução comentada:** Quando n < 0, o oposto -n é positivo; caso contrário, o próprio n já serve.

#### 6. Corrija o ternário

*Corrigir o erro · médio · id `ternario-corrija-a-ordem` · conceitos: Operador ternário (conteúdo complementar) (peso 3)*

A função `situacao(nota)` deveria devolver "aprovado" para 7 ou mais, mas devolve o contrário. Corrija o defeito.

Função: `situacao`

Código inicial:

```js
function situacao(nota) {
  return nota >= 7 ? "reprovado" : "aprovado";
}
```

Testes:

- entrada [8] → retorna "aprovado"
- entrada [7] → retorna "aprovado"
- entrada [3] → retorna "reprovado"

Solução de referência:

```js
function situacao(nota) {
  return nota >= 7 ? "aprovado" : "reprovado";
}
```

**Dica:** Qual valor fica depois do ponto de interrogação?

**Solução comentada:** O valor depois do ? é usado quando a condição é verdadeira. Os dois textos estavam trocados.

#### 7. Ternário em cadeia

*Interpretação de código · difícil · id `ternario-aninhado` · conceitos: Operador ternário (conteúdo complementar) (peso 3); Estrutura else if (peso 1)*

O que o programa abaixo mostra na tela?

```
const n = 0;
const texto = n > 0 ? "positivo" : n < 0 ? "negativo" : "zero";
console.log(texto);
```

- ✗ positivo — *confusão: avalia n > 0 como verdadeiro*
- ✗ negativo — *confusão: avalia n < 0 como verdadeiro*
- ✔ **zero** (correta)
- ✗ true — *confusão: acha que o ternário devolve o resultado da condição*

**Dica:** Leia como uma cadeia if / else if / else.

**Ao acertar:** 0 > 0 é falso; 0 < 0 também é falso; resta o último valor: zero.

---

## Lição 10 — Desafio final do Mundo 4

**Foco:** Juntar as condicionais em um sistema de notas

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Chegou o desafio do Mundo 4: um sistema de notas. O programa recebe as notas de um aluno, calcula a média e informa a situação: aprovado, recuperação ou reprovado.
> 
> Aqui você vai usar tudo o que aprendeu: operadores aritméticos para a média, relacionais para comparar, lógicos para combinar condições e as estruturas condicionais para decidir.
> 
> O desafio principal é o primeiro exercício. Os outros dois treinam a leitura e a correção de decisões encadeadas.

### Exemplo

```
Como montar o sistema de notas:
1. Leia as três notas com lerEntrada() e converta cada uma com Number().
2. Calcule a média: (n1 + n2 + n3) / 3.
3. Decida a situação com if / else if / else: média >= 7 é Aprovado, média >= 5 é Recuperação, o restante é Reprovado.
4. Mostre a média e a situação com console.log.
5. Teste os limites (média exatamente 7 e exatamente 5): é aí que mais aparecem erros.
```

### Revisão

- A média usa parênteses: (n1 + n2 + n3) / 3.
- if / else if / else escolhe um único caminho, testando de cima para baixo.
- Coloque as condições na ordem certa: da faixa mais alta para a mais baixa.
- Teste os valores de fronteira (>= ou >).
- Em toda comparação, use === (e não =).

### Exercícios

#### 1. Desafio: sistema de notas

*Desafio · difícil · id `desafio4-sistema-de-notas` · conceitos: Estrutura else if (peso 2); Operadores aritméticos (peso 2); Operadores relacionais (peso 2); Entrada e saída de informações (peso 1); Conversão de tipos (peso 1)*

Escreva a função `sistemaDeNotas()`: leia três notas com `lerEntrada()` (chegam como texto), calcule a média e mostre duas linhas com `console.log`: `Média: <valor>` e `Situação: <texto>`. A situação é Aprovado (média 7 ou mais), Recuperação (5 ou mais, mas menos de 7) ou Reprovado (menos de 5).

Função: `sistemaDeNotas`

Código inicial:

```js
function sistemaDeNotas() {
  // leia as notas, calcule a média e mostre as duas linhas
}
```

Testes:

- entrada [], lê ["9","8","10"] → imprime ["Média: 9","Situação: Aprovado"]
- entrada [], lê ["6","7","5"] → imprime ["Média: 6","Situação: Recuperação"]
- entrada [], lê ["2","3","4"] → imprime ["Média: 3","Situação: Reprovado"]
- entrada [], lê ["7","7","7"] → imprime ["Média: 7","Situação: Aprovado"]
- entrada [], lê ["5","5","5"] → imprime ["Média: 5","Situação: Recuperação"]

Solução de referência:

```js
function sistemaDeNotas() {
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
}
```

**Dica:** Calcule a média com parênteses e depois use if / else if / else, começando pela faixa mais alta.

**Solução comentada:** Depois de converter as entradas e calcular a média, a cadeia if / else if / else escolhe a situação. Os testes de fronteira (7 e 5) conferem se o >= foi usado corretamente.

#### 2. Desafio: corrija o desconto

*Corrigir o erro · difícil · id `desafio4-corrija-o-desconto` · conceitos: Estrutura else if (peso 3); Condicionais aninhadas (peso 2); Operadores lógicos (peso 1)*

A função `desconto(valor, cliente)` deveria dar 20% de desconto a clientes "vip" e 10% aos demais clientes quando o valor for 100 ou mais; abaixo de 100, não há desconto. Ela devolve o valor final, mas hoje calcula errado em alguns casos. Corrija o defeito.

Função: `desconto`

Código inicial:

```js
function desconto(valor, cliente) {
  if (valor >= 100) {
    return valor * 0.9;
  } else if (cliente === "vip") {
    return valor * 0.8;
  } else {
    return valor;
  }
}
```

Testes:

- entrada [200,"vip"] → retorna 160
- entrada [200,"comum"] → retorna 180
- entrada [50,"vip"] → retorna 50
- entrada [50,"comum"] → retorna 50
- entrada [100,"vip"] → retorna 80

Solução de referência:

```js
function desconto(valor, cliente) {
  if (valor >= 100) {
    if (cliente === "vip") {
      return valor * 0.8;
    } else {
      return valor * 0.9;
    }
  } else {
    return valor;
  }
}
```

**Dica:** O desconto vip só vale quando o valor também atinge 100. Que decisão vem primeiro?

**Solução comentada:** O desconto só existe a partir de 100; dentro dessa faixa, o cliente vip tem 20% e os demais 10%. A estrutura original decidia pelo valor e só olhava o cliente quando o valor era menor.

#### 3. Desafio: acompanhe as decisões

*Interpretação de código · difícil · id `desafio4-acompanhe-as-decisoes` · conceitos: Estrutura else if (peso 2); Condicionais aninhadas (peso 2); Estrutura if (peso 2); Operadores lógicos (peso 2)*

Acompanhe cada condição. O que o programa abaixo mostra na tela, em ordem?

```
const idade = 17;
const autorizado = true;
let resultado = "";
if (idade >= 18) {
  resultado = "adulto";
} else if (idade >= 16 && autorizado) {
  resultado = "menor autorizado";
} else {
  resultado = "barrado";
}
if (resultado !== "barrado") {
  console.log("Entrada liberada");
}
console.log(resultado);
```

- ✗ adulto — *confusão: avalia 17 >= 18 como verdadeiro e ignora a segunda linha*
- ✔ **Entrada liberada / menor autorizado** (correta)
- ✗ Entrada liberada / adulto — *confusão: avalia 17 >= 18 como verdadeiro*
- ✗ barrado — *confusão: acha que a idade 17 cai direto no else*

**Dica:** Siga a primeira cadeia até encontrar a condição verdadeira; depois avalie o segundo if.

**Ao acertar:** 17 >= 18 é falso; 17 >= 16 && true é verdadeiro, então resultado vira "menor autorizado". Como é diferente de "barrado", mostra Entrada liberada e depois o resultado.

