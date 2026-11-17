"use client";

import { useEffect } from "react";
import { earnedBadges } from "@/lib/gamification";
import { recordBadges, useGamification } from "@/lib/gamification-store";
import { useAuth } from "./AuthProvider";
import { useCatalog } from "./CatalogProvider";
import { useBadgeContext } from "./useBadgeContext";

/** Registra no banco, com a data do servidor, as conquistas que o aluno acabou de ganhar. */
export default function GamificationSync() {
  const { profile } = useAuth();
  const { loading } = useCatalog();
  const ctx = useBadgeContext();
  const g = useGamification();
  const ids = earnedBadges(ctx)
    .map((b) => b.id)
    .join(",");
  useEffect(() => {
    if (!profile || loading || !g.available || !ids) return;
    void recordBadges(profile.id, ids.split(","));
  }, [profile, loading, g.available, ids]);
  return null;
}
