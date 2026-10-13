"use client";

import { useStreak } from "@/lib/activity-store";
import type { BadgeContext } from "@/lib/gamification";
import { useProgress } from "@/lib/progress-store";
import { useCatalog } from "./CatalogProvider";

/** Progresso + catálogo + melhor sequência, tudo que as medalhas precisam. */
export function useBadgeContext(): BadgeContext {
  const progress = useProgress();
  const { catalog } = useCatalog();
  const { best } = useStreak();
  return { progress, catalog, bestStreak: best };
}
