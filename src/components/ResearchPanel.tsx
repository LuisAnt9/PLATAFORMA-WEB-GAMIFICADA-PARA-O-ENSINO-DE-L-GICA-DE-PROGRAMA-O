"use client";

import { useCallback, useState } from "react";
import { listTeacherClasses } from "@/lib/classes";
import { downloadFile } from "@/lib/privacy";
import { ITEMS, susBand } from "@/lib/surveys";
import { exportCsv, loadAiComparison, loadSummary } from "@/lib/survey-client";
import { useLoader } from "@/lib/use-loader";
import { usePageTitle } from "@/lib/use-page-title";
import { useAuth } from "./AuthProvider";
import ScrollRegion from "./ScrollRegion";
import { Pill, card, primaryButton } from "./ui";

const box = "rounded-2xl border border-zinc-200 bg-white shadow-sm dark:border-zinc-800 dark:bg-zinc-900";

export default function ResearchPanel() {
  usePageTitle("Pesquisa");
  const { profile } = useAuth();
  const uid = profile?.id ?? "";
  const [classId, setClassId] = useState("");
  const loadClasses = useCallback(() => listTeacherClasses(uid), [uid]);
  const { data: classes } = useLoader(`research-classes:${uid}`, loadClasses);
  const load = useCallback(
    async () => ({
      summary: await loadSummary(classId || null),
      ai: await loadAiComparison(classId || null),
    }),
    [classId],
  );
  const { data, error } = useLoader(`research:${classId}`, load);
  const [busy, setBusy] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);

  async function download() {
    setBusy(true);
    setMsg(null);
    try {
      const csv = await exportCsv(classId || null);
      // BOM para o Excel reconhecer os acentos (UTF-8)
      downloadFile("respostas-pesquisa.csv", "﻿" + csv, "text/csv;charset=utf-8");
      const linhas = Math.max(0, csv.split("\n").length - 1);
      setMsg(`Arquivo gerado com ${linhas} ${linhas === 1 ? "resposta" : "respostas"}.`);
    } catch (e) {
      setMsg((e as Error).message);
    }
    setBusy(false);
  }

  return (
    <div className="space-y-8">
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">Pesquisa</h1>
        <p className="mt-1 text-sm text-zinc-600 dark:text-zinc-400">
          Resultados dos questionários SUS (usabilidade) e Likert (experiência de aprendizagem) respondidos pelos alunos das suas
          turmas. Com menos de 5 respostas, só mostramos a contagem, para não identificar ninguém.
        </p>
      </header>

      <div className="flex flex-wrap items-end gap-4 text-sm">
        <label>
          Turma
          <select
            value={classId}
            onChange={(e) => setClassId(e.target.value)}
            className="mt-1 block rounded-xl border border-zinc-300 bg-white px-3 py-2 dark:border-zinc-700 dark:bg-zinc-950"
          >
            <option value="">Todas as turmas</option>
            {(classes ?? []).map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </label>
        <button type="button" onClick={() => void download()} disabled={busy} className={`${primaryButton} disabled:opacity-50`}>
          Baixar respostas (CSV)
        </button>
      </div>
      {msg && <p role="status" className="text-sm">{msg}</p>}
      {error && <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">{error}. A migration 0017 já foi aplicada?</p>}
      {!data && !error && <p role="status">Carregando...</p>}

      {data && (
        <>
          <section aria-labelledby="sus-resumo" className={`${card} p-5`}>
            <h2 id="sus-resumo" className="mb-2 text-lg font-semibold">SUS: usabilidade</h2>
            {!data.summary.sus.sufficient ? (
              <p className="text-sm text-zinc-600 dark:text-zinc-400">
                Dados insuficientes: {data.summary.sus.n} {data.summary.sus.n === 1 ? "resposta" : "respostas"} (o resumo aparece com 5 ou mais).
              </p>
            ) : (
              <>
                <p className="text-3xl font-semibold">
                  {data.summary.sus.mean_score} <span className="text-base font-normal text-zinc-600 dark:text-zinc-400">de 100</span>
                </p>
                <p className="mt-1 text-sm">
                  Média de {data.summary.sus.n} respostas ({data.summary.sus.anonymous} anônimas):{" "}
                  <Pill>{susBand(data.summary.sus.mean_score ?? 0)}</Pill>
                </p>
                <p className="mt-2 text-xs text-zinc-600 dark:text-zinc-400">
                  Pontuação SUS: itens ímpares valem (resposta - 1), pares valem (5 - resposta); soma × 2,5. A média de referência na literatura é 68.
                </p>
              </>
            )}
          </section>

          <section aria-labelledby="likert-resumo">
            <h2 id="likert-resumo" className="mb-2 text-lg font-semibold">Likert: experiência de aprendizagem</h2>
            {!data.summary.likert.sufficient ? (
              <p className="text-sm text-zinc-600 dark:text-zinc-400">
                Dados insuficientes: {data.summary.likert.n} {data.summary.likert.n === 1 ? "resposta" : "respostas"} (o resumo aparece com 5 ou mais).
              </p>
            ) : (
              <ScrollRegion label="Médias por afirmação da escala Likert" className={box}>
                <table className="w-full text-sm">
                  <caption className="sr-only">Média de cada afirmação (1 a 5)</caption>
                  <thead className="bg-zinc-50 text-left text-zinc-600 dark:bg-zinc-900 dark:text-zinc-400">
                    <tr>
                      <th scope="col" className="px-4 py-2">Afirmação</th>
                      <th scope="col" className="px-4 py-2 text-right">Média (1 a 5)</th>
                    </tr>
                  </thead>
                  <tbody>
                    {ITEMS.likert.map((t, i) => (
                      <tr key={t} className="border-t border-zinc-200 dark:border-zinc-800">
                        <td className="px-4 py-2">{t}</td>
                        <td className="px-4 py-2 text-right">{data.summary.likert.item_means?.[String(i + 1)] ?? "—"}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </ScrollRegion>
            )}
          </section>

          <section aria-labelledby="ia-comparacao" className={`${card} p-5`}>
            <h2 id="ia-comparacao" className="mb-1 text-lg font-semibold">Dica com IA: com e sem uso</h2>
            <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
              Compara, de forma agregada, quem usou a dica com IA ao menos uma vez e quem nunca usou. Não mostra dados de nenhum aluno e só aparece com 5 ou
              mais alunos em cada grupo. Atenção: a diferença não prova que a dica causa o resultado (os grupos podem ser diferentes por outros motivos).
            </p>
            {!data.ai.sufficient ? (
              <p className="text-sm">
                Dados insuficientes: {data.ai.com_ia ?? 0} alunos com IA e {data.ai.sem_ia ?? 0} sem IA (mínimo {data.ai.min} em cada grupo).
              </p>
            ) : (
              <ScrollRegion label="Comparação entre quem usou e quem não usou a dica com IA" className={box}>
                <table className="w-full text-sm">
                  <caption className="sr-only">Grupos com e sem dica com IA</caption>
                  <thead className="bg-zinc-50 text-left text-zinc-600 dark:bg-zinc-900 dark:text-zinc-400">
                    <tr>
                      <th scope="col" className="px-4 py-2">Grupo</th>
                      <th scope="col" className="px-4 py-2 text-right">Alunos</th>
                      <th scope="col" className="px-4 py-2 text-right">Tentativas por aluno</th>
                      <th scope="col" className="px-4 py-2 text-right">Taxa de acerto</th>
                      <th scope="col" className="px-4 py-2 text-right">Exercícios resolvidos por aluno</th>
                    </tr>
                  </thead>
                  <tbody>
                    {data.ai.grupos?.map((g) => (
                      <tr key={g.grupo} className="border-t border-zinc-200 dark:border-zinc-800">
                        <td className="px-4 py-2">{g.grupo === "com" ? "Usou a dica com IA" : "Nunca usou"}</td>
                        <td className="px-4 py-2 text-right">{g.alunos}</td>
                        <td className="px-4 py-2 text-right">{g.tentativas_por_aluno}</td>
                        <td className="px-4 py-2 text-right">{Math.round(g.taxa_de_acerto * 100)}%</td>
                        <td className="px-4 py-2 text-right">{g.exercicios_resolvidos_por_aluno}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </ScrollRegion>
            )}
          </section>
        </>
      )}
    </div>
  );
}
