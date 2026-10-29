"use client";

import { usePageTitle } from "@/lib/use-page-title";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useMemo, useState } from "react";
import {
  DIFFICULTY_LABEL,
  KIND_LABEL,
  type Difficulty,
  type Exercise,
  type ExerciseKind,
} from "@/lib/catalog";
import {
  MAX_TESTS,
  buildStarterCode,
  draftFromExercise,
  emptyDraft,
  newExerciseId,
  validateDraft,
  type Draft,
} from "@/lib/exercise-draft";
import { createExercise, updateExercise } from "@/lib/exercises-admin";
import { placeholderNumbers, splitTemplate } from "@/lib/grading";
import { runExercise, type RunResult } from "@/lib/runner";
import { useAuth } from "./AuthProvider";
import { useCatalog } from "./CatalogProvider";
import CodeEditor from "./CodeEditor";

const input =
  "mt-1 w-full rounded-xl border border-zinc-300 bg-white dark:bg-zinc-950 px-3 py-2 dark:border-zinc-700";
const mono = "font-mono text-sm";
const show = (v: unknown) =>
  v === undefined ? "undefined" : JSON.stringify(v);

const KIND_HELP: Record<ExerciseKind, string> = {
  code: "O aluno escreve uma função em JavaScript e o site confere com os seus casos de teste.",
  choice:
    "O aluno escolhe uma alternativa. Bom para conceitos e para quem está começando.",
  blank:
    "O aluno completa lacunas num trecho de código. Reduz a barreira da sintaxe.",
};

export default function ExerciseForm({ existing }: { existing?: Exercise }) {
  usePageTitle(existing ? "Editar exercício" : "Novo exercício");
  const router = useRouter();
  const { profile } = useAuth();
  const { catalog, reload } = useCatalog();
  const modules = [...catalog.modules].sort((a, b) => a.position - b.position);

  const [draft, setDraft] = useState<Draft>(() =>
    existing ? draftFromExercise(existing) : emptyDraft(modules[0]?.id ?? ""),
  );
  const [solution, setSolution] = useState("");
  const [result, setResult] = useState<RunResult | null>(null);
  const [validatedSnapshot, setValidatedSnapshot] = useState<string | null>(
    null,
  );
  const [attempted, setAttempted] = useState(false);
  const [running, setRunning] = useState(false);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const validation = useMemo(() => validateDraft(draft), [draft]);
  const isCode = draft.kind === "code";
  // A validação com a solução de referência só vale para este nome de função, estes testes e esta solução.
  const snapshot = JSON.stringify([
    draft.functionName.trim(),
    draft.tests,
    solution,
  ]);
  // Código precisa passar na solução de referência; os outros tipos só precisam estar completos.
  const canPublish = isCode
    ? validatedSnapshot === snapshot
    : validation.errors.length === 0;

  function set<K extends keyof Draft>(key: K, value: Draft[K]) {
    setDraft((d) => ({ ...d, [key]: value }));
  }
  function setTest(i: number, key: "args" | "expected", value: string) {
    setDraft((d) => ({
      ...d,
      tests: d.tests.map((t, j) => (j === i ? { ...t, [key]: value } : t)),
    }));
  }
  function setOption(i: number, value: string) {
    setDraft((d) => ({
      ...d,
      options: d.options.map((o, j) => (j === i ? value : o)),
    }));
  }
  function removeOption(i: number) {
    setDraft((d) => ({
      ...d,
      options: d.options.filter((_, j) => j !== i),
      correct:
        d.correct === null
          ? null
          : d.correct === i
            ? null
            : d.correct > i
              ? d.correct - 1
              : d.correct,
    }));
  }
  function setBlankAnswers(i: number, value: string) {
    setDraft((d) => {
      const next = [...d.blankAnswers];
      while (next.length <= i) next.push("");
      next[i] = value;
      return { ...d, blankAnswers: next };
    });
  }

  async function validate() {
    setAttempted(true);
    setError(null);
    if (validation.errors.length > 0) return setError(validation.errors[0]);
    if (!solution.trim())
      return setError(
        "Escreva a solução de referência para conferir os testes.",
      );
    setRunning(true);
    const res = await runExercise(
      { functionName: draft.functionName.trim(), tests: validation.tests },
      solution,
    );
    setResult(res);
    setValidatedSnapshot(res.passed ? snapshot : null);
    setRunning(false);
  }

  async function save(publish: boolean) {
    setAttempted(true);
    setError(null);
    if (validation.errors.length > 0) return setError(validation.errors[0]);
    if (publish && !canPublish) {
      return setError(
        "Para publicar, valide os testes com uma solução de referência que passe em todos.",
      );
    }
    if (!profile) return;
    setSaving(true);
    try {
      if (existing) {
        await updateExercise(
          existing,
          draft,
          validation,
          publish,
          catalog.exercises,
        );
      } else {
        const id = newExerciseId(
          draft.title,
          new Set(catalog.exercises.map((e) => e.id)),
        );
        await createExercise(
          id,
          profile.id,
          draft,
          validation,
          publish,
          catalog.exercises,
        );
      }
      await reload();
      router.push("/professor/exercicios");
    } catch (e) {
      setError((e as Error).message);
      setSaving(false);
    }
  }

  const fnOk = validation.errors.every(
    (e) => !e.startsWith("Nome da função") && !e.includes("reservada"),
  );
  const blankCount =
    draft.kind === "blank"
      ? new Set(placeholderNumbers(draft.template)).size
      : 0;

  return (
    <div className="space-y-8">
      <Link
        href="/professor/exercicios"
        className="text-sm text-zinc-600 dark:text-zinc-400 hover:underline"
      >
        ← Exercícios
      </Link>
      <h1 className="text-2xl font-semibold tracking-tight">
        {existing ? "Editar exercício" : "Novo exercício"}
      </h1>

      <fieldset>
        <legend className="mb-2 text-sm font-medium">Tipo de exercício</legend>
        <div className="grid gap-2 sm:grid-cols-3">
          {(Object.keys(KIND_LABEL) as ExerciseKind[]).map((k) => (
            <label
              key={k}
              className={`rounded-lg border p-3 text-sm ${draft.kind === k ? "border-emerald-500 bg-emerald-50 dark:bg-emerald-950" : "border-zinc-200 dark:border-zinc-800"} ${existing ? "cursor-not-allowed opacity-70" : "cursor-pointer"}`}
            >
              <input
                type="radio"
                name="tipo"
                className="mr-2 accent-emerald-600"
                checked={draft.kind === k}
                disabled={!!existing}
                onChange={() => set("kind", k)}
              />
              <span className="font-medium">{KIND_LABEL[k]}</span>
              <span className="mt-1 block text-xs text-zinc-600 dark:text-zinc-400">
                {KIND_HELP[k]}
              </span>
            </label>
          ))}
        </div>
        {existing && (
          <p className="mt-1 text-xs text-zinc-600 dark:text-zinc-400">
            O tipo não pode ser mudado depois de criado.
          </p>
        )}
      </fieldset>

      <section className="grid gap-4 sm:grid-cols-2">
        <label className="text-sm sm:col-span-2">
          Título
          <input
            className={input}
            value={draft.title}
            onChange={(e) => set("title", e.target.value)}
            maxLength={100}
          />
        </label>
        <label className="text-sm">
          Módulo
          <select
            className={input}
            value={draft.moduleId}
            onChange={(e) => set("moduleId", e.target.value)}
          >
            {modules.map((m) => (
              <option key={m.id} value={m.id} className="text-black">
                {m.title}
              </option>
            ))}
          </select>
        </label>
        <label className="text-sm">
          Dificuldade
          <select
            className={input}
            value={draft.difficulty}
            onChange={(e) => set("difficulty", e.target.value as Difficulty)}
          >
            {(Object.keys(DIFFICULTY_LABEL) as Difficulty[]).map((d) => (
              <option key={d} value={d} className="text-black">
                {DIFFICULTY_LABEL[d]}
              </option>
            ))}
          </select>
        </label>
        <label className="text-sm sm:col-span-2">
          Antes de começar (opcional)
          <span className="block text-xs text-zinc-600 dark:text-zinc-400">
            Uma mini-explicação curta do conceito, mostrada acima do enunciado.
          </span>
          <textarea
            className={`${input} h-24`}
            value={draft.lesson}
            onChange={(e) => set("lesson", e.target.value)}
            maxLength={1500}
          />
        </label>
        <label className="text-sm sm:col-span-2">
          Enunciado
          <textarea
            className={`${input} h-28`}
            value={draft.statement}
            onChange={(e) => set("statement", e.target.value)}
            maxLength={2000}
          />
        </label>
        <label className="text-sm sm:col-span-2">
          Dica (opcional)
          <input
            className={input}
            value={draft.hint}
            onChange={(e) => set("hint", e.target.value)}
            maxLength={500}
          />
        </label>
      </section>

      {draft.kind === "choice" && (
        <section>
          <h2 className="mb-1 text-lg font-semibold">Alternativas</h2>
          <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
            Marque a correta. As respostas ficam legíveis para os alunos, pois a
            correção roda no navegador.
          </p>
          <ul className="space-y-2">
            {draft.options.map((o, i) => (
              <li key={i} className="flex items-center gap-2">
                <input
                  type="radio"
                  name="correta"
                  aria-label={`Alternativa ${i + 1} é a correta`}
                  checked={draft.correct === i}
                  onChange={() => set("correct", i)}
                  className="accent-emerald-600"
                />
                <input
                  aria-label={`Texto da alternativa ${i + 1}`}
                  placeholder={`Alternativa ${i + 1}`}
                  className="min-w-0 flex-1 rounded-xl border border-zinc-300 bg-white dark:bg-zinc-950 px-3 py-2 dark:border-zinc-700"
                  value={o}
                  onChange={(e) => setOption(i, e.target.value)}
                />
                <button
                  type="button"
                  aria-label={`Remover alternativa ${i + 1}`}
                  disabled={draft.options.length <= 2}
                  onClick={() => removeOption(i)}
                  className="px-2 text-zinc-600 dark:text-zinc-400 hover:text-red-700 disabled:opacity-30"
                >
                  ✕
                </button>
              </li>
            ))}
          </ul>
          <button
            type="button"
            disabled={draft.options.length >= 6}
            onClick={() =>
              setDraft((d) => ({ ...d, options: [...d.options, ""] }))
            }
            className="mt-3 text-sm text-emerald-700 hover:underline disabled:opacity-50 dark:text-emerald-400"
          >
            + Adicionar alternativa
          </button>
        </section>
      )}

      {draft.kind === "blank" && (
        <section className="space-y-4">
          <div>
            <h2 className="mb-1 text-lg font-semibold">Modelo com lacunas</h2>
            <p className="mb-2 text-sm text-zinc-600 dark:text-zinc-400">
              Escreva o trecho de código e marque cada lacuna com{" "}
              <code>{"{{1}}"}</code>, <code>{"{{2}}"}</code>... (numeradas em
              sequência).
            </p>
            <textarea
              aria-label="Modelo com lacunas"
              className={`${input} ${mono} h-40`}
              value={draft.template}
              onChange={(e) => set("template", e.target.value)}
              maxLength={2000}
              spellCheck={false}
              placeholder={
                "function f(x) {\n  {{1}} (x > 0) {\n    return 1;\n  }\n}"
              }
            />
          </div>
          {blankCount > 0 && (
            <div>
              <h3 className="mb-1 font-medium">Respostas aceitas</h3>
              <p className="mb-2 text-sm text-zinc-600 dark:text-zinc-400">
                Uma resposta por linha (por exemplo, <code>++</code> e{" "}
                <code>+= 1</code>). Maiúsculas e minúsculas contam; espaços
                extras não.
              </p>
              <div className="grid gap-3 sm:grid-cols-2">
                {Array.from({ length: Math.min(blankCount, 10) }, (_, i) => (
                  <label key={i} className="text-sm">
                    Lacuna {i + 1}
                    <textarea
                      className={`${input} ${mono} h-16`}
                      value={draft.blankAnswers[i] ?? ""}
                      onChange={(e) => setBlankAnswers(i, e.target.value)}
                      spellCheck={false}
                    />
                  </label>
                ))}
              </div>
            </div>
          )}
          {draft.template.trim() && (
            <div className="text-sm">
              <div className="text-zinc-600 dark:text-zinc-400">
                Como o aluno verá
              </div>
              <pre className="mt-1 overflow-x-auto whitespace-pre-wrap rounded-lg bg-zinc-100 p-3 text-xs leading-6 dark:bg-zinc-900">
                {splitTemplate(draft.template).map((p, i) =>
                  p.type === "text" ? (
                    <span key={i}>{p.text}</span>
                  ) : (
                    <span
                      key={i}
                      className="mx-0.5 rounded border-b-2 border-zinc-400 bg-white px-3 dark:bg-zinc-800"
                    >
                      {p.index + 1}
                    </span>
                  ),
                )}
              </pre>
            </div>
          )}
        </section>
      )}

      {draft.kind !== "code" && (
        <label className="block text-sm">
          Explicação ao acertar (opcional)
          <span className="block text-xs text-zinc-600 dark:text-zinc-400">
            Mostrada ao aluno depois que ele acerta.
          </span>
          <textarea
            className={`${input} h-20`}
            value={draft.explanation}
            onChange={(e) => set("explanation", e.target.value)}
            maxLength={500}
          />
        </label>
      )}

      {isCode && (
        <>
          <section className="grid gap-4 sm:grid-cols-2">
            <label className="text-sm">
              Nome da função
              <input
                className={`${input} ${mono}`}
                value={draft.functionName}
                onChange={(e) => set("functionName", e.target.value)}
                maxLength={40}
                placeholder="somaPares"
                autoCapitalize="off"
                spellCheck={false}
              />
            </label>
            <label className="text-sm">
              Parâmetros (separados por vírgula)
              <input
                className={`${input} ${mono}`}
                value={draft.params}
                onChange={(e) => set("params", e.target.value)}
                placeholder="a, b"
                autoCapitalize="off"
                spellCheck={false}
              />
            </label>
            {draft.functionName.trim() && fnOk && (
              <div className="text-sm sm:col-span-2">
                <div className="text-zinc-600 dark:text-zinc-400">
                  Código inicial que o aluno verá
                </div>
                <pre className="mt-1 overflow-x-auto rounded-lg bg-zinc-100 p-3 font-mono text-xs dark:bg-zinc-900">
                  {buildStarterCode(draft.functionName.trim(), draft.params)}
                </pre>
              </div>
            )}
          </section>

          <section>
            <h2 className="mb-1 text-lg font-semibold">Casos de teste</h2>
            <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
              Escreva em JSON. Entradas: <code>2, 3</code> ou{" "}
              <code>[1, 2, 3]</code> ou <code>&quot;abc&quot;</code>. Esperado:{" "}
              <code>5</code>, <code>&quot;par&quot;</code>, <code>true</code> ou{" "}
              <code>[1, 2]</code>. Os casos de teste ficam visíveis para os
              alunos, pois a correção roda no navegador.
            </p>
            <ul className="space-y-2">
              {draft.tests.map((t, i) => {
                const err = validation.testErrors[i];
                const touched = attempted || t.args !== "" || t.expected !== "";
                return (
                  <li key={i}>
                    <div className="flex flex-wrap items-center gap-2">
                      <span className="w-6 text-sm text-zinc-600 dark:text-zinc-400">
                        {i + 1}.
                      </span>
                      <input
                        aria-label={`Entradas do teste ${i + 1}`}
                        placeholder="entradas: 2, 3"
                        className={`min-w-0 flex-1 rounded-xl border border-zinc-300 bg-white dark:bg-zinc-950 px-3 py-2 ${mono} dark:border-zinc-700`}
                        value={t.args}
                        onChange={(e) => setTest(i, "args", e.target.value)}
                      />
                      <span aria-hidden>→</span>
                      <input
                        aria-label={`Resultado esperado do teste ${i + 1}`}
                        placeholder="esperado: 5"
                        className={`min-w-0 flex-1 rounded-xl border border-zinc-300 bg-white dark:bg-zinc-950 px-3 py-2 ${mono} dark:border-zinc-700`}
                        value={t.expected}
                        onChange={(e) => setTest(i, "expected", e.target.value)}
                      />
                      <button
                        type="button"
                        aria-label={`Remover teste ${i + 1}`}
                        disabled={draft.tests.length <= 1}
                        onClick={() =>
                          setDraft((d) => ({
                            ...d,
                            tests: d.tests.filter((_, j) => j !== i),
                          }))
                        }
                        className="px-2 text-zinc-600 dark:text-zinc-400 hover:text-red-700 disabled:opacity-30"
                      >
                        ✕
                      </button>
                    </div>
                    {touched && err && (
                      <p
                        role="alert"
                        className="ml-8 mt-1 text-xs text-red-700 dark:text-red-300"
                      >
                        {err}
                      </p>
                    )}
                  </li>
                );
              })}
            </ul>
            <button
              type="button"
              disabled={draft.tests.length >= MAX_TESTS}
              onClick={() =>
                setDraft((d) => ({
                  ...d,
                  tests: [...d.tests, { args: "", expected: "" }],
                }))
              }
              className="mt-3 text-sm text-emerald-700 hover:underline disabled:opacity-50 dark:text-emerald-400"
            >
              + Adicionar teste
            </button>
          </section>

          <section>
            <h2 className="mb-1 text-lg font-semibold">
              Solução de referência
            </h2>
            <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
              Escreva uma solução correta para conferir se os testes estão
              certos. Ela é usada só aqui e <strong>não é salva</strong>, então
              os alunos nunca a veem. É obrigatória para publicar.
            </p>
            <CodeEditor
              value={solution}
              onChange={setSolution}
              onRun={() => void validate()}
              label="Solução de referência"
            />
            <div className="mt-3 flex flex-wrap items-center gap-3">
              <button
                type="button"
                onClick={() => void validate()}
                disabled={running}
                className="rounded-xl border border-emerald-600 bg-white dark:bg-zinc-900 px-5 py-2.5 font-medium text-emerald-700 hover:bg-emerald-50 disabled:opacity-50 dark:text-emerald-400 dark:hover:bg-emerald-950"
              >
                {running ? "Executando..." : "Validar testes (Ctrl+Enter)"}
              </button>
              {canPublish && (
                <span className="text-sm text-emerald-700 dark:text-emerald-400">
                  ✓ Testes validados
                </span>
              )}
              {result &&
                !canPublish &&
                validatedSnapshot === null &&
                !running && (
                  <span className="text-sm text-zinc-600 dark:text-zinc-400">
                    Validação desatualizada ou com falhas.
                  </span>
                )}
            </div>
            {result && (
              <div aria-live="polite" className="mt-3 space-y-1 text-sm">
                {result.fatal ? (
                  <p className="rounded-lg bg-red-50 p-3 text-red-800 dark:bg-red-950 dark:text-red-200">
                    {result.fatal}
                  </p>
                ) : (
                  <ul className="space-y-1">
                    {result.tests.map((t, i) => (
                      <li
                        key={i}
                        className={`rounded p-2 font-mono text-xs ${t.passed ? "bg-emerald-50 dark:bg-emerald-950" : "bg-red-50 dark:bg-red-950"}`}
                      >
                        {t.passed ? "✓" : "✗"} {draft.functionName}(
                        {t.args.map(show).join(", ")})
                        {!t.passed &&
                          (t.error
                            ? ` → erro: ${t.error}`
                            : ` → esperado ${show(t.expected)}, a solução retornou ${show(t.received)}`)}
                      </li>
                    ))}
                  </ul>
                )}
              </div>
            )}
          </section>
        </>
      )}

      {!isCode && attempted && validation.errors.length > 0 && (
        <ul
          role="alert"
          className="list-disc space-y-1 rounded-lg bg-red-50 p-3 pl-8 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
        >
          {validation.errors.map((e) => (
            <li key={e}>{e}</li>
          ))}
        </ul>
      )}
      {error && (isCode || validation.errors.length === 0) && (
        <p
          role="alert"
          className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
        >
          {error}
        </p>
      )}

      <div className="flex flex-wrap items-center gap-3 border-t border-zinc-200 pt-4 dark:border-zinc-800">
        <button
          type="button"
          onClick={() => void save(true)}
          disabled={saving || (isCode && !canPublish)}
          title={
            isCode && !canPublish
              ? "Valide os testes com uma solução de referência para publicar"
              : ""
          }
          className="rounded-xl bg-emerald-700 px-5 py-2.5 font-medium text-white hover:bg-emerald-800 disabled:opacity-50"
        >
          Salvar e publicar
        </button>
        <button
          type="button"
          onClick={() => void save(false)}
          disabled={saving}
          className="rounded-xl border border-zinc-300 bg-white dark:bg-zinc-900 px-5 py-2.5 disabled:opacity-50 dark:border-zinc-700"
        >
          Salvar como rascunho
        </button>
        {existing?.published && (
          <span className="text-xs text-zinc-600 dark:text-zinc-400">
            Salvar como rascunho tira o exercício da trilha dos alunos.
          </span>
        )}
      </div>
    </div>
  );
}
