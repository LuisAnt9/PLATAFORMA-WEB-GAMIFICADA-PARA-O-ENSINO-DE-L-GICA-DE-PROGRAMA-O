"use client";

import { useGamification } from "@/lib/gamification-store";
import { ProgressBar, card } from "./ui";

/** Missões do dia. O progresso e o XP são calculados pelo banco; aqui só se mostra o estado. */
export default function Missions() {
  const g = useGamification();
  if (!g.available || g.missions.length === 0) return null;
  return (
    <section aria-labelledby="missoes">
      <h2 id="missoes" className="mb-1 text-lg font-semibold">
        Missões de hoje
      </h2>
      <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
        Cada missão rende XP uma vez por dia. As missões renovam todo dia.
      </p>
      <ul className="grid gap-3 sm:grid-cols-2">
        {g.missions.map((m) => (
          <li
            key={m.id}
            className={`${card} p-4 ${m.claimed ? "border-emerald-300 dark:border-emerald-800" : ""}`}
          >
            <div className="flex items-start justify-between gap-2">
              <div className="font-medium">{m.title}</div>
              <span
                className={`shrink-0 rounded-full px-2 py-0.5 text-xs ${
                  m.claimed
                    ? "bg-emerald-100 text-emerald-900 dark:bg-emerald-950 dark:text-emerald-200"
                    : "bg-zinc-200 text-zinc-800 dark:bg-zinc-800 dark:text-zinc-200"
                }`}
              >
                {m.claimed ? "Cumprida" : `+${m.xp} XP`}
              </span>
            </div>
            <p className="mt-1 text-sm text-zinc-600 dark:text-zinc-400">
              {m.description}
            </p>
            <div className="mt-3">
              <ProgressBar
                value={m.target ? m.progress / m.target : 0}
                label={`Progresso na missão ${m.title}`}
              />
            </div>
            <p className="mt-1 text-xs text-zinc-600 dark:text-zinc-400">
              {m.progress}/{m.target}
              {m.claimed && ` · +${m.xp} XP recebidos`}
            </p>
          </li>
        ))}
      </ul>
    </section>
  );
}
