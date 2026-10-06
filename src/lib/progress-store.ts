"use client";

import { useSyncExternalStore } from "react";
import type { Progress } from "./gamification";

// Persistência provisória no navegador. Será trocada pelo banco de dados quando houver login.
const KEY = "logica-gamificada:progress:v1";
const EMPTY: Progress = {};

let cache: Progress | null = null;
const listeners = new Set<() => void>();

function read(): Progress {
  if (cache) return cache;
  try {
    cache = JSON.parse(localStorage.getItem(KEY) ?? "{}") as Progress;
  } catch {
    cache = {};
  }
  return cache;
}

export function saveProgress(next: Progress) {
  cache = next;
  try {
    localStorage.setItem(KEY, JSON.stringify(next));
  } catch {
    // armazenamento indisponível: mantém só em memória
  }
  listeners.forEach((l) => l());
}

export function getProgress(): Progress {
  return read();
}

export function useProgress(): Progress {
  return useSyncExternalStore(
    (cb) => {
      listeners.add(cb);
      return () => listeners.delete(cb);
    },
    read,
    () => EMPTY,
  );
}
