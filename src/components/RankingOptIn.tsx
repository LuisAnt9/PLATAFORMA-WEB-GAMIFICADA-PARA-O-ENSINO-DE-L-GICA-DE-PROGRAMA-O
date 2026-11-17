"use client";

import { useState } from "react";
import { useAuth } from "./AuthProvider";

/** Escolha de aparecer (ou não) no ranking da própria turma. Por padrão, ninguém aparece. */
export default function RankingOptIn({ onChange }: { onChange?: () => void }) {
  const { profile, setRankingOptIn } = useAuth();
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  if (!profile || profile.role !== "aluno") return null;
  const on = profile.show_in_ranking === true;
  return (
    <div>
      <label className="flex items-start gap-3 text-sm">
        <input
          type="checkbox"
          checked={on}
          disabled={busy}
          onChange={async (e) => {
            setBusy(true);
            setError(null);
            const err = await setRankingOptIn(e.target.checked);
            if (err) setError(err);
            else onChange?.();
            setBusy(false);
          }}
          className="mt-0.5 h-5 w-5"
        />
        <span>
          <span className="font-medium">Aparecer no ranking da minha turma</span>
          <span className="block text-zinc-600 dark:text-zinc-400">
            Só colegas da sua turma veem o ranking, com o nome abreviado. Você
            pode mudar de ideia quando quiser.
          </span>
        </span>
      </label>
      {error && (
        <p role="alert" className="mt-2 text-sm text-red-700 dark:text-red-300">
          {error}
        </p>
      )}
    </div>
  );
}
