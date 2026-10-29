"use client";

import { useState } from "react";
import type { HintContext } from "@/lib/ai-hint";
import { getSupabase } from "@/lib/supabase";

interface Props {
  exerciseId: string;
  /** Lido só na hora do clique, para refletir o que o aluno tem na tela agora. */
  getContext: () => HintContext;
}

/** Botão "Dica com IA": pede ao servidor (/api/dica) uma pista sem a resposta pronta. */
export default function AiHint({ exerciseId, getContext }: Props) {
  const [busy, setBusy] = useState(false);
  const [hint, setHint] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [remaining, setRemaining] = useState<number | null>(null);

  async function ask() {
    setBusy(true);
    setError(null);
    try {
      const { data } = await getSupabase().auth.getSession();
      const token = data.session?.access_token;
      if (!token) throw new Error("Entre na sua conta para pedir dicas.");
      const res = await fetch("/api/dica", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ exerciseId, ...getContext() }),
      });
      const body = (await res.json().catch(() => ({}))) as {
        hint?: string;
        error?: string;
        remaining?: number;
      };
      if (typeof body.remaining === "number") setRemaining(body.remaining);
      if (!res.ok || !body.hint) {
        throw new Error(body.error ?? "Não foi possível pedir a dica.");
      }
      setHint(body.hint);
    } catch (e) {
      setError(
        e instanceof Error ? e.message : "Não foi possível pedir a dica.",
      );
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="contents">
      <button
        type="button"
        onClick={() => void ask()}
        disabled={busy}
        className="rounded-xl border border-emerald-700 bg-white px-5 py-2.5 text-emerald-800 hover:bg-emerald-50 disabled:opacity-50 dark:border-emerald-500 dark:bg-zinc-900 dark:text-emerald-300 dark:hover:bg-emerald-950"
      >
        {busy ? "Pensando..." : "✨ Dica com IA"}
      </button>
      <div
        aria-live="polite"
        className="w-full basis-full space-y-2 empty:hidden"
      >
        {hint && (
          <div className="rounded-lg bg-sky-50 p-3 text-sm dark:bg-sky-950">
            <p className="whitespace-pre-line">✨ {hint}</p>
            <p className="mt-2 text-xs text-zinc-600 dark:text-zinc-400">
              Dica gerada por IA, pode conter erros. Ela não entrega a resposta.
              {remaining !== null && ` Restam ${remaining} hoje.`}
            </p>
          </div>
        )}
        {error && (
          <p
            role="alert"
            className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
          >
            {error}
          </p>
        )}
      </div>
    </div>
  );
}
