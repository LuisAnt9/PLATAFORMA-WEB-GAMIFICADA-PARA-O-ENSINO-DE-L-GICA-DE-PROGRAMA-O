"use client";

import Link from "next/link";
import { useState } from "react";
import { getStreak, logActivity } from "@/lib/activity-store";
import { nextExercise as findNext, type Exercise } from "@/lib/catalog";
import { earnedBadges, recordAttempt, totalXp } from "@/lib/gamification";
import {
  blankView,
  choiceView,
  gradeBlanks,
  gradeChoice,
  type BlankResult,
} from "@/lib/grading";
import { getProgress, saveExercise, useProgress } from "@/lib/progress-store";
import { runExercise, type RunResult } from "@/lib/runner";
import { useAuth } from "./AuthProvider";
import BlankBody from "./BlankBody";
import { useCatalog } from "./CatalogProvider";
import ChoiceBody from "./ChoiceBody";
import CodeEditor from "./CodeEditor";

const show = (v: unknown) =>
  v === undefined ? "undefined" : JSON.stringify(v);

export default function ExerciseView({ exercise }: { exercise: Exercise }) {
  const progress = useProgress();
  const { profile } = useAuth();
  const { catalog } = useCatalog();

  const [busy, setBusy] = useState(false);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [gain, setGain] = useState<{ xp: number; badges: string[] } | null>(
    null,
  );
  const [showHint, setShowHint] = useState(false);
  // por tipo de exercício
  const [code, setCode] = useState(exercise.starterCode);
  const [codeResult, setCodeResult] = useState<RunResult | null>(null);
  const [selected, setSelected] = useState<number | null>(null);
  const [choiceResult, setChoiceResult] = useState<boolean | null>(null);
  const [answers, setAnswers] = useState<string[]>([]);
  const [blankResult, setBlankResult] = useState<BlankResult | null>(null);

  const solved = progress[exercise.id]?.solved;
  const nextExercise = findNext(catalog, exercise.id);
  const choice =
    exercise.kind === "choice" ? choiceView(exercise.config) : null;
  const blank = exercise.kind === "blank" ? blankView(exercise.config) : null;
  const broken =
    (exercise.kind === "choice" && !choice) ||
    (exercise.kind === "blank" && !blank);
  const passedNow =
    codeResult?.passed || choiceResult === true || blankResult?.passed === true;

  /** Fluxo comum a todos os tipos: registra a tentativa, o XP, a sequência e as medalhas novas. */
  async function finish(passed: boolean) {
    const before = getProgress();
    const after = recordAttempt(before, exercise, passed);
    setSaveError(null);
    setGain(null);
    if (after === before || !profile) return;

    try {
      await saveExercise(profile.id, exercise.id, after[exercise.id]);
    } catch {
      setSaveError(
        "Não foi possível salvar seu progresso. Verifique a conexão e tente de novo.",
      );
      return;
    }
    const bestBefore = getStreak().best;
    void logActivity(passed); // atualiza a sequência na hora; falha de rede não atrapalha
    const bestAfter = getStreak().best;

    const had = new Set(
      earnedBadges({ progress: before, catalog, bestStreak: bestBefore }).map(
        (b) => b.id,
      ),
    );
    const newBadges = earnedBadges({
      progress: after,
      catalog,
      bestStreak: bestAfter,
    })
      .filter((b) => !had.has(b.id))
      .map((b) => b.name);
    const xp = totalXp(after) - totalXp(before);
    if (xp > 0 || newBadges.length > 0) setGain({ xp, badges: newBadges });
  }

  async function submitCode() {
    setBusy(true);
    const res = await runExercise(exercise, code);
    setCodeResult(res);
    setBusy(false);
    await finish(res.passed);
  }

  async function submitChoice() {
    const passed = gradeChoice(exercise.config, selected);
    setChoiceResult(passed);
    setBusy(true);
    await finish(passed);
    setBusy(false);
  }

  async function submitBlanks() {
    const res = gradeBlanks(exercise.config, answers);
    setBlankResult(res);
    setBusy(true);
    await finish(res.passed);
    setBusy(false);
  }

  return (
    <div className="space-y-4">
      <Link href="/" className="text-sm text-zinc-500 hover:underline">
        ← Voltar à trilha
      </Link>
      <h1 className="text-2xl font-semibold">
        {exercise.title} {solved && "✅"}
      </h1>

      {exercise.lesson && (
        <aside
          aria-label="Antes de começar"
          className="rounded-lg border-l-4 border-emerald-500 bg-emerald-50 p-4 text-sm dark:bg-emerald-950"
        >
          <div className="mb-1 font-medium">Antes de começar</div>
          <p className="whitespace-pre-line">{exercise.lesson}</p>
        </aside>
      )}

      <p className="whitespace-pre-line">{exercise.statement}</p>

      {broken && (
        <p
          role="alert"
          className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
        >
          Este exercício está com um problema de configuração. Avise o
          professor.
        </p>
      )}

      {exercise.kind === "code" && (
        <>
          <CodeEditor value={code} onChange={setCode} onRun={submitCode} />
          <div className="flex gap-2">
            <button
              onClick={submitCode}
              disabled={busy}
              className="rounded-lg bg-emerald-600 px-4 py-2 font-medium text-white hover:bg-emerald-700 disabled:opacity-50"
            >
              {busy ? "Executando..." : "Executar testes (Ctrl+Enter)"}
            </button>
            <HintButton onClick={() => setShowHint((v) => !v)} />
          </div>
        </>
      )}

      {choice && (
        <>
          <ChoiceBody
            view={choice}
            selected={selected}
            result={choiceResult}
            disabled={busy}
            onSelect={(i) => {
              setSelected(i);
              setChoiceResult(null);
            }}
            onSubmit={() => void submitChoice()}
          />
          <HintButton onClick={() => setShowHint((v) => !v)} />
        </>
      )}

      {blank && (
        <>
          <BlankBody
            view={blank}
            answers={answers}
            result={blankResult}
            disabled={busy}
            onChange={(i, v) => {
              setAnswers((a) => {
                const next = [...a];
                next[i] = v;
                return next;
              });
              setBlankResult(null);
            }}
            onSubmit={() => void submitBlanks()}
          />
          <HintButton onClick={() => setShowHint((v) => !v)} />
        </>
      )}

      {showHint && exercise.hint && (
        <p className="rounded-lg bg-amber-50 p-3 text-sm dark:bg-amber-950">
          💡 {exercise.hint}
        </p>
      )}

      <div aria-live="polite" className="space-y-2">
        {codeResult &&
          (codeResult.fatal ? (
            <p className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">
              {codeResult.fatal}
            </p>
          ) : (
            <>
              <p className="font-medium">
                {codeResult.passed
                  ? "🎉 Todos os testes passaram!"
                  : `${codeResult.tests.filter((t) => t.passed).length}/${codeResult.tests.length} testes passaram. Errar faz parte — veja o que falhou:`}
              </p>
              <ul className="space-y-1 text-sm">
                {codeResult.tests.map((t, i) => (
                  <li
                    key={i}
                    className={`rounded p-2 font-mono ${t.passed ? "bg-emerald-50 dark:bg-emerald-950" : "bg-red-50 dark:bg-red-950"}`}
                  >
                    {t.passed ? "✓" : "✗"} {exercise.functionName}(
                    {t.args.map(show).join(", ")})
                    {!t.passed &&
                      (t.error
                        ? ` → erro: ${t.error}`
                        : ` → esperado ${show(t.expected)}, recebido ${show(t.received)}`)}
                  </li>
                ))}
              </ul>
            </>
          ))}

        {choiceResult !== null && (
          <p className="font-medium">
            {choiceResult
              ? "🎉 Correto!"
              : "Ainda não. Errar faz parte — releia o enunciado e tente outra alternativa."}
          </p>
        )}
        {blankResult && blankResult.passed && (
          <p className="font-medium">🎉 Tudo certo!</p>
        )}

        {(choiceResult === true || blankResult?.passed) &&
          exercise.config.explanation && (
            <p className="rounded-lg bg-zinc-100 p-3 text-sm dark:bg-zinc-900">
              {exercise.config.explanation}
            </p>
          )}

        {saveError && (
          <p
            role="alert"
            className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
          >
            {saveError}
          </p>
        )}
        {gain && (
          <p className="rounded-lg bg-emerald-100 p-3 text-sm dark:bg-emerald-900">
            {gain.xp > 0 && `+${gain.xp} XP`}
            {gain.xp > 0 && gain.badges.length > 0 && " · "}
            {gain.badges.length > 0 &&
              `🏅 Nova medalha: ${gain.badges.join(", ")}`}
          </p>
        )}
        {passedNow && nextExercise && (
          <Link
            href={`/exercicio/${nextExercise.id}`}
            className="inline-block text-emerald-700 hover:underline dark:text-emerald-400"
          >
            Próximo: {nextExercise.title} →
          </Link>
        )}
      </div>
    </div>
  );
}

function HintButton({ onClick }: { onClick: () => void }) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="rounded-lg border border-zinc-300 px-4 py-2 dark:border-zinc-700"
    >
      Dica
    </button>
  );
}
