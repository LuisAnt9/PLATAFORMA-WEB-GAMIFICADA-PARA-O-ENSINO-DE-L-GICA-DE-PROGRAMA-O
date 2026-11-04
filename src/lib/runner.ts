import type { Exercise } from "./catalog";

export interface TestResult {
  args: unknown[];
  expected: unknown;
  received?: unknown;
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

// Código do worker: roda isolado da página e pode ser encerrado em caso de laço infinito.
const WORKER_SOURCE = `
self.onmessage = (e) => {
  const { code, functionName, tests } = e.data;
  let fn;
  try {
    fn = new Function(code + "\\n;return typeof " + functionName + " === 'function' ? " + functionName + " : undefined;")();
  } catch (err) {
    self.postMessage({ fatal: "Erro no código: " + err.message, category: err instanceof SyntaxError ? "sintaxe" : "execucao" });
    return;
  }
  if (!fn) {
    self.postMessage({ fatal: "A função " + functionName + " não foi encontrada. Mantenha o nome da função.", category: "execucao" });
    return;
  }
  const out = tests.map((t) => {
    try {
      const received = fn(...structuredClone(t.args));
      return { received: received === undefined ? "undefined" : received, undef: received === undefined };
    } catch (err) {
      return { error: String(err && err.message || err) };
    }
  });
  self.postMessage({ out });
};
`;

function deepEqual(a: unknown, b: unknown): boolean {
  return JSON.stringify(a) === JSON.stringify(b);
}

export function runExercise(
  exercise: Pick<Exercise, "functionName" | "tests">,
  code: string,
): Promise<RunResult> {
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
        if (o.error) return { ...t, passed: false, error: o.error };
        const received = o.undef ? undefined : o.received;
        return { ...t, received, passed: deepEqual(received, t.expected) };
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
      tests: exercise.tests.map((t) => ({ args: t.args })),
    });
  });
}
