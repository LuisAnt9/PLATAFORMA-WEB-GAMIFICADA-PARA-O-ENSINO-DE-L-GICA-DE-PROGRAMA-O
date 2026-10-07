"use client";

import { useState } from "react";
import { useLoader } from "@/lib/use-loader";
import {
  joinClass,
  leaveClass,
  listMyClasses,
  type MyClass,
} from "@/lib/classes";
import { useAuth } from "./AuthProvider";

export default function MyClasses() {
  const { profile } = useAuth();
  const {
    data: classes,
    error,
    refresh,
  } = useLoader("my-classes", listMyClasses);
  const [code, setCode] = useState("");
  const [msg, setMsg] = useState<{ ok: boolean; text: string } | null>(null);
  const [busy, setBusy] = useState(false);

  async function join(e: React.FormEvent) {
    e.preventDefault();
    setBusy(true);
    setMsg(null);
    try {
      const c = await joinClass(code);
      setMsg({ ok: true, text: `Você entrou na turma ${c.name}.` });
      setCode("");
      await refresh();
    } catch (err) {
      setMsg({ ok: false, text: (err as Error).message });
    }
    setBusy(false);
  }

  async function leave(c: MyClass) {
    if (
      !profile ||
      !window.confirm(
        `Sair da turma "${c.name}"? Seu professor deixará de ver seu progresso.`,
      )
    )
      return;
    try {
      await leaveClass(c.id, profile.id);
      await refresh();
    } catch (err) {
      setMsg({ ok: false, text: (err as Error).message });
    }
  }

  return (
    <section>
      <h2 className="mb-1 text-lg font-semibold">Minhas turmas</h2>
      <p className="mb-3 text-sm text-zinc-500">
        Ao entrar em uma turma, o professor passa a acompanhar seu progresso nos
        exercícios.
      </p>

      {classes === null && !error && (
        <p className="text-sm text-zinc-500">Carregando...</p>
      )}
      {error && (
        <p role="alert" className="mb-3 text-sm text-red-700 dark:text-red-300">
          {error}
        </p>
      )}
      {classes && classes.length === 0 && (
        <p className="mb-3 text-sm text-zinc-500">
          Você ainda não está em nenhuma turma.
        </p>
      )}
      {classes && classes.length > 0 && (
        <ul className="mb-4 divide-y divide-zinc-200 rounded-lg border border-zinc-200 text-sm dark:divide-zinc-800 dark:border-zinc-800">
          {classes.map((c) => (
            <li
              key={c.id}
              className="flex items-center justify-between px-4 py-2"
            >
              <span>{c.name}</span>
              <button
                onClick={() => void leave(c)}
                className="text-zinc-500 hover:underline"
              >
                Sair da turma
              </button>
            </li>
          ))}
        </ul>
      )}

      <form onSubmit={join} className="flex max-w-md flex-wrap items-end gap-3">
        <label className="flex-1 text-sm">
          Código da turma
          <input
            value={code}
            onChange={(e) => setCode(e.target.value.toUpperCase())}
            required
            minLength={6}
            maxLength={6}
            placeholder="ABC234"
            autoCapitalize="characters"
            autoComplete="off"
            className="mt-1 w-full rounded-lg border border-zinc-300 bg-transparent px-3 py-2 font-mono uppercase tracking-widest dark:border-zinc-700"
          />
        </label>
        <button
          type="submit"
          disabled={busy || code.trim().length !== 6}
          className="rounded-lg bg-emerald-600 px-4 py-2 font-medium text-white hover:bg-emerald-700 disabled:opacity-50"
        >
          Entrar
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
  );
}
