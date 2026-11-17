"use client";

import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { DIFFICULTY_LABEL, KIND_LABEL, XP_BY_DIFFICULTY } from "@/lib/catalog";
import { lessonSteps, stepIndex, type LessonStep } from "@/lib/student";
import { usePageTitle } from "@/lib/use-page-title";
import { CatalogGate } from "./CatalogProvider";
import { useStudent } from "./useStudent";
import {
  BackLink,
  Pill,
  ProgressBar,
  card,
  primaryButton,
  secondaryButton,
} from "./ui";

const looksLikeCode = (block: string) =>
  !/^\d+\./.test(block) &&
  /[;{}]|console\.|=>|^\s*(let|const|if|for|function)\b/m.test(block);

/** Texto da lição: parágrafos normais e, no exemplo, trechos de código em bloco. */
function Prose({ text, code = false }: { text: string; code?: boolean }) {
  const blocks = text.split(/\n{2,}/);
  return (
    <div className="space-y-3">
      {blocks.map((b, i) =>
        code && looksLikeCode(b) ? (
          <pre
            key={i}
            className="overflow-x-auto rounded-xl bg-zinc-900 p-4 font-mono text-sm text-zinc-100"
          >
            <code>{b}</code>
          </pre>
        ) : (
          <p key={i} className="whitespace-pre-line leading-relaxed">
            {b}
          </p>
        ),
      )}
    </div>
  );
}

function Content({ id }: { id: string }) {
  const s = useStudent();
  const router = useRouter();
  const params = useSearchParams();
  const m = s.catalog.modules.find((x) => x.id === id);
  usePageTitle(m?.title ?? "Lição");

  if (!m || !s.worlds.some((w) => w.lessons.some((l) => l.id === id))) {
    return (
      <div className="space-y-3">
        <p>Lição não encontrada.</p>
        <BackLink href="/mundos">Voltar aos mundos</BackLink>
      </div>
    );
  }
  const world = s.worlds.find((w) => w.lessons.some((l) => l.id === id))!;
  const backHref = `/mundos/${world.world.id}`;
  const st = s.states[m.id];

  if (s.isLocked(m.id)) {
    return (
      <div className="space-y-4">
        <BackLink href={backHref}>{world.world.title}</BackLink>
        <div className={`${card} space-y-3 p-6`}>
          <h1 className="text-xl font-semibold">
            <span role="img" aria-label="Bloqueada">
              🔒{" "}
            </span>
            Esta lição ainda está bloqueada
          </h1>
          <p className="text-zinc-600 dark:text-zinc-400">
            No modo aprendizado, as lições abrem em ordem.
            {st?.blockedBy &&
              ` Resolva pelo menos 70% de "${st.blockedBy.title}" para liberar esta.`}
          </p>
          <div className="flex flex-wrap gap-2">
            {st?.blockedBy && (
              <Link
                href={`/licao/${st.blockedBy.id}`}
                className={primaryButton}
              >
                Ir para &quot;{st.blockedBy.title}&quot;
              </Link>
            )}
            <button
              type="button"
              onClick={() => s.setMode("pratica")}
              className={secondaryButton}
            >
              Ir para o modo prática
            </button>
          </div>
        </div>
      </div>
    );
  }

  const steps: LessonStep[] = lessonSteps(s.catalog, m);
  const idx = stepIndex(steps, params.get("passo"));
  const step = steps[idx];
  const go = (i: number) =>
    router.push(`/licao/${m.id}?passo=${steps[i].id}`, { scroll: false });
  const lessonIdx = world.lessons.findIndex((l) => l.id === m.id);
  const nextLesson = world.lessons[lessonIdx + 1];
  const nextOpen = nextLesson && !s.isLocked(nextLesson.id);
  const total = st?.total ?? 0;
  const done = st?.done ?? 0;
  const xp = s.published
    .filter((e) => e.moduleId === m.id)
    .reduce((n, e) => n + XP_BY_DIFFICULTY[e.difficulty], 0);

  return (
    <div className="space-y-6">
      <BackLink href={backHref}>{world.world.title}</BackLink>
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">
          {m.title}
          {m.optional && (
            <span className="ml-2 align-middle">
              <Pill>Complementar</Pill>
            </span>
          )}
        </h1>
        <div className="mt-3 max-w-md">
          <ProgressBar
            value={total ? done / total : 0}
            label={`Progresso em ${m.title}`}
          />
          <p className="mt-1 text-xs text-zinc-600 dark:text-zinc-400">
            {done}/{total} exercícios resolvidos
          </p>
        </div>
      </header>

      <nav aria-label="Passos da lição">
        <ol className="flex flex-wrap gap-2">
          {steps.map((x, i) => (
            <li key={x.id}>
              <button
                type="button"
                onClick={() => go(i)}
                aria-current={i === idx ? "step" : undefined}
                className={`rounded-full px-3.5 py-1.5 text-sm ${
                  i === idx
                    ? "bg-emerald-700 font-medium text-white"
                    : "bg-zinc-200 text-zinc-800 hover:bg-zinc-300 dark:bg-zinc-800 dark:text-zinc-200 dark:hover:bg-zinc-700"
                }`}
              >
                <span aria-hidden>{i + 1}. </span>
                {x.label}
                {x.exercises.length > 0 &&
                  x.exercises.every((e) => s.progress[e.id]?.solved) && (
                    <span role="img" aria-label=" (concluído)">
                      {" "}
                      ✓
                    </span>
                  )}
              </button>
            </li>
          ))}
        </ol>
      </nav>

      <section
        aria-labelledby="passo-titulo"
        className={`${card} space-y-4 p-6`}
      >
        <h2 id="passo-titulo" className="text-lg font-semibold">
          {step.label}
        </h2>

        {step.id === "introducao" && (
          <div className="space-y-3">
            {m.focus && (
              <p className="leading-relaxed">
                <strong>O que você vai aprender: </strong>
                {m.focus}.
              </p>
            )}
            <p className="text-zinc-600 dark:text-zinc-400">
              {total} {total === 1 ? "exercício" : "exercícios"} · até {xp} XP
              nesta lição.
            </p>
            {m.optional && (
              <p className="rounded-xl bg-zinc-100 p-3 text-sm dark:bg-zinc-800">
                Esta lição é complementar: vale estudar, mas ela não bloqueia a
                lição seguinte.
              </p>
            )}
          </div>
        )}
        {step.id === "explicacao" && <Prose text={m.intro} />}
        {step.id === "exemplo" && <Prose text={m.example} code />}
        {step.id === "revisao" && (
          <div className="space-y-3">
            <Prose text={m.review} />
            {nextLesson ? (
              <p className="text-sm text-zinc-600 dark:text-zinc-400">
                {nextOpen
                  ? "Quando terminar os exercícios, siga para a próxima lição."
                  : st && !st.complete
                    ? `Resolva ${st.needed - st.done} ${st.needed - st.done === 1 ? "exercício" : "exercícios"} para liberar a próxima lição.`
                    : "A próxima lição será liberada em seguida."}
              </p>
            ) : null}
            {nextLesson && nextOpen && (
              <Link href={`/licao/${nextLesson.id}`} className={primaryButton}>
                Próxima lição: {nextLesson.title} <span aria-hidden>→</span>
              </Link>
            )}
          </div>
        )}
        {step.exercises.length > 0 && (
          <ul className="divide-y divide-zinc-100 dark:divide-zinc-800">
            {step.exercises.map((e) => {
              const p = s.progress[e.id];
              return (
                <li key={e.id}>
                  <Link
                    href={`/exercicio/${e.id}`}
                    className="flex items-center gap-3 py-3 hover:bg-zinc-50 dark:hover:bg-zinc-800/60"
                  >
                    <span
                      role="img"
                      aria-label={p?.solved ? "Resolvido" : "Pendente"}
                      className={`flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-sm ${
                        p?.solved
                          ? "bg-emerald-600 text-white"
                          : "border-2 border-zinc-300 text-zinc-600 dark:border-zinc-600 dark:text-zinc-300"
                      }`}
                    >
                      {p?.solved ? "✓" : ""}
                    </span>
                    <span className="min-w-0 flex-1">
                      <span className="block font-medium">{e.title}</span>
                      <span className="mt-0.5 flex flex-wrap gap-1.5">
                        <Pill>{KIND_LABEL[e.kind]}</Pill>
                        <Pill>{DIFFICULTY_LABEL[e.difficulty]}</Pill>
                        {p && !p.solved && p.attempts > 0 && (
                          <Pill tone="amber">em andamento</Pill>
                        )}
                      </span>
                    </span>
                    <span className="shrink-0 text-sm text-zinc-600 dark:text-zinc-400">
                      {p?.solved ? p.xp : XP_BY_DIFFICULTY[e.difficulty]} XP
                    </span>
                  </Link>
                </li>
              );
            })}
          </ul>
        )}
      </section>

      <div className="flex justify-between gap-3">
        <button
          type="button"
          onClick={() => go(idx - 1)}
          disabled={idx === 0}
          className={`${secondaryButton} disabled:opacity-40`}
        >
          <span aria-hidden>←</span> Passo anterior
        </button>
        <button
          type="button"
          onClick={() => go(idx + 1)}
          disabled={idx === steps.length - 1}
          className={`${primaryButton} disabled:opacity-40`}
        >
          Próximo passo <span aria-hidden>→</span>
        </button>
      </div>
    </div>
  );
}

export default function LessonPage({ id }: { id: string }) {
  return (
    <CatalogGate>
      <Content id={id} />
    </CatalogGate>
  );
}
