"use client";

import Link from "next/link";
import { useAuth } from "./AuthProvider";
import { earnedBadges, levelInfo, totalXp } from "@/lib/gamification";
import { useProgress } from "@/lib/progress-store";

export default function Header() {
  const progress = useProgress();
  const { profile, signOut } = useAuth();
  const xp = totalXp(progress);
  const { level, next, progress: pct } = levelInfo(xp);

  return (
    <header className="border-b border-zinc-200 dark:border-zinc-800">
      <div className="mx-auto flex max-w-4xl items-center justify-between gap-4 px-4 py-3">
        <Link href="/" className="font-semibold">
          Lógica Gamificada
        </Link>
        {profile && (
          <div className="flex items-center gap-4 text-sm">
            <span className="hidden sm:inline">{profile.name}</span>
            <span title="Medalhas conquistadas">
              🏅 {earnedBadges(progress).length}
            </span>
            <div className="w-40">
              <div className="flex justify-between text-xs">
                <span className="font-medium">Nível {level}</span>
                <span>
                  {xp}/{next} XP
                </span>
              </div>
              <div className="mt-1 h-2 rounded bg-zinc-200 dark:bg-zinc-800">
                <div
                  className="h-2 rounded bg-emerald-500"
                  style={{ width: `${Math.round(pct * 100)}%` }}
                />
              </div>
            </div>
            <button
              onClick={() => void signOut()}
              className="text-zinc-500 hover:underline"
            >
              Sair
            </button>
          </div>
        )}
      </div>
    </header>
  );
}
