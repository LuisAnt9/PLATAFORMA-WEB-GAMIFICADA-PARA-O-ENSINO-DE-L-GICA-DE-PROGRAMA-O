"use client";

import { useRouter } from "next/navigation";
import { useCallback, useState } from "react";
import {
  KIND_NAME,
  RESULT_RULE_LABEL,
  STATUS_LABEL,
  assignmentReport,
  deleteAssignment,
  formatDue,
  formatDuration,
} from "@/lib/assignments";
import { useLoader } from "@/lib/use-loader";
import { usePageTitle } from "@/lib/use-page-title";
import ScrollRegion from "./ScrollRegion";
import { BackLink, Pill, card } from "./ui";

const th = "px-4 py-2";
const box = "rounded-2xl border border-zinc-200 bg-white shadow-sm dark:border-zinc-800 dark:bg-zinc-900";

export default function AssignmentReportView({ id }: { id: number }) {
  const router = useRouter();
  const load = useCallback(() => assignmentReport(id), [id]);
  const { data: r, error } = useLoader(`report:${id}`, load);
  const [msg, setMsg] = useState<string | null>(null);
  usePageTitle(r?.assignment.title ?? "Atividade");

  if (error)
    return (
      <div className="space-y-3">
        <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">
          {error}
        </p>
        <BackLink href="/professor/atividades">Atividades</BackLink>
      </div>
    );
  if (!r) return <p role="status">Carregando...</p>;
  const a = r.assignment;
  const isTest = a.kind === "avaliacao";
  const count = (s: string) => r.students.filter((x) => x.status === s).length;
  const doneCount = isTest ? count("entregue") : count("concluida") + count("concluida_atrasada");
  const scored = r.students.filter((s) => s.score !== null && s.max_score);
  const avg = scored.length
    ? scored.reduce((n, s) => n + (s.score ?? 0) / (s.max_score ?? 1), 0) / scored.length
    : null;

  async function remove() {
    if (!window.confirm(`Apagar "${a.title}"? As respostas e entregas dos alunos nesta atividade também serão apagadas.`)) return;
    try {
      await deleteAssignment(id);
      router.push("/professor/atividades");
    } catch (e) {
      setMsg((e as Error).message);
    }
  }

  return (
    <div className="space-y-8">
      <BackLink href="/professor/atividades">Atividades</BackLink>
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">{a.title}</h1>
        <div className="mt-2 flex flex-wrap items-center gap-2 text-sm text-zinc-600 dark:text-zinc-400">
          <Pill>{KIND_NAME[a.kind]}</Pill>
          <span>{a.class_name}</span>
          <span>· Disponível desde {formatDue(a.available_from)}</span>
          <span>· Prazo: {formatDue(a.due_at)}</span>
          {isTest && <span>· {RESULT_RULE_LABEL[a.result_rule]}</span>}
        </div>
        {a.instructions && <p className="mt-3 whitespace-pre-line">{a.instructions}</p>}
      </header>

      <section aria-label="Resumo" className="grid gap-3 sm:grid-cols-4">
        {[
          [`${r.students.length - count("nao_iniciada") - count("nao_entregue")}/${r.students.length}`, "iniciaram"],
          [`${doneCount}/${r.students.length}`, isTest ? "entregaram" : "concluíram"],
          [String(count("atrasada") + count("concluida_atrasada") + count("nao_entregue")), "com atraso ou sem entrega"],
          [avg === null ? "—" : `${Math.round(avg * 100)}%`, "aproveitamento médio"],
        ].map(([v, l]) => (
          <div key={l} className={`${card} p-4`}>
            <div className="text-2xl font-semibold">{v}</div>
            <div className="text-xs text-zinc-600 dark:text-zinc-400">{l}</div>
          </div>
        ))}
      </section>

      <section aria-labelledby="alunos">
        <h2 id="alunos" className="mb-3 text-lg font-semibold">Alunos</h2>
        <ScrollRegion label="Situação dos alunos" className={box}>
          <table className="w-full text-sm">
            <caption className="sr-only">Situação de cada aluno na atividade</caption>
            <thead className="bg-zinc-50 text-left text-zinc-600 dark:bg-zinc-900 dark:text-zinc-400">
              <tr>
                <th scope="col" className={th}>Aluno</th>
                <th scope="col" className={th}>Situação</th>
                <th scope="col" className={`${th} text-right`}>{isTest ? "Nota" : "Exercícios"}</th>
                <th scope="col" className={`${th} text-right`}>Tentativas</th>
                <th scope="col" className={`${th} text-right`}>Tempo</th>
              </tr>
            </thead>
            <tbody>
              {r.students.map((s) => (
                <tr key={s.id} className="border-t border-zinc-200 dark:border-zinc-800">
                  <td className={th}>{s.name}</td>
                  <td className={th}>
                    <Pill tone={s.status === "concluida" || s.status === "entregue" ? "green" : s.status === "atrasada" || s.status === "nao_entregue" || s.status === "concluida_atrasada" ? "amber" : "neutral"}>
                      {STATUS_LABEL[s.status]}
                    </Pill>
                  </td>
                  <td className={`${th} text-right`}>
                    {isTest ? (s.score === null ? "—" : `${s.score}/${s.max_score}`) : `${s.items_done}/${s.items_total}`}
                  </td>
                  <td className={`${th} text-right`}>{s.attempts}</td>
                  <td className={`${th} text-right`}>{formatDuration(s.duration_ms)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </ScrollRegion>
      </section>

      <section aria-labelledby="porexercicio">
        <h2 id="porexercicio" className="mb-3 text-lg font-semibold">Desempenho por exercício</h2>
        <ScrollRegion label="Desempenho por exercício" className={box}>
          <table className="w-full text-sm">
            <caption className="sr-only">Quantos alunos tentaram e acertaram cada exercício</caption>
            <thead className="bg-zinc-50 text-left text-zinc-600 dark:bg-zinc-900 dark:text-zinc-400">
              <tr>
                <th scope="col" className={th}>Exercício</th>
                <th scope="col" className={`${th} text-right`}>Tentaram</th>
                <th scope="col" className={`${th} text-right`}>Acertaram</th>
                <th scope="col" className={`${th} text-right`}>Tentativas</th>
              </tr>
            </thead>
            <tbody>
              {r.exercises.map((e) => (
                <tr key={e.exercise_id} className="border-t border-zinc-200 dark:border-zinc-800">
                  <td className={th}>{e.title}</td>
                  <td className={`${th} text-right`}>{e.attempted}</td>
                  <td className={`${th} text-right`}>{e.solved}</td>
                  <td className={`${th} text-right`}>{e.attempts}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </ScrollRegion>
      </section>

      <section aria-labelledby="porconceito">
        <h2 id="porconceito" className="mb-1 text-lg font-semibold">Desempenho por conceito</h2>
        <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
          Considera só as tentativas feitas nesta atividade. Com menos de 3
          tentativas, os dados são insuficientes para concluir algo.
        </p>
        {r.concepts.length === 0 ? (
          <p className="text-sm text-zinc-600 dark:text-zinc-400">Ainda não há tentativas.</p>
        ) : (
          <ul className="grid gap-3 sm:grid-cols-2">
            {r.concepts.map((c) => (
              <li key={c.concept_id} className={`${card} p-4 text-sm`}>
                <div className="font-medium">{c.title}</div>
                <div className="text-zinc-600 dark:text-zinc-400">
                  {c.attempts < 3
                    ? `Dados insuficientes (${c.attempts} ${c.attempts === 1 ? "tentativa" : "tentativas"})`
                    : `${c.wrong} erros em ${c.attempts} tentativas (${Math.round((c.wrong / c.attempts) * 100)}%)`}
                </div>
              </li>
            ))}
          </ul>
        )}
      </section>

      {msg && <p role="alert" className="text-sm text-red-700 dark:text-red-300">{msg}</p>}
      <button onClick={() => void remove()} className="text-sm text-red-700 hover:underline dark:text-red-300">
        Apagar esta atividade
      </button>
    </div>
  );
}
