export type Difficulty = "facil" | "medio" | "dificil";

/**
 * Caso de teste de um exercício com código. Compara o valor retornado (`expected`), as linhas
 * impressas com console.log (`output`), ou os dois. `inputs` são as entradas simuladas que o código
 * recebe ao chamar `lerEntrada()`.
 */
export interface TestCase {
  args: unknown[];
  expected?: unknown;
  inputs?: unknown[];
  output?: string[];
}

export type ExerciseKind =
  | "code"
  | "choice"
  | "blank"
  | "interpretation"
  | "order"
  | "fix"
  | "challenge";

export const KIND_LABEL: Record<ExerciseKind, string> = {
  code: "Código",
  choice: "Múltipla escolha",
  blank: "Completar a lacuna",
  interpretation: "Interpretação de código",
  order: "Ordenação",
  fix: "Corrigir o erro",
  challenge: "Desafio",
};

/** Tipos corrigidos rodando o código do aluno (têm função e testes). */
export const isCodeKind = (k: ExerciseKind) =>
  k === "code" || k === "fix" || k === "challenge";

/** Tipos de escolher uma alternativa. */
export const isChoiceKind = (k: ExerciseKind) =>
  k === "choice" || k === "interpretation";

/**
 * Dados específicos de cada tipo (vêm do banco, escritos por professores, então são tratados
 * com cuidado em `grading.ts`). Múltipla escolha: options + correct. Lacunas: template + blanks.
 */
/** Alternativa: texto simples ou texto + a confusão que ela revela (para a análise de erros). */
export type ChoiceOption = string | { text: string; misconception?: string };

export interface ExerciseConfig {
  options?: ChoiceOption[];
  correct?: number;
  template?: string;
  blanks?: { answers: string[] }[];
  /** Interpretação de código: trecho a ser lido. */
  code?: string;
  /** Ordenação: os passos, na ordem correta. */
  items?: string[];
  /** Mostrada ao acertar. */
  explanation?: string;
}

export interface Exercise {
  id: string;
  kind: ExerciseKind;
  /** Mini-explicação mostrada antes do enunciado. */
  lesson: string | null;
  config: ExerciseConfig;
  moduleId: string;
  title: string;
  difficulty: Difficulty;
  statement: string;
  /** Nome da função que o aluno deve implementar (vazio nos tipos sem código). */
  functionName: string;
  starterCode: string;
  tests: TestCase[];
  hint: string;
  position: number;
  /** Rascunhos (false) só são visíveis para professores. */
  published: boolean;
}

export interface Module {
  id: string;
  title: string;
  /** Dificuldade de aprendizagem (referencial teórico) que o módulo trabalha. */
  focus: string;
  /** Texto do conceito, lido antes dos exercícios (modo aprendizado). */
  intro: string;
  /** Lição complementar: não trava a liberação da próxima lição (migration 0013). */
  optional: boolean;
  /** Mundo ao qual a lição pertence (migration 0010). */
  worldId: string | null;
  /** Exemplo demonstrativo e revisão da lição (migration 0010). */
  example: string;
  review: string;
  position: number;
}

export interface World {
  id: string;
  title: string;
  objective: string;
  position: number;
}

export interface Concept {
  id: string;
  title: string;
  description: string;
  worldId: string | null;
}

/** Ligação exercício-conceito (migration 0010). */
export interface ExerciseConcept {
  exerciseId: string;
  conceptId: string;
  weight: number;
}

export interface Catalog {
  modules: Module[];
  exercises: Exercise[];
  /** Conceitos e ligações (migration 0010); vazios se o banco ainda não os tem. */
  concepts?: Concept[];
  links?: ExerciseConcept[];
}

export const EMPTY_CATALOG: Catalog = {
  modules: [],
  exercises: [],
  concepts: [],
  links: [],
};

/** Conceitos de um exercício, do mais para o menos importante. */
export function conceptsOf(c: Catalog, exerciseId: string): Concept[] {
  const byId = new Map((c.concepts ?? []).map((x) => [x.id, x]));
  return (c.links ?? [])
    .filter((l) => l.exerciseId === exerciseId)
    .sort((a, b) => b.weight - a.weight)
    .map((l) => byId.get(l.conceptId))
    .filter((x): x is Concept => x !== undefined);
}

export const XP_BY_DIFFICULTY: Record<Difficulty, number> = {
  facil: 10,
  medio: 20,
  dificil: 35,
};

export const DIFFICULTY_LABEL: Record<Difficulty, string> = {
  facil: "Fácil",
  medio: "Médio",
  dificil: "Difícil",
};

export function getExercise(c: Catalog, id: string): Exercise | undefined {
  return c.exercises.find((e) => e.id === id);
}

export function exercisesOf(c: Catalog, moduleId: string): Exercise[] {
  return c.exercises
    .filter((e) => e.moduleId === moduleId)
    .sort((a, b) => a.position - b.position);
}

/** Todos os exercícios na ordem da trilha: por módulo e, dentro dele, por posição. */
export function orderedExercises(c: Catalog): Exercise[] {
  return [...c.modules]
    .sort((a, b) => a.position - b.position)
    .flatMap((m) => exercisesOf(c, m.id));
}

export function nextExercise(c: Catalog, id: string): Exercise | undefined {
  const list = orderedExercises(c).filter((e) => e.published);
  const i = list.findIndex((e) => e.id === id);
  return i >= 0 ? list[i + 1] : undefined;
}

// ---- Conversão das linhas do banco (snake_case) ----

export interface ModuleRow {
  id: string;
  title: string;
  focus: string;
  /** Coluna da migration 0009: pode não existir se o banco ainda não a recebeu. */
  intro?: string;
  optional?: boolean;
  world_id?: string | null;
  example?: string;
  review?: string;
  position: number;
}

export interface ExerciseRow {
  id: string;
  // Colunas das migrations 0005+: podem não existir se o banco ainda não as recebeu.
  kind?: ExerciseKind;
  lesson?: string | null;
  config?: ExerciseConfig | null;
  module_id: string;
  title: string;
  difficulty: Difficulty;
  statement: string;
  function_name: string | null;
  starter_code: string;
  tests: TestCase[];
  hint: string;
  position: number;
  published: boolean;
}

// "*" pelo mesmo motivo dos exercícios: tolera migration nova ainda não aplicada.
export const MODULE_COLUMNS = "*";
// "*" em vez de lista fixa: o site continua funcionando se uma migration nova ainda não foi aplicada.
export const EXERCISE_COLUMNS = "*";

export function moduleFromRow(r: ModuleRow): Module {
  return {
    id: r.id,
    title: r.title,
    focus: r.focus,
    intro: r.intro ?? "",
    optional: r.optional ?? false,
    worldId: r.world_id ?? null,
    example: r.example ?? "",
    review: r.review ?? "",
    position: r.position,
  };
}

export function exerciseFromRow(r: ExerciseRow): Exercise {
  return {
    id: r.id,
    kind: r.kind ?? "code",
    lesson: r.lesson ?? null,
    config: r.config ?? {},
    moduleId: r.module_id,
    title: r.title,
    difficulty: r.difficulty,
    statement: r.statement,
    functionName: r.function_name ?? "",
    starterCode: r.starter_code,
    tests: r.tests ?? [],
    hint: r.hint,
    position: r.position,
    published: r.published,
  };
}
