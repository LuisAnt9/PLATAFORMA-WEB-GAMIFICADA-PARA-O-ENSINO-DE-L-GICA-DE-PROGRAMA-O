"use client";

import { useSyncExternalStore } from "react";
import type { ExerciseProgress, Progress } from "./gamification";
import { getSupabase } from "./supabase";

// Cache em memória do progresso do usuário logado; a fonte da verdade é a tabela exercise_progress.
const EMPTY: Progress = {};
let cache: Progress = EMPTY;
const listeners = new Set<() => void>();

function set(next: Progress) {
  cache = next;
  listeners.forEach((l) => l());
}

export function getProgress(): Progress {
  return cache;
}

export function clearProgress() {
  set(EMPTY);
}

/** Carrega o progresso do usuário a partir do banco. */
export async function loadProgress(userId: string): Promise<void> {
  const { data, error } = await getSupabase()
    .from("exercise_progress")
    .select("exercise_id, attempts, solved, first_try, xp")
    .eq("user_id", userId);
  if (error) throw new Error(error.message);
  const next: Progress = {};
  for (const r of data ?? []) {
    next[r.exercise_id] = {
      attempts: r.attempts,
      solved: r.solved,
      firstTry: r.first_try,
      xp: r.xp,
    };
  }
  set(next);
}

/**
 * Atualiza o cache na hora (interface responde imediatamente) e grava no banco.
 * Se a gravação falhar, reverte o cache e lança o erro para a tela avisar o aluno.
 */
export async function saveExercise(
  userId: string,
  exerciseId: string,
  value: ExerciseProgress,
): Promise<void> {
  const previous = cache;
  set({ ...cache, [exerciseId]: value });
  const { data, error } = await getSupabase()
    .from("exercise_progress")
    .upsert({
      user_id: userId,
      exercise_id: exerciseId,
      attempts: value.attempts,
      solved: value.solved,
      first_try: value.firstTry,
      xp: value.xp,
      solved_at: value.solved ? new Date().toISOString() : null,
    })
    .select("xp");
  if (error) {
    set(previous);
    throw new Error(error.message);
  }
  // O XP que vale é o calculado pelo banco (migration 0014); sem ela, o valor local continua.
  const serverXp = Array.isArray(data) ? (data[0] as { xp?: number })?.xp : undefined;
  if (value.solved && typeof serverXp === "number" && serverXp !== value.xp)
    set({ ...cache, [exerciseId]: { ...value, xp: serverXp } });
}

export function useProgress(): Progress {
  return useSyncExternalStore(
    (cb) => {
      listeners.add(cb);
      return () => listeners.delete(cb);
    },
    () => cache,
    () => EMPTY,
  );
}
