"use client";

import { useAuth } from "./AuthProvider";
import { useModuleLocks } from "./useModuleLocks";

/** Alternância entre o modo aprendizado (em ordem) e o modo prática (aprendizagem livre). */
export default function ModeSwitch() {
  const { profile } = useAuth();
  const { mode, setMode } = useModuleLocks();
  if (profile?.role === "professor") return null;
  return (
    <div className="flex flex-wrap items-center justify-between gap-3">
      <div
        role="radiogroup"
        aria-label="Modo de estudo"
        className="inline-flex rounded-xl bg-zinc-200/60 p-1 text-sm dark:bg-zinc-800/60"
      >
        {(
          [
            ["aprendizado", "Modo aprendizado"],
            ["pratica", "Modo prática"],
          ] as const
        ).map(([value, label]) => (
          <button
            key={value}
            type="button"
            role="radio"
            aria-checked={mode === value}
            onClick={() => setMode(value)}
            className={`rounded-lg px-3 py-1.5 ${
              mode === value
                ? "bg-white font-medium text-emerald-900 shadow-sm dark:bg-zinc-950 dark:text-emerald-300"
                : "text-zinc-700 hover:text-foreground dark:text-zinc-300"
            }`}
          >
            {label}
          </button>
        ))}
      </div>
      <p className="text-sm text-zinc-600 dark:text-zinc-400">
        {mode === "aprendizado"
          ? "As lições abrem em ordem: resolva 70% de uma para liberar a próxima."
          : "Aprendizagem livre: tudo liberado, escolha qualquer lição."}
      </p>
    </div>
  );
}
