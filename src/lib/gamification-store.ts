"use client";

import { useSyncExternalStore } from "react";
import { totalXp, type Progress } from "./gamification";
import { getSupabase } from "./supabase";

/** Missão diária como o banco devolve (a conta de progresso e do XP é toda do servidor). */
export interface Mission {
  id: string;
  title: string;
  description: string;
  target: number;
  xp: number;
  progress: number;
  claimed: boolean;
}

export interface GamificationState {
  /** false enquanto a migration 0014 não existe no banco: o site segue sem missões e bônus. */
  available: boolean;
  /** XP de missões e de conclusão de mundo (somado ao XP dos exercícios). */
  bonusXp: number;
  missions: Mission[];
  worldsDone: string[];
  /** Conquistas já registradas, com a data. */
  badgeDates: Record<string, string>;
}

const EMPTY: GamificationState = {
  available: false,
  bonusXp: 0,
  missions: [],
  worldsDone: [],
  badgeDates: {},
};
let state = EMPTY;
const listeners = new Set<() => void>();
const set = (next: GamificationState) => {
  state = next;
  listeners.forEach((l) => l());
};

export function clearGamification() {
  set(EMPTY);
}

export function getGamification() {
  return state;
}

/** Resultado de uma sincronização: os mundos concluídos agora (para avisar o aluno). */
export interface SyncResult {
  newWorlds: string[];
}

/**
 * Pede ao banco para conferir missões e mundos (concedendo o que for devido, uma vez) e guarda o
 * estado. Nunca lança: sem a migration 0014 ou sem rede, a plataforma segue com o XP dos exercícios.
 */
export async function syncGamification(): Promise<SyncResult> {
  try {
    const supabase = getSupabase();
    const [sync, badges] = await Promise.all([
      supabase.rpc("sync_gamification"),
      supabase.from("user_badges").select("badge_id, earned_at"),
    ]);
    if (sync.error || !sync.data) return { newWorlds: [] };
    const d = sync.data as {
      bonus_xp: number;
      missions: Mission[];
      new_worlds: string[];
      worlds_done: string[];
    };
    const badgeDates: Record<string, string> = { ...state.badgeDates };
    if (Array.isArray(badges.data))
      for (const b of badges.data as { badge_id: string; earned_at: string }[])
        badgeDates[b.badge_id] = b.earned_at;
    set({
      available: true,
      bonusXp: Number(d.bonus_xp) || 0,
      missions: d.missions ?? [],
      worldsDone: d.worlds_done ?? [],
      badgeDates,
    });
    return { newWorlds: d.new_worlds ?? [] };
  } catch {
    return { newWorlds: [] };
  }
}

/** Registra conquistas novas (a data é a do servidor). Falhas não atrapalham o aluno. */
export async function recordBadges(userId: string, ids: string[]) {
  const fresh = ids.filter((id) => !(id in state.badgeDates));
  if (!state.available || fresh.length === 0) return;
  // marca já, para não tentar de novo enquanto a gravação não volta
  set({
    ...state,
    badgeDates: {
      ...state.badgeDates,
      ...Object.fromEntries(fresh.map((id) => [id, new Date().toISOString()])),
    },
  });
  try {
    const { error } = await getSupabase()
      .from("user_badges")
      .upsert(
        fresh.map((badge_id) => ({ user_id: userId, badge_id })),
        { onConflict: "user_id,badge_id", ignoreDuplicates: true },
      );
    if (error) throw new Error(error.message);
    await syncGamification();
  } catch {
    /* as medalhas continuam aparecendo; a data entra na próxima vez */
  }
}

export function useGamification(): GamificationState {
  return useSyncExternalStore(
    (cb) => {
      listeners.add(cb);
      return () => listeners.delete(cb);
    },
    () => state,
    () => EMPTY,
  );
}

/** XP total: exercícios resolvidos + missões + conclusão de mundos. */
export function totalXpWithBonus(p: Progress, g: GamificationState): number {
  return totalXp(p) + g.bonusXp;
}
