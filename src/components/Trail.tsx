"use client";

import { usePageTitle } from "@/lib/use-page-title";
import Link from "next/link";
import {
  DIFFICULTY_LABEL,
  KIND_LABEL,
  XP_BY_DIFFICULTY,
  exercisesOf,
  orderedExercises,
  type Difficulty,
} from "@/lib/catalog";
import {
  badgesFor,
  earnedBadges,
  levelInfo,
  totalXp,
} from "@/lib/gamification";
import { useProgress } from "@/lib/progress-store";
import { useAuth } from "./AuthProvider";
import { CatalogGate, useCatalog } from "./CatalogProvider";
import { useBadgeContext } from "./useBadgeContext";

const DIFFICULTY_STYLE: Record<Difficulty, string> = {
  facil:
    "bg-emerald-100 text-emerald-900 dark:bg-emerald-950 dark:text-emerald-200",
  medio: "bg-amber-100 text-amber-900 dark:bg-amber-950 dark:text-amber-200",
  dificil: "bg-rose-100 text-rose-900 dark:bg-rose-950 dark:text-rose-200",
};

const card =
  "rounded-2xl border border-zinc-200 bg-white shadow-sm dark:border-zinc-800 dark:bg-zinc-900";

function ProgressBar({ value, label }: { value: number; label: string }) {
  return (
    <div
      role="progressbar"
      aria-label={label}
      aria-valuemin={0}
      aria-valuemax={100}
      aria-valuenow={Math.round(value * 100)}
      className="h-2 w-full overflow-hidden rounded-full bg-zinc-200 dark:bg-zinc-800"
    >
      <div
        className="h-full rounded-full bg-emerald-600 transition-[width]"
        style={{ width: `${Math.round(value * 100)}%` }}
      />
    </div>
  );
}

function StatusIcon({ solved, index }: { solved: boolean; index: number }) {
  return solved ? (
    <span
      role="img"
      aria-label="Resolvido"
      className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-emerald-600 text-white"
    >
      <svg viewBox="0 0 20 20" className="h-4 w-4" fill="none" aria-hidden>
        <path
          d="M4 10.5l4 4 8-9"
          stroke="currentColor"
          strokeWidth="2.5"
          strokeLinecap="round"
          strokeLinejoin="round"
        />
      </svg>
    </span>
  ) : (
    <span
      role="img"
      aria-label="Pendente"
      className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full border-2 border-zinc-300 text-sm font-medium text-zinc-600 dark:border-zinc-600 dark:text-zinc-300"
    >
      {index}
    </span>
  );
}

function TrailContent() {
  usePageTitle("Trilha");
  const progress = useProgress();
  const { catalog } = useCatalog();
  const badgeCtx = useBadgeContext();
  const { profile } = useAuth();
  const earned = new Set(earnedBadges(badgeCtx).map((b) => b.id));
  const modules = [...catalog.modules].sort((a, b) => a.position - b.position);

  const published = orderedExercises(catalog).filter((e) => e.published);
  const solvedCount = published.filter((e) => progress[e.id]?.solved).length;
  const upNext = published.find((e) => !progress[e.id]?.solved);
  const xp = totalXp(progress);
  const { level, next, floor, progress: levelPct } = levelInfo(xp);
  const firstName = profile?.name.split(" ")[0];
  const total = published.length || 1;

  return (
    <div className="space-y-8">
      <section className={`${card} p-6`}>
        <div className="flex flex-wrap items-start justify-between gap-6">
          <div className="min-w-0 flex-1 basis-64">
            <p className="text-sm font-medium text-emerald-700 dark:text-emerald-400">
              Trilha de lógica de programação
            </p>
            <h1 className="mt-1 text-2xl font-semibold tracking-tight">
              {solvedCount === 0
                ? `Bem-vindo${firstName ? `, ${firstName}` : ""}!`
                : `Olá${firstName ? `, ${firstName}` : ""}!`}
            </h1>
            <p className="mt-1 text-zinc-600 dark:text-zinc-400">
              {upNext
                ? solvedCount === 0
                  ? "Resolva desafios em JavaScript, ganhe XP e conquiste medalhas."
                  : "Continue de onde você parou."
                : published.length > 0
                  ? "Você concluiu toda a trilha. Parabéns!"
                  : "Ainda não há exercícios publicados."}
            </p>
            {upNext && (
              <Link
                href={`/exercicio/${upNext.id}`}
                className="mt-4 inline-flex items-center gap-2 rounded-xl bg-emerald-700 px-5 py-2.5 font-medium text-white shadow-sm hover:bg-emerald-800"
              >
                {solvedCount === 0 ? "Começar" : "Continuar"}: {upNext.title}
                <span aria-hidden>→</span>
              </Link>
            )}
          </div>

          <div className="grid min-w-56 flex-1 basis-56 gap-4">
            <div>
              <div className="flex items-baseline justify-between">
                <span className="text-sm text-zinc-600 dark:text-zinc-400">
                  Nível {level}
                </span>
                <span className="text-sm font-medium">
                  {xp - floor}/{next - floor} XP
                </span>
              </div>
              <div className="mt-1.5">
                <ProgressBar value={levelPct} label="Progresso do nível" />
              </div>
            </div>
            <div>
              <div className="flex items-baseline justify-between">
                <span className="text-sm text-zinc-600 dark:text-zinc-400">
                  Exercícios resolvidos
                </span>
                <span className="text-sm font-medium">
                  {solvedCount}/{published.length}
                </span>
              </div>
              <div className="mt-1.5">
                <ProgressBar
                  value={solvedCount / total}
                  label="Progresso da trilha"
                />
              </div>
            </div>
          </div>
        </div>
      </section>

      {modules.map((m, mi) => {
        const list = exercisesOf(catalog, m.id);
        const visible = list.filter((e) => e.published);
        const done = visible.filter((e) => progress[e.id]?.solved).length;
        if (list.length === 0) return null;
        return (
          <section key={m.id} aria-labelledby={`mod-${m.id}`} className={card}>
            <div className="flex items-start gap-4 p-5">
              <span
                aria-hidden
                className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-emerald-100 font-semibold text-emerald-900 dark:bg-emerald-950 dark:text-emerald-200"
              >
                {mi + 1}
              </span>
              <div className="min-w-0 flex-1">
                <div className="flex flex-wrap items-baseline justify-between gap-x-4">
                  <h2 id={`mod-${m.id}`} className="text-lg font-semibold">
                    {m.title}
                  </h2>
                  <span className="text-sm text-zinc-600 dark:text-zinc-400">
                    {done}/{visible.length} concluídos
                  </span>
                </div>
                <p className="text-sm text-zinc-600 dark:text-zinc-400">
                  {m.focus}
                </p>
                <div className="mt-3">
                  <ProgressBar
                    value={visible.length ? done / visible.length : 0}
                    label={`Progresso em ${m.title}`}
                  />
                </div>
              </div>
            </div>
            <ul className="divide-y divide-zinc-100 border-t border-zinc-100 dark:divide-zinc-800 dark:border-zinc-800">
              {list.map((e, i) => {
                const p = progress[e.id];
                return (
                  <li key={e.id}>
                    <Link
                      href={`/exercicio/${e.id}`}
                      className="flex items-center gap-4 px-5 py-3 hover:bg-zinc-50 dark:hover:bg-zinc-800/60"
                    >
                      <StatusIcon solved={!!p?.solved} index={i + 1} />
                      <div className="min-w-0 flex-1">
                        <div className="font-medium">{e.title}</div>
                        <div className="mt-1 flex flex-wrap items-center gap-1.5 text-xs">
                          <span className="rounded-full bg-zinc-100 px-2 py-0.5 text-zinc-700 dark:bg-zinc-800 dark:text-zinc-300">
                            {KIND_LABEL[e.kind]}
                          </span>
                          <span
                            className={`rounded-full px-2 py-0.5 ${DIFFICULTY_STYLE[e.difficulty]}`}
                          >
                            {DIFFICULTY_LABEL[e.difficulty]}
                          </span>
                          {!e.published && profile?.role === "professor" && (
                            <span className="rounded-full bg-zinc-200 px-2 py-0.5 text-zinc-800 dark:bg-zinc-700 dark:text-zinc-100">
                              Rascunho
                            </span>
                          )}
                        </div>
                      </div>
                      <span className="shrink-0 text-sm text-zinc-600 dark:text-zinc-400">
                        {p?.solved ? p.xp : XP_BY_DIFFICULTY[e.difficulty]} XP
                      </span>
                      <span aria-hidden className="text-zinc-400">
                        ›
                      </span>
                    </Link>
                  </li>
                );
              })}
            </ul>
          </section>
        );
      })}

      <section aria-labelledby="medalhas">
        <div className="mb-3 flex items-baseline justify-between">
          <h2 id="medalhas" className="text-lg font-semibold">
            Medalhas
          </h2>
          <span className="text-sm text-zinc-600 dark:text-zinc-400">
            {earned.size}/{badgesFor(catalog).length} conquistadas
          </span>
        </div>
        <ul className="grid gap-3 sm:grid-cols-2">
          {badgesFor(catalog).map((b) => {
            const has = earned.has(b.id);
            return (
              <li
                key={b.id}
                className={`flex items-start gap-3 rounded-2xl border p-4 ${
                  has
                    ? "border-emerald-300 bg-emerald-50 dark:border-emerald-800 dark:bg-emerald-950"
                    : "border-zinc-200 bg-white dark:border-zinc-800 dark:bg-zinc-900"
                }`}
              >
                <span
                  aria-hidden
                  className={`flex h-10 w-10 shrink-0 items-center justify-center rounded-full text-lg ${
                    has
                      ? "bg-emerald-600"
                      : "bg-zinc-100 grayscale dark:bg-zinc-800"
                  }`}
                >
                  {has ? "🏅" : "🔒"}
                </span>
                <div className="min-w-0">
                  <div className="font-medium">
                    {b.name}
                    <span className="sr-only">
                      {has ? " (conquistada)" : " (bloqueada)"}
                    </span>
                  </div>
                  <div className="text-sm text-zinc-600 dark:text-zinc-400">
                    {b.description}
                  </div>
                </div>
              </li>
            );
          })}
        </ul>
      </section>
    </div>
  );
}

export default function Trail() {
  return (
    <CatalogGate>
      <TrailContent />
    </CatalogGate>
  );
}
