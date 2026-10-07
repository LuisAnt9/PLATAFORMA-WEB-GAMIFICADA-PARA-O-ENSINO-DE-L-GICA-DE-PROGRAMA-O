"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useMemo, useState } from "react";
import {
  DIFFICULTY_LABEL,
  type Difficulty,
  type Exercise,
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
import { runExercise, type RunResult } from "@/lib/runner";
import { useAuth } from "./AuthProvider";
import { useCatalog } from "./CatalogProvider";
import CodeEditor from "./CodeEditor";

const input =
  "mt-1 w-full rounded-lg border border-zinc-300 bg-transparent px-3 py-2 dark:border-zinc-700";
const show = (v: unknown) =>
  v === undefined ? "undefined" : JSON.stringify(v);

export default function ExerciseForm({ existing }: { existing?: Exercise }) {
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
  // A validação com a solução de referência só vale para este nome de função, estes testes e esta solução.
  const snapshot = JSON.stringify([
    draft.functionName.trim(),
    draft.tests,
    solution,
  ]);
  const canPublish = validatedSnapshot === snapshot;

  function set<K extends keyof Draft>(key: K, value: Draft[K]) {
    setDraft((d) => ({ ...d, [key]: value }));
  }
  function setTest(i: number, key: "args" | "expected", value: string) {
    setDraft((d) => ({
      ...d,
      tests: d.tests.map((t, j) => (j === i ? { ...t, [key]: value } : t)),
    }));
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
    if (publish && !canPublish)
      return setError(
        "Para publicar, valide os testes com uma solução de referência que passe em todos.",
      );
    if (!profile) return;
    setSaving(true);
    try {
      if (existing) {
        await updateExercise(
          existing,
          draft,
          validation.tests,
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
          validation.tests,
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

  return (
    <div className="space-y-8">
      <Link
        href="/professor/exercicios"
        className="text-sm text-zinc-500 hover:underline"
      >
        ← Exercícios
      </Link>
      <h1 className="text-2xl font-semibold">
        {existing ? "Editar exercício" : "Novo exercício"}
      </h1>

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
          Enunciado
          <textarea
            className={`${input} h-28`}
            value={draft.statement}
            onChange={(e) => set("statement", e.target.value)}
            maxLength={2000}
          />
        </label>
        <label className="text-sm">
          Nome da função
          <input
            className={`${input} font-mono`}
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
            className={`${input} font-mono`}
            value={draft.params}
            onChange={(e) => set("params", e.target.value)}
            placeholder="a, b"
            autoCapitalize="off"
            spellCheck={false}
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
        {draft.functionName.trim() && fnOk && (
          <div className="text-sm sm:col-span-2">
            <div className="text-zinc-500">Código inicial que o aluno verá</div>
            <pre className="mt-1 overflow-x-auto rounded-lg bg-zinc-100 p-3 font-mono text-xs dark:bg-zinc-900">
              {buildStarterCode(draft.functionName.trim(), draft.params)}
            </pre>
          </div>
        )}
      </section>

      <section>
        <h2 className="mb-1 text-lg font-semibold">Casos de teste</h2>
        <p className="mb-3 text-sm text-zinc-500">
          Escreva em JSON. Entradas: <code>2, 3</code> ou <code>[1, 2, 3]</code>{" "}
          ou <code>&quot;abc&quot;</code>. Esperado: <code>5</code>,{" "}
          <code>&quot;par&quot;</code>, <code>true</code> ou <code>[1, 2]</code>
          . Os casos de teste ficam visíveis para os alunos, pois a correção
          roda no navegador.
        </p>
        <ul className="space-y-2">
          {draft.tests.map((t, i) => {
            const err = validation.testErrors[i];
            const touched = attempted || t.args !== "" || t.expected !== "";
            return (
              <li key={i}>
                <div className="flex flex-wrap items-center gap-2">
                  <span className="w-6 text-sm text-zinc-500">{i + 1}.</span>
                  <input
                    aria-label={`Entradas do teste ${i + 1}`}
                    placeholder="entradas: 2, 3"
                    className="min-w-0 flex-1 rounded-lg border border-zinc-300 bg-transparent px-3 py-2 font-mono text-sm dark:border-zinc-700"
                    value={t.args}
                    onChange={(e) => setTest(i, "args", e.target.value)}
                  />
                  <span aria-hidden>→</span>
                  <input
                    aria-label={`Resultado esperado do teste ${i + 1}`}
                    placeholder="esperado: 5"
                    className="min-w-0 flex-1 rounded-lg border border-zinc-300 bg-transparent px-3 py-2 font-mono text-sm dark:border-zinc-700"
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
                    className="px-2 text-zinc-500 hover:text-red-700 disabled:opacity-30"
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
        <h2 className="mb-1 text-lg font-semibold">Solução de referência</h2>
        <p className="mb-3 text-sm text-zinc-500">
          Escreva uma solução correta para conferir se os testes estão certos.
          Ela é usada só aqui e <strong>não é salva</strong>, então os alunos
          nunca a veem. É obrigatória para publicar.
        </p>
        <CodeEditor
          value={solution}
          onChange={setSolution}
          onRun={() => void validate()}
        />
        <div className="mt-3 flex flex-wrap items-center gap-3">
          <button
            type="button"
            onClick={() => void validate()}
            disabled={running}
            className="rounded-lg border border-emerald-600 px-4 py-2 font-medium text-emerald-700 hover:bg-emerald-50 disabled:opacity-50 dark:text-emerald-400 dark:hover:bg-emerald-950"
          >
            {running ? "Executando..." : "Validar testes (Ctrl+Enter)"}
          </button>
          {canPublish && (
            <span className="text-sm text-emerald-700 dark:text-emerald-400">
              ✓ Testes validados
            </span>
          )}
          {result && !canPublish && validatedSnapshot === null && !running && (
            <span className="text-sm text-zinc-500">
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

      {error && (
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
          disabled={saving || !canPublish}
          title={
            canPublish
              ? ""
              : "Valide os testes com uma solução de referência para publicar"
          }
          className="rounded-lg bg-emerald-600 px-4 py-2 font-medium text-white hover:bg-emerald-700 disabled:opacity-50"
        >
          Salvar e publicar
        </button>
        <button
          type="button"
          onClick={() => void save(false)}
          disabled={saving}
          className="rounded-lg border border-zinc-300 px-4 py-2 disabled:opacity-50 dark:border-zinc-700"
        >
          Salvar como rascunho
        </button>
        {existing?.published && (
          <span className="text-xs text-zinc-500">
            Salvar como rascunho tira o exercício da trilha dos alunos.
          </span>
        )}
      </div>
    </div>
  );
}
