# Revisão do conteúdo — Variáveis e Tipos de Dados

> GERADO por `npm run content:review`. Não edite este arquivo: ele muda quando o conteúdo mudar.

**Objetivo do mundo:** Ensinar o aluno a armazenar, identificar e manipular informações.

Este documento reúne tudo o que os alunos vão ver neste mundo: 14 lições e 99 exercícios. **Nada foi publicado:** os exercícios estão como rascunho e só o professor os vê.

## Como revisar
1. Leia cada lição (texto, exemplo, revisão e exercícios) como se fosse um aluno iniciante.
2. Confira o gabarito (✔) e as "confusões" das alternativas erradas: elas alimentam o painel de dificuldades.
3. Anote ajustes por lição. Peça a correção ao Claude, que altera os arquivos de `content/`.
4. Quando aprovar, publique com `npm run content:publish -- mundo-2` (gera o SQL para colar no Supabase).

## Resumo
| Lição | Exercícios | Fácil | Médio | Difícil | Tipos |
|---|---:|---:|---:|---:|---|
| Introdução às variáveis | 7 | 3 | 3 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 ordenação |
| Declaração de variáveis | 7 | 3 | 3 | 1 | 3 múltipla escolha, 1 completar a lacuna, 2 interpretação de código, 1 corrigir o erro |
| Utilização de let e const | 7 | 3 | 3 | 1 | 3 múltipla escolha, 1 completar a lacuna, 2 interpretação de código, 1 corrigir o erro |
| Tipo String | 7 | 3 | 3 | 1 | 3 múltipla escolha, 2 interpretação de código, 1 completar a lacuna, 1 corrigir o erro |
| Tipo Number | 7 | 3 | 3 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 código |
| Tipo Boolean | 7 | 3 | 3 | 1 | 2 múltipla escolha, 4 interpretação de código, 1 completar a lacuna |
| Manipulação de textos | 7 | 3 | 3 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 código |
| Concatenação | 8 | 3 | 4 | 1 | 1 múltipla escolha, 4 interpretação de código, 1 completar a lacuna, 1 ordenação, 1 código |
| Template literals | 8 | 3 | 4 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 corrigir o erro, 1 código |
| Operações com números | 7 | 3 | 3 | 1 | 2 múltipla escolha, 3 interpretação de código, 1 completar a lacuna, 1 código |
| Conversão de tipos | 8 | 3 | 4 | 1 | 1 múltipla escolha, 4 interpretação de código, 1 completar a lacuna, 1 corrigir o erro, 1 código |
| Entrada e saída de informações | 8 | 3 | 4 | 1 | 1 múltipla escolha, 2 interpretação de código, 3 código, 1 ordenação, 1 corrigir o erro |
| Utilização de console.log() | 8 | 3 | 4 | 1 | 1 múltipla escolha, 4 interpretação de código, 1 completar a lacuna, 1 código, 1 corrigir o erro |
| Desafio final do Mundo 2 | 3 | 0 | 0 | 3 | 1 desafio, 1 corrigir o erro, 1 interpretação de código |

---

## Lição 1 — Introdução às variáveis

**Foco:** Entender a variável como um nome que guarda um valor

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Um programa precisa guardar informações: o nome de uma pessoa, uma idade, um saldo. Para isso usamos variáveis.
> 
> Uma variável é um nome que guarda um valor na memória do computador. Pense em uma caixa com uma etiqueta: a etiqueta é o nome da variável e o que está dentro da caixa é o valor. Quando precisamos do valor, chamamos a variável pelo nome.
> 
> O valor pode mudar ao longo do programa (daí o nome "variável"). Para guardar um valor em uma variável, usamos o sinal =. Atenção: em programação, = não significa "igual a" como na matemática. Ele manda guardar: "idade = 21" lê-se "idade recebe 21". Isso se chama atribuição.

### Exemplo

```
let idade = 20;
console.log(idade);   // mostra 20

idade = 21;           // troca o valor guardado
console.log(idade);   // mostra 21

Passo a passo:
1. let idade = 20; cria a variável idade e guarda o valor 20 nela.
2. console.log(idade); mostra o valor guardado (20), e não a palavra "idade".
3. idade = 21; substitui o valor antigo por 21. O 20 se perde.
4. O último console.log mostra 21.

Repare que o nome da variável não vai entre aspas: as aspas serviriam para mostrar o texto "idade" em vez do valor.
```

### Revisão

- Variável é um nome que guarda um valor na memória.
- O valor guardado pode mudar durante o programa.
- O sinal = guarda um valor na variável (atribuição); não é "igual" da matemática.
- Para usar o valor, escrevemos o nome da variável, sem aspas.
- Ao guardar um novo valor, o antigo é substituído.

### Exercícios

#### 1. O que é uma variável?

*Múltipla escolha · fácil · id `variaveis-o-que-e` · conceitos: Introdução às variáveis (peso 3)*

O que é uma variável em um programa?

- ✗ Um valor que nunca pode mudar — *confusão: confunde variável com um valor fixo*
- ✔ **Um nome que guarda um valor na memória do computador** (correta)
- ✗ Um comando que mostra algo na tela — *confusão: confunde variável com o comando console.log*
- ✗ Um erro que aparece quando o programa muda — *confusão: associa a palavra "variável" a algo que dá defeito*

**Dica:** Pense em uma caixa com etiqueta: o nome é a etiqueta e o valor é o conteúdo.

**Ao acertar:** Uma variável é um nome associado a um valor guardado na memória. O valor pode ser consultado e trocado quando for preciso.

#### 2. O que aparece na tela?

*Interpretação de código · fácil · id `variaveis-mostrar-valor` · conceitos: Introdução às variáveis (peso 3)*

Veja o programa abaixo. O que ele mostra na tela?

```
let pontos = 10;
console.log(pontos);
```

- ✗ pontos — *confusão: mostra o nome da variável em vez do valor guardado nela*
- ✗ let pontos — *confusão: acha que o console.log repete a declaração*
- ✗ Nada, porque faltou o ponto e vírgula — *confusão: acha que o programa não funciona sem aquele sinal*
- ✔ **10** (correta)

**Dica:** console.log mostra o valor que a variável guarda.

**Ao acertar:** A variável pontos guarda o número 10. Ao escrever pontos dentro do console.log, o computador mostra o valor guardado: 10.

#### 3. Guarde e mostre a idade

*Completar a lacuna · fácil · id `variaveis-complete-idade` · conceitos: Introdução às variáveis (peso 2)*

Complete o programa para guardar o número 18 na variável idade e mostrar o valor dela.

```
let {{1}} = 18;
console.log({{2}});
```

Respostas aceitas: lacuna 1: idade; lacuna 2: idade

**Dica:** O mesmo nome é usado para guardar e para consultar o valor.

**Ao acertar:** O nome idade identifica a variável tanto na declaração quanto no console.log, que mostra o valor guardado (18).

#### 4. E o valor antigo?

*Interpretação de código · médio · id `variaveis-trocar-o-valor` · conceitos: Introdução às variáveis (peso 3)*

O que o programa abaixo mostra na tela?

```
let saldo = 100;
saldo = 150;
console.log(saldo);
```

- ✔ **150** (correta)
- ✗ 100 — *confusão: acha que o primeiro valor guardado nunca é substituído*
- ✗ 250 — *confusão: acha que o novo valor é somado ao antigo*
- ✗ saldo — *confusão: mostra o nome da variável em vez do valor guardado nela*

**Dica:** O que acontece com o valor antigo quando guardamos um novo?

**Ao acertar:** A atribuição saldo = 150 substitui o valor 100. O valor antigo se perde e o console.log mostra 150.

#### 5. Ordene o programa

*Ordenação · médio · id `variaveis-ordene-o-programa` · conceitos: Introdução às variáveis (peso 3); Sequência lógica (peso 1)*

Coloque as linhas na ordem certa para o programa mostrar o número 2.

Ordem correta:

1. let contador = 1;
2. contador = 2;
3. console.log(contador);

**Dica:** A variável precisa existir antes de ser usada, e o valor novo precisa ser guardado antes de ser mostrado.

**Ao acertar:** Primeiro criamos a variável, depois guardamos o novo valor e, por fim, mostramos o resultado.

#### 6. O que significa o =?

*Múltipla escolha · médio · id `variaveis-sinal-de-igual` · conceitos: Introdução às variáveis (peso 3)*

Na linha idade = 21; o que o sinal = faz?

- ✗ Afirma que idade é igual a 21, como na matemática — *confusão: lê o = como igualdade matemática e não como atribuição*
- ✗ Compara idade com 21 e mostra true ou false — *confusão: confunde atribuição com comparação*
- ✔ **Guarda o valor 21 na variável idade** (correta)
- ✗ Cria uma variável chamada 21 — *confusão: inverte os lados da atribuição*

**Dica:** Leia como "idade recebe 21".

**Ao acertar:** O = é o operador de atribuição: guarda o valor da direita na variável da esquerda. Comparar é outra operação, que veremos mais adiante.

#### 7. Quanto vale b?

*Interpretação de código · difícil · id `variaveis-copia-de-valor` · conceitos: Introdução às variáveis (peso 3)*

Acompanhe os valores e responda: o que o programa mostra?

```
let a = 5;
let b = a;
a = 8;
console.log(b);
```

- ✗ 8 — *confusão: acha que b acompanha as mudanças de a*
- ✔ **5** (correta)
- ✗ 13 — *confusão: soma os dois valores*
- ✗ a — *confusão: mostra o nome da variável em vez do valor guardado nela*

**Dica:** b recebeu uma cópia do valor que a tinha naquele momento.

**Ao acertar:** Ao fazer b = a, a variável b guarda o valor 5 (uma cópia). Mudar a depois não altera b: ele continua valendo 5.

---

## Lição 2 — Declaração de variáveis

**Foco:** Declarar variáveis e escolher nomes válidos

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Declarar uma variável é criá-la. Em JavaScript usamos a palavra let, seguida do nome. Podemos já guardar um valor (inicializar) ou deixar a variável sem valor, e então ela vale undefined, que significa "ainda não tem valor".
> 
> Regras para os nomes:
> - podem ter letras, números, _ e $;
> - não podem começar com número nem ter espaços;
> - não podem ser palavras reservadas da linguagem (let, const, if...);
> - maiúsculas e minúsculas fazem diferença: idade e Idade são variáveis diferentes.
> 
> Boas práticas: use nomes que expliquem o conteúdo (notaFinal, e não x) e o estilo camelCase (a primeira palavra em minúsculas e as seguintes com inicial maiúscula). Cada instrução termina com ponto e vírgula.

### Exemplo

```
let nome = "Ana";        // declara e já guarda um valor
let idade;               // declara sem valor
console.log(idade);      // undefined
idade = 30;              // agora guarda 30
let notaFinal = 8.5;     // nome em camelCase

Passo a passo:
1. let nome = "Ana"; cria a variável nome e guarda o texto Ana.
2. let idade; cria a variável, mas ela ainda não tem valor: vale undefined.
3. idade = 30; guarda o valor depois. Aqui não usamos let de novo, porque a variável já existe.
4. notaFinal é um nome claro e segue o camelCase.
```

### Revisão

- let cria uma variável: let nome = valor;
- Sem valor inicial, a variável vale undefined.
- Nomes: letras, números, _ e $; sem espaços; não começam com número; não podem ser palavras reservadas.
- Maiúsculas e minúsculas são diferentes: idade e Idade não são a mesma variável.
- Prefira nomes claros em camelCase.

### Exercícios

#### 1. Qual nome é válido?

*Múltipla escolha · fácil · id `declaracao-nome-valido` · conceitos: Declaração de variáveis (peso 3)*

Qual destes é um nome de variável válido?

- ✗ 1nota — *confusão: acha que o nome pode começar com número*
- ✗ nota final — *confusão: esquece que o nome não pode ter espaços*
- ✗ let — *confusão: usa uma palavra reservada como nome*
- ✔ **nota1** (correta)

**Dica:** O nome pode ter números, mas não pode começar por um.

**Ao acertar:** nota1 usa só letras e número e não começa com número. Espaços e palavras reservadas, como let, não são permitidos.

#### 2. Qual linha declara a variável?

*Múltipla escolha · fácil · id `declaracao-linha-correta` · conceitos: Declaração de variáveis (peso 3)*

Qual linha declara a variável cidade guardando o texto "Picos"?

- ✔ **let cidade = "Picos";** (correta)
- ✗ cidade let = "Picos"; — *confusão: inverte a ordem: a palavra let vem antes do nome*
- ✗ let cidade == "Picos"; — *confusão: usa == (comparação) no lugar de = (atribuição)*
- ✗ let "cidade" = Picos; — *confusão: troca as aspas: o texto vai entre aspas, o nome da variável não*

**Dica:** A palavra let vem primeiro; depois o nome; depois o = e o valor.

**Ao acertar:** A forma correta é let nome = valor;. O texto vai entre aspas e o nome da variável, não.

#### 3. Complete a declaração

*Completar a lacuna · fácil · id `declaracao-complete` · conceitos: Declaração de variáveis (peso 2); Introdução às variáveis (peso 1)*

Complete o programa para declarar a variável nome com o texto Ana e mostrá-la.

```
{{1}} nome = "Ana";
console.log({{2}});
```

Respostas aceitas: lacuna 1: let; lacuna 2: nome

**Dica:** A declaração começa com a palavra reservada que cria variáveis.

**Ao acertar:** let cria a variável e console.log(nome) mostra o valor guardado nela.

#### 4. Variável sem valor

*Interpretação de código · médio · id `declaracao-sem-valor` · conceitos: Declaração de variáveis (peso 3)*

O que o programa abaixo mostra na tela?

```
let nome;
console.log(nome);
```

- ✗ Um texto vazio — *confusão: acha que uma variável sem valor guarda um texto vazio*
- ✗ 0 — *confusão: acha que uma variável sem valor guarda zero*
- ✔ **undefined** (correta)
- ✗ Nada: dá erro, porque a variável não tem valor — *confusão: acha que declarar sem valor causa erro*

**Dica:** A variável existe, mas ninguém guardou nada nela.

**Ao acertar:** Uma variável declarada sem valor vale undefined, que significa "ainda sem valor". Isso não é um erro.

#### 5. Idade ou idade?

*Interpretação de código · médio · id `declaracao-maiuscula-minuscula` · conceitos: Declaração de variáveis (peso 3)*

O que acontece ao executar o programa abaixo?

```
let idade = 20;
console.log(Idade);
```

- ✗ Mostra 20 — *confusão: acha que maiúsculas e minúsculas não fazem diferença*
- ✔ **Dá erro, porque Idade (com I maiúsculo) nunca foi declarada** (correta)
- ✗ Mostra Idade — *confusão: acha que o console.log mostra o nome como texto*
- ✗ Mostra undefined — *confusão: acha que uma variável que não existe vale undefined*

**Dica:** Compare as duas grafias letra por letra.

**Ao acertar:** O JavaScript diferencia maiúsculas de minúsculas. Idade e idade são nomes diferentes, e Idade não existe: o programa para com um erro.

#### 6. Corrija o nome da variável

*Corrigir o erro · médio · id `declaracao-corrija-o-nome` · conceitos: Declaração de variáveis (peso 3); Retorno com return (peso 1)*

A função `quadrado(numero)` deveria devolver o número multiplicado por ele mesmo, mas tem um defeito no nome de uma variável. Corrija.

Função: `quadrado`

Código inicial:

```js
function quadrado(numero) {
  let resultado = numero * numero;
  return Resultado;
}
```

Testes:

- entrada [3] → retorna 9
- entrada [5] → retorna 25
- entrada [0] → retorna 0

Solução de referência:

```js
function quadrado(numero) {
  let resultado = numero * numero;
  return resultado;
}
```

**Dica:** Compare a variável criada com a variável devolvida.

**Solução comentada:** O defeito estava na grafia: Resultado (maiúsculo) não existe, porque a variável se chama resultado. Em JavaScript, maiúsculas e minúsculas contam.

#### 7. Só nomes válidos

*Múltipla escolha · difícil · id `declaracao-so-nomes-validos` · conceitos: Declaração de variáveis (peso 3)*

Qual alternativa tem SOMENTE nomes de variável válidos?

- ✗ 2aluno, total, preco — *confusão: aceita um nome que começa com número*
- ✗ nota final, total, preco — *confusão: aceita um nome com espaço*
- ✗ let, const, total — *confusão: aceita palavras reservadas como nome*
- ✔ **total, nota_final, $preco, aluno2** (correta)

**Dica:** Verifique cada nome: começo, espaços e palavras reservadas.

**Ao acertar:** total, nota_final, $preco e aluno2 seguem as regras: só letras, números, _ e $, e nenhum começa com número.

---

## Lição 3 — Utilização de let e const

**Foco:** Escolher entre let (valor muda) e const (valor fixo)

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Há duas formas de declarar uma variável em JavaScript:
> - let: o valor pode ser trocado depois.
> - const: o valor é fixo. Depois de guardado, não pode ser substituído, e a variável precisa receber o valor na própria declaração.
> 
> Se o programa tentar mudar uma const, ele para com o erro "Assignment to constant variable".
> 
> Regra prática: use const para o que não muda (o valor de PI, uma taxa, o nome do curso) e let para o que muda (um contador, um saldo, uma pontuação). Assim quem lê o código sabe, só pela palavra, se o valor pode mudar. Existe também a palavra var, mais antiga; neste curso usamos só let e const.

### Exemplo

```
const PI = 3.14159;     // não muda
let raio = 2;           // pode mudar
raio = 5;               // ok: let aceita um novo valor
// PI = 3;              // ERRO: Assignment to constant variable
console.log(PI * raio); // 15.70795

Passo a passo:
1. PI é uma const: o valor 3.14159 nunca muda.
2. raio é uma let: começa em 2 e depois recebe 5.
3. A linha comentada com // tentaria mudar a const PI e causaria um erro, por isso ela está desativada.
4. O resultado é 3.14159 * 5 = 15.70795.
```

### Revisão

- let: o valor pode mudar. const: o valor é fixo.
- const precisa receber o valor na declaração.
- Mudar uma const causa o erro "Assignment to constant variable".
- Use const por padrão e let só quando o valor precisar mudar.
- Não declare a mesma variável duas vezes no mesmo lugar.

### Exercícios

#### 1. Qual palavra permite mudar o valor?

*Múltipla escolha · fácil · id `letconst-palavra-que-muda` · conceitos: Utilização de let e const (peso 3)*

Qual palavra declara uma variável cujo valor pode ser trocado depois?

- ✔ **let** (correta)
- ✗ const — *confusão: confunde constante com variável que pode mudar*
- ✗ mudar — *confusão: acha que existe uma palavra chamada mudar*
- ✗ valor — *confusão: confunde o conteúdo da variável com a palavra que a declara*

**Dica:** A outra palavra é a que fixa o valor.

**Ao acertar:** let cria variáveis que podem receber novos valores. const cria valores fixos.

#### 2. Quando usar const?

*Múltipla escolha · fácil · id `letconst-quando-usar-const` · conceitos: Utilização de let e const (peso 3)*

Qual destes valores combina melhor com const?

- ✗ O saldo de uma conta bancária — *confusão: usa const para um valor que muda a todo momento*
- ✗ A pontuação de um jogador — *confusão: usa const para um valor que muda durante o jogo*
- ✔ **O valor de PI (3,14159)** (correta)
- ✗ O número de tentativas já usadas — *confusão: usa const para um valor que aumenta a cada tentativa*

**Dica:** Escolha o valor que nunca muda.

**Ao acertar:** O valor de PI é sempre o mesmo, então é uma boa const. Saldo, pontuação e tentativas mudam, e pedem let.

#### 3. let ou const?

*Completar a lacuna · fácil · id `letconst-complete` · conceitos: Utilização de let e const (peso 3)*

Complete as declarações: PI nunca muda e raio pode mudar depois.

```
{{1}} PI = 3.14;
{{2}} raio = 5;
```

Respostas aceitas: lacuna 1: const; lacuna 2: let

**Dica:** Uma palavra fixa o valor; a outra permite trocá-lo.

**Ao acertar:** PI é um valor fixo (const) e raio pode receber outro valor (let).

#### 4. Mudando uma const

*Interpretação de código · médio · id `letconst-alterando-const` · conceitos: Utilização de let e const (peso 3)*

O que acontece ao executar o programa abaixo?

```
const taxa = 0.1;
taxa = 0.2;
console.log(taxa);
```

- ✗ Mostra 0.2 — *confusão: acha que uma const pode receber um novo valor*
- ✔ **Dá erro: não é possível alterar uma const** (correta)
- ✗ Mostra 0.1, ignorando a segunda linha — *confusão: acha que o programa ignora a tentativa de mudar a const*
- ✗ Mostra taxa — *confusão: mostra o nome da variável em vez do valor guardado nela*

**Dica:** Veja qual palavra declarou a variável taxa.

**Ao acertar:** taxa foi declarada com const, então a linha taxa = 0.2 causa o erro "Assignment to constant variable" e o programa para.

#### 5. Quantos pontos?

*Interpretação de código · médio · id `letconst-somando-pontos` · conceitos: Utilização de let e const (peso 2); Introdução às variáveis (peso 1)*

O que o programa abaixo mostra na tela?

```
let pontos = 10;
pontos = pontos + 5;
console.log(pontos);
```

- ✗ 10 — *confusão: ignora a nova atribuição*
- ✗ 5 — *confusão: acha que o novo valor substitui o antigo sem usá-lo no cálculo*
- ✗ pontos + 5 — *confusão: acha que o computador mostra a expressão em vez de calculá-la*
- ✔ **15** (correta)

**Dica:** Primeiro o computador calcula o lado direito, usando o valor atual de pontos.

**Ao acertar:** pontos + 5 vale 10 + 5 = 15. Esse resultado é guardado em pontos, substituindo o 10.

#### 6. Corrija a área do círculo

*Corrigir o erro · médio · id `letconst-corrija-a-area` · conceitos: Utilização de let e const (peso 3); Tipo Number (peso 1)*

A função `areaDoCirculo(raio)` deveria devolver a área (3.14 * raio * raio), mas dá erro. Corrija o defeito.

Função: `areaDoCirculo`

Código inicial:

```js
function areaDoCirculo(raio) {
  const PI = 3.14;
  const area = 0;
  area = PI * raio * raio;
  return area;
}
```

Testes:

- entrada [1] → retorna 3.14
- entrada [2] → retorna 12.56
- entrada [0] → retorna 0

Solução de referência:

```js
function areaDoCirculo(raio) {
  const PI = 3.14;
  let area = 0;
  area = PI * raio * raio;
  return area;
}
```

**Dica:** Qual declaração está sendo alterada depois de criada?

**Solução comentada:** area foi declarada com const e depois recebeu outro valor. Como ela muda, deve ser let (ou ser declarada já com o resultado).

#### 7. Qual dupla de linhas funciona?

*Múltipla escolha · difícil · id `letconst-qual-funciona` · conceitos: Utilização de let e const (peso 3); Declaração de variáveis (peso 1)*

Qual das duplas de linhas abaixo funciona, sem causar erro?

- ✔ **let total; / total = 5;** (correta)
- ✗ const total = 0; / total = 5; — *confusão: acha que uma const pode ser alterada depois*
- ✗ const total; / total = 5; — *confusão: acha que uma const pode ser declarada sem valor e preenchida depois*
- ✗ let total = 0; / let total = 5; — *confusão: acha que a mesma variável pode ser declarada duas vezes*

**Dica:** Teste cada dupla: const não muda, e uma variável só é declarada uma vez.

**Ao acertar:** let total; cria a variável e total = 5; guarda o valor. As outras duplas alteram uma const, declaram uma const sem valor ou repetem a declaração.

---

## Lição 4 — Tipo String

**Foco:** Reconhecer e escrever textos (strings)

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Todo valor tem um tipo, que define o que ele é e o que podemos fazer com ele. O primeiro tipo que vamos estudar é a string: um texto, isto é, uma sequência de caracteres entre aspas.
> 
> - Podemos usar aspas duplas ("Ana"), aspas simples ('Ana') ou crases (veremos mais adiante). A aspa que abre precisa ser a mesma que fecha.
> - O texto vazio ("") também é uma string.
> - Atenção: "42" entre aspas é um texto, e não um número. O que está entre aspas é tratado como texto, mesmo que pareça outra coisa.
> - Sem aspas, o computador entende que Ana é o nome de uma variável, e não um texto.
> 
> Para descobrir o tipo de um valor usamos typeof.

### Exemplo

```
const nome = "Ana";
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
3. Para mostrar aspas dentro do texto, usamos outro tipo de aspas por fora: por fora aspas simples, por dentro aspas duplas.
```

### Revisão

- String é um texto: uma sequência de caracteres entre aspas.
- As aspas que abrem e fecham devem ser do mesmo tipo.
- "42" entre aspas é texto, não número.
- Sem aspas, o nome é entendido como uma variável.
- typeof mostra o tipo de um valor.

### Exercícios

#### 1. Qual valor é uma string?

*Múltipla escolha · fácil · id `string-qual-e-texto` · conceitos: Tipo String (peso 3)*

Qual destes valores é uma string?

- ✗ 42 — *confusão: acha que todo número é um texto*
- ✗ true — *confusão: confunde o valor lógico true com um texto*
- ✔ **"42"** (correta)
- ✗ Ana — *confusão: esquece as aspas: sem aspas, Ana seria o nome de uma variável*

**Dica:** Procure o valor que está entre aspas.

**Ao acertar:** O que está entre aspas é uma string, mesmo quando parece um número. Sem aspas, 42 é número e Ana seria o nome de uma variável.

#### 2. Qual é o tipo?

*Interpretação de código · fácil · id `string-typeof-numero-entre-aspas` · conceitos: Tipo String (peso 3)*

O que o programa abaixo mostra na tela?

```
const valor = "7";
console.log(typeof valor);
```

- ✗ number — *confusão: acha que um número entre aspas continua sendo número*
- ✔ **string** (correta)
- ✗ 7 — *confusão: mostra o valor em vez do tipo*
- ✗ valor — *confusão: mostra o nome da variável em vez do tipo*

**Dica:** Repare nas aspas em volta do 7.

**Ao acertar:** As aspas fazem de "7" um texto, então typeof mostra string.

#### 3. Complete as aspas

*Completar a lacuna · fácil · id `string-complete-as-aspas` · conceitos: Tipo String (peso 2)*

Complete as aspas (use aspas duplas) para guardar o texto gato na variável animal.

```
const animal = {{1}}gato{{2}};
console.log(typeof animal);
```

Respostas aceitas: lacuna 1: "; lacuna 2: "

**Dica:** O texto começa e termina com o mesmo símbolo.

**Ao acertar:** As aspas duplas delimitam o texto. Com elas, typeof animal mostra string.

#### 4. true ou "true"?

*Interpretação de código · médio · id `string-typeof-true-entre-aspas` · conceitos: Tipo String (peso 3); Tipo Boolean (peso 1)*

O que o programa abaixo mostra na tela?

```
console.log(typeof "true");
console.log(typeof true);
```

- ✗ boolean / boolean — *confusão: acha que as aspas não mudam o tipo do valor*
- ✗ string / string — *confusão: acha que o valor true é sempre um texto*
- ✗ boolean / string — *confusão: inverte os tipos*
- ✔ **string / boolean** (correta)

**Dica:** Um dos valores está entre aspas e o outro não.

**Ao acertar:** "true" entre aspas é um texto (string). true sem aspas é um valor lógico (boolean).

#### 5. Aspas dentro do texto

*Múltipla escolha · médio · id `string-aspas-dentro-do-texto` · conceitos: Tipo String (peso 3)*

Qual linha mostra corretamente o texto: Ele disse "oi"?

- ✔ **console.log('Ele disse "oi"');** (correta)
- ✗ console.log("Ele disse "oi""); — *confusão: usa o mesmo tipo de aspas por dentro e por fora, e o texto termina antes da hora*
- ✗ console.log(Ele disse "oi"); — *confusão: esquece as aspas externas do texto*
- ✗ console.log("Ele disse 'oi); — *confusão: abre aspas simples por dentro e não fecha*

**Dica:** Use um tipo de aspas por fora e o outro por dentro.

**Ao acertar:** Com aspas simples por fora, as aspas duplas de dentro fazem parte do texto e não o encerram.

#### 6. Corrija o texto sem aspas

*Corrigir o erro · médio · id `string-corrija-as-aspas` · conceitos: Tipo String (peso 3)*

A função `cidade()` deveria devolver o texto Picos, mas dá erro. Corrija o defeito.

Função: `cidade`

Código inicial:

```js
function cidade() {
  return Picos;
}
```

Testes:

- entrada [] → retorna "Picos"

Solução de referência:

```js
function cidade() {
  return "Picos";
}
```

**Dica:** Como o computador entende uma palavra sem aspas?

**Solução comentada:** Sem aspas, Picos é entendido como o nome de uma variável que não existe. Entre aspas, vira um texto.

#### 7. "42" e 42 são iguais?

*Múltipla escolha · difícil · id `string-por-que-sao-diferentes` · conceitos: Tipo String (peso 3); Tipo Number (peso 1)*

Por que "42" e 42 são considerados valores diferentes pelo computador?

- ✗ Não são diferentes: só mudam as aspas — *confusão: acha que as aspas não mudam o significado do valor*
- ✗ Porque "42" é maior que 42 — *confusão: compara os valores como se as aspas mudassem o tamanho*
- ✔ **Porque o primeiro é um texto e o segundo é um número, e cada tipo se comporta de um jeito** (correta)
- ✗ Porque 42 é o nome de uma variável — *confusão: confunde número com nome de variável*

**Dica:** Pense no tipo de cada um.

**Ao acertar:** "42" é uma string e 42 é um number. O tipo define o que se pode fazer com o valor: contas com números, junção com textos.

---

## Lição 5 — Tipo Number

**Foco:** Reconhecer e escrever números (inteiros e decimais)

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O tipo number guarda números. Em JavaScript, inteiros (7, -2) e decimais (3.14) são o mesmo tipo: number.
> 
> Pontos importantes:
> - Números não levam aspas. Com aspas, viram texto.
> - O separador decimal é o ponto (3.5), e não a vírgula.
> - Podemos fazer contas com + (soma), - (subtração), * (multiplicação) e / (divisão). Veremos todos os operadores com calma no Mundo 3.
> - Algumas contas têm resultados especiais: dividir por zero dá Infinity, e uma conta sem sentido, como "abc" * 2, dá NaN (a sigla de "Not a Number", ou "não é um número").

### Exemplo

```
const inteiro = 7;
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
4. Multiplicar um texto que não é número por 2 não faz sentido: o resultado é NaN.
```

### Revisão

- number é o tipo dos números, inteiros ou decimais.
- Números não levam aspas e usam ponto como separador decimal.
- 10 / 0 resulta em Infinity.
- NaN significa "não é um número" e aparece em contas sem sentido.
- typeof mostra number para qualquer número, inclusive NaN.

### Exercícios

#### 1. Como escrever 3,5?

*Múltipla escolha · fácil · id `number-como-escrever-decimal` · conceitos: Tipo Number (peso 3)*

Como se escreve o número três e meio em JavaScript?

- ✗ 3,5 — *confusão: usa a vírgula como separador decimal*
- ✔ **3.5** (correta)
- ✗ "3.5" — *confusão: coloca aspas e transforma o número em texto*
- ✗ 3 e meio — *confusão: escreve o número por extenso, como em um texto*

**Dica:** Em programação, o separador decimal é o mesmo das calculadoras americanas.

**Ao acertar:** O separador decimal é o ponto: 3.5. Com vírgula ou com aspas, o valor deixaria de ser um número.

#### 2. Qual é o tipo de 3.14?

*Interpretação de código · fácil · id `number-typeof-decimal` · conceitos: Tipo Number (peso 3)*

O que o programa abaixo mostra na tela?

```
console.log(typeof 3.14);
```

- ✗ decimal — *confusão: acha que existe um tipo separado chamado decimal*
- ✗ float — *confusão: usa o nome de tipo de outras linguagens de programação*
- ✗ string — *confusão: acha que um número com ponto é um texto*
- ✔ **number** (correta)

**Dica:** Em JavaScript inteiros e decimais têm o mesmo tipo.

**Ao acertar:** Todos os números, inteiros ou decimais, são do tipo number.

#### 3. Guarde a altura

*Completar a lacuna · fácil · id `number-complete-a-altura` · conceitos: Tipo Number (peso 2)*

Complete a linha para guardar a altura 1,75 metro (escreva o número do jeito certo em JavaScript).

```
const altura = {{1}};
console.log(typeof altura);
```

Respostas aceitas: lacuna 1: 1.75

**Dica:** Decimais usam ponto e não levam aspas.

**Ao acertar:** 1.75 é um número decimal válido em JavaScript, e typeof mostra number.

#### 4. Divisões

*Interpretação de código · médio · id `number-divisao-decimal` · conceitos: Tipo Number (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(10 / 4);
console.log(7 / 2);
```

- ✔ **2.5 / 3.5** (correta)
- ✗ 2 / 3 — *confusão: acha que a divisão sempre dá um resultado inteiro*
- ✗ 2,5 / 3,5 — *confusão: mostra a vírgula como separador decimal*
- ✗ 3 / 4 — *confusão: acha que o resultado é arredondado para cima*

**Dica:** A divisão em JavaScript mantém a parte decimal.

**Ao acertar:** 10 / 4 vale 2.5 e 7 / 2 vale 3.5. O resultado é mostrado com ponto decimal.

#### 5. O que é NaN?

*Múltipla escolha · médio · id `number-o-que-e-nan` · conceitos: Tipo Number (peso 3)*

O que significa o valor NaN?

- ✗ Um número negativo — *confusão: confunde NaN com número negativo*
- ✗ Um número muito grande, maior que qualquer outro — *confusão: confunde NaN com Infinity*
- ✔ **"Não é um número": o resultado de uma conta sem sentido** (correta)
- ✗ O número zero — *confusão: acha que uma conta sem sentido resulta em zero*

**Dica:** A sigla vem do inglês: Not a Number.

**Ao acertar:** NaN aparece quando uma conta não resulta em um número válido, como "abc" * 2.

#### 6. Média de dois números

*Código · médio · id `number-media-de-dois` · conceitos: Tipo Number (peso 2); Operações com números (peso 1)*

Escreva a função `media(a, b)` que devolve a média aritmética de dois números (soma dividida por 2).

Função: `media`

Código inicial:

```js
function media(a, b) {
  // seu código aqui
}
```

Testes:

- entrada [4,6] → retorna 5
- entrada [7,8] → retorna 7.5
- entrada [0,0] → retorna 0

Solução de referência:

```js
function media(a, b) {
  return (a + b) / 2;
}
```

**Dica:** Some os dois valores e divida pelo total de valores. Cuidado com a ordem das contas.

**Solução comentada:** A média é a soma dos valores dividida pela quantidade deles: (a + b) / 2. Os parênteses garantem que a soma aconteça antes da divisão.

#### 7. Resultados especiais

*Interpretação de código · difícil · id `number-contas-especiais` · conceitos: Tipo Number (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(10 / 0);
console.log("abc" * 2);
```

- ✗ Erro / Erro — *confusão: acha que contas inválidas sempre param o programa com erro*
- ✔ **Infinity / NaN** (correta)
- ✗ 0 / 0 — *confusão: acha que contas inválidas resultam em zero*
- ✗ Infinity / Infinity — *confusão: acha que as duas contas dão o mesmo resultado especial*

**Dica:** Uma conta é uma divisão por zero; a outra tenta multiplicar um texto sem sentido numérico.

**Ao acertar:** Dividir por zero dá Infinity, e multiplicar um texto que não é número por 2 dá NaN. Nenhuma das duas causa erro.

---

## Lição 6 — Tipo Boolean

**Foco:** Reconhecer valores lógicos: true e false

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O tipo boolean tem apenas dois valores: true (verdadeiro) e false (falso). Eles são escritos em minúsculas e sem aspas. Com aspas, "true" vira um texto; com letra maiúscula, True não existe em JavaScript.
> 
> Valores booleanos aparecem como resposta a perguntas: "5 é maior que 3?" (true), "2 é maior que 10?" (false). Usamos os operadores de comparação: > (maior), < (menor), >= (maior ou igual), <= (menor ou igual) e === (igual). Você vai estudá-los com calma no Mundo 3.
> 
> No Mundo 4, os booleanos serão a base das decisões do programa: se a resposta for true, fazemos uma coisa; se for false, outra.

### Exemplo

```
const maiorDeIdade = true;
const temDesconto = false;

console.log(typeof maiorDeIdade);  // boolean
console.log(5 > 3);                // true
console.log(2 > 10);               // false
console.log("true");               // true (mas aqui é um texto!)

Passo a passo:
1. true e false, sem aspas, são valores boolean.
2. Uma comparação como 5 > 3 é uma pergunta, e a resposta é um boolean.
3. A última linha mostra o texto true. Na tela parece igual ao valor lógico, mas o tipo é string.
```

### Revisão

- boolean tem só dois valores: true e false (minúsculos, sem aspas).
- Comparações (>, <, >=, <=, ===) resultam em boolean.
- "true" entre aspas é texto, não boolean.
- True com T maiúsculo não existe em JavaScript.
- Booleanos serão a base das decisões do programa.

### Exercícios

#### 1. Os dois valores do boolean

*Múltipla escolha · fácil · id `boolean-quais-sao-os-valores` · conceitos: Tipo Boolean (peso 3)*

Quais são os dois únicos valores do tipo boolean?

- ✗ 0 e 1 — *confusão: confunde o tipo boolean com números*
- ✗ sim e não — *confusão: usa palavras do português em vez dos valores da linguagem*
- ✗ "verdadeiro" e "falso" — *confusão: escreve os valores como textos*
- ✔ **true e false** (correta)

**Dica:** Os nomes vêm do inglês e são escritos em minúsculas.

**Ao acertar:** O tipo boolean só aceita true e false, sem aspas e em minúsculas.

#### 2. 5 é maior que 3?

*Interpretação de código · fácil · id `boolean-comparacao-simples` · conceitos: Tipo Boolean (peso 3)*

O que o programa abaixo mostra na tela?

```
console.log(5 > 3);
```

- ✔ **true** (correta)
- ✗ 5 > 3 — *confusão: acha que o computador mostra a expressão em vez de avaliá-la*
- ✗ false — *confusão: acha que 5 não é maior que 3*
- ✗ 8 — *confusão: acha que o sinal > faz uma soma*

**Dica:** O sinal > faz uma pergunta: o da esquerda é maior que o da direita?

**Ao acertar:** A comparação 5 > 3 é verdadeira, então o resultado é o valor boolean true.

#### 3. Cliente sem desconto

*Completar a lacuna · fácil · id `boolean-complete-sem-desconto` · conceitos: Tipo Boolean (peso 2)*

O cliente NÃO tem desconto. Complete a linha com o valor booleano certo.

```
const temDesconto = {{1}};
console.log(typeof temDesconto);
```

Respostas aceitas: lacuna 1: false

**Dica:** É um valor lógico, escrito sem aspas.

**Ao acertar:** false representa "não". Sem aspas, ele é do tipo boolean.

#### 4. Qual valor é boolean?

*Múltipla escolha · médio · id `boolean-qual-e-boolean` · conceitos: Tipo Boolean (peso 3); Tipo String (peso 1)*

Qual destes valores é do tipo boolean?

- ✗ "false" — *confusão: confunde o texto "false" com o valor lógico false*
- ✗ True — *confusão: escreve com inicial maiúscula, mas o JavaScript diferencia maiúsculas de minúsculas*
- ✔ **false** (correta)
- ✗ 0 — *confusão: confunde número com valor lógico*

**Dica:** O valor lógico é escrito em minúsculas e sem aspas.

**Ao acertar:** false (minúsculo e sem aspas) é um valor boolean. "false" é texto, True não existe em JavaScript e 0 é um número.

#### 5. Pode entrar?

*Interpretação de código · médio · id `boolean-idade-minima` · conceitos: Tipo Boolean (peso 3); Introdução às variáveis (peso 1)*

O que o programa abaixo mostra na tela?

```
const idade = 16;
console.log(idade >= 18);
```

- ✗ true — *confusão: avalia a comparação ao contrário*
- ✔ **false** (correta)
- ✗ 16 — *confusão: mostra o valor da variável em vez do resultado da comparação*
- ✗ 18 — *confusão: mostra o outro valor da comparação*

**Dica:** Substitua idade por 16 e responda: 16 é maior ou igual a 18?

**Ao acertar:** 16 não é maior nem igual a 18, então a comparação resulta em false.

#### 6. Três tipos

*Interpretação de código · médio · id `boolean-tres-typeof` · conceitos: Tipo Boolean (peso 2); Tipo String (peso 1); Tipo Number (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(typeof true);
console.log(typeof "true");
console.log(typeof 1);
```

- ✗ string / string / number — *confusão: acha que o valor true é sempre um texto*
- ✗ boolean / boolean / number — *confusão: acha que as aspas não mudam o tipo do valor*
- ✗ boolean / string / boolean — *confusão: acha que o número 1 é um valor lógico*
- ✔ **boolean / string / number** (correta)

**Dica:** Observe quais valores têm aspas.

**Ao acertar:** true é boolean, "true" entre aspas é string e 1 é number.

#### 7. Resultado da comparação

*Interpretação de código · difícil · id `boolean-igualdade` · conceitos: Tipo Boolean (peso 3); Introdução às variáveis (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
const a = 7;
const b = 7;
const iguais = a === b;
console.log(iguais);
console.log(typeof iguais);
```

- ✔ **true / boolean** (correta)
- ✗ 7 / number — *confusão: acha que a variável iguais guarda o valor de a*
- ✗ true / string — *confusão: acha que o resultado de uma comparação é um texto*
- ✗ false / boolean — *confusão: avalia a comparação de igualdade ao contrário*

**Dica:** O sinal === compara se os dois valores são iguais e dá um valor lógico.

**Ao acertar:** a e b valem 7, então a === b é true. O resultado da comparação é guardado em iguais e seu tipo é boolean.

---

## Lição 7 — Manipulação de textos

**Foco:** Consultar e transformar textos com propriedades e métodos

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Os textos têm ferramentas prontas, que chamamos com um ponto depois do texto:
> - .length: quantos caracteres o texto tem (é uma propriedade, sem parênteses).
> - .toUpperCase() e .toLowerCase(): devolvem o texto em maiúsculas ou minúsculas.
> - .trim(): remove os espaços do início e do fim.
> - .includes("x"): diz (true ou false) se o texto contém "x".
> - .indexOf("x"): devolve a posição de "x", ou -1 se não achar.
> - .slice(inicio, fim): devolve um pedaço do texto.
> 
> As posições (índices) começam em 0: o primeiro caractere é texto[0]. Os métodos não alteram o texto original: eles devolvem um novo valor.

### Exemplo

```
const nome = "  Ana Lima ";
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
4. indexOf devolve -1 quando o pedaço não existe.
```

### Revisão

- .length dá o tamanho do texto; os índices começam em 0.
- toUpperCase, toLowerCase e trim devolvem um novo texto.
- includes responde true ou false; indexOf devolve a posição ou -1.
- slice(inicio, fim) inclui o início e não inclui o fim.
- Os métodos não mudam o texto original.

### Exercícios

#### 1. Como saber o tamanho?

*Múltipla escolha · fácil · id `textos-propriedade-do-tamanho` · conceitos: Manipulação de textos (peso 3)*

Qual propriedade informa quantos caracteres tem um texto?

- ✗ size — *confusão: usa o nome de outras linguagens*
- ✗ count — *confusão: usa o nome de outras linguagens*
- ✔ **length** (correta)
- ✗ tamanho — *confusão: traduz o nome da propriedade para o português*

**Dica:** O nome vem do inglês e significa "comprimento".

**Ao acertar:** texto.length devolve a quantidade de caracteres, e não leva parênteses.

#### 2. Quantas letras?

*Interpretação de código · fácil · id `textos-tamanho-de-casa` · conceitos: Manipulação de textos (peso 3)*

O que o programa abaixo mostra na tela?

```
const palavra = "casa";
console.log(palavra.length);
```

- ✗ 3 — *confusão: esquece de contar uma das letras, confundindo tamanho com último índice*
- ✔ **4** (correta)
- ✗ casa — *confusão: mostra o texto em vez do tamanho*
- ✗ 5 — *confusão: conta um caractere a mais do que o texto tem*

**Dica:** Conte as letras de casa.

**Ao acertar:** length conta todos os caracteres: c, a, s, a. São 4.

#### 3. Texto em maiúsculas

*Completar a lacuna · fácil · id `textos-complete-maiusculas` · conceitos: Manipulação de textos (peso 2)*

Complete a linha para mostrar o nome em letras maiúsculas.

```
const nome = "ana";
console.log(nome.{{1}}());
```

Respostas aceitas: lacuna 1: toUpperCase

**Dica:** O método tem o nome em inglês e usa letra maiúscula no meio.

**Ao acertar:** toUpperCase() devolve o texto em maiúsculas: ANA.

#### 4. Letras e posições

*Interpretação de código · médio · id `textos-indices-de-banana` · conceitos: Manipulação de textos (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
const palavra = "banana";
console.log(palavra[0]);
console.log(palavra[5]);
console.log(palavra.length);
```

- ✗ b / a / 5 — *confusão: acha que length é o último índice, e não a quantidade de letras*
- ✗ a / b / 6 — *confusão: inverte as posições 0 e 5*
- ✗ b / n / 6 — *confusão: erra a letra da posição 5*
- ✔ **b / a / 6** (correta)

**Dica:** A posição 0 é a primeira letra; a última letra está na posição length - 1.

**Ao acertar:** palavra[0] é b, palavra[5] é a (a sexta letra) e palavra.length vale 6.

#### 5. Recortando um texto

*Múltipla escolha · médio · id `textos-recorte-com-slice` · conceitos: Manipulação de textos (peso 3)*

O que "Programação".slice(0, 4) devolve?

- ✔ **"Prog"** (correta)
- ✗ "Progr" — *confusão: acha que a posição final também entra no pedaço*
- ✗ "rogr" — *confusão: começa a contar as posições do 1 em vez do 0*
- ✗ "ção" — *confusão: acha que slice pega o final do texto*

**Dica:** slice pega da posição inicial até a posição final, sem incluí-la.

**Ao acertar:** slice(0, 4) pega as posições 0, 1, 2 e 3: P, r, o, g. O 4 não entra.

#### 6. Analisando um e-mail

*Interpretação de código · médio · id `textos-email` · conceitos: Manipulação de textos (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
const email = "Ana@Escola.com";
console.log(email.toLowerCase());
console.log(email.includes("ESCOLA"));
console.log(email.indexOf("@"));
```

- ✗ ana@escola.com / true / 3 — *confusão: acha que includes ignora a diferença entre maiúsculas e minúsculas*
- ✗ ana@escola.com / false / 4 — *confusão: conta a posição do @ a partir de 1*
- ✔ **ana@escola.com / false / 3** (correta)
- ✗ ana@escola.com / 3 / false — *confusão: inverte as respostas de includes e indexOf*

**Dica:** includes diferencia maiúsculas de minúsculas, e os índices começam em 0.

**Ao acertar:** toLowerCase deixa o texto em minúsculas. includes("ESCOLA") procura exatamente esse texto no original (que tem "Escola"), então é false. O @ está na posição 3 (A=0, n=1, a=2, @=3).

#### 7. Inicial em maiúscula

*Código · difícil · id `textos-inicial-em-maiuscula` · conceitos: Manipulação de textos (peso 3)*

Escreva a função `inicial(nome)` que devolve a primeira letra do nome, em maiúscula, ignorando espaços no começo do texto.

Função: `inicial`

Código inicial:

```js
function inicial(nome) {
  // seu código aqui
}
```

Testes:

- entrada ["  ana "] → retorna "A"
- entrada ["beto"] → retorna "B"
- entrada ["Carla"] → retorna "C"

Solução de referência:

```js
function inicial(nome) {
  return nome.trim()[0].toUpperCase();
}
```

**Dica:** Primeiro tire os espaços, depois pegue a letra de posição 0 e deixe em maiúscula.

**Solução comentada:** trim() remove os espaços das pontas, [0] pega a primeira letra e toUpperCase() a deixa em maiúscula. Os métodos podem ser encadeados.

---

## Lição 8 — Concatenação

**Foco:** Juntar textos com o operador +

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Concatenar é juntar textos. Em JavaScript, usamos o operador +.
> 
> - "Bom" + "dia" resulta em "Bomdia": o + não coloca espaço, então precisamos escrevê-lo: "Bom" + " " + "dia".
> - Quando um dos lados é texto, o + junta em vez de somar. Por isso "Idade: " + 20 resulta em "Idade: 20".
> - Cuidado: "5" + 3 resulta em "53" (junção de textos), mas 5 + 3 resulta em 8 (soma de números).
> - Quando há vários + seguidos, o computador resolve da esquerda para a direita, trocando de comportamento assim que aparece um texto: 1 + 2 + "3" resulta em "33" e "1" + 2 + 3 resulta em "123".

### Exemplo

```
const nome = "Ana";
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
4. "5" + 3 junta (53), mas 5 + 3 soma (8). A diferença está nas aspas.
```

### Revisão

- O operador + junta textos (concatenação).
- O + não coloca espaços sozinho: escreva-os entre aspas.
- Se um dos lados é texto, o + junta; se os dois são números, soma.
- "5" + 3 é "53", e 5 + 3 é 8.
- Em uma sequência de +, a conta vai da esquerda para a direita.

### Exercícios

#### 1. Qual operador junta textos?

*Múltipla escolha · fácil · id `concat-operador` · conceitos: Concatenação (peso 3)*

Qual operador junta dois textos em JavaScript?

- ✗ & — *confusão: usa o operador de outras linguagens*
- ✔ **+** (correta)
- ✗ . — *confusão: usa o operador de outras linguagens*
- ✗ , — *confusão: confunde com a vírgula que separa valores no console.log*

**Dica:** É o mesmo sinal usado para somar números.

**Ao acertar:** O operador + junta textos. Com números dos dois lados, ele soma.

#### 2. Texto grudado

*Interpretação de código · fácil · id `concat-bom-dia` · conceitos: Concatenação (peso 3)*

O que o programa abaixo mostra na tela?

```
const a = "Bom";
const b = "dia";
console.log(a + b);
```

- ✗ Bom dia — *confusão: acha que o + coloca um espaço automaticamente*
- ✗ Bom+dia — *confusão: acha que o console.log mostra o sinal +*
- ✗ undefined — *confusão: acha que juntar textos não funciona sem um terceiro valor*
- ✔ **Bomdia** (correta)

**Dica:** O + junta exatamente o que está nos dois textos.

**Ao acertar:** Os textos são juntados sem nada no meio: Bomdia. Para ter espaço, seria preciso concatenar também " ".

#### 3. Complete a saudação

*Completar a lacuna · fácil · id `concat-complete-ola` · conceitos: Concatenação (peso 2)*

Complete o programa para mostrar Olá, Ana (com o nome vindo da variável).

```
const nome = "Ana";
console.log("Olá, " {{1}} nome);
```

Respostas aceitas: lacuna 1: +

**Dica:** Use o operador que junta textos.

**Ao acertar:** O + junta o texto "Olá, " ao valor da variável nome.

#### 4. "5" + 3 e 5 + 3

*Interpretação de código · médio · id `concat-texto-e-numero` · conceitos: Concatenação (peso 3); Tipo Number (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log("5" + 3);
console.log(5 + 3);
```

- ✔ **53 / 8** (correta)
- ✗ 8 / 8 — *confusão: acha que o + sempre soma*
- ✗ 53 / 53 — *confusão: acha que o + sempre junta*
- ✗ 8 / 53 — *confusão: inverte o comportamento do + com texto e com números*

**Dica:** Repare em qual dos dois 5 está entre aspas.

**Ao acertar:** Com um texto de um dos lados, o + junta: "5" + 3 dá "53". Com dois números, o + soma: 5 + 3 dá 8.

#### 5. Ordene o programa

*Ordenação · médio · id `concat-ordene-a-saudacao` · conceitos: Concatenação (peso 2); Sequência lógica (peso 1)*

Coloque as linhas na ordem certa para o programa mostrar Olá, Ana!

Ordem correta:

1. const nome = "Ana";
2. const saudacao = "Olá, " + nome + "!";
3. console.log(saudacao);

**Dica:** Cada linha usa uma variável criada na linha anterior.

**Ao acertar:** Primeiro criamos nome, depois montamos a saudação juntando textos e, por último, mostramos o resultado.

#### 6. Frase com a idade

*Interpretação de código · médio · id `concat-idade-na-frase` · conceitos: Concatenação (peso 3)*

O que o programa abaixo mostra na tela?

```
const idade = 20;
console.log("Tenho " + idade + " anos");
```

- ✗ Tenho idade anos — *confusão: trata o nome da variável como parte do texto*
- ✗ Tenho20anos — *confusão: acha que o + remove os espaços do texto*
- ✔ **Tenho 20 anos** (correta)
- ✗ Tenho + 20 + anos — *confusão: acha que o console.log mostra os sinais de +*

**Dica:** Os espaços estão dentro dos textos, junto às aspas.

**Ao acertar:** A variável idade é trocada pelo seu valor (20) e os espaços escritos dentro dos textos são mantidos: Tenho 20 anos.

#### 7. Da esquerda para a direita

*Interpretação de código · difícil · id `concat-da-esquerda-para-a-direita` · conceitos: Concatenação (peso 3); Tipo Number (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(1 + 2 + "3");
console.log("1" + 2 + 3);
```

- ✗ 6 / 6 — *confusão: acha que o + sempre soma*
- ✔ **33 / 123** (correta)
- ✗ 123 / 123 — *confusão: acha que o + sempre junta, ignorando a ordem das contas*
- ✗ 33 / 6 — *confusão: soma os números mesmo depois de aparecer um texto*

**Dica:** O computador resolve o + da esquerda para a direita, um par de cada vez.

**Ao acertar:** Na primeira linha, 1 + 2 vale 3 e só depois 3 + "3" vira "33". Na segunda, "1" + 2 já é texto ("12") e continua juntando: "123".

#### 8. Nome completo

*Código · médio · id `concat-nome-completo` · conceitos: Concatenação (peso 3); O que são algoritmos? (peso 1)*

Escreva a função `nomeCompleto(nome, sobrenome)` que devolve os dois textos juntos, separados por um espaço.

Função: `nomeCompleto`

Código inicial:

```js
function nomeCompleto(nome, sobrenome) {
  // seu código aqui
}
```

Testes:

- entrada ["Ana","Lima"] → retorna "Ana Lima"
- entrada ["Beto","Souza"] → retorna "Beto Souza"

Solução de referência:

```js
function nomeCompleto(nome, sobrenome) {
  return nome + " " + sobrenome;
}
```

**Dica:** Junte nome, um texto com um espaço e sobrenome.

**Solução comentada:** Concatenamos três partes: o nome, o espaço (" ") e o sobrenome.

---

## Lição 9 — Template literals

**Foco:** Montar textos com variáveis usando crases e ${ }

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Montar frases com + pode ficar confuso: "Olá, " + nome + "! Você tem " + idade + " anos.". Os template literals tornam isso mais fácil.
> 
> Um template literal é um texto escrito entre crases (`), a tecla do acento grave. Dentro dele, usamos ${ } para inserir o valor de uma variável ou o resultado de uma conta. Os espaços e a pontuação ficam exatamente como escritos.
> 
> Atenção: só as crases fazem a substituição. Com aspas comuns, o texto ${nome} aparece literalmente na tela, sem trocar pelo valor da variável.

### Exemplo

```
const nome = "Ana";
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
3. Na última linha, as aspas comuns mostram o texto literalmente.
```

### Revisão

- Template literal é um texto entre crases (`).
- ${ } insere o valor de uma variável ou de uma expressão.
- Só as crases fazem a substituição; aspas comuns não.
- Facilita montar frases com várias variáveis, sem muitos +.

### Exercícios

#### 1. Qual símbolo usar?

*Múltipla escolha · fácil · id `template-qual-simbolo` · conceitos: Template literals (peso 3)*

Qual símbolo delimita um template literal?

- ✗ Aspas duplas (" ") — *confusão: confunde template literal com texto comum*
- ✗ Aspas simples (' ') — *confusão: confunde template literal com texto comum*
- ✗ Parênteses ( ) — *confusão: confunde o delimitador do texto com o de uma chamada de função*
- ✔ **Crases (` `)** (correta)

**Dica:** Fica na tecla do acento grave.

**Ao acertar:** Os template literals usam crases. Só com elas o ${ } é substituído pelo valor.

#### 2. O que aparece?

*Interpretação de código · fácil · id `template-oi-beto` · conceitos: Template literals (peso 3)*

O que o programa abaixo mostra na tela?

```
const nome = "Beto";
console.log(`Oi, ${nome}!`);
```

- ✔ **Oi, Beto!** (correta)
- ✗ Oi, nome! — *confusão: acha que ${ } mostra o nome da variável*
- ✗ Oi, ${nome}! — *confusão: acha que o texto aparece exatamente como foi escrito*
- ✗ Oi, Beto — *confusão: esquece a pontuação que faz parte do texto*

**Dica:** O ${ } é trocado pelo valor da variável.

**Ao acertar:** ${nome} é substituído por Beto, e o restante do texto é mantido: Oi, Beto!

#### 3. Complete o template

*Completar a lacuna · fácil · id `template-complete` · conceitos: Template literals (peso 2)*

Complete a linha para mostrar Olá, Ana! usando a variável nome.

```
const nome = "Ana";
console.log(`Olá, ${{{1}}}!`);
```

Respostas aceitas: lacuna 1: nome

**Dica:** Dentro do ${ } vai o nome da variável, sem aspas.

**Ao acertar:** ${nome} insere o valor da variável nome no meio do texto.

#### 4. Conta dentro do ${ }

*Interpretação de código · médio · id `template-conta-dentro` · conceitos: Template literals (peso 3); Operações com números (peso 1)*

O que o programa abaixo mostra na tela?

```
const preco = 50;
console.log(`Total: ${preco * 2} reais`);
```

- ✗ Total: preco * 2 reais — *confusão: acha que o conteúdo de ${ } é apenas texto*
- ✗ Total: 50 * 2 reais — *confusão: troca a variável pelo valor, mas não faz a conta*
- ✔ **Total: 100 reais** (correta)
- ✗ Total: 502 reais — *confusão: junta o 50 e o 2 como se fossem textos*

**Dica:** Dentro do ${ } o computador calcula a expressão.

**Ao acertar:** O computador calcula preco * 2 = 100 e coloca o resultado no lugar do ${ }.

#### 5. Qual linha está certa?

*Múltipla escolha · médio · id `template-qual-linha` · conceitos: Template literals (peso 3)*

Qual linha mostra Olá, Ana! usando a variável nome (que vale "Ana")?

- ✗ console.log("Olá, ${nome}!"); — *confusão: usa aspas comuns, que não substituem o ${nome}*
- ✔ **console.log(`Olá, ${nome}!`);** (correta)
- ✗ console.log(`Olá, nome!`); — *confusão: esquece o ${ } ao redor da variável*
- ✗ console.log(`Olá, {nome}!`); — *confusão: esquece o cifrão antes das chaves*

**Dica:** Confira o tipo de aspas e o ${ }.

**Ao acertar:** Só as crases com ${nome} trocam o nome pelo valor da variável.

#### 6. Corrija a saudação

*Corrigir o erro · médio · id `template-corrija-a-saudacao` · conceitos: Template literals (peso 3)*

A função `saudacao(nome)` deveria devolver, por exemplo, Olá, Ana!, mas devolve o texto com ${nome} sem substituir. Corrija.

Função: `saudacao`

Código inicial:

```js
function saudacao(nome) {
  return "Olá, ${nome}!";
}
```

Testes:

- entrada ["Ana"] → retorna "Olá, Ana!"
- entrada ["Beto"] → retorna "Olá, Beto!"

Solução de referência:

```js
function saudacao(nome) {
  return `Olá, ${nome}!`;
}
```

**Dica:** Que símbolo é preciso trocar para o ${ } funcionar?

**Solução comentada:** Com aspas comuns, o ${nome} não é substituído. Trocando por crases, o valor da variável entra no texto.

#### 7. Apresentar uma pessoa

*Código · médio · id `template-apresentar` · conceitos: Template literals (peso 3); Concatenação (peso 1)*

Escreva a função `apresentar(nome, idade)` que devolve, por exemplo, Ana tem 20 anos (use um template literal).

Função: `apresentar`

Código inicial:

```js
function apresentar(nome, idade) {
  // seu código aqui
}
```

Testes:

- entrada ["Ana",20] → retorna "Ana tem 20 anos"
- entrada ["Beto",35] → retorna "Beto tem 35 anos"

Solução de referência:

```js
function apresentar(nome, idade) {
  return `${nome} tem ${idade} anos`;
}
```

**Dica:** Escreva o texto entre crases e coloque cada variável dentro de um ${ }.

**Solução comentada:** O template literal `${nome} tem ${idade} anos` insere as duas variáveis no texto.

#### 8. A soma na frase

*Interpretação de código · difícil · id `template-soma-na-frase` · conceitos: Template literals (peso 3); Operações com números (peso 1)*

O que o programa abaixo mostra na tela?

```
const a = 3;
const b = 4;
console.log(`${a} + ${b} = ${a + b}`);
```

- ✗ a + b = 7 — *confusão: troca só o último valor e esquece de substituir as variáveis do começo*
- ✗ 3 + 4 = 34 — *confusão: junta os valores como texto dentro do ${ }*
- ✗ 3 + 4 = a + b — *confusão: não calcula a expressão dentro do ${ }*
- ✔ **3 + 4 = 7** (correta)

**Dica:** Cada ${ } é resolvido separadamente, e o texto entre eles é mantido.

**Ao acertar:** ${a} vira 3, ${b} vira 4 e ${a + b} vira 7. O sinal + e o = fora dos ${ } fazem parte do texto.

---

## Lição 10 — Operações com números

**Foco:** Fazer contas com números e variáveis

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Com números, o computador faz contas:
> - + soma, - subtração, * multiplicação, / divisão;
> - % resto da divisão (7 % 2 vale 1);
> - ** potência (2 ** 3 vale 8).
> 
> Como na matemática, multiplicação, divisão e resto são feitos antes de soma e subtração, e os parênteses mudam a ordem: 2 + 3 * 4 vale 14, mas (2 + 3) * 4 vale 20.
> 
> Para arredondar, usamos Math.round (para o inteiro mais próximo) e Math.floor (para baixo). As contas podem usar variáveis, e o resultado pode ser guardado em outra variável.

### Exemplo

```
const a = 7;
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
3. Math.round(3.6) arredonda para o inteiro mais próximo (4); Math.floor(3.9) arredonda sempre para baixo (3).
```

### Revisão

- + - * / fazem as quatro operações; % dá o resto; ** é a potência.
- Multiplicação, divisão e resto vêm antes de soma e subtração; parênteses mudam a ordem.
- Math.round arredonda para o mais próximo; Math.floor arredonda para baixo.
- Podemos usar variáveis nas contas e guardar o resultado em outra variável.

### Exercícios

#### 1. Qual operador dá o resto?

*Múltipla escolha · fácil · id `operacoes-resto` · conceitos: Operações com números (peso 3)*

Qual operador dá o resto de uma divisão?

- ✔ **%** (correta)
- ✗ / — *confusão: confunde o resto com o resultado da divisão*
- ✗ * — *confusão: confunde resto com multiplicação*
- ✗ ** — *confusão: confunde resto com potência*

**Dica:** É um símbolo que lembra uma porcentagem, mas que aqui tem outro significado.

**Ao acertar:** O operador % devolve o resto da divisão. Por exemplo, 7 % 2 vale 1.

#### 2. Quanto vale 7 % 2?

*Interpretação de código · fácil · id `operacoes-resto-de-sete` · conceitos: Operações com números (peso 3)*

O que o programa abaixo mostra na tela?

```
console.log(7 % 2);
```

- ✗ 3 — *confusão: mostra o resultado inteiro da divisão em vez do resto*
- ✗ 3.5 — *confusão: mostra o resultado decimal da divisão*
- ✔ **1** (correta)
- ✗ 0 — *confusão: acha que o resto de 7 por 2 é zero*

**Dica:** 7 dividido por 2 dá 3 e sobra...

**Ao acertar:** 2 cabe 3 vezes em 7 (6) e sobra 1. O % devolve essa sobra.

#### 3. Área do quadrado

*Completar a lacuna · fácil · id `operacoes-area-do-quadrado` · conceitos: Operações com números (peso 2)*

Complete a conta para calcular a área de um quadrado (lado vezes lado).

```
const lado = 5;
const area = lado {{1}} lado;
console.log(area);
```

Respostas aceitas: lacuna 1: *

**Dica:** Área é um lado multiplicado pelo outro.

**Ao acertar:** A área do quadrado é lado * lado, que dá 25.

#### 4. Média das notas

*Interpretação de código · médio · id `operacoes-media-de-duas-notas` · conceitos: Operações com números (peso 3); Tipo Number (peso 1)*

O que o programa abaixo mostra na tela?

```
const nota1 = 6;
const nota2 = 8;
const media = (nota1 + nota2) / 2;
console.log(media);
```

- ✗ 10 — *confusão: ignora os parênteses e divide só a segunda nota por 2*
- ✔ **7** (correta)
- ✗ 14 — *confusão: só soma as notas, esquecendo de dividir*
- ✗ 3.5 — *confusão: divide só a primeira nota por 2 e esquece a soma*

**Dica:** Os parênteses fazem a soma acontecer antes da divisão.

**Ao acertar:** (6 + 8) / 2 = 14 / 2 = 7. Sem os parênteses, 6 + 8 / 2 daria 10.

#### 5. Média de três números

*Código · médio · id `operacoes-media-de-tres` · conceitos: Operações com números (peso 3); Tipo Number (peso 1)*

Escreva a função `mediaDeTres(a, b, c)` que devolve a média aritmética dos três números.

Função: `mediaDeTres`

Código inicial:

```js
function mediaDeTres(a, b, c) {
  // seu código aqui
}
```

Testes:

- entrada [3,6,9] → retorna 6
- entrada [0,0,0] → retorna 0
- entrada [1,2,3] → retorna 2
- entrada [10,10,10] → retorna 10

Solução de referência:

```js
function mediaDeTres(a, b, c) {
  return (a + b + c) / 3;
}
```

**Dica:** Some os três valores entre parênteses e divida por 3.

**Solução comentada:** A média é (a + b + c) / 3. Os parênteses fazem a soma acontecer antes da divisão.

#### 6. Vinte por cento do preço

*Múltipla escolha · médio · id `operacoes-porcentagem` · conceitos: Operações com números (peso 3); Tipo Number (peso 1)*

Qual expressão calcula 20% de um preço guardado em p?

- ✗ p * 20 — *confusão: usa 20 em vez de 0.2: confunde porcentagem com o número inteiro*
- ✗ p / 20 — *confusão: divide em vez de multiplicar pela fração*
- ✗ p + 0.2 — *confusão: soma em vez de multiplicar*
- ✔ **p * 0.2** (correta)

**Dica:** 20% é o mesmo que 0.2, e "vinte por cento de p" é uma multiplicação.

**Ao acertar:** 20% equivale a 0.2, e calcular uma parte de um valor é multiplicar: p * 0.2.

#### 7. Quatro contas

*Interpretação de código · difícil · id `operacoes-precedencia-e-arredondamento` · conceitos: Operações com números (peso 3)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(2 + 3 * 4);
console.log((2 + 3) * 4);
console.log(2 ** 3);
console.log(Math.floor(7 / 2));
```

- ✔ **14 / 20 / 8 / 3** (correta)
- ✗ 20 / 20 / 8 / 3 — *confusão: calcula 2 + 3 * 4 da esquerda para a direita, ignorando a precedência*
- ✗ 14 / 20 / 6 / 3 — *confusão: acha que ** multiplica em vez de elevar à potência*
- ✗ 14 / 20 / 8 / 3.5 — *confusão: esquece que Math.floor arredonda para baixo*

**Dica:** Multiplicação vem antes da soma, e os parênteses mudam a ordem.

**Ao acertar:** 2 + 3 * 4 = 14; (2 + 3) * 4 = 20; 2 ** 3 = 8; e 7 / 2 = 3.5, que Math.floor arredonda para 3.

---

## Lição 11 — Conversão de tipos

**Foco:** Converter valores entre texto e número

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Converter é mudar o tipo de um valor. As principais conversões:
> - Number("42") transforma o texto "42" no número 42. Se o texto não for um número, o resultado é NaN.
> - String(42) transforma o número 42 no texto "42".
> - parseInt("42px") e parseFloat("3.5kg") leem o número no começo do texto (42 e 3.5).
> 
> Por que isso importa? Dados digitados por uma pessoa costumam chegar como texto, mesmo que pareçam números. Sem converter, "10" + 5 vira "105", e não 15.
> 
> O JavaScript também converte sozinho em alguns casos: "5" * 2 vira 10. Porém o + junta textos, então "5" + 2 vira "52". Para evitar surpresas, converta de forma explícita.

### Exemplo

```
const idadeTexto = "20";
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
4. parseInt e parseFloat aproveitam o número que aparece no começo do texto.
```

### Revisão

- Number("42") converte texto em número; texto inválido vira NaN.
- String(42) converte número em texto.
- parseInt e parseFloat leem o número do começo de um texto.
- Dados de entrada costumam ser texto: converta antes de fazer contas.
- O + junta textos; o * converte textos que parecem números.

### Exercícios

#### 1. Texto para número

*Múltipla escolha · fácil · id `conversao-qual-funcao` · conceitos: Conversão de tipos (peso 3)*

Qual expressão converte o texto "42" no número 42?

- ✗ String("42") — *confusão: usa a função que converte para texto, mas "42" já é texto*
- ✗ Texto("42") — *confusão: inventa uma função que não existe*
- ✔ **Number("42")** (correta)
- ✗ Converter("42") — *confusão: inventa uma função que não existe*

**Dica:** O resultado deve ser do tipo number.

**Ao acertar:** Number("42") devolve o número 42. String() faz o contrário: transforma números em texto.

#### 2. Tipo depois de converter

*Interpretação de código · fácil · id `conversao-tipo-depois-de-number` · conceitos: Conversão de tipos (peso 3)*

O que o programa abaixo mostra na tela?

```
const n = Number("15");
console.log(typeof n);
```

- ✗ string — *confusão: acha que Number() mantém o valor como texto*
- ✔ **number** (correta)
- ✗ 15 — *confusão: mostra o valor em vez do tipo*
- ✗ n — *confusão: mostra o nome da variável em vez do tipo*

**Dica:** Number() converte para o tipo number.

**Ao acertar:** Number("15") devolve o número 15, então typeof n mostra number.

#### 3. Converta antes de somar

*Completar a lacuna · fácil · id `conversao-complete` · conceitos: Conversão de tipos (peso 2)*

A idade chegou como texto. Complete a linha para convertê-la em número e depois somar 1.

```
const idade = {{1}}("20");
console.log(idade + 1);
```

Respostas aceitas: lacuna 1: Number

**Dica:** A função tem o mesmo nome do tipo que queremos.

**Ao acertar:** Number("20") vira o número 20, e 20 + 1 resulta em 21.

#### 4. Com e sem conversão

*Interpretação de código · médio · id `conversao-texto-ou-numero` · conceitos: Conversão de tipos (peso 3); Concatenação (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
const x = "10";
console.log(x + 5);
console.log(Number(x) + 5);
```

- ✗ 15 / 15 — *confusão: acha que o texto "10" é somado como número automaticamente*
- ✗ 105 / 105 — *confusão: acha que Number() não muda o comportamento do +*
- ✗ 15 / 105 — *confusão: inverte os resultados com e sem conversão*
- ✔ **105 / 15** (correta)

**Dica:** Na primeira linha x é texto; na segunda, é número.

**Ao acertar:** "10" + 5 junta os textos (105). Number(x) + 5 soma os números (15).

#### 5. Três conversões

*Interpretação de código · médio · id `conversao-resultados` · conceitos: Conversão de tipos (peso 3); Tipo Number (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log(Number("abc"));
console.log(Number("12"));
console.log(String(7) + 1);
```

- ✔ **NaN / 12 / 71** (correta)
- ✗ Erro / 12 / 8 — *confusão: acha que converter um texto inválido causa erro e que String(7) + 1 soma*
- ✗ 0 / 12 / 71 — *confusão: acha que um texto inválido vira zero*
- ✗ NaN / 12 / 8 — *confusão: acha que String(7) + 1 soma como se fosse número*

**Dica:** String(7) transforma o 7 em texto antes do +.

**Ao acertar:** "abc" não é um número (NaN), "12" vira 12, e "7" + 1 junta os textos: 71.

#### 6. Corrija a soma

*Corrigir o erro · médio · id `conversao-corrija-a-soma` · conceitos: Conversão de tipos (peso 3); Concatenação (peso 1)*

A função `somar(a, b)` recebe dois números escritos como texto (por exemplo, "2" e "3") e deveria devolver a soma (5), mas junta os textos. Corrija.

Função: `somar`

Código inicial:

```js
function somar(a, b) {
  return a + b;
}
```

Testes:

- entrada ["2","3"] → retorna 5
- entrada ["10","5"] → retorna 15
- entrada ["0","0"] → retorna 0

Solução de referência:

```js
function somar(a, b) {
  return Number(a) + Number(b);
}
```

**Dica:** O que o + faz quando os dois lados são textos? Converta antes.

**Solução comentada:** Com textos, o + junta ("23"). Convertendo cada valor com Number(), o + soma de verdade.

#### 7. Some duas entradas

*Código · médio · id `conversao-somar-entradas` · conceitos: Conversão de tipos (peso 3); Entrada e saída de informações (peso 2)*

Escreva a função `somarEntradas()`: ela deve ler dois valores com `lerEntrada()` (que chegam como texto), converter para número e mostrar a soma com `console.log`.

Função: `somarEntradas`

Código inicial:

```js
function somarEntradas() {
  // leia dois valores, converta e mostre a soma
}
```

Testes:

- entrada [], lê ["4","6"] → imprime ["10"]
- entrada [], lê ["10","25"] → imprime ["35"]
- entrada [], lê ["0","0"] → imprime ["0"]

Solução de referência:

```js
function somarEntradas() {
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  console.log(a + b);
}
```

**Dica:** Cada lerEntrada() lê um valor. Converta com Number() antes de somar.

**Solução comentada:** Sem a conversão, "4" + "6" daria "46". Com Number() em cada valor, a soma é feita entre números.

#### 8. O * e o + com texto

*Interpretação de código · difícil · id `conversao-multiplicar-e-somar` · conceitos: Conversão de tipos (peso 3); Concatenação (peso 2)*

O que o programa abaixo mostra na tela, em ordem?

```
const a = "3";
const b = 4;
console.log(a * b);
console.log(a + b);
console.log(typeof (a * b));
```

- ✗ 7 / 7 / number — *confusão: acha que o texto "3" é sempre somado como número*
- ✗ 12 / 12 / number — *confusão: acha que o + também converte o texto em número*
- ✔ **12 / 34 / number** (correta)
- ✗ 34 / 34 / string — *confusão: acha que o * também junta textos*

**Dica:** O * converte o texto em número; o + junta quando um dos lados é texto.

**Ao acertar:** a * b converte "3" em 3 e multiplica: 12 (number). a + b junta os valores como texto: "34".

---

## Lição 12 — Entrada e saída de informações

**Foco:** Ler dados, convertê-los, processá-los e mostrar o resultado

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Já vimos que todo programa tem entrada, processamento e saída. Agora vamos colocar isso em prática com variáveis.
> 
> - Entrada: nesta plataforma, lerEntrada() lê um valor de cada vez, na ordem em que foram informados.
> - Conversão: o valor lido costuma ser texto. Se for número, converta com Number().
> - Processamento: as contas e transformações, guardando resultados em variáveis.
> - Saída: console.log mostra o resultado; um template literal deixa a frase bem montada.
> 
> Um programa de verdade, em um navegador, receberia a entrada de uma caixa de texto ou de um formulário. A lógica é a mesma.

### Exemplo

```
function dobroDoNumero() {
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
4. O template literal monta a frase e console.log a mostra.
```

### Revisão

- lerEntrada() lê um valor por vez, na ordem informada.
- Entradas costumam ser texto: converta com Number() antes de calcular.
- Guarde resultados intermediários em variáveis com nomes claros.
- console.log mostra a saída; template literals ajudam a montar frases.
- O caminho é sempre: ler, converter, processar e mostrar.

### Exercícios

#### 1. Qual comando lê a entrada?

*Múltipla escolha · fácil · id `es-comando-de-entrada` · conceitos: Entrada e saída de informações (peso 3)*

Qual comando da plataforma lê um valor de entrada?

- ✗ console.log() — *confusão: confunde entrada com saída*
- ✔ **lerEntrada()** (correta)
- ✗ Number() — *confusão: confunde converter um valor com ler um valor*
- ✗ typeof — *confusão: confunde descobrir o tipo com ler um valor*

**Dica:** Entrada é o que o programa recebe, e não o que ele mostra.

**Ao acertar:** lerEntrada() lê um valor. console.log mostra, Number converte e typeof descobre o tipo.

#### 2. Olá, nome

*Interpretação de código · fácil · id `es-ola-nome` · conceitos: Entrada e saída de informações (peso 3); Concatenação (peso 1)*

Se a entrada for Ana, o que o programa abaixo mostra na tela?

```
const nome = lerEntrada();
console.log("Olá, " + nome);
```

- ✗ Olá, nome — *confusão: mostra o nome da variável em vez do valor lido*
- ✗ Olá, lerEntrada() — *confusão: acha que o texto da chamada aparece na tela*
- ✗ Ana — *confusão: esquece a parte fixa do texto*
- ✔ **Olá, Ana** (correta)

**Dica:** A variável nome recebe o que foi digitado.

**Ao acertar:** lerEntrada() entrega Ana, que fica na variável nome. A saída junta o texto "Olá, " ao valor: Olá, Ana.

#### 3. Boas-vindas

*Código · fácil · id `es-boas-vindas` · conceitos: Entrada e saída de informações (peso 3); Template literals (peso 1)*

Escreva a função `boasVindas()`: leia um nome com `lerEntrada()` e mostre, com `console.log`, a frase Bem-vindo, NOME!

Função: `boasVindas`

Código inicial:

```js
function boasVindas() {
  // leia o nome e mostre a frase
}
```

Testes:

- entrada [], lê ["Ana"] → imprime ["Bem-vindo, Ana!"]
- entrada [], lê ["Beto"] → imprime ["Bem-vindo, Beto!"]

Solução de referência:

```js
function boasVindas() {
  const nome = lerEntrada();
  console.log(`Bem-vindo, ${nome}!`);
}
```

**Dica:** Guarde o nome em uma variável e monte a frase com um template literal.

**Solução comentada:** A entrada fica na variável nome e a saída é montada com um template literal: `Bem-vindo, ${nome}!`.

#### 4. Entradas são texto

*Interpretação de código · médio · id `es-entradas-sao-texto` · conceitos: Entrada e saída de informações (peso 3); Conversão de tipos (peso 2)*

As entradas são "2" e "3" (como textos). O que o programa abaixo mostra na tela?

```
const a = lerEntrada();
const b = lerEntrada();
console.log(a + b);
```

- ✔ **23** (correta)
- ✗ 5 — *confusão: esquece que a entrada chega como texto, e que o + junta textos*
- ✗ a + b — *confusão: mostra a expressão em vez do resultado*
- ✗ 2 / 3 — *confusão: acha que o console.log mostra as duas entradas*

**Dica:** O + junta quando os dois lados são textos.

**Ao acertar:** Como a entrada chega como texto, "2" + "3" junta os textos e resulta em "23". Para somar, seria preciso converter com Number().

#### 5. Ordene o programa

*Ordenação · médio · id `es-ordene-o-programa` · conceitos: Entrada e saída de informações (peso 3); Sequência lógica (peso 2)*

Coloque as linhas na ordem certa para ler um número, calcular o dobro e mostrar o resultado.

Ordem correta:

1. const texto = lerEntrada();
2. const numero = Number(texto);
3. const dobro = numero * 2;
4. console.log(dobro);

**Dica:** Cada linha usa a variável criada na linha anterior.

**Ao acertar:** Lemos o valor, convertemos para número, calculamos o dobro e só então mostramos o resultado.

#### 6. Área do retângulo

*Código · médio · id `es-area-do-retangulo` · conceitos: Entrada e saída de informações (peso 3); Operações com números (peso 2); Template literals (peso 1)*

Escreva a função `areaDoRetangulo()`: leia a base e a altura com `lerEntrada()` (chegam como texto) e mostre, com `console.log`, a frase Área: VALOR.

Função: `areaDoRetangulo`

Código inicial:

```js
function areaDoRetangulo() {
  // leia a base e a altura, calcule e mostre
}
```

Testes:

- entrada [], lê ["5","3"] → imprime ["Área: 15"]
- entrada [], lê ["10","2"] → imprime ["Área: 20"]

Solução de referência:

```js
function areaDoRetangulo() {
  const base = Number(lerEntrada());
  const altura = Number(lerEntrada());
  console.log(`Área: ${base * altura}`);
}
```

**Dica:** Converta os dois valores com Number() antes de multiplicar.

**Solução comentada:** Lemos base e altura, convertemos para número, multiplicamos e mostramos a frase com o resultado.

#### 7. Corrija o ano que vem

*Corrigir o erro · médio · id `es-corrija-o-ano-que-vem` · conceitos: Entrada e saída de informações (peso 3); Conversão de tipos (peso 3)*

O programa lê uma idade e deveria mostrar Ano que vem: 21 (se a idade for 20), mas mostra Ano que vem: 201. Corrija o defeito.

Função: `anoQueVem`

Código inicial:

```js
function anoQueVem() {
  const idade = lerEntrada();
  console.log("Ano que vem: " + idade + 1);
}
```

Testes:

- entrada [], lê ["20"] → imprime ["Ano que vem: 21"]
- entrada [], lê ["9"] → imprime ["Ano que vem: 10"]

Solução de referência:

```js
function anoQueVem() {
  const idade = Number(lerEntrada());
  console.log("Ano que vem: " + (idade + 1));
}
```

**Dica:** Primeiro faça a conta com números; depois junte ao texto.

**Solução comentada:** Como idade é texto, o + junta "20" e 1 (201). Convertendo com Number() e somando antes de juntar ao texto, o resultado é 21.

#### 8. Média das notas

*Código · difícil · id `es-media-das-notas` · conceitos: Entrada e saída de informações (peso 3); Conversão de tipos (peso 2); Operações com números (peso 2); Template literals (peso 1)*

Escreva a função `mediaDasNotas()`: leia três notas com `lerEntrada()` (chegam como texto) e mostre, com `console.log`, a frase Média: VALOR.

Função: `mediaDasNotas`

Código inicial:

```js
function mediaDasNotas() {
  // leia as três notas, calcule a média e mostre
}
```

Testes:

- entrada [], lê ["6","8","7"] → imprime ["Média: 7"]
- entrada [], lê ["10","10","10"] → imprime ["Média: 10"]
- entrada [], lê ["3","6","9"] → imprime ["Média: 6"]

Solução de referência:

```js
function mediaDasNotas() {
  const n1 = Number(lerEntrada());
  const n2 = Number(lerEntrada());
  const n3 = Number(lerEntrada());
  const media = (n1 + n2 + n3) / 3;
  console.log(`Média: ${media}`);
}
```

**Dica:** São três leituras, três conversões, uma soma entre parênteses, uma divisão e uma frase.

**Solução comentada:** O programa lê as três notas, converte cada uma com Number(), calcula (n1 + n2 + n3) / 3 e mostra a frase.

---

## Lição 13 — Utilização de console.log()

**Foco:** Usar o console.log para mostrar e acompanhar valores

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> O console.log é a principal ferramenta de saída: ele mostra valores na tela e também ajuda a descobrir o que está acontecendo dentro do programa.
> 
> - Cada chamada mostra uma nova linha.
> - Podemos passar vários valores separados por vírgula: eles aparecem na mesma linha, separados por um espaço. console.log("Total:", 50) mostra Total: 50.
> - Textos aparecem sem as aspas. Números, booleanos e resultados de contas aparecem normalmente.
> - Um texto entre aspas aparece exatamente como foi escrito, e um cálculo sem aspas é resolvido antes de ser mostrado.
> 
> Programadores usam console.log o tempo todo para acompanhar o valor de variáveis passo a passo. Isso se chama depurar (procurar defeitos).

### Exemplo

```
console.log("Olá");              // Olá
console.log("Total:", 50);       // Total: 50
console.log("a", "b", "c");      // a b c
console.log(2 + 3);              // 5
console.log("2 + 3");            // 2 + 3
console.log(true);               // true

Passo a passo:
1. Cada console.log mostra uma linha.
2. Com vírgulas, os valores aparecem juntos, separados por um espaço.
3. 2 + 3 sem aspas é calculado (5); com aspas é só um texto, mostrado como está.
4. Valores booleanos também podem ser mostrados.
```

### Revisão

- Cada console.log mostra uma nova linha.
- Com vírgulas, os valores ficam na mesma linha, separados por espaço.
- Textos aparecem sem aspas; contas sem aspas são calculadas.
- console.log ajuda a acompanhar os valores das variáveis e a achar defeitos.

### Exercícios

#### 1. Duas chamadas

*Múltipla escolha · fácil · id `log-varias-chamadas` · conceitos: Utilização de console.log() (peso 3)*

O que acontece quando chamamos console.log duas vezes seguidas?

- ✗ Os dois valores aparecem na mesma linha — *confusão: acha que console.log não muda de linha*
- ✗ Só o último valor aparece — *confusão: acha que a última chamada apaga a anterior*
- ✔ **Cada chamada mostra uma nova linha** (correta)
- ✗ O programa dá erro — *confusão: acha que só se pode chamar console.log uma vez*

**Dica:** Pense nas mensagens que você já viu aparecerem uma embaixo da outra.

**Ao acertar:** Cada chamada de console.log escreve uma linha própria.

#### 2. Valores com vírgula

*Interpretação de código · fácil · id `log-com-virgula` · conceitos: Utilização de console.log() (peso 3)*

O que o programa abaixo mostra na tela?

```
console.log("Total:", 50);
```

- ✗ Total:50 — *confusão: acha que a vírgula junta os valores sem espaço*
- ✔ **Total: 50** (correta)
- ✗ Total:, 50 — *confusão: acha que a vírgula aparece na tela*
- ✗ 50 — *confusão: acha que só o último valor é mostrado*

**Dica:** A vírgula separa os valores, e o console.log coloca um espaço entre eles.

**Ao acertar:** Com vários valores, o console.log mostra todos na mesma linha, separados por um espaço.

#### 3. Mostre a média

*Completar a lacuna · fácil · id `log-complete-a-media` · conceitos: Utilização de console.log() (peso 2)*

Complete o programa para mostrar Média: 7 usando a variável media.

```
const media = 7;
console.log("Média:", {{1}});
```

Respostas aceitas: lacuna 1: media

**Dica:** O segundo valor do console.log é o nome da variável, sem aspas.

**Ao acertar:** media (sem aspas) é substituída pelo valor 7. Com aspas, apareceria a palavra media.

#### 4. Texto ou conta?

*Interpretação de código · médio · id `log-texto-ou-conta` · conceitos: Utilização de console.log() (peso 3); Tipo String (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
console.log("5 + 5");
console.log(5 + 5);
console.log("5", "5");
```

- ✗ 10 / 10 / 55 — *confusão: acha que o texto entre aspas também é calculado e que a vírgula junta os valores*
- ✗ 5 + 5 / 55 / 5 5 — *confusão: acha que 5 + 5 junta os valores como texto*
- ✗ 5 + 5 / 10 / 10 — *confusão: calcula a última linha em vez de mostrar os dois textos*
- ✔ **5 + 5 / 10 / 5 5** (correta)

**Dica:** Aspas mostram o texto como está; sem aspas, a conta é feita; a vírgula separa com espaço.

**Ao acertar:** "5 + 5" é mostrado como texto, 5 + 5 é calculado (10) e os dois "5" separados por vírgula aparecem com um espaço entre eles.

#### 5. Mostre os dados

*Código · médio · id `log-mostrar-os-dados` · conceitos: Utilização de console.log() (peso 3); Entrada e saída de informações (peso 2)*

Escreva a função `mostrarDados()`: leia o nome e a idade com `lerEntrada()` e mostre duas linhas com `console.log`, no formato Nome: NOME e Idade: IDADE (use vírgulas no console.log).

Função: `mostrarDados`

Código inicial:

```js
function mostrarDados() {
  // leia o nome e a idade e mostre as duas linhas
}
```

Testes:

- entrada [], lê ["Ana",20] → imprime ["Nome: Ana","Idade: 20"]
- entrada [], lê ["Beto",35] → imprime ["Nome: Beto","Idade: 35"]

Solução de referência:

```js
function mostrarDados() {
  const nome = lerEntrada();
  const idade = lerEntrada();
  console.log("Nome:", nome);
  console.log("Idade:", idade);
}
```

**Dica:** Cada console.log é uma linha; use a vírgula para separar o rótulo do valor.

**Solução comentada:** Duas chamadas de console.log geram duas linhas, e a vírgula coloca o espaço entre o rótulo e o valor.

#### 6. Contas em linhas

*Interpretação de código · médio · id `log-operacoes-em-linhas` · conceitos: Utilização de console.log() (peso 3); Operações com números (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
const a = 6;
const b = 4;
console.log("Soma:", a + b);
console.log("Produto:", a * b);
console.log("Divisão:", a / b);
```

- ✔ **Soma: 10 / Produto: 24 / Divisão: 1.5** (correta)
- ✗ Soma: 64 / Produto: 24 / Divisão: 1.5 — *confusão: junta os números como texto na soma*
- ✗ Soma: 10 / Produto: 24 / Divisão: 2 — *confusão: acha que a divisão sempre dá um resultado inteiro*
- ✗ Soma: a + b / Produto: a * b / Divisão: a / b — *confusão: mostra as expressões em vez de calculá-las*

**Dica:** Os valores depois da vírgula são calculados antes de serem mostrados.

**Ao acertar:** 6 + 4 = 10, 6 * 4 = 24 e 6 / 4 = 1.5. Cada console.log mostra o rótulo e o resultado.

#### 7. Corrija o espaço do total

*Corrigir o erro · médio · id `log-corrija-o-total` · conceitos: Utilização de console.log() (peso 3); Concatenação (peso 1)*

A função `mostrarTotal(preco, quantidade)` deveria mostrar Total: 50 (para preço 10 e quantidade 5), mas mostra Total:50. Corrija o defeito.

Função: `mostrarTotal`

Código inicial:

```js
function mostrarTotal(preco, quantidade) {
  const total = preco * quantidade;
  console.log("Total:" + total);
}
```

Testes:

- entrada [10,5] → imprime ["Total: 50"]
- entrada [3,3] → imprime ["Total: 9"]

Solução de referência:

```js
function mostrarTotal(preco, quantidade) {
  const total = preco * quantidade;
  console.log("Total:", total);
}
```

**Dica:** Falta um espaço entre o rótulo e o valor. Há mais de uma forma de resolver.

**Solução comentada:** Com a vírgula, o console.log coloca o espaço sozinho. Também funcionaria incluir o espaço no texto: "Total: " + total.

#### 8. Quatro linhas

*Interpretação de código · difícil · id `log-quatro-linhas` · conceitos: Utilização de console.log() (peso 3); Tipo String (peso 1); Concatenação (peso 1)*

O que o programa abaixo mostra na tela, em ordem?

```
const nome = "Ana";
console.log("nome");
console.log(nome);
console.log(nome, nome.length);
console.log("1" + 1, 1 + 1);
```

- ✗ Ana / Ana / Ana 3 / 2 2 — *confusão: mostra o valor da variável mesmo quando o nome está entre aspas e soma o "1" + 1*
- ✗ nome / Ana / Ana 3 / 2 2 — *confusão: soma "1" + 1 como se fosse número*
- ✔ **nome / Ana / Ana 3 / 11 2** (correta)
- ✗ nome / Ana / Ana, 3 / 11, 2 — *confusão: acha que a vírgula aparece na tela*

**Dica:** Atenção a quais valores estão entre aspas e ao que o + faz com texto.

**Ao acertar:** "nome" é um texto; nome é a variável (Ana). nome.length vale 3. "1" + 1 junta (11) e 1 + 1 soma (2), e os dois aparecem na mesma linha.

---

## Lição 14 — Desafio final do Mundo 2

**Foco:** Juntar variáveis, tipos, conversões, entrada e saída em um só programa

- [ ] Aprovada  - [ ] Precisa de ajustes: ______________________________

### Introdução e explicação

> Hora de juntar tudo o que você aprendeu no Mundo 2: variáveis, tipos de dados, concatenação, template literals, conversões e entrada e saída.
> 
> O desafio principal é o primeiro exercício: criar um pequeno programa que receba os dados de uma pessoa (nome, idade e altura), guarde-os em variáveis e mostre os resultados em frases bem formatadas. Os outros dois exercícios treinam a conversão de tipos em situações em que é fácil errar.
> 
> Dica: antes de escrever, pense em cada dado: qual é o tipo? Ele chega como texto? Precisa ser convertido?

### Exemplo

```
Como atacar um desafio de programa:
1. Liste as entradas e o tipo de cada uma (nome: texto; idade: número; altura: número).
2. Lembre que lerEntrada() entrega os valores na ordem e que eles chegam como texto.
3. Guarde cada valor em uma variável com nome claro e converta quando for preciso.
4. Faça as contas pedidas e guarde os resultados em variáveis.
5. Mostre cada resultado em uma frase, com template literals.
6. Teste mentalmente com um caso simples antes de executar.
```

### Revisão

- Toda variável guarda um valor de um tipo: string, number ou boolean.
- Entradas chegam como texto: converta com Number() antes de calcular.
- O + junta textos e soma números: cuidado com a mistura.
- Template literals montam frases com variáveis e contas.
- console.log mostra o resultado, uma linha por chamada.

### Exercícios

#### 1. Desafio: ficha da pessoa

*Desafio · difícil · id `desafio2-ficha-da-pessoa` · conceitos: Entrada e saída de informações (peso 2); Template literals (peso 2); Conversão de tipos (peso 2); Introdução às variáveis (peso 1); Utilização de let e const (peso 1)*

Escreva a função `ficha()`: leia o nome, a idade e a altura (em metros) com `lerEntrada()` (chegam como texto) e mostre quatro linhas com `console.log`: Nome: NOME, Idade: IDADE anos, Altura: ALTURA m e Daqui a 10 anos, NOME terá IDADE+10 anos.

Função: `ficha`

Código inicial:

```js
function ficha() {
  // leia nome, idade e altura
  // mostre as quatro linhas pedidas
}
```

Testes:

- entrada [], lê ["Ana","20","1.75"] → imprime ["Nome: Ana","Idade: 20 anos","Altura: 1.75 m","Daqui a 10 anos, Ana terá 30 anos."]
- entrada [], lê ["Beto","35","1.8"] → imprime ["Nome: Beto","Idade: 35 anos","Altura: 1.8 m","Daqui a 10 anos, Beto terá 45 anos."]

Solução de referência:

```js
function ficha() {
  const nome = lerEntrada();
  const idade = Number(lerEntrada());
  const altura = Number(lerEntrada());
  console.log(`Nome: ${nome}`);
  console.log(`Idade: ${idade} anos`);
  console.log(`Altura: ${altura} m`);
  console.log(`Daqui a 10 anos, ${nome} terá ${idade + 10} anos.`);
}
```

**Dica:** A idade precisa virar número para somar 10. Use const para os dados que não mudam.

**Solução comentada:** O programa lê os três dados, converte a idade para número, soma 10 e monta cada frase com template literals.

#### 2. Desafio: corrija o resumo

*Corrigir o erro · difícil · id `desafio2-corrija-o-resumo` · conceitos: Conversão de tipos (peso 3); Concatenação (peso 2); Entrada e saída de informações (peso 2)*

O programa lê dois números e deveria mostrar a soma e a média, mas mostra resultados errados (por exemplo, Soma: 46 e Média: 23 para as entradas 4 e 6). Corrija o defeito.

Função: `resumo`

Código inicial:

```js
function resumo() {
  const a = lerEntrada();
  const b = lerEntrada();
  const soma = a + b;
  const media = soma / 2;
  console.log(`Soma: ${soma}`);
  console.log(`Média: ${media}`);
}
```

Testes:

- entrada [], lê ["4","6"] → imprime ["Soma: 10","Média: 5"]
- entrada [], lê ["10","20"] → imprime ["Soma: 30","Média: 15"]
- entrada [], lê ["3","4"] → imprime ["Soma: 7","Média: 3.5"]

Solução de referência:

```js
function resumo() {
  const a = Number(lerEntrada());
  const b = Number(lerEntrada());
  const soma = a + b;
  const media = soma / 2;
  console.log(`Soma: ${soma}`);
  console.log(`Média: ${media}`);
}
```

**Dica:** Os valores lidos são textos. O que o + faz com dois textos?

**Solução comentada:** Como as entradas são texto, a + b juntava os valores ("46"). Convertendo com Number(), a soma e a média passam a ser calculadas com números.

#### 3. Desafio: acompanhe os tipos

*Interpretação de código · difícil · id `desafio2-tipos-e-conversoes` · conceitos: Conversão de tipos (peso 2); Concatenação (peso 2); Tipo String (peso 1); Tipo Number (peso 1)*

Acompanhe o valor e o tipo de cada variável. O que o programa abaixo mostra na tela, em ordem?

```
const preco = "20";
const quantidade = 3;
let total = preco * quantidade;
total = total + "0";
console.log(typeof total);
console.log(total);
```

- ✗ number / 60 — *confusão: ignora a segunda atribuição, que transforma o total em texto*
- ✔ **string / 600** (correta)
- ✗ number / 600 — *confusão: acha que somar um texto a um número mantém o tipo number*
- ✗ string / 2060 — *confusão: junta "20" e 3 em vez de multiplicar*

**Dica:** O * converte o texto em número; depois o + com um texto junta os valores.

**Ao acertar:** preco * quantidade converte "20" em 20 e dá 60 (number). Depois, total + "0" junta 60 com "0" e resulta no texto "600" (string).

