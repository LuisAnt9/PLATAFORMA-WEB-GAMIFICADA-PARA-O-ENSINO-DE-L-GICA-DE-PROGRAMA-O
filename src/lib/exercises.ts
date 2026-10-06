export type Difficulty = "facil" | "medio" | "dificil";

export interface TestCase {
  args: unknown[];
  expected: unknown;
}

export interface Exercise {
  id: string;
  moduleId: string;
  title: string;
  difficulty: Difficulty;
  statement: string;
  /** Nome da função que o aluno deve implementar. */
  functionName: string;
  starterCode: string;
  tests: TestCase[];
  hint: string;
}

export interface Module {
  id: string;
  title: string;
  /** Dificuldade de aprendizagem (referencial teórico) que o módulo trabalha. */
  focus: string;
}

export const XP_BY_DIFFICULTY: Record<Difficulty, number> = {
  facil: 10,
  medio: 20,
  dificil: 35,
};

export const modules: Module[] = [
  {
    id: "fundamentos",
    title: "Fundamentos",
    focus: "Traduzir um problema em passos e operações",
  },
  {
    id: "condicionais",
    title: "Condicionais",
    focus: "Tomar decisões no fluxo do algoritmo",
  },
  {
    id: "repeticao",
    title: "Estruturas de repetição",
    focus: "Compreender o passo a passo de um laço",
  },
  { id: "vetores", title: "Vetores", focus: "Manipular coleções de dados" },
];

export const exercises: Exercise[] = [
  {
    id: "soma",
    moduleId: "fundamentos",
    title: "Somar dois números",
    difficulty: "facil",
    statement:
      "Escreva a função `soma(a, b)` que retorna a soma de dois números.",
    functionName: "soma",
    starterCode: "function soma(a, b) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [2, 3], expected: 5 },
      { args: [-1, 1], expected: 0 },
      { args: [10, 25], expected: 35 },
    ],
    hint: "Use o operador + e não esqueça do `return`.",
  },
  {
    id: "media",
    moduleId: "fundamentos",
    title: "Média aritmética",
    difficulty: "facil",
    statement:
      "Escreva `media(a, b, c)` que retorna a média aritmética de três números.",
    functionName: "media",
    starterCode: "function media(a, b, c) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [3, 6, 9], expected: 6 },
      { args: [0, 0, 0], expected: 0 },
      { args: [1, 2, 3], expected: 2 },
    ],
    hint: "Some os três valores entre parênteses antes de dividir por 3.",
  },
  {
    id: "par-ou-impar",
    moduleId: "condicionais",
    title: "Par ou ímpar",
    difficulty: "facil",
    statement: 'Escreva `parOuImpar(n)` que retorna a string "par" ou "impar".',
    functionName: "parOuImpar",
    starterCode: "function parOuImpar(n) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [4], expected: "par" },
      { args: [7], expected: "impar" },
      { args: [0], expected: "par" },
    ],
    hint: "O resto da divisão por 2 (`n % 2`) diz se o número é par.",
  },
  {
    id: "maior-de-tres",
    moduleId: "condicionais",
    title: "Maior de três",
    difficulty: "medio",
    statement:
      "Escreva `maiorDeTres(a, b, c)` que retorna o maior dos três números, sem usar `Math.max`.",
    functionName: "maiorDeTres",
    starterCode: "function maiorDeTres(a, b, c) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [1, 2, 3], expected: 3 },
      { args: [9, 2, 3], expected: 9 },
      { args: [4, 8, 3], expected: 8 },
      { args: [-5, -2, -9], expected: -2 },
    ],
    hint: "Guarde o maior valor visto até agora numa variável e compare com cada número.",
  },
  {
    id: "somatorio",
    moduleId: "repeticao",
    title: "Somatório de 1 até n",
    difficulty: "facil",
    statement:
      "Escreva `somatorio(n)` que retorna 1 + 2 + ... + n usando um laço. Para n = 0, retorna 0.",
    functionName: "somatorio",
    starterCode: "function somatorio(n) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [5], expected: 15 },
      { args: [1], expected: 1 },
      { args: [0], expected: 0 },
      { args: [100], expected: 5050 },
    ],
    hint: "Crie um acumulador começando em 0 e some `i` a cada volta do `for`.",
  },
  {
    id: "fatorial",
    moduleId: "repeticao",
    title: "Fatorial",
    difficulty: "medio",
    statement: "Escreva `fatorial(n)` que retorna n! (com 0! = 1).",
    functionName: "fatorial",
    starterCode: "function fatorial(n) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [0], expected: 1 },
      { args: [1], expected: 1 },
      { args: [5], expected: 120 },
      { args: [10], expected: 3628800 },
    ],
    hint: "Diferente do somatório, o acumulador começa em 1 e é multiplicado.",
  },
  {
    id: "soma-vetor",
    moduleId: "vetores",
    title: "Soma dos elementos",
    difficulty: "medio",
    statement:
      "Escreva `somaVetor(v)` que retorna a soma de todos os elementos do vetor `v`.",
    functionName: "somaVetor",
    starterCode: "function somaVetor(v) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [[1, 2, 3]], expected: 6 },
      { args: [[]], expected: 0 },
      { args: [[-2, 2, 10]], expected: 10 },
    ],
    hint: "Percorra o vetor com um laço usando `v.length` e acumule `v[i]`.",
  },
  {
    id: "inverter-vetor",
    moduleId: "vetores",
    title: "Inverter vetor",
    difficulty: "dificil",
    statement:
      "Escreva `inverter(v)` que retorna um NOVO vetor com os elementos na ordem inversa, sem usar `reverse`.",
    functionName: "inverter",
    starterCode: "function inverter(v) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [[1, 2, 3]], expected: [3, 2, 1] },
      { args: [[]], expected: [] },
      { args: [["a", "b"]], expected: ["b", "a"] },
      { args: [[7]], expected: [7] },
    ],
    hint: "Percorra o vetor do último índice até o 0 e use `push` num vetor novo.",
  },
  {
    id: "celsius",
    moduleId: "fundamentos",
    title: "Celsius para Fahrenheit",
    difficulty: "facil",
    statement:
      "Escreva `celsiusParaFahrenheit(c)` que converte graus Celsius para Fahrenheit (F = C × 9/5 + 32).",
    functionName: "celsiusParaFahrenheit",
    starterCode:
      "function celsiusParaFahrenheit(c) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [0], expected: 32 },
      { args: [100], expected: 212 },
      { args: [-40], expected: -40 },
      { args: [10], expected: 50 },
    ],
    hint: "Multiplique por 9, divida por 5 e some 32.",
  },
  {
    id: "area-retangulo",
    moduleId: "fundamentos",
    title: "Área do retângulo",
    difficulty: "facil",
    statement:
      "Escreva `areaRetangulo(base, altura)` que retorna a área do retângulo.",
    functionName: "areaRetangulo",
    starterCode:
      "function areaRetangulo(base, altura) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [3, 4], expected: 12 },
      { args: [1, 1], expected: 1 },
      { args: [0, 5], expected: 0 },
      { args: [2.5, 4], expected: 10 },
    ],
    hint: "A área é base vezes altura.",
  },
  {
    id: "nota",
    moduleId: "condicionais",
    title: "Situação do aluno",
    difficulty: "medio",
    statement:
      'Escreva `situacao(nota)` que retorna "aprovado" se nota >= 7, "recuperacao" se nota >= 5, ou "reprovado" caso contrário.',
    functionName: "situacao",
    starterCode: "function situacao(nota) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [10], expected: "aprovado" },
      { args: [7], expected: "aprovado" },
      { args: [6.5], expected: "recuperacao" },
      { args: [5], expected: "recuperacao" },
      { args: [4.9], expected: "reprovado" },
    ],
    hint: "Teste primeiro a faixa mais alta e use `else if` para as demais.",
  },
  {
    id: "bissexto",
    moduleId: "condicionais",
    title: "Ano bissexto",
    difficulty: "dificil",
    statement:
      "Escreva `ehBissexto(ano)` que retorna true se o ano é bissexto: divisível por 4, exceto os divisíveis por 100, a menos que também sejam divisíveis por 400.",
    functionName: "ehBissexto",
    starterCode: "function ehBissexto(ano) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [2024], expected: true },
      { args: [2023], expected: false },
      { args: [1900], expected: false },
      { args: [2000], expected: true },
      { args: [2100], expected: false },
    ],
    hint: "Combine as três regras com `&&` e `||`, cuidando dos parênteses.",
  },
  {
    id: "tabuada",
    moduleId: "repeticao",
    title: "Tabuada",
    difficulty: "facil",
    statement:
      "Escreva `tabuada(n)` que retorna um vetor com n×1, n×2, ..., n×10.",
    functionName: "tabuada",
    starterCode: "function tabuada(n) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [2], expected: [2, 4, 6, 8, 10, 12, 14, 16, 18, 20] },
      { args: [0], expected: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0] },
      { args: [5], expected: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50] },
    ],
    hint: "Crie um vetor vazio e faça `push(n * i)` para i de 1 a 10.",
  },
  {
    id: "primo",
    moduleId: "repeticao",
    title: "Número primo",
    difficulty: "dificil",
    statement:
      "Escreva `ehPrimo(n)` que retorna true se n é primo (maior que 1 e divisível apenas por 1 e por ele mesmo).",
    functionName: "ehPrimo",
    starterCode: "function ehPrimo(n) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [2], expected: true },
      { args: [1], expected: false },
      { args: [0], expected: false },
      { args: [17], expected: true },
      { args: [18], expected: false },
      { args: [97], expected: true },
    ],
    hint: "Teste os divisores de 2 até n-1; se algum dividir exatamente, não é primo.",
  },
  {
    id: "maior-vetor",
    moduleId: "vetores",
    title: "Maior elemento",
    difficulty: "medio",
    statement:
      "Escreva `maiorElemento(v)` que retorna o maior número de um vetor não vazio, sem usar `Math.max`.",
    functionName: "maiorElemento",
    starterCode: "function maiorElemento(v) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [[3, 9, 2]], expected: 9 },
      { args: [[-4, -1, -7]], expected: -1 },
      { args: [[5]], expected: 5 },
    ],
    hint: "Comece com `v[0]` como maior e compare com os demais elementos.",
  },
  {
    id: "busca-linear",
    moduleId: "vetores",
    title: "Busca linear",
    difficulty: "medio",
    statement:
      "Escreva `buscar(v, x)` que retorna o índice da primeira ocorrência de x no vetor, ou -1 se não existir. Não use `indexOf`.",
    functionName: "buscar",
    starterCode: "function buscar(v, x) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [[4, 8, 15], 8], expected: 1 },
      { args: [[4, 8, 15], 99], expected: -1 },
      { args: [[], 1], expected: -1 },
      { args: [[7, 7, 7], 7], expected: 0 },
    ],
    hint: "Percorra o vetor e retorne o índice assim que encontrar o valor; só retorne -1 depois do laço.",
  },
  {
    id: "ordenar",
    moduleId: "vetores",
    title: "Ordenar vetor",
    difficulty: "dificil",
    statement:
      "Escreva `ordenar(v)` que retorna um NOVO vetor de números em ordem crescente, sem usar `sort`.",
    functionName: "ordenar",
    starterCode: "function ordenar(v) {\n  // seu código aqui\n}\n",
    tests: [
      { args: [[3, 1, 2]], expected: [1, 2, 3] },
      { args: [[]], expected: [] },
      { args: [[5, 5, 1]], expected: [1, 5, 5] },
      { args: [[-1, -3, 2, 0]], expected: [-3, -1, 0, 2] },
      { args: [[1, 2, 3]], expected: [1, 2, 3] },
    ],
    hint: "Uma ideia simples: percorra pares vizinhos e troque os que estão fora de ordem, repetindo até não haver trocas (bubble sort).",
  },
];

export function getExercise(id: string): Exercise | undefined {
  return exercises.find((e) => e.id === id);
}

export function exercisesOf(moduleId: string): Exercise[] {
  return exercises.filter((e) => e.moduleId === moduleId);
}
