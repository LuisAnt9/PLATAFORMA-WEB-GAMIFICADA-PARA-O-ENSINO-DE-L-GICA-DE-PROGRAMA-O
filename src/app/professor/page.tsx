"use client";

import Link from "next/link";
import { useCallback, useState } from "react";
import { useLoader } from "@/lib/use-loader";
import { useAuth } from "@/components/AuthProvider";
import ProfessorOnly from "@/components/ProfessorOnly";
import { createClass, listTeacherClasses } from "@/lib/classes";

function Classes() {
  const { profile } = useAuth();
  const userId = profile?.id ?? "";
  const load = useCallback(() => listTeacherClasses(userId), [userId]);
  const {
    data: classes,
    error: loadError,
    refresh,
  } = useLoader(`teacher-classes:${userId}`, load);
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
      <h1 className="mb-1 text-2xl font-semibold">Minhas turmas</h1>
      <p className="mb-6 text-sm text-zinc-500">
        Crie uma turma e passe o código aos alunos. Eles entram pela página{" "}
        <strong>Perfil</strong>.
      </p>

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
            className="mt-1 w-full rounded-lg border border-zinc-300 bg-transparent px-3 py-2 dark:border-zinc-700"
          />
        </label>
        <button
          type="submit"
          disabled={busy}
          className="rounded-lg bg-emerald-600 px-4 py-2 font-medium text-white hover:bg-emerald-700 disabled:opacity-50"
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
      {classes === null && <p className="text-zinc-500">Carregando...</p>}
      {classes && classes.length === 0 && (
        <p className="text-zinc-500">Você ainda não criou nenhuma turma.</p>
      )}
      {classes && classes.length > 0 && (
        <ul className="grid gap-3 sm:grid-cols-2">
          {classes.map((c) => (
            <li key={c.id}>
              <Link
                href={`/professor/turmas/${c.id}`}
                className="block rounded-lg border border-zinc-200 p-4 hover:border-emerald-500 dark:border-zinc-800"
              >
                <div className="font-medium">{c.name}</div>
                <div className="mt-1 text-sm text-zinc-500">
                  {c.members} {c.members === 1 ? "aluno" : "alunos"}
                </div>
                <div className="mt-3 text-xs text-zinc-500">
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
    </>
  );
}

export default function ProfessorPage() {
  return (
    <ProfessorOnly>
      <Classes />
    </ProfessorOnly>
  );
}
