"use client";

import Link from "next/link";
import { useCallback, useState } from "react";
import { listMyClasses } from "@/lib/classes";
import { ITEMS, SCALE_LABELS, type SurveyKind } from "@/lib/surveys";
import { loadDone, submitSurvey } from "@/lib/survey-client";
import { useLoader } from "@/lib/use-loader";
import { usePageTitle } from "@/lib/use-page-title";
import { useAuth } from "./AuthProvider";
import { card, primaryButton } from "./ui";

const TITLES: Record<SurveyKind, { title: string; intro: string }> = {
  sus: {
    title: "Usabilidade da plataforma (SUS)",
    intro: "Marque o quanto você concorda com cada afirmação sobre o uso da plataforma.",
  },
  likert: {
    title: "Experiência de aprendizagem",
    intro: "Marque o quanto você concorda com cada afirmação sobre o que aprendeu e como se sentiu.",
  },
};

function Form({ kind, onDone }: { kind: SurveyKind; onDone: () => void }) {
  const items = ITEMS[kind];
  const { data: classes } = useLoader("survey-classes", listMyClasses);
  const [answers, setAnswers] = useState<(number | null)[]>(() => items.map(() => null));
  const [anonymous, setAnonymous] = useState(true);
  const [classId, setClassId] = useState("");
  const [comment, setComment] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const complete = answers.every((a) => a !== null);

  async function send(e: React.FormEvent) {
    e.preventDefault();
    if (!complete) return setError("Responda todas as afirmações.");
    setBusy(true);
    setError(null);
    try {
      await submitSurvey({
        kind,
        answers: answers as number[],
        comment,
        anonymous,
        classId: classId || null,
      });
      onDone();
    } catch (err) {
      setError((err as Error).message);
    }
    setBusy(false);
  }

  return (
    <form onSubmit={send} className="space-y-5">
      <p className="text-sm text-zinc-600 dark:text-zinc-400">{TITLES[kind].intro}</p>
      {items.map((text, i) => (
        <fieldset key={i} className={`${card} p-4`}>
          <legend className="px-1 text-sm font-medium">
            {i + 1}. {text}
          </legend>
          <div className="mt-2 flex flex-wrap gap-2">
            {SCALE_LABELS.map((label, v) => (
              <label
                key={v}
                className="flex min-h-11 flex-1 basis-32 cursor-pointer items-center gap-2 rounded-lg border border-zinc-300 px-3 py-2 text-sm has-[:checked]:border-emerald-600 has-[:checked]:bg-emerald-50 dark:border-zinc-700 dark:has-[:checked]:bg-emerald-950"
              >
                <input
                  type="radio"
                  name={`${kind}-${i}`}
                  checked={answers[i] === v + 1}
                  onChange={() => setAnswers((a) => a.map((x, k) => (k === i ? v + 1 : x)))}
                />
                <span>
                  <span className="font-medium">{v + 1}</span> · {label}
                </span>
              </label>
            ))}
          </div>
        </fieldset>
      ))}
      <label className="block text-sm">
        Comentário (opcional)
        <textarea
          value={comment}
          onChange={(e) => setComment(e.target.value)}
          maxLength={1000}
          rows={3}
          className="mt-1 w-full rounded-xl border border-zinc-300 bg-white px-3 py-2 dark:border-zinc-700 dark:bg-zinc-950"
        />
      </label>
      <fieldset className="space-y-2 text-sm">
        <legend className="font-medium">Como quer responder?</legend>
        <label className="flex items-start gap-2">
          <input type="radio" name={`modo-${kind}`} checked={anonymous} onChange={() => setAnonymous(true)} className="mt-1" />
          <span>
            <strong>De forma anônima</strong>: a resposta não fica ligada ao seu nome.
          </span>
        </label>
        <label className="flex items-start gap-2">
          <input type="radio" name={`modo-${kind}`} checked={!anonymous} onChange={() => setAnonymous(false)} className="mt-1" />
          <span>
            <strong>Identificada</strong>: o professor da turma vê que foi você.
          </span>
        </label>
      </fieldset>
      {(classes?.length ?? 0) > 0 && (
        <label className="block text-sm">
          Turma (para o professor receber o resultado da turma)
          <select
            value={classId}
            onChange={(e) => setClassId(e.target.value)}
            className="mt-1 w-full max-w-sm rounded-xl border border-zinc-300 bg-white px-3 py-2 dark:border-zinc-700 dark:bg-zinc-950"
          >
            <option value="">Não informar a turma</option>
            {classes!.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </label>
      )}
      {error && (
        <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">
          {error}
        </p>
      )}
      <button type="submit" disabled={busy} className={`${primaryButton} disabled:opacity-50`}>
        Enviar respostas
      </button>
    </form>
  );
}

export default function SurveyPage() {
  usePageTitle("Sua opinião");
  const { profile } = useAuth();
  const load = useCallback(() => loadDone(), []);
  const { data: done, refresh } = useLoader(`survey-done:${profile?.id}`, load);
  const [open, setOpen] = useState<SurveyKind | null>(null);
  if (profile?.role === "professor")
    return <p>Os questionários são respondidos pelos alunos. Veja o resultado em Professor → Pesquisa.</p>;
  return (
    <div className="space-y-6">
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">Sua opinião</h1>
        <p className="mt-1 text-zinc-600 dark:text-zinc-400">
          Duas perguntas curtas para avaliar a plataforma (parte do TCC). Responder é opcional, não vale nota e as respostas
          são usadas de forma agregada. Veja a{" "}
          <Link href="/privacidade" className="text-emerald-700 underline dark:text-emerald-400">
            política de privacidade
          </Link>
          .
        </p>
      </header>
      {(["sus", "likert"] as const).map((k) => {
        const answered = done?.includes(k);
        return (
          <section key={k} aria-labelledby={`q-${k}`} className={`${card} p-5`}>
            <h2 id={`q-${k}`} className="text-lg font-semibold">
              {TITLES[k].title}
            </h2>
            {answered ? (
              <p className="mt-2 text-sm text-emerald-700 dark:text-emerald-400">Respondido. Obrigado pela sua participação!</p>
            ) : open === k ? (
              <div className="mt-4">
                <Form
                  kind={k}
                  onDone={() => {
                    setOpen(null);
                    void refresh();
                  }}
                />
              </div>
            ) : (
              <button type="button" onClick={() => setOpen(k)} className={`mt-3 ${primaryButton}`}>
                Responder ({ITEMS[k].length} afirmações)
              </button>
            )}
          </section>
        );
      })}
    </div>
  );
}
