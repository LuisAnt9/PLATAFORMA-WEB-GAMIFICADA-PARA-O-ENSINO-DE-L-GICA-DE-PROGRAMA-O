"use client";

import { usePageTitle } from "@/lib/use-page-title";
import Link from "next/link";
import { useState } from "react";
import { useAuth } from "@/components/AuthProvider";
import MyClasses from "@/components/MyClasses";
import { CatalogGate, useCatalog } from "@/components/CatalogProvider";
import RankingOptIn from "@/components/RankingOptIn";
import { useTotalXp } from "@/components/useBadgeContext";
import { useStreak } from "@/lib/activity-store";
import { localDay, recentDays } from "@/lib/streak";
import { levelInfo, statsOf } from "@/lib/gamification";
import { useProgress } from "@/lib/progress-store";

function PerfilContent() {
  usePageTitle("Perfil");
  const { profile, updateName } = useAuth();
  const { catalog } = useCatalog();
  const streak = useStreak();
  const [today] = useState(() => localDay());
  const progress = useProgress();
  const totalXp = useTotalXp();
  const [name, setName] = useState(profile?.name ?? "");
  const [msg, setMsg] = useState<{ ok: boolean; text: string } | null>(null);
  const [busy, setBusy] = useState(false);

  if (!profile) return null;
  const stats = statsOf(progress, catalog);
  const { level, floor, next, progress: pct } = levelInfo(totalXp);

  async function save(e: React.FormEvent) {
    e.preventDefault();
    setBusy(true);
    const err = await updateName(name.trim());
    setMsg(
      err ? { ok: false, text: err } : { ok: true, text: "Nome atualizado." },
    );
    setBusy(false);
  }

  const card =
    "rounded-2xl border border-zinc-200 bg-white p-4 shadow-sm dark:border-zinc-800 dark:bg-zinc-900";

  return (
    <div className="space-y-8">
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">
          {profile.name}
        </h1>
        <p className="text-sm text-zinc-500 dark:text-zinc-400">
          {profile.role === "professor" ? "Professor" : "Aluno"}
        </p>
      </header>

      <section aria-label="Resumo" className="grid gap-3 sm:grid-cols-4">
        <div className={card}>
          <div className="text-2xl font-semibold">Nível {level}</div>
          <div className="mt-2 h-2 rounded bg-zinc-200 dark:bg-zinc-800">
            <div
              className="h-2 rounded bg-emerald-500"
              style={{ width: `${Math.round(pct * 100)}%` }}
            />
          </div>
          <div className="mt-1 text-xs text-zinc-500 dark:text-zinc-400">
            {totalXp - floor}/{next - floor} XP para o próximo
          </div>
        </div>
        <div className={card}>
          <div className="text-2xl font-semibold">{totalXp}</div>
          <div className="text-xs text-zinc-500 dark:text-zinc-400">
            XP total
          </div>
        </div>
        <div className={card}>
          <div className="text-2xl font-semibold">
            {stats.solved}/{stats.total}
          </div>
          <div className="text-xs text-zinc-500 dark:text-zinc-400">
            exercícios resolvidos
          </div>
        </div>
        <div className={card}>
          <div className="text-2xl font-semibold">
            {Math.round(stats.firstTryRate * 100)}%
          </div>
          <div className="text-xs text-zinc-500 dark:text-zinc-400">
            acertos de primeira · {stats.attempts} tentativas
          </div>
        </div>
      </section>

      {streak.available && (
        <section aria-label="Sequência diária">
          <h2 className="mb-3 text-lg font-semibold">Sequência diária</h2>
          <div className="flex flex-wrap items-baseline gap-x-8 gap-y-2">
            <div>
              <span className="text-3xl font-semibold">
                🔥 {streak.current}
              </span>{" "}
              <span className="text-sm text-zinc-500 dark:text-zinc-400">
                {streak.current === 1 ? "dia seguido" : "dias seguidos"}
              </span>
            </div>
            <div className="text-sm text-zinc-500 dark:text-zinc-400">
              Melhor sequência:{" "}
              <strong className="text-foreground">{streak.best}</strong>
            </div>
          </div>
          <p className="mt-2 text-sm text-zinc-500 dark:text-zinc-400">
            {streak.activeToday
              ? "Você já praticou hoje. Volte amanhã para continuar a sequência."
              : streak.current > 0
                ? "Pratique hoje para não perder a sua sequência."
                : "Resolva um exercício hoje para começar uma sequência."}
          </p>
          <ul aria-label="Últimos 14 dias" className="mt-3 flex gap-1">
            {recentDays(streak.days, today, 14).map((d) => (
              <li
                key={d.day}
                title={`${d.day.slice(8, 10)}/${d.day.slice(5, 7)}: ${d.active ? "praticou" : "não praticou"}`}
                aria-label={`${d.day.slice(8, 10)}/${d.day.slice(5, 7)}: ${d.active ? "praticou" : "não praticou"}`}
                className={`h-5 w-5 rounded-full ${d.active ? "bg-emerald-600" : "bg-zinc-200 dark:bg-zinc-800"}`}
              />
            ))}
          </ul>
        </section>
      )}

      <p className="text-sm text-zinc-600 dark:text-zinc-400">
        Medalhas e nível estão em{" "}
        <Link
          href="/conquistas"
          className="text-emerald-700 hover:underline dark:text-emerald-400"
        >
          Conquistas
        </Link>
        ; o histórico e o desempenho por conceito, em{" "}
        <Link
          href="/progresso"
          className="text-emerald-700 hover:underline dark:text-emerald-400"
        >
          Meu progresso
        </Link>
        .
      </p>

      {profile.role === "aluno" && <MyClasses />}

      {profile.role === "aluno" && (
        <section aria-labelledby="privacidade">
          <h2 id="privacidade" className="mb-3 text-lg font-semibold">
            Privacidade
          </h2>
          <RankingOptIn />
        </section>
      )}

      <section>
        <h2 className="mb-3 text-lg font-semibold">Conta</h2>
        <form
          onSubmit={save}
          className="flex max-w-md flex-wrap items-end gap-3"
        >
          <label className="flex-1 text-sm">
            Nome
            <input
              value={name}
              onChange={(e) => setName(e.target.value)}
              required
              minLength={2}
              maxLength={80}
              className="mt-1 w-full rounded-xl border border-zinc-300 bg-white px-3 py-2.5 dark:border-zinc-700 dark:bg-zinc-950"
            />
          </label>
          <button
            type="submit"
            disabled={busy || name.trim() === profile.name}
            className="rounded-xl bg-emerald-700 px-5 py-2.5 font-medium text-white hover:bg-emerald-800 disabled:opacity-50"
          >
            Salvar
          </button>
        </form>
        {msg && (
          <p
            role={msg.ok ? "status" : "alert"}
            className={`mt-2 text-sm ${msg.ok ? "text-emerald-700 dark:text-emerald-400" : "text-red-700 dark:text-red-300"}`}
          >
            {msg.text}
          </p>
        )}
      </section>
    </div>
  );
}

export default function PerfilPage() {
  return (
    <CatalogGate>
      <PerfilContent />
    </CatalogGate>
  );
}
