"use client";

import Link from "next/link";
import { DIFFICULTY_LABEL, exercisesOf } from "@/lib/catalog";
import { badgesFor, earnedBadges } from "@/lib/gamification";
import { useProgress } from "@/lib/progress-store";
import { useAuth } from "./AuthProvider";
import { CatalogGate, useCatalog } from "./CatalogProvider";

function TrailContent() {
  const progress = useProgress();
  const { catalog } = useCatalog();
  const { profile } = useAuth();
  const earned = new Set(earnedBadges(progress, catalog).map((b) => b.id));
  const modules = [...catalog.modules].sort((a, b) => a.position - b.position);

  return (
    <div className="space-y-10">
      {modules.map((m) => {
        const list = exercisesOf(catalog, m.id);
        const visible = list.filter((e) => e.published);
        const done = visible.filter((e) => progress[e.id]?.solved).length;
        if (list.length === 0) return null;
        return (
          <section key={m.id}>
            <div className="mb-3 flex items-baseline justify-between">
              <div>
                <h2 className="text-lg font-semibold">{m.title}</h2>
                <p className="text-sm text-zinc-500">{m.focus}</p>
              </div>
              <span className="text-sm text-zinc-500">
                {done}/{visible.length}
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
                        <div className="text-xs text-zinc-500">
                          {DIFFICULTY_LABEL[e.difficulty]}
                          {!e.published &&
                            profile?.role === "professor" &&
                            " · rascunho"}
                        </div>
                      </div>
                      {p?.solved ? (
                        <span aria-label="Resolvido">✅</span>
                      ) : (
                        <span
                          aria-label="Pendente"
                          className="inline-block h-4 w-4 rounded-full border-2 border-zinc-300 dark:border-zinc-600"
                        />
                      )}
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
          {badgesFor(catalog).map((b) => (
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

export default function Trail() {
  return (
    <CatalogGate>
      <TrailContent />
    </CatalogGate>
  );
}
