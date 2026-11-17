"use client";

import Link from "next/link";
import { useState } from "react";
import { useStreak } from "@/lib/activity-store";
import { statsOf } from "@/lib/gamification";
import {
  MIN_ATTEMPTS,
  MIN_EXERCISES,
  WORLD_STATUS_LABEL,
  conceptPerformance,
  weeklyActivity,
  type ConceptLevel,
} from "@/lib/student";
import { addDays, localDay } from "@/lib/streak";
import { usePageTitle } from "@/lib/use-page-title";
import { CatalogGate } from "./CatalogProvider";
import { useStudent } from "./useStudent";
import { useTotalXp } from "./useBadgeContext";
import { Pill, ProgressBar, card } from "./ui";

const LEVEL_LABEL: Record<ConceptLevel, string> = {
  insuficiente: "Dados insuficientes",
  praticar: "Vale praticar mais",
  "em-bom-caminho": "Em bom caminho",
};

function Content() {
  usePageTitle("Meu progresso");
  const s = useStudent();
  const streak = useStreak();
  const [today] = useState(() => localDay());
  const stats = statsOf(s.progress, s.catalog);
  const xpTotal = useTotalXp();
  const concepts = conceptPerformance(s.catalog, s.progress);
  const weeks = weeklyActivity(streak.days, today, 8, addDays);
  const max = Math.max(1, ...weeks.map((w) => w.count));
  const worldTitle = (id: string | null) =>
    s.worlds.find((w) => w.world.id === id)?.world.title ?? "";
  const history = s.catalog.exercises.filter((e) => s.progress[e.id]);

  return (
    <div className="space-y-10">
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">Meu progresso</h1>
        <p className="mt-1 text-zinc-600 dark:text-zinc-400">
          {stats.solved}/{stats.total} exercícios resolvidos · {xpTotal} XP ·{" "}
          {Math.round(stats.firstTryRate * 100)}% de primeira ·{" "}
          {stats.attempts} tentativas
        </p>
      </header>

      <section aria-labelledby="por-mundo">
        <h2 id="por-mundo" className="mb-3 text-lg font-semibold">
          Progresso por mundo
        </h2>
        <ul className="space-y-3">
          {s.worlds.map((w) => (
            <li key={w.world.id}>
              <div className="flex justify-between gap-2 text-sm">
                <Link
                  href={`/mundos/${w.world.id}`}
                  className="hover:underline"
                >
                  {w.world.title}
                </Link>
                <span className="text-zinc-600 dark:text-zinc-400">
                  {w.status === "em-breve"
                    ? WORLD_STATUS_LABEL[w.status]
                    : `${w.done}/${w.total}`}
                </span>
              </div>
              <div className="mt-1">
                <ProgressBar
                  value={w.total ? w.done / w.total : 0}
                  label={`Progresso em ${w.world.title}`}
                />
              </div>
            </li>
          ))}
        </ul>
      </section>

      <section aria-labelledby="por-conceito">
        <h2 id="por-conceito" className="mb-1 text-lg font-semibold">
          Seu desempenho por conceito
        </h2>
        <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
          Serve para você saber o que revisar, não para te classificar. Só
          dizemos algo sobre um conceito depois de {MIN_ATTEMPTS} tentativas em
          pelo menos {MIN_EXERCISES} exercícios.
        </p>
        {concepts.length === 0 ? (
          <p className="text-sm text-zinc-600 dark:text-zinc-400">
            Resolva alguns exercícios e os conceitos praticados aparecem aqui.
          </p>
        ) : (
          <ul className="grid gap-3 sm:grid-cols-2">
            {concepts.map((c) => (
              <li key={c.conceptId} className={`${card} p-4`}>
                <div className="flex items-start justify-between gap-2">
                  <div>
                    <div className="font-medium">{c.title}</div>
                    <div className="text-xs text-zinc-600 dark:text-zinc-400">
                      {worldTitle(c.worldId)}
                    </div>
                  </div>
                  <Pill
                    tone={
                      c.level === "em-bom-caminho"
                        ? "green"
                        : c.level === "praticar"
                          ? "amber"
                          : "neutral"
                    }
                  >
                    {LEVEL_LABEL[c.level]}
                  </Pill>
                </div>
                <p className="mt-2 text-sm text-zinc-600 dark:text-zinc-400">
                  {c.exercisesSolved} de {c.exercisesTried}{" "}
                  {c.exercisesTried === 1
                    ? "exercício resolvido"
                    : "exercícios resolvidos"}{" "}
                  · {c.attempts} {c.attempts === 1 ? "tentativa" : "tentativas"}
                </p>
              </li>
            ))}
          </ul>
        )}
      </section>

      {streak.available && (
        <section aria-labelledby="ao-longo">
          <h2 id="ao-longo" className="mb-1 text-lg font-semibold">
            Dias de prática por semana
          </h2>
          <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
            Últimas 8 semanas · melhor sequência: {streak.best}{" "}
            {streak.best === 1 ? "dia" : "dias"}
          </p>
          <ul className="flex h-28 items-end gap-2">
            {weeks.map((w) => (
              <li
                key={w.start}
                aria-label={`Semana de ${w.start.slice(8, 10)}/${w.start.slice(5, 7)}: ${w.count} ${w.count === 1 ? "dia" : "dias"}`}
                className="flex h-full flex-1 flex-col items-center justify-end gap-1 text-xs"
              >
                <span aria-hidden>{w.count}</span>
                <span
                  aria-hidden
                  className="w-full rounded-t bg-emerald-600"
                  style={{ height: `${Math.max(4, (w.count / max) * 72)}px` }}
                />
                <span aria-hidden className="text-zinc-600 dark:text-zinc-400">
                  {w.start.slice(8, 10)}/{w.start.slice(5, 7)}
                </span>
              </li>
            ))}
          </ul>
        </section>
      )}

      <section aria-labelledby="historico">
        <h2 id="historico" className="mb-3 text-lg font-semibold">
          Histórico de atividades
        </h2>
        {history.length === 0 ? (
          <p className="text-sm text-zinc-600 dark:text-zinc-400">
            Você ainda não tentou nenhum exercício.{" "}
            <Link
              href="/mundos"
              className="text-emerald-700 hover:underline dark:text-emerald-400"
            >
              Ir para os mundos
            </Link>
          </p>
        ) : (
          <ul className="divide-y divide-zinc-200 text-sm dark:divide-zinc-800">
            {history.map((e) => {
              const p = s.progress[e.id];
              return (
                <li
                  key={e.id}
                  className="flex items-center justify-between gap-3 py-2"
                >
                  <Link href={`/exercicio/${e.id}`} className="hover:underline">
                    {e.title}
                  </Link>
                  <span className="shrink-0 text-zinc-600 dark:text-zinc-400">
                    {p.solved ? `✅ ${p.xp} XP` : "em andamento"} · {p.attempts}{" "}
                    {p.attempts === 1 ? "tentativa" : "tentativas"}
                  </span>
                </li>
              );
            })}
          </ul>
        )}
      </section>
    </div>
  );
}

export default function MyProgress() {
  return (
    <CatalogGate>
      <Content />
    </CatalogGate>
  );
}
