"use client";

import { useStreak } from "@/lib/activity-store";
import { useGamification } from "@/lib/gamification-store";
import type { BadgeContext } from "@/lib/gamification";
import { useProgress } from "@/lib/progress-store";
import { useCatalog } from "./CatalogProvider";

/** Progresso + catálogo + melhor sequência + mundos concluídos: tudo que as medalhas precisam. */
export function useBadgeContext(): BadgeContext {
  const progress = useProgress();
  const { catalog } = useCatalog();
  const { best } = useStreak();
  const { worldsDone } = useGamification();
  return { progress, catalog, bestStreak: best, worldsDone };
}

/** XP total (exercícios + missões + mundos concluídos), como o banco soma no ranking. */
export function useTotalXp(): number {
  const progress = useProgress();
  const { bonusXp } = useGamification();
  return Object.values(progress).reduce((n, e) => n + (e.solved ? e.xp : 0), 0) + bonusXp;
}
