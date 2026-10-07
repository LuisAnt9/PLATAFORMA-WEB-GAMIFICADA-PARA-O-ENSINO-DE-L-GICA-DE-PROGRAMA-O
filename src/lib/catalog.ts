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
  position: number;
  /** Rascunhos (false) só são visíveis para professores. */
  published: boolean;
}

export interface Module {
  id: string;
  title: string;
  /** Dificuldade de aprendizagem (referencial teórico) que o módulo trabalha. */
  focus: string;
  position: number;
}

export interface Catalog {
  modules: Module[];
  exercises: Exercise[];
}

export const EMPTY_CATALOG: Catalog = { modules: [], exercises: [] };

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
  position: number;
}

export interface ExerciseRow {
  id: string;
  module_id: string;
  title: string;
  difficulty: Difficulty;
  statement: string;
  function_name: string;
  starter_code: string;
  tests: TestCase[];
  hint: string;
  position: number;
  published: boolean;
}

export const MODULE_COLUMNS = "id, title, focus, position";
export const EXERCISE_COLUMNS =
  "id, module_id, title, difficulty, statement, function_name, starter_code, tests, hint, position, published";

export function moduleFromRow(r: ModuleRow): Module {
  return { id: r.id, title: r.title, focus: r.focus, position: r.position };
}

export function exerciseFromRow(r: ExerciseRow): Exercise {
  return {
    id: r.id,
    moduleId: r.module_id,
    title: r.title,
    difficulty: r.difficulty,
    statement: r.statement,
    functionName: r.function_name,
    starterCode: r.starter_code,
    tests: r.tests,
    hint: r.hint,
    position: r.position,
    published: r.published,
  };
}
