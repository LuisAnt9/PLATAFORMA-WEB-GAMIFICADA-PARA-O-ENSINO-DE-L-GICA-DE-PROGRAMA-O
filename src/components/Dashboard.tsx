"use client";

import Link from "next/link";
import { usePageTitle } from "@/lib/use-page-title";
import { badgesFor, earnedBadges, levelInfo } from "@/lib/gamification";
import { useStreak } from "@/lib/activity-store";
import { WORLD_STATUS_LABEL } from "@/lib/student";
import { useAuth } from "./AuthProvider";
import { CatalogGate } from "./CatalogProvider";
import { useBadgeContext, useTotalXp } from "./useBadgeContext";
import { useStudent } from "./useStudent";
import Missions from "./Missions";
import { AssignmentRow, useMyAssignments } from "./MyAssignments";
import { isPending } from "@/lib/assignments";
import { Pill, ProgressBar, card, primaryButton } from "./ui";

function DashboardContent() {
  usePageTitle("Início");
  const { profile } = useAuth();
  const s = useStudent();
  const mine = useMyAssignments();
  const pendingList = (mine.data ?? []).filter((a) => isPending(a.status)).slice(0, 3);
  const badgeCtx = useBadgeContext();
  const streak = useStreak();
  const xp = useTotalXp();
  const { level, next, floor, progress: levelPct } = levelInfo(xp);
  const firstName = profile?.name.split(" ")[0];
  const earned = earnedBadges(badgeCtx);
  const recent = earned.slice(-3).reverse();
  const total = s.published.length || 1;
  const nextLesson = s.upNext
    ? s.catalog.modules.find((m) => m.id === s.upNext!.moduleId)
    : undefined;
  const visibleWorlds = s.worlds.filter((w) => w.status !== "em-breve");

  return (
    <div className="space-y-8">
      <section className={`${card} p-6`}>
        <div className="flex flex-wrap items-start justify-between gap-6">
          <div className="min-w-0 flex-1 basis-64">
            <p className="text-sm font-medium text-emerald-700 dark:text-emerald-400">
              Lógica de programação
            </p>
            <h1 className="mt-1 text-2xl font-semibold tracking-tight">
              {s.solvedCount === 0
                ? `Bem-vindo${firstName ? `, ${firstName}` : ""}!`
                : `Olá${firstName ? `, ${firstName}` : ""}!`}
            </h1>
            <p className="mt-1 text-zinc-600 dark:text-zinc-400">
              {s.upNext
                ? s.solvedCount === 0
                  ? "Resolva desafios em JavaScript, ganhe XP e conquiste medalhas."
                  : "Continue de onde você parou."
                : s.published.length > 0
                  ? "Você concluiu todos os exercícios publicados. Parabéns!"
                  : "Ainda não há exercícios publicados."}
            </p>
            {s.upNext && (
              <>
                {nextLesson && (
                  <p className="mt-3 text-sm text-zinc-600 dark:text-zinc-400">
                    Próxima lição: <strong>{nextLesson.title}</strong>
                  </p>
                )}
                <Link
                  href={`/exercicio/${s.upNext.id}`}
                  className={`mt-3 ${primaryButton}`}
                >
                  {s.solvedCount === 0 ? "Começar" : "Continuar"}:{" "}
                  {s.upNext.title}
                  <span aria-hidden>→</span>
                </Link>
              </>
            )}
          </div>

          <div className="grid min-w-56 flex-1 basis-56 gap-4">
            <div>
              <div className="flex items-baseline justify-between">
                <span className="text-sm text-zinc-600 dark:text-zinc-400">
                  Nível {level}
                </span>
                <span className="text-sm font-medium">
                  {xp - floor}/{next - floor} XP
                </span>
              </div>
              <div className="mt-1.5">
                <ProgressBar value={levelPct} label="Progresso do nível" />
              </div>
            </div>
            <div>
              <div className="flex items-baseline justify-between">
                <span className="text-sm text-zinc-600 dark:text-zinc-400">
                  Exercícios resolvidos
                </span>
                <span className="text-sm font-medium">
                  {s.solvedCount}/{s.published.length}
                </span>
              </div>
              <div className="mt-1.5">
                <ProgressBar
                  value={s.solvedCount / total}
                  label="Progresso geral"
                />
              </div>
            </div>
            {streak.available && (
              <p className="text-sm text-zinc-600 dark:text-zinc-400">
                <span aria-hidden>🔥 </span>
                <strong className="text-foreground">{streak.current}</strong>{" "}
                {streak.current === 1 ? "dia seguido" : "dias seguidos"}
                {streak.activeToday
                  ? " · você já praticou hoje"
                  : " · pratique hoje para manter"}
              </p>
            )}
          </div>
        </div>
      </section>

      {profile?.role === "aluno" && pendingList.length > 0 && (
        <section aria-labelledby="pendentes">
          <div className="mb-3 flex items-baseline justify-between">
            <h2 id="pendentes" className="text-lg font-semibold">
              Atividades pendentes
            </h2>
            <Link
              href="/atividades"
              className="text-sm text-emerald-700 hover:underline dark:text-emerald-400"
            >
              Ver todas
            </Link>
          </div>
          <ul className="space-y-3">
            {pendingList.map((a) => (
              <AssignmentRow key={a.id} a={a} />
            ))}
          </ul>
        </section>
      )}

      <Missions />

      <section aria-labelledby="meus-mundos">
        <div className="mb-3 flex items-baseline justify-between">
          <h2 id="meus-mundos" className="text-lg font-semibold">
            Seus mundos
          </h2>
          <Link
            href="/mundos"
            className="text-sm text-emerald-700 hover:underline dark:text-emerald-400"
          >
            Ver todos os mundos
          </Link>
        </div>
        {visibleWorlds.length === 0 ? (
          <p className="text-sm text-zinc-600 dark:text-zinc-400">
            Os mundos aparecem aqui quando o professor publicar o conteúdo.
          </p>
        ) : (
          <ul className="grid gap-3 sm:grid-cols-2">
            {visibleWorlds.map((w) => (
              <li key={w.world.id} className={`${card} p-4`}>
                <div className="flex items-baseline justify-between gap-2">
                  <Link
                    href={`/mundos/${w.world.id}`}
                    className="font-medium hover:underline"
                  >
                    {w.world.title}
                  </Link>
                  <Pill tone={w.status === "concluido" ? "green" : "neutral"}>
                    {WORLD_STATUS_LABEL[w.status]}
                  </Pill>
                </div>
                <div className="mt-2">
                  <ProgressBar
                    value={w.total ? w.done / w.total : 0}
                    label={`Progresso em ${w.world.title}`}
                  />
                </div>
                <p className="mt-1 text-xs text-zinc-600 dark:text-zinc-400">
                  {w.done}/{w.total} exercícios
                </p>
              </li>
            ))}
          </ul>
        )}
      </section>

      <section aria-labelledby="recentes">
        <div className="mb-3 flex items-baseline justify-between">
          <h2 id="recentes" className="text-lg font-semibold">
            Conquistas recentes
          </h2>
          <Link
            href="/conquistas"
            className="text-sm text-emerald-700 hover:underline dark:text-emerald-400"
          >
            {earned.length}/{badgesFor(s.catalog).length} conquistadas
          </Link>
        </div>
        {recent.length === 0 ? (
          <p className="text-sm text-zinc-600 dark:text-zinc-400">
            Resolva seu primeiro exercício para ganhar uma medalha.
          </p>
        ) : (
          <ul className="grid gap-3 sm:grid-cols-3">
            {recent.map((b) => (
              <li
                key={b.id}
                className="rounded-2xl border border-emerald-300 bg-emerald-50 p-4 dark:border-emerald-800 dark:bg-emerald-950"
              >
                <div className="font-medium">
                  <span aria-hidden>🏅 </span>
                  {b.name}
                </div>
                <div className="text-sm text-zinc-600 dark:text-zinc-400">
                  {b.description}
                </div>
              </li>
            ))}
          </ul>
        )}
      </section>
    </div>
  );
}

export default function Dashboard() {
  return (
    <CatalogGate>
      <DashboardContent />
    </CatalogGate>
  );
}
