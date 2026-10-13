"use client";

import { splitTemplate, type BlankResult, type BlankView } from "@/lib/grading";

export default function BlankBody({
  view,
  answers,
  result,
  onChange,
  onSubmit,
  disabled,
}: {
  view: BlankView;
  answers: string[];
  /** null = ainda não verificou as respostas atuais. */
  result: BlankResult | null;
  onChange: (index: number, value: string) => void;
  onSubmit: () => void;
  disabled: boolean;
}) {
  const parts = splitTemplate(view.template);
  return (
    <form
      onSubmit={(e) => {
        e.preventDefault();
        onSubmit();
      }}
      className="space-y-3"
    >
      <pre className="overflow-x-auto whitespace-pre-wrap rounded-lg border border-zinc-300 bg-zinc-50 p-4 font-mono text-sm leading-8 dark:border-zinc-700 dark:bg-zinc-900">
        {parts.map((p, i) => {
          if (p.type === "text") return <span key={i}>{p.text}</span>;
          const ok = result?.correct[p.index];
          const longest = Math.max(
            ...(view.blanks[p.index]?.answers ?? [""]).map((a) => a.length),
            3,
          );
          return (
            <input
              key={i}
              value={answers[p.index] ?? ""}
              onChange={(e) => onChange(p.index, e.target.value)}
              aria-label={`Lacuna ${p.index + 1}`}
              aria-invalid={ok === false ? true : undefined}
              spellCheck={false}
              autoCapitalize="off"
              autoCorrect="off"
              autoComplete="off"
              size={longest + 2}
              className={`mx-0.5 rounded border-b-2 px-1 font-mono text-sm outline-offset-2 ${
                ok === true
                  ? "border-emerald-600 bg-emerald-100 dark:bg-emerald-900"
                  : ok === false
                    ? "border-red-500 bg-red-100 dark:bg-red-900"
                    : "border-zinc-400 bg-white dark:bg-zinc-800"
              }`}
            />
          );
        })}
      </pre>
      {result && !result.passed && (
        <p role="status" className="text-sm text-zinc-500">
          {result.correct.filter(Boolean).length} de {result.correct.length}{" "}
          lacunas corretas. Confira as marcadas em vermelho.
        </p>
      )}
      <button
        type="submit"
        disabled={disabled}
        className="rounded-lg bg-emerald-600 px-4 py-2 font-medium text-white hover:bg-emerald-700 disabled:opacity-50"
      >
        Verificar respostas
      </button>
    </form>
  );
}
