"use client";

import Link from "next/link";
import { useState } from "react";
import { useAuth } from "@/components/AuthProvider";
import { exercises, exercisesOf, modules } from "@/lib/exercises";
import { badges, earnedBadges, levelInfo, statsOf } from "@/lib/gamification";
import { useProgress } from "@/lib/progress-store";

export default function PerfilPage() {
  const { profile, updateName } = useAuth();
  const progress = useProgress();
  const [name, setName] = useState(profile?.name ?? "");
  const [msg, setMsg] = useState<{ ok: boolean; text: string } | null>(null);
  const [busy, setBusy] = useState(false);

  if (!profile) return null;
  const stats = statsOf(progress);
  const { level, floor, next, progress: pct } = levelInfo(stats.xp);
  const earned = new Set(earnedBadges(progress).map((b) => b.id));

  async function save(e: React.FormEvent) {
    e.preventDefault();
    setBusy(true);
    const err = await updateName(name.trim());
    setMsg(
      err ? { ok: false, text: err } : { ok: true, text: "Nome atualizado." },
    );
    setBusy(false);
  }

  const card = "rounded-lg border border-zinc-200 p-4 dark:border-zinc-800";

  return (
    <div className="space-y-8">
      <header>
        <h1 className="text-2xl font-semibold">{profile.name}</h1>
        <p className="text-sm text-zinc-500">
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
          <div className="mt-1 text-xs text-zinc-500">
            {stats.xp - floor}/{next - floor} XP para o próximo
          </div>
        </div>
        <div className={card}>
          <div className="text-2xl font-semibold">{stats.xp}</div>
          <div className="text-xs text-zinc-500">XP total</div>
        </div>
        <div className={card}>
          <div className="text-2xl font-semibold">
            {stats.solved}/{stats.total}
          </div>
          <div className="text-xs text-zinc-500">exercícios resolvidos</div>
        </div>
        <div className={card}>
          <div className="text-2xl font-semibold">
            {Math.round(stats.firstTryRate * 100)}%
          </div>
          <div className="text-xs text-zinc-500">
            acertos de primeira · {stats.attempts} tentativas
          </div>
        </div>
      </section>

      <section>
        <h2 className="mb-3 text-lg font-semibold">Progresso por módulo</h2>
        <ul className="space-y-3">
          {modules.map((m) => {
            const list = exercisesOf(m.id);
            const done = list.filter((e) => progress[e.id]?.solved).length;
            return (
              <li key={m.id}>
                <div className="flex justify-between text-sm">
                  <span>{m.title}</span>
                  <span className="text-zinc-500">
                    {done}/{list.length}
                  </span>
                </div>
                <div className="mt-1 h-2 rounded bg-zinc-200 dark:bg-zinc-800">
                  <div
                    className="h-2 rounded bg-emerald-500"
                    style={{ width: `${(done / list.length) * 100}%` }}
                  />
                </div>
              </li>
            );
          })}
        </ul>
      </section>

      <section>
        <h2 className="mb-3 text-lg font-semibold">
          Medalhas ({earned.size}/{badges.length})
        </h2>
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

      <section>
        <h2 className="mb-3 text-lg font-semibold">Histórico</h2>
        {Object.keys(progress).length === 0 ? (
          <p className="text-sm text-zinc-500">
            Você ainda não tentou nenhum exercício.{" "}
            <Link
              href="/"
              className="text-emerald-700 hover:underline dark:text-emerald-400"
            >
              Ir para a trilha
            </Link>
          </p>
        ) : (
          <ul className="divide-y divide-zinc-200 text-sm dark:divide-zinc-800">
            {exercises
              .filter((e) => progress[e.id])
              .map((e) => {
                const p = progress[e.id];
                return (
                  <li
                    key={e.id}
                    className="flex items-center justify-between py-2"
                  >
                    <Link
                      href={`/exercicio/${e.id}`}
                      className="hover:underline"
                    >
                      {e.title}
                    </Link>
                    <span className="text-zinc-500">
                      {p.solved ? `✅ ${p.xp} XP` : "em andamento"} ·{" "}
                      {p.attempts}{" "}
                      {p.attempts === 1 ? "tentativa" : "tentativas"}
                    </span>
                  </li>
                );
              })}
          </ul>
        )}
      </section>

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
              className="mt-1 w-full rounded-lg border border-zinc-300 bg-transparent px-3 py-2 dark:border-zinc-700"
            />
          </label>
          <button
            type="submit"
            disabled={busy || name.trim() === profile.name}
            className="rounded-lg bg-emerald-600 px-4 py-2 font-medium text-white hover:bg-emerald-700 disabled:opacity-50"
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
