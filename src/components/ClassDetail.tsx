"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useCallback, useState } from "react";
import { daysSince, memberSummaries } from "@/lib/class-stats";
import { useLoader } from "@/lib/use-loader";
import {
  deleteClass,
  getTeacherClass,
  loadClassData,
  removeMember,
  renameClass,
} from "@/lib/classes";
import { CatalogGate, useCatalog } from "./CatalogProvider";

function Content({ id }: { id: string }) {
  const router = useRouter();
  const { catalog } = useCatalog();
  const load = useCallback(async () => {
    const info = await getTeacherClass(id);
    return { info, data: info ? await loadClassData(id) : null };
  }, [id]);
  const {
    data: loaded,
    error: loadError,
    refresh,
  } = useLoader(`class:${id}`, load);
  const [nameDraft, setNameDraft] = useState<string | null>(null);
  const [msg, setMsg] = useState<{ ok: boolean; text: string } | null>(null);
  const [copied, setCopied] = useState(false);

  if (loadError)
    return (
      <p role="alert" className="text-red-700 dark:text-red-300">
        {loadError}
      </p>
    );
  if (!loaded) return <p className="text-zinc-500">Carregando...</p>;
  const { info, data } = loaded;
  if (!info)
    return (
      <div>
        <p className="mb-3">Turma não encontrada.</p>
        <Link
          href="/professor"
          className="text-emerald-700 hover:underline dark:text-emerald-400"
        >
          ← Minhas turmas
        </Link>
      </div>
    );
  const cls = info; // referência já sem null, usada nas funções abaixo
  const name = nameDraft ?? cls.name;

  const published = catalog.exercises.filter((e) => e.published);
  const summaries = data
    ? memberSummaries(data, new Set(published.map((e) => e.id)))
    : [];

  async function rename(e: React.FormEvent) {
    e.preventDefault();
    try {
      await renameClass(id, name.trim());
      setMsg({ ok: true, text: "Nome atualizado." });
      setNameDraft(null);
      await refresh();
    } catch (err) {
      setMsg({ ok: false, text: (err as Error).message });
    }
  }

  async function remove(studentId: string, studentName: string) {
    if (
      !window.confirm(
        `Remover ${studentName} da turma? O progresso do aluno não é apagado.`,
      )
    )
      return;
    try {
      await removeMember(id, studentId);
      await refresh();
    } catch (err) {
      setMsg({ ok: false, text: (err as Error).message });
    }
  }

  async function removeClass() {
    if (
      !window.confirm(
        `Apagar a turma "${cls.name}"? Os alunos mantêm o progresso, mas saem da turma.`,
      )
    )
      return;
    try {
      await deleteClass(id);
      router.push("/professor");
    } catch (err) {
      setMsg({ ok: false, text: (err as Error).message });
    }
  }

  async function copy() {
    try {
      await navigator.clipboard.writeText(cls.code);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      /* sem permissão de área de transferência: o código continua visível */
    }
  }

  return (
    <div className="space-y-8">
      <Link href="/professor" className="text-sm text-zinc-500 hover:underline">
        ← Minhas turmas
      </Link>
      <header className="flex flex-wrap items-end justify-between gap-4">
        <div>
          <h1 className="text-2xl font-semibold">{cls.name}</h1>
          <p className="text-sm text-zinc-500">
            {summaries.length} {summaries.length === 1 ? "aluno" : "alunos"} ·{" "}
            {published.length} exercícios publicados
          </p>
        </div>
        <div className="text-right">
          <div className="text-xs text-zinc-500">Código de entrada</div>
          <div className="flex items-center gap-2">
            <span className="font-mono text-2xl tracking-widest">
              {cls.code}
            </span>
            <button
              onClick={() => void copy()}
              className="rounded border border-zinc-300 px-2 py-1 text-xs dark:border-zinc-700"
            >
              {copied ? "Copiado!" : "Copiar"}
            </button>
          </div>
        </div>
      </header>

      <section>
        <h2 className="mb-3 text-lg font-semibold">Alunos</h2>
        {summaries.length === 0 ? (
          <p className="text-sm text-zinc-500">
            Nenhum aluno entrou ainda. Passe o código acima para a turma.
          </p>
        ) : (
          <div className="overflow-x-auto rounded-lg border border-zinc-200 dark:border-zinc-800">
            <table className="w-full text-sm">
              <caption className="sr-only">
                Desempenho dos alunos da turma
              </caption>
              <thead className="bg-zinc-50 text-left text-zinc-500 dark:bg-zinc-900">
                <tr>
                  <th scope="col" className="px-4 py-2">
                    Aluno
                  </th>
                  <th scope="col" className="px-4 py-2 text-right">
                    Resolvidos
                  </th>
                  <th scope="col" className="px-4 py-2 text-right">
                    XP
                  </th>
                  <th scope="col" className="px-4 py-2 text-right">
                    Tentativas
                  </th>
                  <th scope="col" className="px-4 py-2">
                    Última atividade
                  </th>
                  <th scope="col" className="px-4 py-2">
                    <span className="sr-only">Ações</span>
                  </th>
                </tr>
              </thead>
              <tbody>
                {summaries.map((s) => {
                  const d = daysSince(s.lastActivity);
                  return (
                    <tr
                      key={s.id}
                      className="border-t border-zinc-200 dark:border-zinc-800"
                    >
                      <td className="px-4 py-2">{s.name}</td>
                      <td className="px-4 py-2 text-right">
                        {s.solved}/{published.length}
                      </td>
                      <td className="px-4 py-2 text-right">{s.xp}</td>
                      <td className="px-4 py-2 text-right">{s.attempts}</td>
                      <td className="px-4 py-2 text-zinc-500">
                        {d === null
                          ? "nunca"
                          : d === 0
                            ? "hoje"
                            : `há ${d} ${d === 1 ? "dia" : "dias"}`}
                      </td>
                      <td className="px-4 py-2 text-right">
                        <button
                          onClick={() => void remove(s.id, s.name)}
                          className="text-zinc-500 hover:underline"
                        >
                          Remover
                        </button>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}
      </section>

      <section>
        <h2 className="mb-3 text-lg font-semibold">Configurações</h2>
        <form
          onSubmit={rename}
          className="flex max-w-md flex-wrap items-end gap-3"
        >
          <label className="flex-1 text-sm">
            Nome da turma
            <input
              value={name}
              onChange={(e) => setNameDraft(e.target.value)}
              required
              minLength={2}
              maxLength={80}
              className="mt-1 w-full rounded-lg border border-zinc-300 bg-transparent px-3 py-2 dark:border-zinc-700"
            />
          </label>
          <button
            type="submit"
            disabled={name.trim() === cls.name}
            className="rounded-lg bg-emerald-600 px-4 py-2 font-medium text-white hover:bg-emerald-700 disabled:opacity-50"
          >
            Salvar
          </button>
        </form>
        {msg && (
          <p
            role={msg.ok ? "status" : "alert"}
            className={`mt-2 text-sm ${msg.ok ? "text-emerald-700 dark:text-emerald-400" : "text-red-700 dark:text-red-300"}`}
          >
            {msg.text}
          </p>
        )}
        <button
          onClick={() => void removeClass()}
          className="mt-6 text-sm text-red-700 hover:underline dark:text-red-300"
        >
          Apagar esta turma
        </button>
      </section>
    </div>
  );
}

export default function ClassDetail({ id }: { id: string }) {
  return (
    <CatalogGate>
      <Content id={id} />
    </CatalogGate>
  );
}
