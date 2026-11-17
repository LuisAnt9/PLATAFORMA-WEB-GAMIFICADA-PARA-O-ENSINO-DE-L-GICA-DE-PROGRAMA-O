"use client";

import { stepOfExercise } from "@/lib/student";
import type { HintContext } from "@/lib/ai-hint";
import { usePageTitle } from "@/lib/use-page-title";
import Link from "next/link";
import { useSearchParams } from "next/navigation";
import { useRef, useState } from "react";
import { getStreak, logActivity } from "@/lib/activity-store";
import { saveAttempt, type Submission } from "@/lib/attempts";
import {
  DIFFICULTY_LABEL,
  KIND_LABEL,
  XP_WORLD_BONUS,
  baseXp,
  isChoiceKind,
  isCodeKind,
  nextExercise as findNext,
  type Exercise,
} from "@/lib/catalog";
import { earnedBadges, recordAttempt, totalXp } from "@/lib/gamification";
import { getGamification, syncGamification } from "@/lib/gamification-store";
import {
  blankView,
  choiceView,
  gradeBlanks,
  gradeChoice,
  gradeOrder,
  interpretationCode,
  orderView,
  shuffledOrder,
  type BlankResult,
} from "@/lib/grading";
import { getProgress, saveExercise, useProgress } from "@/lib/progress-store";
import { runExercise, type RunResult } from "@/lib/runner";
import { useAuth } from "./AuthProvider";
import BlankBody from "./BlankBody";
import { useCatalog } from "./CatalogProvider";
import ChoiceBody from "./ChoiceBody";
import CodeEditor from "./CodeEditor";
import HintPanel from "./HintPanel";
import OrderBody, { type OrderResult } from "./OrderBody";
import SolutionPanel from "./SolutionPanel";
import TestList from "./TestList";

const show = (v: unknown) =>
  v === undefined ? "undefined" : JSON.stringify(v);

export default function ExerciseView({ exercise }: { exercise: Exercise }) {
  usePageTitle(exercise.title);
  const progress = useProgress();
  const { profile } = useAuth();
  // vindo de "Minhas atividades": as tentativas valem para a atividade (modalidade atividade)
  const rawAtividade = Number(useSearchParams().get("atividade"));
  const assignmentId =
    Number.isInteger(rawAtividade) && rawAtividade > 0 ? rawAtividade : null;
  const { catalog } = useCatalog();

  const [busy, setBusy] = useState(false);
  // início da tela e da última tentativa, para medir quanto tempo cada tentativa levou
  const [openedAt] = useState(() => Date.now());
  const lastAttemptAt = useRef<number | null>(null);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [gain, setGain] = useState<{ xp: number; badges: string[]; extras: string[] } | null>(
    null,
  );
  // maior nível de dica aberto (0 a 3), gravado junto das tentativas
  const [hintLevel, setHintLevel] = useState(0);
  // por tipo de exercício
  const [code, setCode] = useState(exercise.starterCode);
  const [codeResult, setCodeResult] = useState<RunResult | null>(null);
  const [selected, setSelected] = useState<number | null>(null);
  const [choiceResult, setChoiceResult] = useState<boolean | null>(null);
  const [answers, setAnswers] = useState<string[]>([]);
  const [blankResult, setBlankResult] = useState<BlankResult | null>(null);
  const orderV = exercise.kind === "order" ? orderView(exercise.config) : null;
  const [order, setOrder] = useState<string[]>(() =>
    orderV ? shuffledOrder(orderV.items, exercise.id) : [],
  );
  const [orderResult, setOrderResult] = useState<OrderResult | null>(null);

  const solved = progress[exercise.id]?.solved;
  const nextExercise = findNext(catalog, exercise.id);
  const codeLike = isCodeKind(exercise.kind);
  const choice = isChoiceKind(exercise.kind)
    ? choiceView(exercise.config)
    : null;
  const snippet =
    exercise.kind === "interpretation"
      ? interpretationCode(exercise.config)
      : null;
  const blank = exercise.kind === "blank" ? blankView(exercise.config) : null;
  const broken =
    (isChoiceKind(exercise.kind) && !choice) ||
    (exercise.kind === "interpretation" && !snippet) ||
    (exercise.kind === "blank" && !blank) ||
    (exercise.kind === "order" && !orderV);
  const passedNow =
    codeResult?.passed ||
    choiceResult === true ||
    blankResult?.passed === true ||
    orderResult?.passed === true;

  /** Registra a tentativa para a análise pedagógica (não bloqueia nem altera XP, medalhas ou sequência). */
  function logAttempt(submission: Submission, passed: boolean) {
    const now = Date.now();
    const durationMs = now - (lastAttemptAt.current ?? openedAt);
    lastAttemptAt.current = now;
    void saveAttempt({
      exercise,
      submission,
      passed,
      durationMs,
      hintLevel,
      ...(assignmentId
        ? { mode: "atividade" as const, assignmentId }
        : {}),
    });
  }

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
    const saved = getProgress(); // com o XP que o banco calculou
    const g0 = getGamification();
    // missões e bônus de mundo são conferidos e concedidos pelo banco
    const sync = passed ? await syncGamification() : { newWorlds: [] };
    const g1 = getGamification();

    const had = new Set(
      earnedBadges({
        progress: before,
        catalog,
        bestStreak: bestBefore,
        worldsDone: g0.worldsDone,
      }).map((b) => b.id),
    );
    const newBadges = earnedBadges({
      progress: saved,
      catalog,
      bestStreak: bestAfter,
      worldsDone: g1.worldsDone,
    })
      .filter((b) => !had.has(b.id))
      .map((b) => b.name);
    const extras = [
      ...g1.missions
        .filter(
          (m) => m.claimed && !g0.missions.find((x) => x.id === m.id)?.claimed,
        )
        .map((m) => `Missão cumprida: ${m.title} (+${m.xp} XP)`),
      ...sync.newWorlds.map(
        (w) =>
          `Mundo concluído: ${catalog.worlds?.find((x) => x.id === w)?.title ?? w} (+${XP_WORLD_BONUS} XP)`,
      ),
    ];
    const xp = totalXp(saved) - totalXp(before);
    if (xp > 0 || newBadges.length > 0 || extras.length > 0)
      setGain({ xp, badges: newBadges, extras });
  }

  async function submitCode() {
    setBusy(true);
    const res = await runExercise(exercise, code);
    logAttempt({ kind: "code", code, result: res }, res.passed);
    setCodeResult(res);
    setBusy(false);
    await finish(res.passed);
  }

  async function submitChoice() {
    const passed = gradeChoice(exercise.config, selected);
    if (selected !== null) logAttempt({ kind: "choice", selected }, passed);
    setChoiceResult(passed);
    setBusy(true);
    await finish(passed);
    setBusy(false);
  }

  async function submitBlanks() {
    const res = gradeBlanks(exercise.config, answers);
    logAttempt({ kind: "blank", answers, result: res }, res.passed);
    setBlankResult(res);
    setBusy(true);
    await finish(res.passed);
    setBusy(false);
  }

  async function submitOrder() {
    if (!orderV) return;
    const passed = gradeOrder(exercise.config, order);
    const inPlace = order.filter((t, i) => t === orderV.items[i]).length;
    logAttempt({ kind: "order", arrangement: order, inPlace }, passed);
    setOrderResult({ passed, inPlace });
    setBusy(true);
    await finish(passed);
    setBusy(false);
  }

  /** O que o aluno tem na tela agora, para a dica com IA. */
  function hintContext(): HintContext {
    if (codeLike) {
      const failed = codeResult?.fatal
        ? codeResult.fatal
        : (codeResult?.tests ?? [])
            .filter((t) => !t.passed)
            .map(
              (t) =>
                `${exercise.functionName}(${t.args.map(show).join(", ")}) → ` +
                (t.error
                  ? `erro: ${t.error}`
                  : t.expectedOutput
                    ? `saída esperada ${show(t.expectedOutput)}, obtida ${show(t.receivedOutput ?? [])}`
                    : `esperado ${show(t.expected)}, recebido ${show(t.received)}`),
            )
            .join("\n");
      return { code, attempt: failed || undefined };
    }
    if (exercise.kind === "order") {
      return {
        attempt: orderResult
          ? `Tentou uma ordem; ${orderResult.inPlace} de ${order.length} passos na posição certa.`
          : undefined,
      };
    }
    if (isChoiceKind(exercise.kind)) {
      const opt = selected === null ? undefined : choice?.options[selected];
      return {
        attempt: opt
          ? `Marcou: ${opt} (${choiceResult === false ? "errada" : "ainda não conferida"})`
          : undefined,
      };
    }
    const filled = answers.filter(Boolean);
    return {
      attempt: filled.length
        ? `Lacunas preenchidas: ${answers.map((a, i) => `${i + 1}=${a || "(vazia)"}`).join(", ")}`
        : undefined,
    };
  }

  return (
    <div className="space-y-4">
      <Link
        href={
          assignmentId
            ? `/atividades/${assignmentId}`
            : `/licao/${exercise.moduleId}?passo=${stepOfExercise(exercise)}`
        }
        className="inline-flex items-center gap-1 rounded-lg px-2 py-1 text-sm text-zinc-600 hover:bg-zinc-100 dark:text-zinc-400 dark:hover:bg-zinc-800"
      >
        <span aria-hidden>←</span>{" "}
        {assignmentId ? "Voltar à atividade" : "Voltar à lição"}
      </Link>

      <div>
        <h1 className="text-2xl font-semibold tracking-tight">
          {exercise.title}
          {solved && (
            <span role="img" aria-label="Resolvido">
              {" "}
              ✅
            </span>
          )}
        </h1>
        <div className="mt-2 flex flex-wrap items-center gap-1.5 text-xs">
          <span className="rounded-full bg-zinc-200 px-2.5 py-1 text-zinc-800 dark:bg-zinc-800 dark:text-zinc-200">
            {KIND_LABEL[exercise.kind]}
          </span>
          <span className="rounded-full bg-zinc-200 px-2.5 py-1 text-zinc-800 dark:bg-zinc-800 dark:text-zinc-200">
            {DIFFICULTY_LABEL[exercise.difficulty]}
          </span>
          <span className="rounded-full bg-emerald-100 px-2.5 py-1 text-emerald-900 dark:bg-emerald-950 dark:text-emerald-200">
            até {Math.round(baseXp(exercise) * 1.5)} XP
          </span>
        </div>
      </div>

      {exercise.lesson && (
        <aside
          aria-label="Antes de começar"
          className="rounded-2xl border border-emerald-200 bg-emerald-50 p-5 text-sm dark:border-emerald-900 dark:bg-emerald-950"
        >
          <div className="mb-1 font-medium">Antes de começar</div>
          <p className="whitespace-pre-line">{exercise.lesson}</p>
        </aside>
      )}

      <section
        aria-label="Enunciado"
        className="rounded-2xl border border-zinc-200 bg-white p-5 shadow-sm dark:border-zinc-800 dark:bg-zinc-900"
      >
        <p className="whitespace-pre-line">{exercise.statement}</p>
      </section>

      {broken && (
        <p
          role="alert"
          className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
        >
          Este exercício está com um problema de configuração. Avise o
          professor.
        </p>
      )}

      {codeLike && (
        <>
          {exercise.kind === "fix" && (
            <p className="text-sm text-zinc-600 dark:text-zinc-400">
              O código abaixo tem um defeito. Encontre o erro e corrija.
            </p>
          )}
          <CodeEditor value={code} onChange={setCode} onRun={submitCode} />
          <div className="flex flex-wrap gap-2">
            <button
              onClick={submitCode}
              disabled={busy}
              className="rounded-xl bg-emerald-700 px-5 py-2.5 font-medium text-white hover:bg-emerald-800 disabled:opacity-50"
            >
              {busy ? "Executando..." : "Executar testes (Ctrl+Enter)"}
            </button>
          </div>
        </>
      )}

      {choice && (
        <ChoiceBody
          code={snippet}
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
      )}

      {blank && (
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
      )}

      {orderV && (
        <OrderBody
          view={orderV}
          order={order}
          result={orderResult}
          disabled={busy}
          onChange={(o) => {
            setOrder(o);
            setOrderResult(null);
          }}
          onSubmit={() => void submitOrder()}
        />
      )}

      {!broken && (
        <HintPanel
          exercise={exercise}
          getContext={hintContext}
          onLevel={(n) => setHintLevel((l) => Math.max(l, n))}
        />
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
              <TestList
                tests={codeResult.tests}
                functionName={exercise.functionName}
              />
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
        {orderResult?.passed && (
          <p className="font-medium">🎉 Ordem correta!</p>
        )}

        {(choiceResult === true ||
          blankResult?.passed ||
          orderResult?.passed) &&
          exercise.config.explanation && (
            <p className="rounded-lg bg-zinc-100 p-3 text-sm dark:bg-zinc-900">
              {exercise.config.explanation}
            </p>
          )}

        {codeResult?.passed && <SolutionPanel exerciseId={exercise.id} />}

        {saveError && (
          <p
            role="alert"
            className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
          >
            {saveError}
          </p>
        )}
        {gain && (
          <div
            role="status"
            className="space-y-1 rounded-lg bg-emerald-100 p-3 text-sm dark:bg-emerald-900"
          >
            {(gain.xp > 0 || gain.badges.length > 0) && (
              <p>
                {gain.xp > 0 && `+${gain.xp} XP`}
                {gain.xp > 0 && gain.badges.length > 0 && " · "}
                {gain.badges.length > 0 &&
                  `🏅 Nova medalha: ${gain.badges.join(", ")}`}
              </p>
            )}
            {gain.extras.map((t) => (
              <p key={t}>{t}</p>
            ))}
          </div>
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
