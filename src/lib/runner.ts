import type { Exercise, TestCase } from "./catalog";

export interface TestResult {
  args: unknown[];
  /** Valor retornado esperado (ausente quando o teste só confere a saída impressa). */
  expected?: unknown;
  received?: unknown;
  /** Entradas simuladas entregues a `lerEntrada()`. */
  inputs?: unknown[];
  /** Linhas esperadas e obtidas de console.log. */
  expectedOutput?: string[];
  receivedOutput?: string[];
  passed: boolean;
  error?: string;
}

/** Por que uma tentativa de código não passou (usado na análise de erros). */
export type ErrorCategory =
  | "sintaxe"
  | "execucao"
  | "tempo"
  | "saida_incorreta";

export interface RunResult {
  passed: boolean;
  tests: TestResult[];
  /** Erro de sintaxe, timeout ou função ausente (impede rodar os testes). */
  fatal?: string;
  /** Preenchido quando não passou. */
  errorCategory?: ErrorCategory;
}

/**
 * Categoria de uma execução que rodou os testes: se algum teste devolveu um valor errado
 * (sem lançar erro), é saída incorreta; se todos os que falharam lançaram erro, é erro de execução.
 */
export function categorizeTests(
  tests: TestResult[],
): ErrorCategory | undefined {
  const failed = tests.filter((t) => !t.passed);
  if (failed.length === 0) return undefined;
  return failed.some((t) => !t.error) ? "saida_incorreta" : "execucao";
}

const TIMEOUT_MS = 2000;
export const MAX_OUTPUT_LINES = 200;
export const MAX_LINE_LENGTH = 2000;

/** Recursos que o código do aluno não pode usar (rede, módulos, importação dinâmica). */
const FORBIDDEN = /\bimport\s*\(|\bimportScripts\b/;

export function forbiddenFeature(code: string): string | null {
  return FORBIDDEN.test(code)
    ? "Este recurso (import) não é permitido nos exercícios."
    : null;
}

// Código do worker: roda isolado da página e pode ser encerrado em caso de laço infinito.
// Antes de rodar o código do aluno, ele: guarda o postMessage verdadeiro (para o aluno não
// conseguir "enviar" um resultado falso), bloqueia rede e APIs de armazenamento, troca o console por um
// que só captura as linhas impressas e oferece `lerEntrada()` com as entradas simuladas do teste.
const WORKER_SOURCE = `
const __post = self.postMessage.bind(self);
const __blocked = (name) => function () { throw new Error(name + " não é permitido neste exercício."); };
for (const name of ["fetch", "XMLHttpRequest", "WebSocket", "EventSource", "importScripts", "indexedDB", "caches", "Worker", "SharedWorker", "BroadcastChannel", "postMessage"]) {
  try { Object.defineProperty(self, name, { value: __blocked(name), configurable: false, writable: false }); } catch (e) {}
}
const __MAX_LINES = ${MAX_OUTPUT_LINES};
const __MAX_LEN = ${MAX_LINE_LENGTH};
let __lines = [];
let __inputs = [];
let __next = 0;
const __fmt = (v) => {
  if (typeof v === "string") return v;
  if (v === undefined) return "undefined";
  // números e booleanos como no console real: NaN, Infinity e -0 (o JSON os trocaria por "null")
  if (typeof v === "number") return Object.is(v, -0) ? "-0" : String(v);
  if (typeof v === "boolean" || typeof v === "bigint") return String(v);
  try { const j = JSON.stringify(v); return j === undefined ? String(v) : j; } catch (e) { return String(v); }
};
const __log = (...args) => {
  if (__lines.length < __MAX_LINES) __lines.push(args.map(__fmt).join(" ").slice(0, __MAX_LEN));
};
const __console = { log: __log, info: __log, warn: () => {}, error: () => {}, debug: () => {}, table: () => {}, trace: () => {} };
try { Object.defineProperty(self, "console", { value: __console, configurable: false, writable: false }); } catch (e) {}
try { Object.defineProperty(self, "lerEntrada", { value: () => (__next < __inputs.length ? __inputs[__next++] : undefined), configurable: false, writable: false }); } catch (e) {}

self.onmessage = (e) => {
  const { code, functionName, tests } = e.data;
  let fn;
  try {
    fn = new Function(code + "\\n;return typeof " + functionName + " === 'function' ? " + functionName + " : undefined;")();
  } catch (err) {
    __post({ fatal: "Erro no código: " + err.message, category: err instanceof SyntaxError ? "sintaxe" : "execucao" });
    return;
  }
  if (!fn) {
    __post({ fatal: "A função " + functionName + " não foi encontrada. Mantenha o nome da função.", category: "execucao" });
    return;
  }
  const out = tests.map((t) => {
    __lines = [];
    __inputs = structuredClone(t.inputs || []);
    __next = 0;
    try {
      const received = fn(...structuredClone(t.args));
      return { received: received === undefined ? "undefined" : received, undef: received === undefined, lines: __lines };
    } catch (err) {
      return { error: String(err && err.message || err), lines: __lines };
    }
  });
  __post({ out });
};
`;

function deepEqual(a: unknown, b: unknown): boolean {
  return JSON.stringify(a) === JSON.stringify(b);
}

/** Resultado bruto de um teste vindo do worker. */
export interface RawTestOutcome {
  received?: unknown;
  error?: string;
  lines?: string[];
}

/**
 * Decide se um teste passou: sem erro, com o valor retornado igual ao esperado (quando há `expected`)
 * e com as linhas impressas iguais às esperadas (quando há `output`).
 */
export function evaluateTest(test: TestCase, raw: RawTestOutcome): TestResult {
  const base: TestResult = {
    args: test.args,
    ...("expected" in test ? { expected: test.expected } : {}),
    ...(test.inputs ? { inputs: test.inputs } : {}),
    ...(test.output ? { expectedOutput: test.output } : {}),
    ...(test.output ? { receivedOutput: raw.lines ?? [] } : {}),
    passed: false,
  };
  if (raw.error !== undefined) return { ...base, error: raw.error };
  const returnOk =
    !("expected" in test) || deepEqual(raw.received, test.expected);
  const outputOk =
    test.output === undefined || deepEqual(raw.lines ?? [], test.output);
  return {
    ...base,
    ...("expected" in test ? { received: raw.received } : {}),
    passed: returnOk && outputOk,
  };
}

export function runExercise(
  exercise: Pick<Exercise, "functionName" | "tests">,
  code: string,
): Promise<RunResult> {
  const forbidden = forbiddenFeature(code);
  if (forbidden) {
    return Promise.resolve({
      passed: false,
      tests: [],
      fatal: forbidden,
      errorCategory: "execucao",
    });
  }
  return new Promise((resolve) => {
    const url = URL.createObjectURL(
      new Blob([WORKER_SOURCE], { type: "text/javascript" }),
    );
    const worker = new Worker(url);
    const cleanup = () => {
      worker.terminate();
      URL.revokeObjectURL(url);
    };

    const timer = setTimeout(() => {
      cleanup();
      resolve({
        passed: false,
        tests: [],
        fatal:
          "Tempo esgotado: seu código demorou demais. Verifique se há um laço infinito.",
        errorCategory: "tempo",
      });
    }, TIMEOUT_MS);

    worker.onmessage = (e) => {
      clearTimeout(timer);
      cleanup();
      if (e.data.fatal) {
        resolve({
          passed: false,
          tests: [],
          fatal: e.data.fatal,
          errorCategory: e.data.category === "sintaxe" ? "sintaxe" : "execucao",
        });
        return;
      }
      const tests: TestResult[] = exercise.tests.map((t, i) => {
        const o = e.data.out[i];
        return evaluateTest(t, {
          received: o.undef ? undefined : o.received,
          error: o.error,
          lines: o.lines,
        });
      });
      resolve({
        passed: tests.every((t) => t.passed),
        tests,
        errorCategory: categorizeTests(tests),
      });
    };
    worker.onerror = (e) => {
      clearTimeout(timer);
      cleanup();
      resolve({
        passed: false,
        tests: [],
        fatal: "Erro ao executar: " + e.message,
        errorCategory: "execucao",
      });
    };

    worker.postMessage({
      code,
      functionName: exercise.functionName,
      tests: exercise.tests.map((t) => ({ args: t.args, inputs: t.inputs })),
    });
  });
}
