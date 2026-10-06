"use client";

import Link from "next/link";
import { exercisesOf, modules, type Difficulty } from "@/lib/exercises";
import { badges, earnedBadges } from "@/lib/gamification";
import { useProgress } from "@/lib/progress-store";

const LABEL: Record<Difficulty, string> = { facil: "Fácil", medio: "Médio", dificil: "Difícil" };

export default function Trail() {
  const progress = useProgress();
  const earned = new Set(earnedBadges(progress).map((b) => b.id));

  return (
    <div className="space-y-10">
      {modules.map((m) => {
        const list = exercisesOf(m.id);
        const done = list.filter((e) => progress[e.id]?.solved).length;
        return (
          <section key={m.id}>
            <div className="mb-3 flex items-baseline justify-between">
              <div>
                <h2 className="text-lg font-semibold">{m.title}</h2>
                <p className="text-sm text-zinc-500">{m.focus}</p>
              </div>
              <span className="text-sm text-zinc-500">
                {done}/{list.length}
              </span>
            </div>
            <ul className="grid gap-2 sm:grid-cols-2">
              {list.map((e) => {
                const p = progress[e.id];
                return (
                  <li key={e.id}>
                    <Link
                      href={`/exercicio/${e.id}`}
                      className="flex items-center justify-between rounded-lg border border-zinc-200 p-3 hover:border-emerald-500 dark:border-zinc-800"
                    >
                      <div>
                        <div className="font-medium">{e.title}</div>
                        <div className="text-xs text-zinc-500">{LABEL[e.difficulty]}</div>
                      </div>
                      <span className="text-lg" aria-label={p?.solved ? "Resolvido" : "Pendente"}>
                        {p?.solved ? "✅" : "▫️"}
                      </span>
                    </Link>
                  </li>
                );
              })}
            </ul>
          </section>
        );
      })}

      <section>
        <h2 className="mb-3 text-lg font-semibold">Medalhas</h2>
        <ul className="grid gap-2 sm:grid-cols-2">
          {badges.map((b) => (
            <li
              key={b.id}
              className={`rounded-lg border p-3 text-sm ${
                earned.has(b.id)
                  ? "border-emerald-500 bg-emerald-50 dark:bg-emerald-950"
                  : "border-zinc-200 opacity-60 dark:border-zinc-800"
              }`}
            >
              <div className="font-medium">
                {earned.has(b.id) ? "🏅" : "🔒"} {b.name}
              </div>
              <div className="text-zinc-500">{b.description}</div>
            </li>
          ))}
        </ul>
      </section>
    </div>
  );
}
