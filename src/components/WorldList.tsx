"use client";

import Link from "next/link";
import { usePageTitle } from "@/lib/use-page-title";
import { WORLD_STATUS_LABEL, type WorldStatus } from "@/lib/student";
import { CatalogGate } from "./CatalogProvider";
import ModeSwitch from "./ModeSwitch";
import { useStudent } from "./useStudent";
import { Pill, ProgressBar, card } from "./ui";

export const STATUS_ICON: Record<WorldStatus, string> = {
  "em-breve": "⏳",
  bloqueado: "🔒",
  "nao-iniciado": "▶",
  "em-andamento": "📖",
  concluido: "✅",
};

function Content() {
  usePageTitle("Mundos");
  const { worlds } = useStudent();
  return (
    <div className="space-y-6">
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">Mundos</h1>
        <p className="mt-1 text-zinc-600 dark:text-zinc-400">
          Cada mundo reúne lições sobre um assunto da lógica de programação.
        </p>
      </header>
      <ModeSwitch />
      <ul className="grid gap-4 sm:grid-cols-2">
        {worlds.map((w, i) => {
          const soon = w.status === "em-breve";
          const body = (
            <>
              <div className="flex items-start gap-3">
                <span
                  aria-hidden
                  className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-emerald-100 font-semibold text-emerald-900 dark:bg-emerald-950 dark:text-emerald-200"
                >
                  {i + 1}
                </span>
                <div className="min-w-0 flex-1">
                  <h2 className="font-semibold">{w.world.title}</h2>
                  <p className="mt-0.5 text-sm text-zinc-600 dark:text-zinc-400">
                    {w.world.objective}
                  </p>
                </div>
              </div>
              <div className="mt-3 flex items-center justify-between gap-2 text-sm">
                <Pill tone={w.status === "concluido" ? "green" : "neutral"}>
                  <span aria-hidden>{STATUS_ICON[w.status]} </span>
                  {WORLD_STATUS_LABEL[w.status]}
                </Pill>
                {!soon && (
                  <span className="text-zinc-600 dark:text-zinc-400">
                    {w.lessons.length}{" "}
                    {w.lessons.length === 1 ? "lição" : "lições"} · {w.done}/
                    {w.total} exercícios
                  </span>
                )}
              </div>
              {!soon && (
                <div className="mt-2">
                  <ProgressBar
                    value={w.total ? w.done / w.total : 0}
                    label={`Progresso em ${w.world.title}`}
                  />
                </div>
              )}
            </>
          );
          return (
            <li key={w.world.id}>
              {soon ? (
                <div className={`${card} border-dashed p-5`}>{body}</div>
              ) : (
                <Link
                  href={`/mundos/${w.world.id}`}
                  className={`${card} block p-5 hover:border-emerald-400 dark:hover:border-emerald-700 ${w.status === "bloqueado" ? "border-dashed" : ""}`}
                >
                  {body}
                </Link>
              )}
            </li>
          );
        })}
      </ul>
    </div>
  );
}

export default function WorldList() {
  return (
    <CatalogGate>
      <Content />
    </CatalogGate>
  );
}
