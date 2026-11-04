"use client";

import { useSyncExternalStore } from "react";

export type LearningMode = "aprendizado" | "pratica";

const KEY = "logica-gamificada:modo";
const listeners = new Set<() => void>();

function read(): LearningMode {
  try {
    return localStorage.getItem(KEY) === "pratica" ? "pratica" : "aprendizado";
  } catch {
    return "aprendizado";
  }
}

/** Modo escolhido neste navegador (padrão: aprendizado). */
export function useLearningMode(): [LearningMode, (m: LearningMode) => void] {
  const mode = useSyncExternalStore(
    (cb) => {
      listeners.add(cb);
      window.addEventListener("storage", cb);
      return () => {
        listeners.delete(cb);
        window.removeEventListener("storage", cb);
      };
    },
    read,
    () => "aprendizado" as LearningMode,
  );
  const set = (m: LearningMode) => {
    try {
      localStorage.setItem(KEY, m);
    } catch {
      /* sem armazenamento: o modo vale só até recarregar */
    }
    listeners.forEach((l) => l());
  };
  return [mode, set];
}
