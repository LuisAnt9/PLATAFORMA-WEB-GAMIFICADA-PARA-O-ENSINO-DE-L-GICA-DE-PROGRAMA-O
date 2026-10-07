"use client";

import Link from "next/link";
import { useState } from "react";
import {
  DIFFICULTY_LABEL,
  exercisesOf,
  type Exercise,
  type Module,
} from "@/lib/catalog";
import { newExerciseId } from "@/lib/exercise-draft";
import {
  createModule,
  setPublished,
  swapPositions,
  updateModule,
} from "@/lib/exercises-admin";
import { CatalogGate, useCatalog } from "./CatalogProvider";

function ModuleForm({
  initial,
  submitLabel,
  onSubmit,
  onCancel,
}: {
  initial: { title: string; focus: string };
  submitLabel: string;
  onSubmit: (title: string, focus: string) => Promise<void>;
  onCancel?: () => void;
}) {
  const [title, setTitle] = useState(initial.title);
  const [focus, setFocus] = useState(initial.focus);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    setBusy(true);
    setError(null);
    try {
      await onSubmit(title, focus);
      if (!onCancel) {
        setTitle("");
        setFocus("");
      }
    } catch (err) {
      setError((err as Error).message);
    }
    setBusy(false);
  }

  const field =
    "mt-1 w-full rounded-lg border border-zinc-300 bg-transparent px-3 py-2 text-sm dark:border-zinc-700";
  return (
    <form onSubmit={submit} className="flex flex-wrap items-end gap-3">
      <label className="min-w-40 flex-1 text-sm">
        Título do módulo
        <input
          className={field}
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          required
          maxLength={80}
        />
      </label>
      <label className="min-w-40 flex-[2] text-sm">
        Dificuldade de aprendizagem que trabalha
        <input
          className={field}
          value={focus}
          onChange={(e) => setFocus(e.target.value)}
          maxLength={200}
          placeholder="Ex.: Compreender o passo a passo de um laço"
        />
      </label>
      <button
        type="submit"
        disabled={busy}
        className="rounded-lg bg-emerald-600 px-4 py-2 text-sm font-medium text-white hover:bg-emerald-700 disabled:opacity-50"
      >
        {submitLabel}
      </button>
      {onCancel && (
        <button
          type="button"
          onClick={onCancel}
          className="px-2 py-2 text-sm text-zinc-500 hover:underline"
        >
          Cancelar
        </button>
      )}
      {error && (
        <p
          role="alert"
          className="basis-full text-sm text-red-700 dark:text-red-300"
        >
          {error}
        </p>
      )}
    </form>
  );
}

function Content() {
  const { catalog, reload } = useCatalog();
  const [editing, setEditing] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const modules = [...catalog.modules].sort((a, b) => a.position - b.position);

  async function run(action: () => Promise<void>) {
    setError(null);
    try {
      await action();
      await reload();
    } catch (e) {
      setError((e as Error).message);
    }
  }

  async function move(list: Exercise[], index: number, dir: -1 | 1) {
    const a = list[index];
    const b = list[index + dir];
    if (a && b) await run(() => swapPositions(a, b));
  }

  async function addModule(title: string, focus: string) {
    const id = newExerciseId(
      title,
      new Set(catalog.modules.map((m) => m.id)),
      Math.random,
      40,
    );
    const position =
      catalog.modules.reduce((m, x) => Math.max(m, x.position), 0) + 1;
    await createModule(id, title, focus, position);
    await reload();
  }

  async function renameModule(m: Module, title: string, focus: string) {
    await updateModule(m.id, title, focus);
    await reload();
    setEditing(null);
  }

  const tag = (e: Exercise) =>
    e.published ? (
      <span className="rounded bg-emerald-100 px-2 py-0.5 text-xs text-emerald-800 dark:bg-emerald-900 dark:text-emerald-200">
        Publicado
      </span>
    ) : (
      <span className="rounded bg-amber-100 px-2 py-0.5 text-xs text-amber-800 dark:bg-amber-900 dark:text-amber-200">
        Rascunho
      </span>
    );

  return (
    <>
      <div className="mb-6 flex flex-wrap items-end justify-between gap-3">
        <div>
          <h1 className="text-2xl font-semibold">Exercícios</h1>
          <p className="text-sm text-zinc-500">
            {catalog.exercises.length} exercícios em {modules.length} módulos.
            Só os publicados aparecem para os alunos.
          </p>
        </div>
        <Link
          href="/professor/exercicios/novo"
          className="rounded-lg bg-emerald-600 px-4 py-2 font-medium text-white hover:bg-emerald-700"
        >
          Novo exercício
        </Link>
      </div>

      {error && (
        <p
          role="alert"
          className="mb-4 rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
        >
          {error}
        </p>
      )}

      <div className="space-y-8">
        {modules.map((m) => {
          const list = exercisesOf(catalog, m.id);
          return (
            <section key={m.id}>
              {editing === m.id ? (
                <div className="mb-3 rounded-lg border border-zinc-200 p-3 dark:border-zinc-800">
                  <ModuleForm
                    initial={{ title: m.title, focus: m.focus }}
                    submitLabel="Salvar módulo"
                    onSubmit={(t, f) => renameModule(m, t, f)}
                    onCancel={() => setEditing(null)}
                  />
                </div>
              ) : (
                <div className="mb-2 flex items-baseline justify-between gap-3">
                  <div>
                    <h2 className="text-lg font-semibold">{m.title}</h2>
                    <p className="text-sm text-zinc-500">
                      {m.focus || "Sem descrição"}
                    </p>
                  </div>
                  <button
                    onClick={() => setEditing(m.id)}
                    className="text-sm text-zinc-500 hover:underline"
                  >
                    Editar módulo
                  </button>
                </div>
              )}
              {list.length === 0 ? (
                <p className="text-sm text-zinc-500">
                  Nenhum exercício neste módulo.
                </p>
              ) : (
                <ul className="divide-y divide-zinc-200 rounded-lg border border-zinc-200 dark:divide-zinc-800 dark:border-zinc-800">
                  {list.map((e, i) => (
                    <li
                      key={e.id}
                      className="flex flex-wrap items-center gap-x-4 gap-y-1 px-4 py-2 text-sm"
                    >
                      <div className="flex flex-col">
                        <button
                          aria-label={`Subir ${e.title}`}
                          disabled={i === 0}
                          onClick={() => void move(list, i, -1)}
                          className="text-xs leading-none text-zinc-500 hover:text-foreground disabled:opacity-20"
                        >
                          ▲
                        </button>
                        <button
                          aria-label={`Descer ${e.title}`}
                          disabled={i === list.length - 1}
                          onClick={() => void move(list, i, 1)}
                          className="text-xs leading-none text-zinc-500 hover:text-foreground disabled:opacity-20"
                        >
                          ▼
                        </button>
                      </div>
                      <div className="min-w-40 flex-1">
                        <div className="font-medium">{e.title}</div>
                        <div className="text-xs text-zinc-500">
                          {DIFFICULTY_LABEL[e.difficulty]} · {e.tests.length}{" "}
                          {e.tests.length === 1 ? "teste" : "testes"}
                        </div>
                      </div>
                      {tag(e)}
                      <div className="flex gap-3">
                        <Link
                          href={`/professor/exercicios/${e.id}`}
                          className="text-emerald-700 hover:underline dark:text-emerald-400"
                        >
                          Editar
                        </Link>
                        <Link
                          href={`/exercicio/${e.id}`}
                          className="text-zinc-500 hover:underline"
                        >
                          Ver como aluno
                        </Link>
                        {e.published && (
                          <button
                            onClick={() =>
                              void run(() => setPublished(e.id, false))
                            }
                            className="text-zinc-500 hover:underline"
                          >
                            Despublicar
                          </button>
                        )}
                      </div>
                    </li>
                  ))}
                </ul>
              )}
            </section>
          );
        })}
      </div>

      <section className="mt-10 rounded-lg border border-dashed border-zinc-300 p-4 dark:border-zinc-700">
        <h2 className="mb-3 font-semibold">Novo módulo</h2>
        <ModuleForm
          initial={{ title: "", focus: "" }}
          submitLabel="Criar módulo"
          onSubmit={addModule}
        />
      </section>
    </>
  );
}

export default function ExerciseAdmin() {
  return (
    <CatalogGate>
      <Content />
    </CatalogGate>
  );
}
