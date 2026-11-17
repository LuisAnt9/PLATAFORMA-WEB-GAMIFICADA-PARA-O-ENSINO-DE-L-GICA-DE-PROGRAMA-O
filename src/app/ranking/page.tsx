"use client";

import { usePageTitle } from "@/lib/use-page-title";
import ScrollRegion from "@/components/ScrollRegion";
import { useEffect, useState } from "react";
import { getSupabase } from "@/lib/supabase";
import { useAuth } from "@/components/AuthProvider";
import RankingOptIn from "@/components/RankingOptIn";

interface Row {
  pos: number;
  display_name: string;
  total_xp: number;
  solved: number;
  is_me: boolean;
}

const MEDAL = ["🥇", "🥈", "🥉"];

export default function RankingPage() {
  usePageTitle("Ranking");
  const { profile } = useAuth();
  const [version, setVersion] = useState(0);
  const [rows, setRows] = useState<Row[] | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;
    getSupabase()
      .rpc("leaderboard", { lim: 20 })
      .then(({ data, error }) => {
        if (cancelled) return;
        if (error) setError(error.message);
        else
          setRows(
            (data as Row[]).map((r) => ({
              ...r,
              pos: Number(r.pos),
              total_xp: Number(r.total_xp),
              solved: Number(r.solved),
            })),
          );
      });
    return () => {
      cancelled = true;
    };
  }, [version]);

  return (
    <>
      <h1 className="mb-1 text-2xl font-semibold tracking-tight">Ranking</h1>
      <p className="mb-4 text-sm text-zinc-600 dark:text-zinc-400">
        Só aparecem colegas da sua turma que escolheram participar, com o nome
        abreviado. O ranking é um extra: o que libera as lições é o domínio do
        conteúdo, nunca o XP.
      </p>
      <div className="mb-6 rounded-2xl border border-zinc-200 bg-white p-4 shadow-sm dark:border-zinc-800 dark:bg-zinc-900">
        <RankingOptIn onChange={() => setVersion((v) => v + 1)} />
      </div>

      {error && (
        <p
          role="alert"
          className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
        >
          Não foi possível carregar o ranking: {error}
        </p>
      )}
      {!rows && !error && (
        <p role="status" className="text-zinc-500 dark:text-zinc-400">
          Carregando...
        </p>
      )}
      {rows && rows.length === 0 && (
        <p className="text-zinc-500 dark:text-zinc-400">
          {profile?.role === "aluno"
            ? "Ninguém da sua turma está no ranking ainda. Se você estiver em uma turma, marque a opção acima para participar."
            : "Nenhum aluno das suas turmas escolheu aparecer no ranking."}
        </p>
      )}

      {rows && rows.length > 0 && (
        <ScrollRegion
          label="Ranking de alunos"
          className="rounded-2xl border border-zinc-200 bg-white shadow-sm dark:border-zinc-800 dark:bg-zinc-900"
        >
          <table className="w-full text-sm">
            <caption className="sr-only">Ranking de alunos por XP</caption>
            <thead className="bg-zinc-50 text-left text-zinc-500 dark:text-zinc-400 dark:bg-zinc-900">
              <tr>
                <th scope="col" className="w-16 px-4 py-2">
                  #
                </th>
                <th scope="col" className="px-4 py-2">
                  Aluno
                </th>
                <th scope="col" className="px-4 py-2 text-right">
                  Exercícios
                </th>
                <th scope="col" className="px-4 py-2 text-right">
                  XP
                </th>
              </tr>
            </thead>
            <tbody>
              {rows.map((r, i) => (
                <tr
                  key={`${r.pos}-${r.display_name}-${i}`}
                  className={`border-t border-zinc-200 dark:border-zinc-800 ${r.is_me ? "bg-emerald-50 font-medium dark:bg-emerald-950" : ""}`}
                >
                  <td className="px-4 py-2">{MEDAL[r.pos - 1] ?? r.pos}</td>
                  <td className="px-4 py-2">
                    {r.display_name}
                    {r.is_me && (
                      <span className="ml-2 text-xs text-emerald-700 dark:text-emerald-400">
                        (você)
                      </span>
                    )}
                  </td>
                  <td className="px-4 py-2 text-right">{r.solved}</td>
                  <td className="px-4 py-2 text-right">{r.total_xp}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </ScrollRegion>
      )}
    </>
  );
}
