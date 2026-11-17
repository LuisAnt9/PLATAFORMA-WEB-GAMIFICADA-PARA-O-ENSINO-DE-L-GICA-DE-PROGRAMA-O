"use client";

import Link from "next/link";
import { useCallback, useState } from "react";
import {
  KIND_NAME,
  completionRate,
  formatDue,
  teacherSummaries,
} from "@/lib/assignments";
import { useLoader } from "@/lib/use-loader";
import { usePageTitle } from "@/lib/use-page-title";
import { useAuth } from "./AuthProvider";
import ScrollRegion from "./ScrollRegion";
import { Pill, primaryButton } from "./ui";

export function useSummaries() {
  const { profile } = useAuth();
  const uid = profile?.id ?? "";
  const load = useCallback(
    () => (uid ? teacherSummaries() : Promise.resolve([])),
    [uid],
  );
  return useLoader(`teacher-assignments:${uid}`, load);
}

export default function TeacherAssignments() {
  usePageTitle("Atividades");
  const { data, error } = useSummaries();
  const [now] = useState(() => Date.now());
  return (
    <div className="space-y-6">
      <header className="flex flex-wrap items-end justify-between gap-3">
        <div>
          <h1 className="text-2xl font-semibold tracking-tight">Atividades</h1>
          <p className="mt-1 text-sm text-zinc-600 dark:text-zinc-400">
            Atividades para casa e avaliações atribuídas às suas turmas.
          </p>
        </div>
        <Link href="/professor/atividades/nova" className={primaryButton}>
          Nova atividade
        </Link>
      </header>
      {error && (
        <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">
          {error}
        </p>
      )}
      {!data && !error && <p role="status">Carregando...</p>}
      {data && data.length === 0 && (
        <p className="text-zinc-600 dark:text-zinc-400">
          Você ainda não atribuiu nenhuma atividade. Use &quot;Nova
          atividade&quot; para começar.
        </p>
      )}
      {data && data.length > 0 && (
        <ScrollRegion
          label="Atividades atribuídas"
          className="rounded-2xl border border-zinc-200 bg-white shadow-sm dark:border-zinc-800 dark:bg-zinc-900"
        >
          <table className="w-full text-sm">
            <caption className="sr-only">Atividades e conclusão por turma</caption>
            <thead className="bg-zinc-50 text-left text-zinc-600 dark:bg-zinc-900 dark:text-zinc-400">
              <tr>
                <th scope="col" className="px-4 py-2">Atividade</th>
                <th scope="col" className="px-4 py-2">Turma</th>
                <th scope="col" className="px-4 py-2">Prazo</th>
                <th scope="col" className="px-4 py-2 text-right">Iniciaram</th>
                <th scope="col" className="px-4 py-2 text-right">Concluíram</th>
              </tr>
            </thead>
            <tbody>
              {data.map((s) => (
                <tr key={s.id} className="border-t border-zinc-200 dark:border-zinc-800">
                  <td className="px-4 py-2">
                    <Link
                      href={`/professor/atividades/${s.id}`}
                      className="font-medium text-emerald-700 hover:underline dark:text-emerald-400"
                    >
                      {s.title}
                    </Link>{" "}
                    <Pill>{KIND_NAME[s.kind]}</Pill>
                    {new Date(s.due_at).getTime() < now && (
                      <span className="ml-1"><Pill>Encerrada</Pill></span>
                    )}
                  </td>
                  <td className="px-4 py-2">{s.class_name}</td>
                  <td className="px-4 py-2">{formatDue(s.due_at)}</td>
                  <td className="px-4 py-2 text-right">{s.started}/{s.students}</td>
                  <td className="px-4 py-2 text-right">
                    {s.completed}/{s.students} ({Math.round(completionRate(s) * 100)}%)
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </ScrollRegion>
      )}
    </div>
  );
}
