"use client";

import { useMemo } from "react";
import { orderedExercises } from "@/lib/catalog";
import { useProgress } from "@/lib/progress-store";
import { worldSummaries } from "@/lib/student";
import { useCatalog } from "./CatalogProvider";
import { useModuleLocks } from "./useModuleLocks";

/** Catálogo, progresso, liberação e resumo dos mundos, num só lugar para as telas do aluno. */
export function useStudent() {
  const { catalog } = useCatalog();
  const progress = useProgress();
  const locks = useModuleLocks();
  const worlds = useMemo(
    () => worldSummaries(catalog, progress, locks.states, locks.enforced),
    [catalog, progress, locks.states, locks.enforced],
  );
  const published = useMemo(
    () => orderedExercises(catalog).filter((e) => e.published),
    [catalog],
  );
  const solvedCount = published.filter((e) => progress[e.id]?.solved).length;
  /** Próximo exercício não resolvido que o aluno pode abrir agora. */
  const upNext = published.find(
    (e) => !progress[e.id]?.solved && !locks.isLocked(e.moduleId),
  );
  return { catalog, progress, worlds, published, solvedCount, upNext, ...locks };
}
