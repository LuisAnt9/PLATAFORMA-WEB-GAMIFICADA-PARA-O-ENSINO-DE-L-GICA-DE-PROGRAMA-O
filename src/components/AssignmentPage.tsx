"use client";

import Link from "next/link";
import { useCallback, useState } from "react";
import {
  KIND_NAME,
  STATUS_LABEL,
  formatDue,
  getAssessment,
  getAssessmentResult,
  listAssignmentItems,
  submitAssessment,
  type Assessment,
  type AssessmentQuestion,
  type AssessmentResult,
} from "@/lib/assignments";
import { getExercise, KIND_LABEL } from "@/lib/catalog";
import { splitTemplate } from "@/lib/grading";
import { useLoader } from "@/lib/use-loader";
import { usePageTitle } from "@/lib/use-page-title";
import { CatalogGate, useCatalog } from "./CatalogProvider";
import { statusTone, useMyAssignments } from "./MyAssignments";
import ScrollRegion from "./ScrollRegion";
import { BackLink, Pill, card, primaryButton } from "./ui";

type Answers = Record<string, unknown>;

function QuestionInput({
  q,
  value,
  onChange,
  disabled,
}: {
  q: AssessmentQuestion;
  value: unknown;
  onChange: (v: unknown) => void;
  disabled: boolean;
}) {
  if (q.kind === "choice" || q.kind === "interpretation") {
    return (
      <fieldset className="space-y-2">
        <legend className="sr-only">Alternativas de {q.title}</legend>
        {q.payload.code && (
          <ScrollRegion
            label="Trecho de código"
            className="mb-3 rounded-xl bg-zinc-900 text-zinc-100"
          >
            <pre className="p-4 font-mono text-sm leading-6">
              {q.payload.code}
            </pre>
          </ScrollRegion>
        )}
        {(q.payload.options ?? []).map((o, i) => (
          <label
            key={i}
            className="flex cursor-pointer items-start gap-3 rounded-xl border border-zinc-300 p-3 has-[:checked]:border-emerald-600 has-[:checked]:bg-emerald-50 dark:border-zinc-700 dark:has-[:checked]:bg-emerald-950"
          >
            <input
              type="radio"
              name={`q${q.id}`}
              checked={value === i}
              disabled={disabled}
              onChange={() => onChange(i)}
              className="mt-1"
            />
            <span className="whitespace-pre-wrap font-mono text-sm">{o}</span>
          </label>
        ))}
      </fieldset>
    );
  }
  if (q.kind === "blank") {
    const parts = splitTemplate(q.payload.template ?? "");
    const arr = Array.isArray(value) ? (value as string[]) : [];
    return (
      <pre className="overflow-x-auto whitespace-pre-wrap rounded-lg border border-zinc-300 bg-zinc-50 p-4 font-mono text-sm leading-8 dark:border-zinc-700 dark:bg-zinc-900">
        {parts.map((p, i) =>
          p.type === "text" ? (
            <span key={i}>{p.text}</span>
          ) : (
            <input
              key={i}
              aria-label={`Lacuna ${p.index + 1} de ${q.title}`}
              value={arr[p.index] ?? ""}
              disabled={disabled}
              onChange={(e) => {
                const next = Array.from(
                  { length: q.payload.blanks ?? arr.length },
                  (_, k) => arr[k] ?? "",
                );
                next[p.index] = e.target.value;
                onChange(next);
              }}
              className="mx-1 w-28 rounded border border-zinc-400 bg-white px-2 py-0.5 dark:bg-zinc-950"
            />
          ),
        )}
      </pre>
    );
  }
  // ordenação: botões para cima e para baixo
  const items = Array.isArray(value)
    ? (value as string[])
    : (q.payload.items ?? []);
  const move = (i: number, d: number) => {
    const next = [...items];
    const j = i + d;
    if (j < 0 || j >= next.length) return;
    [next[i], next[j]] = [next[j], next[i]];
    onChange(next);
  };
  return (
    <ol className="space-y-2">
      {items.map((it, i) => (
        <li
          key={it}
          className="flex items-center gap-2 rounded-xl border border-zinc-300 p-2 dark:border-zinc-700"
        >
          <span className="w-6 text-center text-sm text-zinc-600 dark:text-zinc-400">
            {i + 1}
          </span>
          <span className="flex-1">{it}</span>
          <button
            type="button"
            disabled={disabled || i === 0}
            onClick={() => move(i, -1)}
            aria-label={`Mover "${it}" para cima`}
            className="h-11 w-11 rounded-lg border border-zinc-300 disabled:opacity-40 dark:border-zinc-700"
          >
            ▲
          </button>
          <button
            type="button"
            disabled={disabled || i === items.length - 1}
            onClick={() => move(i, 1)}
            aria-label={`Mover "${it}" para baixo`}
            className="h-11 w-11 rounded-lg border border-zinc-300 disabled:opacity-40 dark:border-zinc-700"
          >
            ▼
          </button>
        </li>
      ))}
    </ol>
  );
}

function ResultView({ r }: { r: AssessmentResult }) {
  return (
    <section aria-labelledby="resultado" className={`${card} space-y-3 p-5`}>
      <h2 id="resultado" className="text-lg font-semibold">
        Sua entrega
      </h2>
      <p className="text-2xl font-semibold">
        Nota: {r.score}/{r.max}
      </p>
      <p className="text-sm text-zinc-600 dark:text-zinc-400">
        Entregue em {formatDue(r.submitted_at)}
        {r.late && " (fora do prazo)"}.
      </p>
      {r.details ? (
        <ul className="divide-y divide-zinc-200 text-sm dark:divide-zinc-800">
          {r.details.map((d) => (
            <li key={d.question_id} className="flex justify-between py-2">
              <span>{d.title}</span>
              <span>
                {d.correct ? "✓ certa" : "✗ errada"} · {d.points}{" "}
                {d.points === 1 ? "ponto" : "pontos"}
              </span>
            </li>
          ))}
        </ul>
      ) : (
        <p className="text-sm text-zinc-600 dark:text-zinc-400">
          O gabarito será liberado conforme a regra definida pelo professor.
        </p>
      )}
    </section>
  );
}

function AssessmentRunner({ id }: { id: number }) {
  const load = useCallback(async () => {
    const result = await getAssessmentResult(id);
    return {
      result,
      assessment: result ? null : await getAssessment(id),
    } as { result: AssessmentResult | null; assessment: Assessment | null };
  }, [id]);
  const { data, error, refresh } = useLoader(`assessment:${id}`, load);
  const [answers, setAnswers] = useState<Answers>({});
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const [confirm, setConfirm] = useState(false);

  if (error)
    return (
      <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">
        {error}
      </p>
    );
  if (!data)
    return (
      <p role="status" className="text-zinc-600 dark:text-zinc-400">
        Carregando...
      </p>
    );
  if (data.result) return <ResultView r={data.result} />;
  const a = data.assessment!;
  const answered = a.questions.filter((q) => {
    const v = answers[String(q.id)];
    return Array.isArray(v) ? v.some((x) => String(x).trim() !== "") : v !== undefined;
  }).length;

  async function submit() {
    setBusy(true);
    setErr(null);
    try {
      await submitAssessment(id, answers);
      await refresh();
    } catch (e) {
      setErr((e as Error).message);
      setConfirm(false);
    }
    setBusy(false);
  }

  return (
    <div className="space-y-6">
      <p className="rounded-xl bg-amber-50 p-3 text-sm dark:bg-amber-950">
        Você só pode entregar esta avaliação <strong>uma vez</strong>, até{" "}
        {formatDue(a.due_at)}. Confira suas respostas antes de enviar.
      </p>
      {a.questions.map((q, i) => (
        <section
          key={q.id}
          aria-labelledby={`q-${q.id}`}
          className={`${card} space-y-3 p-5`}
        >
          <div className="flex items-baseline justify-between gap-2">
            <h2 id={`q-${q.id}`} className="font-semibold">
              {i + 1}. {q.title}
            </h2>
            <Pill>
              {q.points} {q.points === 1 ? "ponto" : "pontos"}
            </Pill>
          </div>
          <p className="whitespace-pre-line">{q.statement}</p>
          <QuestionInput
            q={q}
            value={answers[String(q.id)]}
            disabled={busy}
            onChange={(v) => setAnswers((s) => ({ ...s, [String(q.id)]: v }))}
          />
        </section>
      ))}
      {err && (
        <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">
          {err}
        </p>
      )}
      {!confirm ? (
        <button type="button" onClick={() => setConfirm(true)} className={primaryButton}>
          Entregar avaliação ({answered}/{a.questions.length} respondidas)
        </button>
      ) : (
        <div className={`${card} space-y-3 p-4`} role="alertdialog" aria-label="Confirmar entrega">
          <p>
            Entregar agora? Depois de enviar, não será possível alterar as
            respostas.
          </p>
          <div className="flex gap-2">
            <button type="button" disabled={busy} onClick={() => void submit()} className={primaryButton}>
              Sim, entregar
            </button>
            <button
              type="button"
              disabled={busy}
              onClick={() => setConfirm(false)}
              className="rounded-xl border border-zinc-300 px-5 py-2.5 dark:border-zinc-700"
            >
              Voltar e revisar
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

function ItemList({ id }: { id: number }) {
  const { catalog } = useCatalog();
  const load = useCallback(() => listAssignmentItems(id), [id]);
  const { data, error } = useLoader(`items:${id}`, load);
  if (error)
    return <p role="alert" className="text-sm text-red-700 dark:text-red-300">{error}</p>;
  if (!data) return <p role="status">Carregando...</p>;
  return (
    <ul className="space-y-2">
      {data.map((exId) => {
        const e = getExercise(catalog, exId);
        if (!e) return null;
        return (
          <li key={exId}>
            <Link
              href={`/exercicio/${exId}?atividade=${id}`}
              className={`${card} flex items-center justify-between gap-3 p-3 hover:border-emerald-400 dark:hover:border-emerald-700`}
            >
              <span className="font-medium">{e.title}</span>
              <Pill>{KIND_LABEL[e.kind]}</Pill>
            </Link>
          </li>
        );
      })}
    </ul>
  );
}

function Content({ id }: { id: number }) {
  const { data, error } = useMyAssignments();
  const a = data?.find((x) => x.id === id);
  usePageTitle(a?.title ?? "Atividade");
  if (error)
    return <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">{error}</p>;
  if (!data) return <p role="status" className="text-zinc-600 dark:text-zinc-400">Carregando...</p>;
  if (!a)
    return (
      <div className="space-y-3">
        <p>Atividade não encontrada.</p>
        <BackLink href="/atividades">Minhas atividades</BackLink>
      </div>
    );
  return (
    <div className="space-y-6">
      <BackLink href="/atividades">Minhas atividades</BackLink>
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">{a.title}</h1>
        <div className="mt-2 flex flex-wrap items-center gap-2 text-sm text-zinc-600 dark:text-zinc-400">
          <Pill>{KIND_NAME[a.kind]}</Pill>
          <span>{a.class_name}</span>
          <span>· Prazo: {formatDue(a.due_at)}</span>
          {!a.required && <span>· opcional</span>}
          <Pill tone={statusTone(a.status)}>{STATUS_LABEL[a.status]}</Pill>
        </div>
        {a.instructions && (
          <p className="mt-4 whitespace-pre-line leading-relaxed">{a.instructions}</p>
        )}
      </header>
      {a.kind === "atividade" ? (
        <section aria-labelledby="exercicios">
          <h2 id="exercicios" className="mb-3 text-lg font-semibold">
            Exercícios ({a.items_done}/{a.items_total} resolvidos)
          </h2>
          <ItemList id={a.id} />
          <p className="mt-3 text-sm text-zinc-600 dark:text-zinc-400">
            As tentativas feitas por aqui são registradas como atividade da
            turma. Entregar depois do prazo é possível, mas aparece como
            atraso para o professor.
          </p>
        </section>
      ) : (
        <AssessmentRunner id={a.id} />
      )}
    </div>
  );
}

export default function AssignmentPage({ id }: { id: number }) {
  return (
    <CatalogGate>
      <Content id={id} />
    </CatalogGate>
  );
}
