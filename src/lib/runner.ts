import type { Exercise } from "./exercises";

export interface TestResult {
  args: unknown[];
  expected: unknown;
  received?: unknown;
  passed: boolean;
  error?: string;
}

export interface RunResult {
  passed: boolean;
  tests: TestResult[];
  /** Erro de sintaxe, timeout ou função ausente (impede rodar os testes). */
  fatal?: string;
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
    self.postMessage({ fatal: "Erro no código: " + err.message });
    return;
  }
  if (!fn) {
    self.postMessage({ fatal: "A função " + functionName + " não foi encontrada. Mantenha o nome da função." });
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
  exercise: Exercise,
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
      });
    }, TIMEOUT_MS);

    worker.onmessage = (e) => {
      clearTimeout(timer);
      cleanup();
      if (e.data.fatal) {
        resolve({ passed: false, tests: [], fatal: e.data.fatal });
        return;
      }
      const tests: TestResult[] = exercise.tests.map((t, i) => {
        const o = e.data.out[i];
        if (o.error) return { ...t, passed: false, error: o.error };
        const received = o.undef ? undefined : o.received;
        return { ...t, received, passed: deepEqual(received, t.expected) };
      });
      resolve({ passed: tests.every((t) => t.passed), tests });
    };
    worker.onerror = (e) => {
      clearTimeout(timer);
      cleanup();
      resolve({
        passed: false,
        tests: [],
        fatal: "Erro ao executar: " + e.message,
      });
    };

    worker.postMessage({
      code,
      functionName: exercise.functionName,
      tests: exercise.tests.map((t) => ({ args: t.args })),
    });
  });
}
