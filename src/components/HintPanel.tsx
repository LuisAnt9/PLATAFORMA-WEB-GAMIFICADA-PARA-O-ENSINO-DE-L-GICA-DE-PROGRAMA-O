"use client";

import { useState } from "react";
import type { HintContext } from "@/lib/ai-hint";
import { conceptsOf, type Exercise } from "@/lib/catalog";
import AiHint from "./AiHint";
import { useCatalog } from "./CatalogProvider";

const btn =
  "rounded-xl border border-zinc-300 bg-white px-5 py-2.5 hover:bg-zinc-50 disabled:opacity-50 dark:border-zinc-700 dark:bg-zinc-900 dark:hover:bg-zinc-800";

/**
 * Dicas em três níveis, uma de cada vez: 1) dica do professor, 2) pista do conceito, 3) dica com IA.
 * Nenhuma entrega a solução. O maior nível aberto é informado (`onLevel`) e gravado nas tentativas.
 */
export default function HintPanel({
  exercise,
  getContext,
  onLevel,
}: {
  exercise: Exercise;
  getContext: () => HintContext;
  onLevel: (level: number) => void;
}) {
  const { catalog } = useCatalog();
  const [level, setLevel] = useState(0);
  const [open1, setOpen1] = useState(false);
  const [open2, setOpen2] = useState(false);

  const reach = (n: number) => {
    setLevel((l) => Math.max(l, n));
    onLevel(n);
  };
  const concepts = conceptsOf(catalog, exercise.id);
  const lessonIntro =
    catalog.modules.find((m) => m.id === exercise.moduleId)?.intro ?? "";

  return (
    <div className="flex flex-wrap gap-2">
      <button
        type="button"
        aria-expanded={open1}
        onClick={() => {
          setOpen1((v) => !v);
          reach(1);
        }}
        className={btn}
      >
        Dica
      </button>
      <button
        type="button"
        aria-expanded={open2}
        disabled={level < 1}
        title={level < 1 ? "Abra a primeira dica antes" : undefined}
        onClick={() => {
          setOpen2((v) => !v);
          reach(2);
        }}
        className={btn}
      >
        Dica do conceito
      </button>
      <AiHint
        exerciseId={exercise.id}
        getContext={getContext}
        disabled={level < 2}
        disabledReason="Abra a dica do conceito antes"
        onReceived={() => reach(3)}
      />

      {open1 && (
        <p className="w-full basis-full rounded-lg bg-amber-50 p-3 text-sm dark:bg-amber-950">
          💡{" "}
          {exercise.hint ||
            "Releia o enunciado com calma e identifique o que entra e o que deve sair."}
        </p>
      )}
      {open2 && (
        <div className="w-full basis-full space-y-2 rounded-lg bg-violet-50 p-3 text-sm dark:bg-violet-950">
          <p>
            🧭{" "}
            {concepts.length > 0
              ? `Este exercício trabalha: ${concepts.map((c) => c.title).join("; ")}. Volte à explicação desse conceito antes de tentar de novo.`
              : "Volte à explicação da lição antes de tentar de novo e teste com valores pequenos, passo a passo."}
          </p>
          {lessonIntro && (
            <details>
              <summary className="cursor-pointer font-medium">
                Reler a explicação da lição
              </summary>
              <p className="mt-2 whitespace-pre-line">{lessonIntro}</p>
            </details>
          )}
        </div>
      )}
    </div>
  );
}
