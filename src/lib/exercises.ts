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
  { id: "fundamentos", title: "Fundamentos", focus: "Traduzir um problema em passos e operações" },
  { id: "condicionais", title: "Condicionais", focus: "Tomar decisões no fluxo do algoritmo" },
  { id: "repeticao", title: "Estruturas de repetição", focus: "Compreender o passo a passo de um laço" },
  { id: "vetores", title: "Vetores", focus: "Manipular coleções de dados" },
];

export const exercises: Exercise[] = [
  {
    id: "soma",
    moduleId: "fundamentos",
    title: "Somar dois números",
    difficulty: "facil",
    statement: "Escreva a função `soma(a, b)` que retorna a soma de dois números.",
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
    statement: "Escreva `media(a, b, c)` que retorna a média aritmética de três números.",
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
    statement: "Escreva `maiorDeTres(a, b, c)` que retorna o maior dos três números, sem usar `Math.max`.",
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
    statement: "Escreva `somatorio(n)` que retorna 1 + 2 + ... + n usando um laço. Para n = 0, retorna 0.",
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
    statement: "Escreva `somaVetor(v)` que retorna a soma de todos os elementos do vetor `v`.",
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
];

export function getExercise(id: string): Exercise | undefined {
  return exercises.find((e) => e.id === id);
}

export function exercisesOf(moduleId: string): Exercise[] {
  return exercises.filter((e) => e.moduleId === moduleId);
}
