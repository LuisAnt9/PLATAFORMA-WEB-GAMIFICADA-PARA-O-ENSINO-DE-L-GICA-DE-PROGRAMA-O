"use client";

import Link from "next/link";
import { usePageTitle } from "@/lib/use-page-title";
import { CatalogGate } from "./CatalogProvider";
import ModeSwitch from "./ModeSwitch";
import { useStudent } from "./useStudent";
import { BackLink, Pill, ProgressBar, card } from "./ui";

function Content({ id }: { id: string }) {
  const s = useStudent();
  const w = s.worlds.find((x) => x.world.id === id);
  usePageTitle(w?.world.title ?? "Mundo");
  if (!w) {
    return (
      <div className="space-y-3">
        <p>Mundo não encontrado.</p>
        <BackLink href="/mundos">Voltar aos mundos</BackLink>
      </div>
    );
  }
  return (
    <div className="space-y-6">
      <BackLink href="/mundos">Todos os mundos</BackLink>
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">
          {w.world.title}
        </h1>
        <p className="mt-1 text-zinc-600 dark:text-zinc-400">
          {w.world.objective}
        </p>
      </header>
      <ModeSwitch />
      {w.lessons.length === 0 ? (
        <p className="text-zinc-600 dark:text-zinc-400">
          Este mundo ainda não tem lições publicadas.
        </p>
      ) : (
        <ol className="space-y-3">
          {w.lessons.map((m, i) => {
            const st = s.states[m.id];
            const locked = s.isLocked(m.id);
            const done = st?.done ?? 0;
            const total = st?.total ?? 0;
            return (
              <li key={m.id}>
                <Link
                  href={`/licao/${m.id}`}
                  className={`${card} flex items-start gap-4 p-4 hover:border-emerald-400 dark:hover:border-emerald-700 ${locked ? "border-dashed" : ""}`}
                >
                  <span
                    aria-hidden
                    className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full border-2 border-zinc-300 text-sm font-medium text-zinc-700 dark:border-zinc-600 dark:text-zinc-300"
                  >
                    {st?.complete && !locked ? "✓" : i + 1}
                  </span>
                  <div className="min-w-0 flex-1">
                    <div className="flex flex-wrap items-baseline justify-between gap-x-3">
                      <h2 className="font-semibold">
                        {m.title}
                        {m.optional && (
                          <span className="ml-2 align-middle">
                            <Pill>Complementar</Pill>
                          </span>
                        )}
                      </h2>
                      <span className="text-sm text-zinc-600 dark:text-zinc-400">
                        {locked && (
                          <span role="img" aria-label="Bloqueada">
                            🔒{" "}
                          </span>
                        )}
                        {done}/{total} concluídos
                      </span>
                    </div>
                    <p className="text-sm text-zinc-600 dark:text-zinc-400">
                      {m.focus}
                    </p>
                    <div className="mt-2">
                      <ProgressBar
                        value={total ? done / total : 0}
                        label={`Progresso em ${m.title}`}
                      />
                    </div>
                  </div>
                </Link>
              </li>
            );
          })}
        </ol>
      )}
    </div>
  );
}

export default function WorldDetail({ id }: { id: string }) {
  return (
    <CatalogGate>
      <Content id={id} />
    </CatalogGate>
  );
}
