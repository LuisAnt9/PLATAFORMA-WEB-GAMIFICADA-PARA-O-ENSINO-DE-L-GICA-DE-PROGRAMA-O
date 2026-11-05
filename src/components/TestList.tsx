import type { TestResult } from "@/lib/runner";

const show = (v: unknown) =>
  v === undefined ? "undefined" : JSON.stringify(v);

/** Resultado de cada caso de teste: chamada, entradas simuladas, valor esperado/obtido e saída impressa. */
export default function TestList({
  tests,
  functionName,
}: {
  tests: TestResult[];
  functionName: string;
}) {
  return (
    <ul className="space-y-1 text-sm">
      {tests.map((t, i) => (
        <li
          key={i}
          className={`rounded p-2 font-mono ${t.passed ? "bg-emerald-50 dark:bg-emerald-950" : "bg-red-50 dark:bg-red-950"}`}
        >
          {t.passed ? "✓" : "✗"} {functionName}({t.args.map(show).join(", ")})
          {t.inputs && t.inputs.length > 0 && (
            <span className="block text-xs text-zinc-600 dark:text-zinc-400">
              entradas: {t.inputs.map(show).join(", ")}
            </span>
          )}
          {!t.passed && (
            <>
              {t.error ? (
                ` → erro: ${t.error}`
              ) : (
                <>
                  {"expected" in t &&
                    ` → esperado ${show(t.expected)}, recebido ${show(t.received)}`}
                </>
              )}
              {!t.error && t.expectedOutput && (
                <span className="block text-xs">
                  saída esperada: {show(t.expectedOutput)}
                  <br />
                  saída obtida: {show(t.receivedOutput ?? [])}
                </span>
              )}
            </>
          )}
        </li>
      ))}
    </ul>
  );
}
