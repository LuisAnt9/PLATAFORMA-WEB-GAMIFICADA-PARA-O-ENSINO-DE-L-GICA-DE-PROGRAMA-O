"use client";

import { useMemo } from "react";
import { moduleStates, type ModuleState } from "@/lib/learning";
import { useLearningMode } from "@/lib/learning-mode";
import { useProgress } from "@/lib/progress-store";
import { useAuth } from "./AuthProvider";
import { useCatalog } from "./CatalogProvider";

/**
 * Estado de liberação dos módulos. No modo prática, e para professores, nada fica bloqueado
 * (o bloqueio é uma ajuda pedagógica, não uma regra de segurança).
 */
export function useModuleLocks() {
  const { catalog } = useCatalog();
  const progress = useProgress();
  const { profile } = useAuth();
  const [mode, setMode] = useLearningMode();
  const states = useMemo(
    () => moduleStates(catalog, progress),
    [catalog, progress],
  );
  const enforced = mode === "aprendizado" && profile?.role !== "professor";
  const isLocked = (moduleId: string) =>
    enforced && states[moduleId]?.unlocked === false;
  return { states, mode, setMode, enforced, isLocked } as {
    states: Record<string, ModuleState>;
    mode: typeof mode;
    setMode: typeof setMode;
    enforced: boolean;
    isLocked: (moduleId: string) => boolean;
  };
}
