"use client";

import Link from "next/link";
import CodeEditor from "./CodeEditor";
import { useState } from "react";
import { exercises, type Exercise } from "@/lib/exercises";
import { earnedBadges, recordAttempt, totalXp } from "@/lib/gamification";
import { getProgress, saveProgress, useProgress } from "@/lib/progress-store";
import { runExercise, type RunResult } from "@/lib/runner";

const show = (v: unknown) => (v === undefined ? "undefined" : JSON.stringify(v));

export default function ExerciseView({ exercise }: { exercise: Exercise }) {
  const progress = useProgress();
  const [code, setCode] = useState(exercise.starterCode);
  const [result, setResult] = useState<RunResult | null>(null);
  const [running, setRunning] = useState(false);
  const [gain, setGain] = useState<{ xp: number; badges: string[] } | null>(null);
  const [showHint, setShowHint] = useState(false);

  const solved = progress[exercise.id]?.solved;
  const nextExercise = exercises[exercises.findIndex((e) => e.id === exercise.id) + 1];

  async function submit() {
    setRunning(true);
    setGain(null);
    const res = await runExercise(exercise, code);
    setResult(res);
    setRunning(false);

    const before = getProgress();
    const after = recordAttempt(before, exercise.id, res.passed);
    if (after !== before) saveProgress(after);
    if (res.passed && !before[exercise.id]?.solved) {
      const had = new Set(earnedBadges(before).map((b) => b.id));
      setGain({
        xp: totalXp(after) - totalXp(before),
        badges: earnedBadges(after).filter((b) => !had.has(b.id)).map((b) => b.name),
      });
    }
  }

  return (
    <div className="space-y-4">
      <Link href="/" className="text-sm text-zinc-500 hover:underline">
        ← Voltar à trilha
      </Link>
      <h1 className="text-2xl font-semibold">
        {exercise.title} {solved && "✅"}
      </h1>
      <p>{exercise.statement}</p>

      <CodeEditor value={code} onChange={setCode} onRun={submit} />

      <div className="flex gap-2">
        <button
          onClick={submit}
          disabled={running}
          className="rounded-lg bg-emerald-600 px-4 py-2 font-medium text-white hover:bg-emerald-700 disabled:opacity-50"
        >
          {running ? "Executando..." : "Executar testes (Ctrl+Enter)"}
        </button>
        <button
          onClick={() => setShowHint((v) => !v)}
          className="rounded-lg border border-zinc-300 px-4 py-2 dark:border-zinc-700"
        >
          Dica
        </button>
      </div>

      {showHint && (
        <p className="rounded-lg bg-amber-50 p-3 text-sm dark:bg-amber-950">💡 {exercise.hint}</p>
      )}

      {result && (
        <div aria-live="polite" className="space-y-2">
          {result.fatal ? (
            <p className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">
              {result.fatal}
            </p>
          ) : (
            <>
              <p className="font-medium">
                {result.passed
                  ? "🎉 Todos os testes passaram!"
                  : `${result.tests.filter((t) => t.passed).length}/${result.tests.length} testes passaram. Errar faz parte — veja o que falhou:`}
              </p>
              <ul className="space-y-1 text-sm">
                {result.tests.map((t, i) => (
                  <li
                    key={i}
                    className={`rounded p-2 font-mono ${
                      t.passed ? "bg-emerald-50 dark:bg-emerald-950" : "bg-red-50 dark:bg-red-950"
                    }`}
                  >
                    {t.passed ? "✓" : "✗"} {exercise.functionName}({t.args.map(show).join(", ")})
                    {!t.passed &&
                      (t.error
                        ? ` → erro: ${t.error}`
                        : ` → esperado ${show(t.expected)}, recebido ${show(t.received)}`)}
                  </li>
                ))}
              </ul>
            </>
          )}
          {gain && (
            <p className="rounded-lg bg-emerald-100 p-3 text-sm dark:bg-emerald-900">
              +{gain.xp} XP{gain.badges.length > 0 && ` · 🏅 Nova medalha: ${gain.badges.join(", ")}`}
            </p>
          )}
          {result.passed && nextExercise && (
            <Link href={`/exercicio/${nextExercise.id}`} className="inline-block text-emerald-700 hover:underline">
              Próximo: {nextExercise.title} →
            </Link>
          )}
        </div>
      )}
    </div>
  );
}
