"use client";

import Link from "next/link";
import { getExercise } from "@/lib/catalog";
import { CatalogGate, useCatalog } from "./CatalogProvider";
import ExerciseView from "./ExerciseView";
import { useModuleLocks } from "./useModuleLocks";

function Inner({ id }: { id: string }) {
  const { catalog } = useCatalog();
  const exercise = getExercise(catalog, id);
  const { states, isLocked, setMode } = useModuleLocks();
  if (exercise && isLocked(exercise.moduleId)) {
    const prev = states[exercise.moduleId]?.blockedBy;
    return (
      <div className="space-y-3 rounded-2xl border border-zinc-200 bg-white p-6 shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
        <h1 className="text-xl font-semibold">
          Esta lição ainda está bloqueada
        </h1>
        <p className="text-zinc-600 dark:text-zinc-400">
          No modo aprendizado, as lições abrem em ordem.
          {prev &&
            ` Resolva pelo menos 70% de "${prev.title}" para liberar esta.`}
        </p>
        <div className="flex flex-wrap gap-2">
          <Link
            href="/mundos"
            className="rounded-xl bg-emerald-700 px-5 py-2.5 font-medium text-white hover:bg-emerald-800"
          >
            Voltar aos mundos
          </Link>
          <button
            type="button"
            onClick={() => setMode("pratica")}
            className="rounded-xl border border-zinc-300 bg-white px-5 py-2.5 hover:bg-zinc-50 dark:border-zinc-700 dark:bg-zinc-900 dark:hover:bg-zinc-800"
          >
            Ir para o modo prática
          </button>
        </div>
      </div>
    );
  }
  if (!exercise) {
    return (
      <div>
        <p className="mb-3">Exercício não encontrado.</p>
        <Link
          href="/mundos"
          className="text-emerald-700 hover:underline dark:text-emerald-400"
        >
          ← Voltar aos mundos
        </Link>
      </div>
    );
  }
  // key força reinício do editor ao trocar de exercício
  return <ExerciseView key={exercise.id} exercise={exercise} />;
}

export default function ExerciseLoader({ id }: { id: string }) {
  return (
    <CatalogGate>
      <Inner id={id} />
    </CatalogGate>
  );
}
