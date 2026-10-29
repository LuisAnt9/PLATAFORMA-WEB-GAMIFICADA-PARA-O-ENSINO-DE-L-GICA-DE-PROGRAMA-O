"use client";

import ScrollRegion from "./ScrollRegion";
import type { Exercise } from "@/lib/catalog";
import type { Cell, MatrixRow } from "@/lib/class-analytics";

function cellLabel(c: Cell) {
  if (c.state === "solved")
    return `resolvido em ${c.attempts} ${c.attempts === 1 ? "tentativa" : "tentativas"}`;
  if (c.state === "trying")
    return `${c.attempts} ${c.attempts === 1 ? "tentativa" : "tentativas"}, ainda não resolvido`;
  return "não tentou";
}

// Uma só cor, mais escura = mais progresso (sequencial). O estado também está no texto, nunca só na cor.
const STYLE: Record<Cell["state"], string> = {
  none: "bg-zinc-100 text-zinc-400 dark:bg-zinc-900 dark:text-zinc-600",
  trying:
    "bg-emerald-200 text-emerald-950 dark:bg-emerald-900 dark:text-emerald-100",
  solved: "bg-emerald-700 text-white",
};

export default function ProgressMatrix({
  rows,
  exercises,
}: {
  rows: MatrixRow[];
  exercises: Exercise[];
}) {
  return (
    <div>
      <ScrollRegion
        label="Grade de progresso dos alunos"
        className="rounded-2xl border border-zinc-200 bg-white shadow-sm dark:bg-zinc-900 dark:border-zinc-800"
      >
        <table className="w-full border-separate border-spacing-0.5 text-xs">
          <caption className="sr-only">
            Progresso de cada aluno em cada exercício
          </caption>
          <thead>
            <tr>
              <th
                scope="col"
                className="sticky left-0 z-10 bg-background px-3 py-1 text-left font-normal text-zinc-600 dark:text-zinc-400"
              >
                Aluno
              </th>
              {exercises.map((e, i) => (
                <th
                  key={e.id}
                  scope="col"
                  title={e.title}
                  className="px-0 py-1 text-center font-normal tabular-nums text-zinc-600 dark:text-zinc-400"
                >
                  {i + 1}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {rows.map((r) => (
              <tr key={r.studentId}>
                <th
                  scope="row"
                  className="sticky left-0 z-10 whitespace-nowrap bg-background px-3 py-0.5 text-left text-sm font-normal"
                >
                  {r.name}
                </th>
                {r.cells.map((c, i) => (
                  <td key={i} className="p-0 text-center">
                    <span
                      title={`${exercises[i].title}: ${cellLabel(c)}`}
                      aria-label={`${exercises[i].title}: ${cellLabel(c)}`}
                      role="img"
                      className={`mx-auto flex h-7 w-7 items-center justify-center rounded ${STYLE[c.state]}`}
                    >
                      {c.state === "solved"
                        ? "✓"
                        : c.state === "trying"
                          ? c.attempts
                          : ""}
                    </span>
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </ScrollRegion>
      <p className="mt-2 text-xs text-zinc-600 dark:text-zinc-400">
        ✓ resolvido · número = tentativas ainda sem acertar · vazio = não
        tentou. Passe o mouse (ou foque) para ver o nome do exercício.
      </p>
      <ol className="mt-2 grid gap-x-6 gap-y-0.5 text-xs text-zinc-600 dark:text-zinc-400 sm:grid-cols-2">
        {exercises.map((e, i) => (
          <li key={e.id}>
            <span className="tabular-nums">{i + 1}.</span> {e.title}
          </li>
        ))}
      </ol>
    </div>
  );
}
