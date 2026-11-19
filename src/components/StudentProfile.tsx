"use client";

import { useCallback, useMemo, useState } from "react";
import { LEVEL_LABEL } from "@/lib/concept-analytics";
import { CATEGORY_LABEL, MODE_LABEL, NO_FILTERS, loadConceptReport } from "@/lib/concept-report";
import { loadClassData } from "@/lib/classes";
import { getSupabase } from "@/lib/supabase";
import type { Progress } from "@/lib/gamification";
import { moduleStates } from "@/lib/learning";
import { MIN_ATTEMPTS, MIN_EXERCISES } from "@/lib/concept-analytics";
import {
  WORLD_STATUS_LABEL,
  conceptPerformance,
  worldSummaries,
} from "@/lib/student";
import { useLoader } from "@/lib/use-loader";
import { usePageTitle } from "@/lib/use-page-title";
import { CatalogGate, useCatalog } from "./CatalogProvider";
import { BackLink, Pill, ProgressBar, card } from "./ui";

interface AttemptDetail {
  id: number;
  exercise_id: string;
  passed: boolean;
  answer: string | null;
  error_category: string | null;
  misconception: string | null;
  mode: keyof typeof MODE_LABEL;
  created_at: string;
}

/** Exercícios, respostas dadas e evolução do aluno em um conceito. */
function ConceptDetail({ studentId, conceptId }: { studentId: string; conceptId: string }) {
  const { catalog } = useCatalog();
  const ids = useMemo(
    () => (catalog.links ?? []).filter((l) => l.conceptId === conceptId).map((l) => l.exerciseId),
    [catalog, conceptId],
  );
  const load = useCallback(async () => {
    const { data, error } = await getSupabase()
      .from("attempts")
      .select("id, exercise_id, passed, answer, error_category, misconception, mode, created_at")
      .eq("user_id", studentId)
      .in("exercise_id", ids)
      .order("created_at");
    if (error) throw new Error("Não foi possível carregar as respostas.");
    return data as AttemptDetail[];
  }, [studentId, ids]);
  const { data, error } = useLoader(`concept-detail:${studentId}:${conceptId}`, load);
  if (error) return <p role="alert" className="text-sm text-red-700 dark:text-red-300">{error}</p>;
  if (!data) return <p role="status" className="text-sm">Carregando...</p>;
  const title = (id: string) => catalog.exercises.find((e) => e.id === id)?.title ?? id;
  return (
    <div className="mt-3 space-y-3 text-sm">
      <p aria-label="Evolução" className="flex flex-wrap items-center gap-1">
        <span className="mr-2 text-zinc-600 dark:text-zinc-400">Evolução:</span>
        {data.map((a) => (
          <span
            key={a.id}
            role="img"
            aria-label={a.passed ? "acertou" : "errou"}
            className={`flex h-6 w-6 items-center justify-center rounded-full text-xs ${a.passed ? "bg-emerald-600 text-white" : "bg-zinc-200 text-zinc-800 dark:bg-zinc-700 dark:text-zinc-100"}`}
          >
            {a.passed ? "✓" : "✗"}
          </span>
        ))}
      </p>
      <ol className="space-y-2">
        {data.map((a) => (
          <li key={a.id} className="rounded-xl border border-zinc-200 p-3 dark:border-zinc-800">
            <div className="flex flex-wrap items-baseline justify-between gap-2">
              <span className="font-medium">{title(a.exercise_id)}</span>
              <span className="text-xs text-zinc-600 dark:text-zinc-400">
                {new Date(a.created_at).toLocaleString("pt-BR", { dateStyle: "short", timeStyle: "short" })} · {MODE_LABEL[a.mode]}
              </span>
            </div>
            <div className="mt-1">
              {a.passed ? "Acertou" : `Errou${a.error_category ? `: ${CATEGORY_LABEL[a.error_category] ?? a.error_category}` : ""}`}
              {a.misconception && <span className="text-zinc-600 dark:text-zinc-400"> · {a.misconception}</span>}
            </div>
            {a.answer && (
              <pre className="mt-2 max-h-40 overflow-auto whitespace-pre-wrap rounded-lg bg-zinc-100 p-2 font-mono text-xs dark:bg-zinc-800">{a.answer}</pre>
            )}
          </li>
        ))}
      </ol>
    </div>
  );
}

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
  const loadReport = useCallback(() => loadConceptReport(classId, NO_FILTERS), [classId]);
  const { data: report } = useLoader(`student-report:${classId}`, loadReport);
  const [open, setOpen] = useState<string | null>(null);
  const mine = useMemo(
    () => (report?.student_concepts ?? []).filter((s) => s.student_id === studentId),
    [report, studentId],
  );
  const conceptTitle = (id: string) => catalog.concepts?.find((c) => c.id === id)?.title ?? id;

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
          Só se afirma algo com {MIN_ATTEMPTS} tentativas em pelo menos {MIN_EXERCISES} exercícios do conceito, e as
          tentativas mais recentes pesam mais. Descreve o conceito neste momento, não a pessoa.
        </p>
        {mine.length > 0 ? (
          <ul className="space-y-3">
            {mine.map((c) => (
              <li key={c.concept_id} className={`${card} p-4 text-sm`}>
                <div className="flex flex-wrap items-start justify-between gap-2">
                  <span className="font-medium">{conceptTitle(c.concept_id)}</span>
                  <Pill tone={c.level === "bom" ? "green" : c.level === "dificuldade" ? "amber" : "neutral"}>
                    {LEVEL_LABEL[c.level]}
                  </Pill>
                </div>
                <div className="mt-1 text-zinc-600 dark:text-zinc-400">
                  {c.attempts} {c.attempts === 1 ? "tentativa" : "tentativas"} em {c.exercises}{" "}
                  {c.exercises === 1 ? "exercício" : "exercícios"}
                  {c.level === "nao_avaliado" &&
                    ` · faltam ${Math.max(0, MIN_ATTEMPTS - c.attempts)} tentativas e ${Math.max(0, MIN_EXERCISES - c.exercises)} exercícios para uma conclusão`}
                </div>
                <button
                  type="button"
                  aria-expanded={open === c.concept_id}
                  onClick={() => setOpen(open === c.concept_id ? null : c.concept_id)}
                  className="mt-2 text-emerald-700 underline dark:text-emerald-400"
                >
                  {open === c.concept_id ? "Ocultar respostas" : "Ver exercícios e respostas"}
                </button>
                {open === c.concept_id && <ConceptDetail studentId={studentId} conceptId={c.concept_id} />}
              </li>
            ))}
          </ul>
        ) : concepts.length === 0 ? (
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
