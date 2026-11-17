"use client";

import Link from "next/link";
import { useCallback } from "react";
import {
  KIND_NAME,
  STATUS_LABEL,
  formatDue,
  isPending,
  listMyAssignments,
  type MyAssignment,
} from "@/lib/assignments";
import { useLoader } from "@/lib/use-loader";
import { usePageTitle } from "@/lib/use-page-title";
import { useAuth } from "./AuthProvider";
import { Pill, card } from "./ui";

export function statusTone(s: MyAssignment["status"]) {
  return s === "concluida" || s === "entregue"
    ? "green"
    : s === "atrasada" || s === "nao_entregue" || s === "concluida_atrasada"
      ? "amber"
      : "neutral";
}

export function useMyAssignments() {
  const { profile } = useAuth();
  const uid = profile?.id ?? "";
  const load = useCallback(
    () => (uid ? listMyAssignments() : Promise.resolve([])),
    [uid],
  );
  return useLoader(`my-assignments:${uid}`, load);
}

export function AssignmentRow({ a }: { a: MyAssignment }) {
  return (
    <li>
      <Link
        href={`/atividades/${a.id}`}
        className={`${card} flex flex-wrap items-start justify-between gap-3 p-4 hover:border-emerald-400 dark:hover:border-emerald-700`}
      >
        <div className="min-w-0">
          <div className="font-medium">{a.title}</div>
          <div className="mt-0.5 text-sm text-zinc-600 dark:text-zinc-400">
            {KIND_NAME[a.kind]} · {a.class_name}
            {!a.required && " · opcional"}
          </div>
          <div className="mt-1 text-sm text-zinc-600 dark:text-zinc-400">
            Prazo: {formatDue(a.due_at)}
            {a.kind === "atividade" && (
              <>
                {" "}
                · {a.items_done}/{a.items_total} exercícios
              </>
            )}
            {a.kind === "avaliacao" &&
              a.score !== null &&
              ` · nota ${a.score}/${a.max_score}`}
          </div>
        </div>
        <Pill tone={statusTone(a.status)}>{STATUS_LABEL[a.status]}</Pill>
      </Link>
    </li>
  );
}

export default function MyAssignments() {
  usePageTitle("Minhas atividades");
  const { data, error } = useMyAssignments();
  const pending = (data ?? []).filter((a) => isPending(a.status));
  const done = (data ?? []).filter((a) => !isPending(a.status));
  return (
    <div className="space-y-8">
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">
          Minhas atividades
        </h1>
        <p className="mt-1 text-zinc-600 dark:text-zinc-400">
          Atividades e avaliações que o seu professor atribuiu à sua turma.
        </p>
      </header>
      {error && (
        <p
          role="alert"
          className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
        >
          Não foi possível carregar suas atividades: {error}
        </p>
      )}
      {!data && !error && (
        <p role="status" className="text-zinc-600 dark:text-zinc-400">
          Carregando...
        </p>
      )}
      {data && data.length === 0 && (
        <p className="text-zinc-600 dark:text-zinc-400">
          Você ainda não tem atividades. Elas aparecem aqui quando o professor
          atribuir algo à sua turma.
        </p>
      )}
      {pending.length > 0 && (
        <section aria-labelledby="pendentes">
          <h2 id="pendentes" className="mb-3 text-lg font-semibold">
            Pendentes
          </h2>
          <ul className="space-y-3">
            {pending.map((a) => (
              <AssignmentRow key={a.id} a={a} />
            ))}
          </ul>
        </section>
      )}
      {done.length > 0 && (
        <section aria-labelledby="concluidas">
          <h2 id="concluidas" className="mb-3 text-lg font-semibold">
            Concluídas e encerradas
          </h2>
          <ul className="space-y-3">
            {done.map((a) => (
              <AssignmentRow key={a.id} a={a} />
            ))}
          </ul>
        </section>
      )}
    </div>
  );
}
