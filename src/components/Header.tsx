"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useAuth } from "./AuthProvider";
import { earnedBadges, levelInfo, totalXp } from "@/lib/gamification";
import { useProgress } from "@/lib/progress-store";

const NAV = [
  { href: "/", label: "Trilha" },
  { href: "/ranking", label: "Ranking" },
  { href: "/perfil", label: "Perfil" },
];

export default function Header() {
  const progress = useProgress();
  const pathname = usePathname();
  const { profile, signOut } = useAuth();
  const xp = totalXp(progress);
  const { level, next, progress: pct } = levelInfo(xp);

  return (
    <header className="border-b border-zinc-200 dark:border-zinc-800">
      <div className="mx-auto flex max-w-4xl flex-wrap items-center justify-between gap-x-6 gap-y-2 px-4 py-3">
        <div className="flex items-center gap-6">
          <Link href="/" className="font-semibold">
            Lógica Gamificada
          </Link>
          {profile && (
            <nav aria-label="Principal" className="flex gap-4 text-sm">
              {NAV.map((n) => {
                const active =
                  n.href === "/"
                    ? pathname === "/" || pathname.startsWith("/exercicio")
                    : pathname.startsWith(n.href);
                return (
                  <Link
                    key={n.href}
                    href={n.href}
                    aria-current={active ? "page" : undefined}
                    className={
                      active
                        ? "font-medium text-emerald-700 dark:text-emerald-400"
                        : "text-zinc-500 hover:text-foreground"
                    }
                  >
                    {n.label}
                  </Link>
                );
              })}
            </nav>
          )}
        </div>
        {profile && (
          <div className="flex items-center gap-4 text-sm">
            <span title="Medalhas conquistadas">
              🏅 {earnedBadges(progress).length}
            </span>
            <div className="w-36">
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
