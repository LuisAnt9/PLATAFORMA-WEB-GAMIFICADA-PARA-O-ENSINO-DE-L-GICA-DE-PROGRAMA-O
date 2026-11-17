"use client";

import { useCallback, useMemo } from "react";
import { loadClassData } from "@/lib/classes";
import type { Progress } from "@/lib/gamification";
import { moduleStates } from "@/lib/learning";
import {
  MIN_ATTEMPTS,
  MIN_EXERCISES,
  WORLD_STATUS_LABEL,
  conceptPerformance,
  worldSummaries,
} from "@/lib/student";
import { useLoader } from "@/lib/use-loader";
import { usePageTitle } from "@/lib/use-page-title";
import { CatalogGate, useCatalog } from "./CatalogProvider";
import { BackLink, Pill, ProgressBar, card } from "./ui";

function Content({ classId, studentId }: { classId: string; studentId: string }) {
  const { catalog } = useCatalog();
  const load = useCallback(() => loadClassData(classId), [classId]);
  const { data, error } = useLoader(`student-profile:${classId}`, load);
  const member = data?.members.find((m) => m.id === studentId);
  usePageTitle(member?.name ?? "Aluno");

  const progress = useMemo<Progress>(() => {
    const out: Progress = {};
    for (const p of data?.progress ?? [])
      if (p.user_id === studentId)
        out[p.exercise_id] = {
          attempts: p.attempts,
          solved: p.solved,
          firstTry: p.first_try,
          xp: p.xp,
        };
    return out;
  }, [data, studentId]);
  const states = useMemo(() => moduleStates(catalog, progress), [catalog, progress]);
  const worlds = useMemo(() => worldSummaries(catalog, progress, states, false), [catalog, progress, states]);
  const concepts = useMemo(() => conceptPerformance(catalog, progress), [catalog, progress]);

  if (error)
    return <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">{error}</p>;
  if (!data) return <p role="status">Carregando...</p>;
  if (!member)
    return (
      <div className="space-y-3">
        <p>Aluno não encontrado nesta turma.</p>
        <BackLink href={`/professor/turmas/${classId}`}>Turma</BackLink>
      </div>
    );
  const entries = Object.values(progress);
  const solved = entries.filter((e) => e.solved).length;
  const attempts = entries.reduce((n, e) => n + e.attempts, 0);
  const xp = entries.reduce((n, e) => n + (e.solved ? e.xp : 0), 0);

  return (
    <div className="space-y-8">
      <BackLink href={`/professor/turmas/${classId}`}>Turma</BackLink>
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">{member.name}</h1>
        <p className="mt-1 text-sm text-zinc-600 dark:text-zinc-400">
          Visão do professor. Descreve o que o aluno já praticou, sem rotular a pessoa.
        </p>
      </header>
      <section aria-label="Resumo" className="grid gap-3 sm:grid-cols-3">
        {[
          [String(solved), "exercícios resolvidos"],
          [String(attempts), "tentativas"],
          [String(xp), "XP em exercícios"],
        ].map(([v, l]) => (
          <div key={l} className={`${card} p-4`}>
            <div className="text-2xl font-semibold">{v}</div>
            <div className="text-xs text-zinc-600 dark:text-zinc-400">{l}</div>
          </div>
        ))}
      </section>
      <section aria-labelledby="mundos">
        <h2 id="mundos" className="mb-3 text-lg font-semibold">Mundos</h2>
        <ul className="space-y-3">
          {worlds.filter((w) => w.status !== "em-breve").map((w) => (
            <li key={w.world.id}>
              <div className="flex justify-between gap-2 text-sm">
                <span>{w.world.title}</span>
                <span className="text-zinc-600 dark:text-zinc-400">
                  {WORLD_STATUS_LABEL[w.status]} · {w.done}/{w.total}
                </span>
              </div>
              <div className="mt-1">
                <ProgressBar value={w.total ? w.done / w.total : 0} label={`Progresso em ${w.world.title}`} />
              </div>
            </li>
          ))}
        </ul>
      </section>
      <section aria-labelledby="conceitos">
        <h2 id="conceitos" className="mb-1 text-lg font-semibold">Desempenho por conceito</h2>
        <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
          Só se afirma algo com {MIN_ATTEMPTS} tentativas em pelo menos {MIN_EXERCISES} exercícios do conceito.
        </p>
        {concepts.length === 0 ? (
          <p className="text-sm text-zinc-600 dark:text-zinc-400">O aluno ainda não praticou conceitos.</p>
        ) : (
          <ul className="grid gap-3 sm:grid-cols-2">
            {concepts.map((c) => (
              <li key={c.conceptId} className={`${card} p-4 text-sm`}>
                <div className="flex items-start justify-between gap-2">
                  <span className="font-medium">{c.title}</span>
                  <Pill tone={c.level === "em-bom-caminho" ? "green" : c.level === "praticar" ? "amber" : "neutral"}>
                    {c.level === "insuficiente" ? "Dados insuficientes" : c.level === "praticar" ? "Vale praticar mais" : "Em bom caminho"}
                  </Pill>
                </div>
                <div className="mt-1 text-zinc-600 dark:text-zinc-400">
                  {c.exercisesSolved} de {c.exercisesTried} exercícios resolvidos · {c.attempts} tentativas
                </div>
              </li>
            ))}
          </ul>
        )}
      </section>
    </div>
  );
}

export default function StudentProfile({ classId, studentId }: { classId: string; studentId: string }) {
  return (
    <CatalogGate>
      <Content classId={classId} studentId={studentId} />
    </CatalogGate>
  );
}
