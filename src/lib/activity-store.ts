"use client";

import { useSyncExternalStore } from "react";
import { getSupabase } from "./supabase";
import { computeStreak, localDay, type StreakInfo } from "./streak";

// Dias em que o aluno praticou (tabela daily_activity). Se a migration 0004 ainda não existe,
// `available` fica false e a interface simplesmente não mostra a sequência.
interface State {
  days: readonly string[];
  available: boolean;
}

export interface StreakSnapshot extends StreakInfo {
  available: boolean;
  days: readonly string[];
}

const EMPTY_STATE: State = { days: [], available: false };
const EMPTY_SNAPSHOT: StreakSnapshot = {
  current: 0,
  best: 0,
  activeToday: false,
  available: false,
  days: [],
};

let state: State = EMPTY_STATE;
let version = 0;
const listeners = new Set<() => void>();

function set(next: State) {
  state = next;
  version++;
  listeners.forEach((l) => l());
}

export function clearActivity() {
  set(EMPTY_STATE);
}

export async function loadActivity(userId: string): Promise<void> {
  const { data, error } = await getSupabase()
    .from("daily_activity")
    .select("day")
    .eq("user_id", userId)
    .order("day", { ascending: false })
    .limit(500);
  if (error || !Array.isArray(data)) {
    set(EMPTY_STATE);
    return;
  }
  set({ days: (data as { day: string }[]).map((r) => r.day), available: true });
}

/** Registra uma tentativa de hoje. A tela atualiza na hora; falha de rede aqui nunca atrapalha o aluno. */
export async function logActivity(solved: boolean): Promise<void> {
  if (!state.available) return;
  const day = localDay();
  if (!state.days.includes(day))
    set({ days: [day, ...state.days], available: true });
  try {
    await getSupabase().rpc("log_activity", { p_day: day, p_solved: solved });
  } catch {
    /* a sequência é um extra: não vale interromper o exercício */
  }
}

let cached: StreakSnapshot = EMPTY_SNAPSHOT;
let cachedKey = "";

function getSnapshot(): StreakSnapshot {
  if (!state.available) return EMPTY_SNAPSHOT;
  const today = localDay(); // recalcula sozinho na virada do dia
  const key = `${version}|${today}`;
  if (key !== cachedKey) {
    cached = {
      ...computeStreak(state.days, today),
      available: true,
      days: state.days,
    };
    cachedKey = key;
  }
  return cached;
}

export function getStreak(): StreakSnapshot {
  return getSnapshot();
}

export function useStreak(): StreakSnapshot {
  return useSyncExternalStore(
    (cb) => {
      listeners.add(cb);
      return () => listeners.delete(cb);
    },
    getSnapshot,
    () => EMPTY_SNAPSHOT,
  );
}
