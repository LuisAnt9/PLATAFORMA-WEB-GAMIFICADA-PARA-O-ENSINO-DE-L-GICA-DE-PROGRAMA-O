"use client";

import { usePageTitle } from "@/lib/use-page-title";
import Link from "next/link";
import { useCallback, useState } from "react";
import { useLoader } from "@/lib/use-loader";
import { useAuth } from "@/components/AuthProvider";
import { createClass, listTeacherClasses } from "@/lib/classes";
import { completionRate, formatDue } from "@/lib/assignments";
import { useSummaries } from "@/components/TeacherAssignments";

function Classes() {
  usePageTitle("Turmas");
  const { profile } = useAuth();
  const userId = profile?.id ?? "";
  const load = useCallback(() => listTeacherClasses(userId), [userId]);
  const {
    data: classes,
    error: loadError,
    refresh,
  } = useLoader(`teacher-classes:${userId}`, load);
  const { data: summaries } = useSummaries();
  const [now] = useState(() => Date.now());
  const [name, setName] = useState("");
  const [actionError, setActionError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const error = actionError ?? loadError;

  async function create(e: React.FormEvent) {
    e.preventDefault();
    setBusy(true);
    setActionError(null);
    try {
      await createClass(name.trim());
      setName("");
      await refresh();
    } catch (err) {
      setActionError((err as Error).message);
    }
    setBusy(false);
  }

  return (
    <>
      <h1 className="mb-1 text-2xl font-semibold tracking-tight">
        Minhas turmas
      </h1>
      <p className="mb-6 text-sm text-zinc-600 dark:text-zinc-400">
        Crie uma turma e passe o código aos alunos. Eles entram pela página{" "}
        <strong>Perfil</strong>.
      </p>

      {summaries && (
        <section aria-label="Resumo das atividades" className="mb-8">
          <div className="grid gap-3 sm:grid-cols-4">
            {(() => {
              const open = summaries.filter((a) => !a.archived && new Date(a.due_at).getTime() >= now);
              const rate = summaries.length
                ? summaries.reduce((n, a) => n + completionRate(a), 0) / summaries.length
                : null;
              return [
                [String((classes ?? []).filter((c) => !c.archived).length), "turmas ativas"],
                [String(summaries.length), "atividades atribuídas"],
                [String(open.length), "com prazo em aberto"],
                [rate === null ? "—" : `${Math.round(rate * 100)}%`, "conclusão média"],
              ].map(([v, l]) => (
                <div key={l} className="rounded-2xl border border-zinc-200 bg-white p-4 shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
                  <div className="text-2xl font-semibold">{v}</div>
                  <div className="text-xs text-zinc-600 dark:text-zinc-400">{l}</div>
                </div>
              ));
            })()}
          </div>
          {summaries.filter((a) => new Date(a.due_at).getTime() >= now).slice(0, 3).length > 0 && (
            <ul className="mt-4 space-y-1 text-sm">
              {summaries.filter((a) => new Date(a.due_at).getTime() >= now).slice(0, 3).map((a) => (
                <li key={a.id}>
                  <Link href={`/professor/atividades/${a.id}`} className="text-emerald-700 hover:underline dark:text-emerald-400">
                    {a.title}
                  </Link>{" "}
                  <span className="text-zinc-600 dark:text-zinc-400">
                    · {a.class_name} · prazo {formatDue(a.due_at)} · {a.completed}/{a.students} concluíram
                  </span>
                </li>
              ))}
            </ul>
          )}
        </section>
      )}

      <form
        onSubmit={create}
        className="mb-8 flex max-w-lg flex-wrap items-end gap-3"
      >
        <label className="flex-1 text-sm">
          Nome da nova turma
          <input
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
            minLength={2}
            maxLength={80}
            placeholder="Ex.: Lógica de Programação — 2026.2"
            className="mt-1 w-full rounded-xl border border-zinc-300 bg-white dark:bg-zinc-950 px-3 py-2 dark:border-zinc-700"
          />
        </label>
        <button
          type="submit"
          disabled={busy}
          className="rounded-xl bg-emerald-700 px-5 py-2.5 font-medium text-white hover:bg-emerald-800 disabled:opacity-50"
        >
          Criar turma
        </button>
      </form>

      {error && (
        <p
          role="alert"
          className="mb-4 rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
        >
          {error}
        </p>
      )}
      {classes === null && (
        <p className="text-zinc-600 dark:text-zinc-400">Carregando...</p>
      )}
      {classes && classes.length === 0 && (
        <p className="text-zinc-600 dark:text-zinc-400">
          Você ainda não criou nenhuma turma.
        </p>
      )}
      {classes && classes.length > 0 && (
        <ul className="grid gap-3 sm:grid-cols-2">
          {classes.filter((c) => !c.archived).map((c) => (
            <li key={c.id}>
              <Link
                href={`/professor/turmas/${c.id}`}
                className="block rounded-lg border border-zinc-200 p-4 hover:border-emerald-500 dark:border-zinc-800"
              >
                <div className="font-medium">{c.name}</div>
                <div className="mt-1 text-sm text-zinc-600 dark:text-zinc-400">
                  {c.members} {c.members === 1 ? "aluno" : "alunos"}
                </div>
                <div className="mt-3 text-xs text-zinc-600 dark:text-zinc-400">
                  Código de entrada
                </div>
                <div className="font-mono text-xl tracking-widest">
                  {c.code}
                </div>
              </Link>
            </li>
          ))}
        </ul>
      )}
      {classes && classes.some((c) => c.archived) && (
        <details className="mt-8">
          <summary className="cursor-pointer text-sm font-medium">
            Turmas arquivadas ({classes.filter((c) => c.archived).length})
          </summary>
          <ul className="mt-3 grid gap-3 sm:grid-cols-2">
            {classes.filter((c) => c.archived).map((c) => (
              <li key={c.id}>
                <Link
                  href={`/professor/turmas/${c.id}`}
                  className="block rounded-lg border border-dashed border-zinc-300 p-4 hover:border-emerald-500 dark:border-zinc-700"
                >
                  <div className="font-medium">{c.name}</div>
                  <div className="text-sm text-zinc-600 dark:text-zinc-400">
                    {c.members} {c.members === 1 ? "aluno" : "alunos"}
                  </div>
                </Link>
              </li>
            ))}
          </ul>
        </details>
      )}
    </>
  );
}

export default function ProfessorPage() {
  return <Classes />;
}
