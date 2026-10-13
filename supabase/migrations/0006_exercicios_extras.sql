-- Conteúdo extra para o piloto: 31 exercícios novos e 2 módulos ("Funções" e "Textos").
-- Execute depois de 0005.
--
-- TODOS entram como RASCUNHO (published = false): os alunos só os veem depois que o professor
-- revisar e publicar em Professor > Exercícios. As respostas dos de código estão em
-- docs/gabarito-exercicios-extras.md (cole a solução no editor, clique em "Validar testes" e publique).

insert into public.modules (id, title, focus, position) values
  ($q$funcoes$q$, $q$Funções$q$, $q$Dividir um problema em partes reutilizáveis$q$, 5),
  ($q$textos$q$, $q$Textos$q$, $q$Percorrer e transformar sequências de caracteres$q$, 6);

insert into public.exercises
  (id, module_id, kind, title, difficulty, statement, lesson, function_name, starter_code, tests, config, hint, position, published)
values
  ($q$tipos-de-dados$q$, $q$primeiros-passos$q$, $q$choice$q$, $q$Qual é o tipo do valor?$q$, $q$facil$q$, $q$Em JavaScript, qual é o tipo do valor "42" (escrito entre aspas)?$q$, $q$Todo valor tem um tipo: número (3 ou 2.5), texto ("olá") ou lógico (true ou false). O tipo define o que podemos fazer com o valor.$q$, null, '', '[]'::jsonb, $q${"options":["Número","Texto (string)","Lógico (boolean)","Vetor"],"correct":1,"explanation":"As aspas fazem de \"42\" um texto. Sem aspas, 42 seria um número."}$q$::jsonb, $q$Repare nas aspas.$q$, 101, false),
  ($q$precedencia-operadores$q$, $q$primeiros-passos$q$, $q$choice$q$, $q$Quem calcula primeiro?$q$, $q$facil$q$, $q$Qual é o resultado de 2 + 3 * 4?$q$, $q$Como na matemática, multiplicação e divisão são calculadas antes de soma e subtração. Parênteses mudam a ordem.$q$, null, '', '[]'::jsonb, $q${"options":["20","14","24","10"],"correct":1,"explanation":"A multiplicação vem primeiro: 3 * 4 = 12, e depois 2 + 12 = 14. Com parênteses, (2 + 3) * 4 daria 20."}$q$::jsonb, $q$Faça a multiplicação antes da soma.$q$, 102, false),
  ($q$resto-da-divisao$q$, $q$primeiros-passos$q$, $q$choice$q$, $q$Resto da divisão$q$, $q$facil$q$, $q$Quanto vale 17 % 5?$q$, $q$O operador % devolve o resto da divisão inteira. Por exemplo, 7 % 3 vale 1, porque 7 = 2 * 3 + 1. Um número é par quando n % 2 vale 0.$q$, null, '', '[]'::jsonb, $q${"options":["3","2","12","3,4"],"correct":1,"explanation":"17 = 3 * 5 + 2, então o resto é 2."}$q$::jsonb, $q$Quantas vezes o 5 cabe no 17? O que sobra?$q$, 103, false),
  ($q$quadrado$q$, $q$fundamentos$q$, 'code', $q$Quadrado de um número$q$, $q$facil$q$, $q$Escreva `quadrado(n)` que retorna n multiplicado por ele mesmo.$q$, null, $q$quadrado$q$, $q$function quadrado(n) {
  // seu código aqui
}
$q$, $q$[{"args":[2],"expected":4},{"args":[0],"expected":0},{"args":[-3],"expected":9},{"args":[1.5],"expected":2.25}]$q$::jsonb, '{}'::jsonb, $q$Use o operador * com n duas vezes.$q$, 101, false),
  ($q$media-ponderada$q$, $q$fundamentos$q$, 'code', $q$Média ponderada$q$, $q$medio$q$, $q$Escreva `mediaPonderada(a, b)` que calcula a média em que a nota `a` tem peso 3 e a nota `b` tem peso 7 (some os pesos: 3 + 7 = 10).$q$, null, $q$mediaPonderada$q$, $q$function mediaPonderada(a, b) {
  // seu código aqui
}
$q$, $q$[{"args":[10,10],"expected":10},{"args":[0,10],"expected":7},{"args":[10,0],"expected":3},{"args":[5,5],"expected":5},{"args":[6,8],"expected":7.4},{"args":[9,4],"expected":5.5}]$q$::jsonb, '{}'::jsonb, $q$Multiplique cada nota pelo peso, some e divida por 10.$q$, 102, false),
  ($q$completar-media$q$, $q$fundamentos$q$, $q$blank$q$, $q$Complete o cálculo da média$q$, $q$facil$q$, $q$Complete as lacunas para que a função retorne a média de dois números.$q$, $q$Os operadores aritméticos são + (soma), - (subtração), * (multiplicação) e / (divisão). Parênteses garantem que a soma aconteça antes da divisão.$q$, null, '', '[]'::jsonb, $q${"template":"function media(a, b) {\n  return (a {{1}} b) {{2}} 2;\n}","blanks":[{"answers":["+"]},{"answers":["/"]}],"explanation":"Primeiro somamos os dois valores e depois dividimos a soma por 2."}$q$::jsonb, $q$Média = soma dividida pela quantidade.$q$, 103, false),
  ($q$operadores-logicos$q$, $q$condicionais$q$, $q$choice$q$, $q$E, OU e NÃO$q$, $q$facil$q$, $q$Se idade = 20 e temCarteira = false, quanto vale a expressão (idade >= 18 && temCarteira)?$q$, $q$&& (E) só é verdadeiro quando as duas condições são verdadeiras. || (OU) é verdadeiro se pelo menos uma for. ! (NÃO) inverte o valor lógico.$q$, null, '', '[]'::jsonb, $q${"options":["true","false","20","dá erro"],"correct":1,"explanation":"idade >= 18 é true, mas temCarteira é false. Com &&, as duas precisam ser verdadeiras, então o resultado é false."}$q$::jsonb, $q$Com && (E), uma condição falsa já basta para o resultado ser falso.$q$, 101, false),
  ($q$completar-else-if$q$, $q$condicionais$q$, $q$blank$q$, $q$Complete a classificação$q$, $q$medio$q$, $q$Complete as lacunas para classificar a nota em A (9 ou mais), B (7 ou mais) ou C (as demais).$q$, $q$Quando há mais de dois caminhos, encadeamos condições com "else if" (senão, se). O "else" final trata todos os casos que sobraram.$q$, null, '', '[]'::jsonb, $q${"template":"function conceito(nota) {\n  if (nota >= 9) {\n    return \"A\";\n  } {{1}} (nota >= 7) {\n    return \"B\";\n  } {{2}} {\n    return \"C\";\n  }\n}","blanks":[{"answers":["else if"]},{"answers":["else"]}],"explanation":"Depois do primeiro \"if\", usamos \"else if\" para a segunda condição e \"else\" para o que sobrou."}$q$::jsonb, $q$Em inglês: "senão, se" e "senão".$q$, 102, false),
  ($q$dentro-do-intervalo$q$, $q$condicionais$q$, 'code', $q$Dentro do intervalo$q$, $q$facil$q$, $q$Escreva `dentroDoIntervalo(n, min, max)` que retorna true se n está entre min e max (incluindo os extremos) e false caso contrário.$q$, null, $q$dentroDoIntervalo$q$, $q$function dentroDoIntervalo(n, min, max) {
  // seu código aqui
}
$q$, $q$[{"args":[5,1,10],"expected":true},{"args":[1,1,10],"expected":true},{"args":[10,1,10],"expected":true},{"args":[0,1,10],"expected":false},{"args":[11,1,10],"expected":false}]$q$::jsonb, '{}'::jsonb, $q$Combine duas comparações com && (E).$q$, 103, false),
  ($q$tipo-de-triangulo$q$, $q$condicionais$q$, 'code', $q$Tipo de triângulo$q$, $q$medio$q$, $q$Escreva `tipoTriangulo(a, b, c)` que recebe os três lados e retorna "equilatero" (três lados iguais), "isosceles" (exatamente dois iguais) ou "escaleno" (todos diferentes).$q$, null, $q$tipoTriangulo$q$, $q$function tipoTriangulo(a, b, c) {
  // seu código aqui
}
$q$, $q$[{"args":[3,3,3],"expected":"equilatero"},{"args":[3,3,4],"expected":"isosceles"},{"args":[3,4,3],"expected":"isosceles"},{"args":[4,3,3],"expected":"isosceles"},{"args":[3,4,5],"expected":"escaleno"}]$q$::jsonb, '{}'::jsonb, $q$Teste primeiro o caso mais específico (os três iguais).$q$, 104, false),
  ($q$quantas-vezes$q$, $q$repeticao$q$, $q$choice$q$, $q$Quantas vezes o laço executa?$q$, $q$facil$q$, $q$for (let i = 0; i < 4; i++) {
  // bloco
}

Quantas vezes o bloco executa?$q$, $q$Um laço for tem três partes: onde começa (let i = 0), até quando continua (i < 4) e como muda a cada volta (i++). O bloco executa enquanto a condição for verdadeira.$q$, null, '', '[]'::jsonb, $q${"options":["3","4","5","Infinitas vezes"],"correct":1,"explanation":"i vale 0, 1, 2 e 3, ou seja, 4 voltas. Quando i chega a 4, a condição i < 4 deixa de ser verdadeira."}$q$::jsonb, $q$Liste os valores de i, um por volta.$q$, 101, false),
  ($q$completar-while$q$, $q$repeticao$q$, $q$blank$q$, $q$Complete o while$q$, $q$medio$q$, $q$Complete as lacunas para calcular 5! (5 × 4 × 3 × 2 × 1) em fatorial.$q$, $q$O laço "while" (enquanto) repete o bloco enquanto a condição for verdadeira. É preciso mudar alguma variável dentro do laço, senão ele nunca termina.$q$, null, '', '[]'::jsonb, $q${"template":"let n = 5;\nlet fatorial = 1;\n{{1}} (n > 1) {\n  fatorial = fatorial * n;\n  n{{2}};\n}","blanks":[{"answers":["while"]},{"answers":["--","-= 1","-=1"]}],"explanation":"O while repete enquanto n > 1, e n-- diminui n em 1 a cada volta, até a condição ficar falsa."}$q$::jsonb, $q$Em inglês: "enquanto". Para diminuir 1, existe um operador parecido com o ++.$q$, 102, false),
  ($q$soma-dos-pares$q$, $q$repeticao$q$, 'code', $q$Soma dos números pares$q$, $q$medio$q$, $q$Escreva `somaPares(n)` que retorna a soma de todos os números pares de 1 até n (incluindo n, se for par). Para n menor que 2, o resultado é 0.$q$, null, $q$somaPares$q$, $q$function somaPares(n) {
  // seu código aqui
}
$q$, $q$[{"args":[10],"expected":30},{"args":[1],"expected":0},{"args":[0],"expected":0},{"args":[7],"expected":12},{"args":[2],"expected":2}]$q$::jsonb, '{}'::jsonb, $q$Percorra os números e some só os que têm resto 0 na divisão por 2.$q$, 103, false),
  ($q$potencia$q$, $q$repeticao$q$, 'code', $q$Potência$q$, $q$medio$q$, $q$Escreva `potencia(base, exp)` que retorna base elevada a exp (um inteiro maior ou igual a 0), usando um laço. Não use `Math.pow` nem o operador `**`.$q$, null, $q$potencia$q$, $q$function potencia(base, exp) {
  // seu código aqui
}
$q$, $q$[{"args":[2,3],"expected":8},{"args":[5,0],"expected":1},{"args":[3,1],"expected":3},{"args":[10,4],"expected":10000},{"args":[0,5],"expected":0}]$q$::jsonb, '{}'::jsonb, $q$Comece o resultado em 1 e multiplique pela base, exp vezes.$q$, 104, false),
  ($q$conta-digitos$q$, $q$repeticao$q$, 'code', $q$Quantos dígitos?$q$, $q$medio$q$, $q$Escreva `contaDigitos(n)` que retorna quantos dígitos tem o inteiro n (maior ou igual a 0), sem converter para texto. O número 0 tem 1 dígito.$q$, null, $q$contaDigitos$q$, $q$function contaDigitos(n) {
  // seu código aqui
}
$q$, $q$[{"args":[0],"expected":1},{"args":[7],"expected":1},{"args":[10],"expected":2},{"args":[12345],"expected":5},{"args":[100],"expected":3}]$q$::jsonb, '{}'::jsonb, $q$Divida por 10 (parte inteira) até sobrar um dígito, contando as divisões.$q$, 105, false),
  ($q$mdc$q$, $q$repeticao$q$, 'code', $q$Máximo divisor comum$q$, $q$dificil$q$, $q$Escreva `mdc(a, b)` que retorna o maior número que divide a e b ao mesmo tempo (a e b inteiros positivos). Dica: o algoritmo de Euclides troca (a, b) por (b, a % b) até o resto ser 0.$q$, null, $q$mdc$q$, $q$function mdc(a, b) {
  // seu código aqui
}
$q$, $q$[{"args":[12,18],"expected":6},{"args":[7,13],"expected":1},{"args":[100,25],"expected":25},{"args":[48,36],"expected":12},{"args":[17,17],"expected":17}]$q$::jsonb, '{}'::jsonb, $q$Repita enquanto b for diferente de 0; quando b chegar a 0, a resposta é a.$q$, 106, false),
  ($q$indice-do-vetor$q$, $q$vetores$q$, $q$choice$q$, $q$O primeiro elemento$q$, $q$facil$q$, $q$Em let v = [10, 20, 30, 40], quanto vale v[2]?$q$, $q$Um vetor guarda vários valores numa só variável. Cada posição tem um índice, e a contagem começa em 0: v[0] é o primeiro elemento, v[1] o segundo, e assim por diante.$q$, null, '', '[]'::jsonb, $q${"options":["20","30","40","10"],"correct":1,"explanation":"Os índices são v[0] = 10, v[1] = 20, v[2] = 30 e v[3] = 40."}$q$::jsonb, $q$Lembre-se: o primeiro índice é 0.$q$, 101, false),
  ($q$completar-percorrer$q$, $q$vetores$q$, $q$blank$q$, $q$Percorrer o vetor$q$, $q$facil$q$, $q$Complete as lacunas para somar todos os elementos do vetor v.$q$, $q$Para percorrer um vetor, usamos um índice i que vai de 0 até o último elemento. O tamanho do vetor é v.length, e o elemento da posição i é v[i].$q$, null, '', '[]'::jsonb, $q${"template":"let soma = 0;\nfor (let i = 0; i < v{{1}}; i++) {\n  soma += v{{2}};\n}","blanks":[{"answers":[".length"]},{"answers":["[i]"]}],"explanation":"O laço vai de 0 até v.length - 1, e a cada volta somamos o elemento da posição i, que é v[i]."}$q$::jsonb, $q$O tamanho é uma propriedade do vetor; o elemento usa colchetes.$q$, 102, false),
  ($q$conta-pares$q$, $q$vetores$q$, 'code', $q$Quantos pares?$q$, $q$facil$q$, $q$Escreva `contaPares(v)` que retorna quantos elementos pares existem no vetor de inteiros `v`.$q$, null, $q$contaPares$q$, $q$function contaPares(v) {
  // seu código aqui
}
$q$, $q$[{"args":[[1,2,3,4]],"expected":2},{"args":[[]],"expected":0},{"args":[[1,3,5]],"expected":0},{"args":[[2,4,6,8]],"expected":4},{"args":[[0]],"expected":1}]$q$::jsonb, '{}'::jsonb, $q$Percorra o vetor e some 1 a um contador sempre que o elemento for par.$q$, 103, false),
  ($q$media-do-vetor$q$, $q$vetores$q$, 'code', $q$Média do vetor$q$, $q$medio$q$, $q$Escreva `mediaVetor(v)` que retorna a média dos números do vetor `v`, que tem pelo menos um elemento.$q$, null, $q$mediaVetor$q$, $q$function mediaVetor(v) {
  // seu código aqui
}
$q$, $q$[{"args":[[1,2,3]],"expected":2},{"args":[[10]],"expected":10},{"args":[[1,2]],"expected":1.5},{"args":[[0,0,6]],"expected":2},{"args":[[-2,2]],"expected":0}]$q$::jsonb, '{}'::jsonb, $q$Some tudo e divida pela quantidade de elementos.$q$, 104, false),
  ($q$segundo-maior$q$, $q$vetores$q$, 'code', $q$Segundo maior valor$q$, $q$dificil$q$, $q$Escreva `segundoMaior(v)` que retorna o segundo maior valor DISTINTO do vetor `v` (que tem pelo menos dois valores diferentes). Por exemplo, em [10, 9, 10, 8] o segundo maior é 9.$q$, null, $q$segundoMaior$q$, $q$function segundoMaior(v) {
  // seu código aqui
}
$q$, $q$[{"args":[[3,1,2]],"expected":2},{"args":[[5,5,4]],"expected":4},{"args":[[1,2]],"expected":1},{"args":[[10,9,10,8]],"expected":9},{"args":[[-1,-5,-3]],"expected":-3}]$q$::jsonb, '{}'::jsonb, $q$Guarde o maior e o segundo maior vistos até agora, atualizando os dois a cada elemento.$q$, 105, false),
  ($q$parametro-e-retorno$q$, $q$funcoes$q$, $q$choice$q$, $q$Parâmetro e retorno$q$, $q$facil$q$, $q$Na função abaixo, o que é n?

function dobro(n) {
  return n * 2;
}$q$, $q$Uma função recebe valores de entrada, chamados parâmetros, e pode devolver um resultado com return. Assim, o mesmo código pode ser reutilizado com valores diferentes.$q$, null, '', '[]'::jsonb, $q${"options":["O resultado da função","Um parâmetro: o valor de entrada","O nome da função","Um erro"],"correct":1,"explanation":"n é o parâmetro: o valor que a função recebe. O resultado é o que ela devolve com return."}$q$::jsonb, $q$Fica entre parênteses, depois do nome.$q$, 101, false),
  ($q$completar-funcao$q$, $q$funcoes$q$, $q$blank$q$, $q$Complete a função$q$, $q$facil$q$, $q$Complete as lacunas para definir uma função que devolve a área de um retângulo.$q$, $q$Uma função é declarada com a palavra "function", seguida do nome e dos parâmetros entre parênteses. Para devolver o resultado, usamos "return".$q$, null, '', '[]'::jsonb, $q${"template":"{{1}} area(base, altura) {\n  {{2}} base * altura;\n}","blanks":[{"answers":["function"]},{"answers":["return"]}],"explanation":"\"function\" declara a função e \"return\" devolve o resultado para quem a chamou."}$q$::jsonb, $q$Em inglês: "função" e "retornar".$q$, 102, false),
  ($q$escopo-de-variavel$q$, $q$funcoes$q$, $q$choice$q$, $q$Onde a variável existe?$q$, $q$medio$q$, $q$O que acontece ao executar o código abaixo?

function f() {
  let x = 5;
}
f();
console.log(x);$q$, $q$Uma variável criada dentro de uma função só existe ali dentro. Esse limite se chama escopo: fora da função, o nome não é conhecido.$q$, null, '', '[]'::jsonb, $q${"options":["Mostra 5","Dá erro: x não existe fora da função","Mostra undefined","Mostra 0"],"correct":1,"explanation":"x foi criada dentro de f, então só existe ali. Fora da função, usar x causa um erro (ReferenceError)."}$q$::jsonb, $q$Onde a variável x foi declarada?$q$, 103, false),
  ($q$maior-de-dois$q$, $q$funcoes$q$, 'code', $q$Maior de dois$q$, $q$facil$q$, $q$Escreva `maiorDeDois(a, b)` que retorna o maior entre os dois números.$q$, $q$Uma função pode escolher entre valores e devolver só um deles. Cada caminho do if pode ter o seu próprio return.$q$, $q$maiorDeDois$q$, $q$function maiorDeDois(a, b) {
  // seu código aqui
}
$q$, $q$[{"args":[1,2],"expected":2},{"args":[5,3],"expected":5},{"args":[4,4],"expected":4},{"args":[-1,-2],"expected":-1},{"args":[0,-7],"expected":0}]$q$::jsonb, '{}'::jsonb, $q$Compare os dois com um if e retorne o maior.$q$, 104, false),
  ($q$hipotenusa$q$, $q$funcoes$q$, 'code', $q$Hipotenusa$q$, $q$medio$q$, $q$Escreva `hipotenusa(a, b)` que retorna o comprimento da hipotenusa de um triângulo retângulo com catetos a e b (teorema de Pitágoras). Você pode usar `Math.sqrt`.$q$, $q$Math.sqrt(x) devolve a raiz quadrada de x. Funções prontas como essa podem ser usadas dentro das suas.$q$, $q$hipotenusa$q$, $q$function hipotenusa(a, b) {
  // seu código aqui
}
$q$, $q$[{"args":[3,4],"expected":5},{"args":[5,12],"expected":13},{"args":[0,0],"expected":0},{"args":[8,15],"expected":17},{"args":[1,1],"expected":1.4142135623730951}]$q$::jsonb, '{}'::jsonb, $q$A hipotenusa é a raiz quadrada de a² + b².$q$, 105, false),
  ($q$tamanho-do-texto$q$, $q$textos$q$, $q$choice$q$, $q$Letras e índices$q$, $q$facil$q$, $q$Em let s = "lógica";, quanto vale s.length?$q$, $q$Um texto é uma sequência de caracteres, e cada um tem um índice começando em 0, como num vetor: "abc"[0] é "a". O tamanho do texto vem de .length.$q$, null, '', '[]'::jsonb, $q${"options":["5","6","7","4"],"correct":1,"explanation":"\"lógica\" tem 6 letras (l, ó, g, i, c, a), então s.length vale 6."}$q$::jsonb, $q$Conte as letras uma a uma.$q$, 101, false),
  ($q$completar-texto$q$, $q$textos$q$, $q$blank$q$, $q$Complete as consultas ao texto$q$, $q$facil$q$, $q$Complete as lacunas para obter o tamanho do texto e a sua primeira letra.$q$, $q$Todo texto tem a propriedade .length (quantos caracteres) e permite acessar uma letra pelo índice entre colchetes, como s[0] para a primeira.$q$, null, '', '[]'::jsonb, $q${"template":"let nome = \"Ana\";\nlet tamanho = nome{{1}};\nlet primeira = nome{{2}};","blanks":[{"answers":[".length"]},{"answers":["[0]",".charAt(0)"]}],"explanation":"nome.length dá o tamanho (3) e nome[0] dá a primeira letra (\"A\")."}$q$::jsonb, $q$A primeira posição tem índice 0.$q$, 102, false),
  ($q$inverter-texto$q$, $q$textos$q$, 'code', $q$Inverter um texto$q$, $q$medio$q$, $q$Escreva `inverterTexto(s)` que retorna o texto `s` de trás para frente. Por exemplo, "abc" vira "cba".$q$, $q$Os textos podem ser percorridos como vetores, usando s[i], e concatenados com +.$q$, $q$inverterTexto$q$, $q$function inverterTexto(s) {
  // seu código aqui
}
$q$, $q$[{"args":["abc"],"expected":"cba"},{"args":[""],"expected":""},{"args":["a"],"expected":"a"},{"args":["lógica"],"expected":"acigól"},{"args":["ab ba"],"expected":"ab ba"}]$q$::jsonb, '{}'::jsonb, $q$Percorra do último índice até o 0, juntando as letras num novo texto.$q$, 103, false),
  ($q$conta-vogais$q$, $q$textos$q$, 'code', $q$Contar vogais$q$, $q$medio$q$, $q$Escreva `contaVogais(s)` que retorna quantas vogais (a, e, i, o, u) há no texto `s`. Os textos de teste têm só letras minúsculas e sem acentos.$q$, null, $q$contaVogais$q$, $q$function contaVogais(s) {
  // seu código aqui
}
$q$, $q$[{"args":["banana"],"expected":3},{"args":[""],"expected":0},{"args":["xyz"],"expected":0},{"args":["aeiou"],"expected":5},{"args":["programacao"],"expected":5},{"args":["logica"],"expected":3}]$q$::jsonb, '{}'::jsonb, $q$Percorra as letras e use "aeiou".includes(letra) para testar cada uma.$q$, 104, false),
  ($q$palindromo$q$, $q$textos$q$, 'code', $q$Palíndromo$q$, $q$dificil$q$, $q$Escreva `ehPalindromo(s)` que retorna true se o texto `s` é igual quando lido de trás para frente (por exemplo, "arara"). Os testes usam só letras minúsculas, sem espaços. O texto vazio é um palíndromo.$q$, null, $q$ehPalindromo$q$, $q$function ehPalindromo(s) {
  // seu código aqui
}
$q$, $q$[{"args":["arara"],"expected":true},{"args":["casa"],"expected":false},{"args":["a"],"expected":true},{"args":[""],"expected":true},{"args":["radar"],"expected":true},{"args":["abca"],"expected":false}]$q$::jsonb, '{}'::jsonb, $q$Compare a primeira letra com a última, a segunda com a penúltima, e assim por diante.$q$, 105, false);
