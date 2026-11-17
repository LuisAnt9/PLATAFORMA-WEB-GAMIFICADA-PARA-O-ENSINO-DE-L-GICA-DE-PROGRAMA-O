"use client";

import { usePageTitle } from "@/lib/use-page-title";
import { badgesFor, earnedBadges, levelInfo, totalXp } from "@/lib/gamification";
import { CatalogGate } from "./CatalogProvider";
import { useBadgeContext } from "./useBadgeContext";
import { useStudent } from "./useStudent";
import { ProgressBar, card } from "./ui";

function Content() {
  usePageTitle("Conquistas");
  const s = useStudent();
  const badgeCtx = useBadgeContext();
  const earned = new Set(earnedBadges(badgeCtx).map((b) => b.id));
  const xp = totalXp(s.progress);
  const { level, floor, next, progress: pct } = levelInfo(xp);
  const all = badgesFor(s.catalog);
  return (
    <div className="space-y-8">
      <h1 className="text-2xl font-semibold tracking-tight">Conquistas</h1>
      <section aria-label="Nível" className={`${card} p-5`}>
        <div className="flex items-baseline justify-between">
          <span className="text-xl font-semibold">Nível {level}</span>
          <span className="text-sm text-zinc-600 dark:text-zinc-400">
            {xp} XP no total
          </span>
        </div>
        <div className="mt-2">
          <ProgressBar value={pct} label="Progresso do nível" />
        </div>
        <p className="mt-1 text-xs text-zinc-600 dark:text-zinc-400">
          {xp - floor}/{next - floor} XP para o próximo nível
        </p>
      </section>
      <section aria-labelledby="medalhas">
        <div className="mb-3 flex items-baseline justify-between">
          <h2 id="medalhas" className="text-lg font-semibold">
            Medalhas
          </h2>
          <span className="text-sm text-zinc-600 dark:text-zinc-400">
            {earned.size}/{all.length} conquistadas
          </span>
        </div>
        <ul className="grid gap-3 sm:grid-cols-2">
          {all.map((b) => {
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
                    has ? "bg-emerald-600" : "bg-zinc-100 grayscale dark:bg-zinc-800"
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

export default function Achievements() {
  return (
    <CatalogGate>
      <Content />
    </CatalogGate>
  );
}
