"use client";

import { useState } from "react";
import { getSupabase } from "@/lib/supabase";
import ScrollRegion from "./ScrollRegion";

/** Solução comentada: só aparece depois de acertar e só é entregue pelo servidor a quem já acertou. */
export default function SolutionPanel({ exerciseId }: { exerciseId: string }) {
  const [busy, setBusy] = useState(false);
  const [solution, setSolution] = useState<{
    solution: string;
    commentary: string;
  } | null>(null);
  const [message, setMessage] = useState<string | null>(null);

  async function load() {
    setBusy(true);
    setMessage(null);
    try {
      const { data, error } = await getSupabase().rpc("get_solution", {
        p_exercise: exerciseId,
      });
      if (error) throw new Error(error.message);
      const row = (data as { solution: string; commentary: string }[])?.[0];
      if (row) setSolution(row);
      else setMessage("Este exercício não tem solução comentada.");
    } catch {
      setMessage("A solução comentada não está disponível agora.");
    }
    setBusy(false);
  }

  return (
    <div className="space-y-2">
      {!solution && (
        <button
          type="button"
          onClick={() => void load()}
          disabled={busy}
          className="rounded-xl border border-zinc-300 bg-white px-5 py-2.5 hover:bg-zinc-50 disabled:opacity-50 dark:border-zinc-700 dark:bg-zinc-900 dark:hover:bg-zinc-800"
        >
          {busy ? "Buscando..." : "Ver solução comentada"}
        </button>
      )}
      {message && (
        <p className="text-sm text-zinc-600 dark:text-zinc-400">{message}</p>
      )}
      {solution && (
        <div className="space-y-2 rounded-lg bg-zinc-100 p-3 text-sm dark:bg-zinc-900">
          <div className="font-medium">Uma solução possível</div>
          <ScrollRegion
            label="Solução comentada"
            className="rounded-lg bg-zinc-900 text-zinc-100"
          >
            <pre className="p-3 font-mono text-sm leading-6">
              {solution.solution}
            </pre>
          </ScrollRegion>
          {solution.commentary && (
            <p className="whitespace-pre-line">{solution.commentary}</p>
          )}
          <p className="text-xs text-zinc-600 dark:text-zinc-400">
            Existem outras soluções corretas: o que importa é passar nos testes.
          </p>
        </div>
      )}
    </div>
  );
}
