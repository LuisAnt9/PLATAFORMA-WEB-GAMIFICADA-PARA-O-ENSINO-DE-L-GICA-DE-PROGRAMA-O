import type { Difficulty, Exercise, TestCase } from "./catalog";

/** Um teste como o professor o digita: texto JSON para as entradas e para o resultado esperado. */
export interface DraftTest {
  args: string;
  expected: string;
}

export interface Draft {
  title: string;
  moduleId: string;
  difficulty: Difficulty;
  statement: string;
  functionName: string;
  /** Parâmetros separados por vírgula, ex.: "a, b". */
  params: string;
  hint: string;
  tests: DraftTest[];
}

export const MAX_TESTS = 30;
const IDENT = /^[A-Za-z_$][A-Za-z0-9_$]*$/;
const RESERVED = new Set(
  "break case catch class const continue debugger default delete do else enum export extends false finally for function if import in instanceof let new null return super switch this throw true try typeof var void while with yield await async static undefined NaN Infinity eval arguments".split(
    " ",
  ),
);

export const ARGS_HELP =
  'Use JSON: números como 2, textos entre aspas como "abc", vetores como [1, 2], separados por vírgula.';

export function emptyDraft(moduleId = ""): Draft {
  return {
    title: "",
    moduleId,
    difficulty: "facil",
    statement: "",
    functionName: "",
    params: "",
    hint: "",
    tests: [{ args: "", expected: "" }],
  };
}

export const formatArgs = (args: unknown[]) =>
  args.map((a) => JSON.stringify(a)).join(", ");
export const formatExpected = (v: unknown) => JSON.stringify(v);

export function draftFromExercise(e: Exercise): Draft {
  const m = /function\s+[A-Za-z_$][A-Za-z0-9_$]*\s*\(([^)]*)\)/.exec(
    e.starterCode,
  );
  return {
    title: e.title,
    moduleId: e.moduleId,
    difficulty: e.difficulty,
    statement: e.statement,
    functionName: e.functionName,
    params: (m?.[1] ?? "").trim(),
    hint: e.hint,
    tests: e.tests.map((t) => ({
      args: formatArgs(t.args),
      expected: formatExpected(t.expected),
    })),
  };
}

export function buildStarterCode(functionName: string, params: string): string {
  const list = params
    .split(",")
    .map((p) => p.trim())
    .filter(Boolean)
    .join(", ");
  return `function ${functionName}(${list}) {\n  // seu código aqui\n}\n`;
}

type Parsed<T> = { ok: true; value: T } | { ok: false; error: string };

export function parseArgs(text: string): Parsed<unknown[]> {
  try {
    const value = JSON.parse(`[${text}]`);
    return { ok: true, value };
  } catch {
    return { ok: false, error: ARGS_HELP };
  }
}

export function parseExpected(text: string): Parsed<unknown> {
  if (text.trim() === "")
    return { ok: false, error: "Informe o resultado esperado." };
  try {
    return { ok: true, value: JSON.parse(text) };
  } catch {
    return {
      ok: false,
      error: 'Resultado esperado inválido. Use JSON: 5, "texto", true, [1, 2].',
    };
  }
}

export interface DraftValidation {
  errors: string[];
  /** Mensagem por linha de teste (null = ok). */
  testErrors: (string | null)[];
  /** Testes já convertidos; só confiável quando `errors` está vazio. */
  tests: TestCase[];
}

export function validateDraft(d: Draft): DraftValidation {
  const errors: string[] = [];
  const title = d.title.trim();
  if (title.length < 1 || title.length > 100)
    errors.push("O título deve ter entre 1 e 100 caracteres.");
  if (!d.moduleId) errors.push("Escolha um módulo.");
  const statement = d.statement.trim();
  if (statement.length < 1) errors.push("Escreva o enunciado.");
  if (statement.length > 2000)
    errors.push("O enunciado passa de 2000 caracteres.");
  if (d.hint.length > 500) errors.push("A dica passa de 500 caracteres.");

  const fn = d.functionName.trim();
  if (!IDENT.test(fn) || fn.length > 40)
    errors.push(
      "Nome da função inválido: use letras, números e _ (sem espaços ou acentos), até 40 caracteres.",
    );
  else if (RESERVED.has(fn))
    errors.push(
      `"${fn}" é uma palavra reservada do JavaScript; escolha outro nome.`,
    );

  const params = d.params
    .split(",")
    .map((p) => p.trim())
    .filter(Boolean);
  if (params.length > 10) errors.push("No máximo 10 parâmetros.");
  for (const p of params) {
    if (!IDENT.test(p) || RESERVED.has(p))
      errors.push(`Parâmetro inválido: "${p}".`);
  }
  if (new Set(params).size !== params.length)
    errors.push("Há parâmetros repetidos.");

  if (d.tests.length < 1) errors.push("Inclua pelo menos um caso de teste.");
  if (d.tests.length > MAX_TESTS)
    errors.push(`No máximo ${MAX_TESTS} casos de teste.`);

  const tests: TestCase[] = [];
  const testErrors = d.tests.map((t, i) => {
    const a = parseArgs(t.args);
    if (!a.ok) return a.error;
    const e = parseExpected(t.expected);
    if (!e.ok) return e.error;
    if (params.length > 0 && a.value.length > params.length)
      return `Mais entradas (${a.value.length}) do que parâmetros (${params.length}).`;
    tests[i] = { args: a.value, expected: e.value };
    return null;
  });
  if (testErrors.some(Boolean))
    errors.push("Corrija os casos de teste destacados.");

  return { errors, testErrors, tests };
}

/** Remove acentos e deixa só [a-z0-9-]. */
export function slugify(text: string): string {
  return text
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 50);
}

/** id único baseado no título, ex.: "soma-dos-pares", ou "soma-dos-pares-k3f" se já existir. */
export function newExerciseId(
  title: string,
  taken: Set<string>,
  rand: () => number = Math.random,
  maxLength = 56,
): string {
  // deixa espaço para o sufixo "-xyz" (4 caracteres)
  const base =
    slugify(title)
      .slice(0, maxLength - 4)
      .replace(/-+$/, "") || "exercicio";
  if (!taken.has(base)) return base;
  const alphabet = "abcdefghjkmnpqrstuvwxyz23456789";
  for (let i = 0; i < 50; i++) {
    let suffix = "";
    for (let j = 0; j < 3; j++)
      suffix += alphabet[Math.floor(rand() * alphabet.length)];
    const id = `${base}-${suffix}`;
    if (!taken.has(id)) return id;
  }
  throw new Error("Não foi possível gerar um identificador único.");
}
