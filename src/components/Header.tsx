"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useAuth } from "./AuthProvider";
import { useStreak } from "@/lib/activity-store";
import { useBadgeContext } from "./useBadgeContext";
import { earnedBadges, levelInfo, totalXp } from "@/lib/gamification";
import { useProgress } from "@/lib/progress-store";

const NAV = [
  { href: "/", label: "Trilha" },
  { href: "/ranking", label: "Ranking" },
  { href: "/perfil", label: "Perfil" },
  { href: "/professor", label: "Professor", onlyProfessor: true },
];

export default function Header() {
  const progress = useProgress();
  const pathname = usePathname();
  const { profile, signOut } = useAuth();
  const badgeCtx = useBadgeContext();
  const streak = useStreak();
  const xp = totalXp(progress);
  const { level, next, progress: pct } = levelInfo(xp);

  return (
    <header className="sticky top-0 z-30 border-b border-zinc-200 bg-white/90 backdrop-blur dark:border-zinc-800 dark:bg-zinc-950/90">
      <div className="mx-auto flex max-w-4xl flex-wrap items-center justify-between gap-x-6 gap-y-2 px-4 py-3">
        <div className="flex flex-wrap items-center gap-x-6 gap-y-2">
          <Link
            href="/"
            className="flex items-center gap-2 whitespace-nowrap font-semibold tracking-tight"
          >
            <span
              aria-hidden
              className="flex h-8 w-8 items-center justify-center rounded-lg bg-emerald-700 font-mono text-sm text-white"
            >
              {"</>"}
            </span>
            Lógica Gamificada
          </Link>
          {profile && (
            <nav aria-label="Principal" className="flex gap-1 text-sm">
              {NAV.filter(
                (n) => !n.onlyProfessor || profile.role === "professor",
              ).map((n) => {
                const active =
                  n.href === "/"
                    ? pathname === "/" || pathname.startsWith("/exercicio")
                    : pathname.startsWith(n.href);
                return (
                  <Link
                    key={n.href}
                    href={n.href}
                    aria-current={active ? "page" : undefined}
                    className={`rounded-lg px-3 py-1.5 ${
                      active
                        ? "bg-emerald-100 font-medium text-emerald-900 dark:bg-emerald-950 dark:text-emerald-200"
                        : "text-zinc-600 hover:bg-zinc-100 hover:text-foreground dark:text-zinc-400 dark:hover:bg-zinc-800"
                    }`}
                  >
                    {n.label}
                  </Link>
                );
              })}
            </nav>
          )}
        </div>
        {profile && (
          <div className="flex items-center gap-3 text-sm">
            {streak.available && (
              <span
                title={
                  streak.current > 0
                    ? `${streak.current} ${streak.current === 1 ? "dia seguido" : "dias seguidos"}${streak.activeToday ? "" : " — pratique hoje para manter"}`
                    : "Pratique hoje para começar uma sequência"
                }
                aria-label={`Sequência: ${streak.current} ${streak.current === 1 ? "dia" : "dias"}`}
                className={`rounded-full bg-zinc-100 px-2.5 py-1 dark:bg-zinc-800 ${streak.current > 0 ? "" : "grayscale"}`}
              >
                🔥 {streak.current}
              </span>
            )}
            <span
              title="Medalhas conquistadas"
              className="rounded-full bg-zinc-100 px-2.5 py-1 dark:bg-zinc-800"
            >
              🏅 {earnedBadges(badgeCtx).length}
            </span>
            <div className="w-32">
              <div className="flex justify-between text-xs">
                <span className="font-medium">Nível {level}</span>
                <span>
                  {xp}/{next} XP
                </span>
              </div>
              <div className="mt-1 h-2 rounded-full bg-zinc-200 dark:bg-zinc-800">
                <div
                  className="h-2 rounded-full bg-emerald-600"
                  style={{ width: `${Math.round(pct * 100)}%` }}
                />
              </div>
            </div>
            <button
              onClick={() => void signOut()}
              className="rounded-lg px-2 py-1 text-zinc-600 hover:bg-zinc-100 dark:text-zinc-400 dark:hover:bg-zinc-800"
            >
              Sair
            </button>
          </div>
        )}
      </div>
    </header>
  );
}
