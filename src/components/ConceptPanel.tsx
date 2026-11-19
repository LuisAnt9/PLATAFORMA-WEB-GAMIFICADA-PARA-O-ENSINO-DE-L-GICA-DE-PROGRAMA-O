"use client";

import Link from "next/link";
import { useCallback, useMemo, useState } from "react";
import { MIN_ATTEMPTS, MIN_EXERCISES } from "@/lib/concept-analytics";
import {
  CATEGORY_LABEL,
  MODE_LABEL,
  NO_FILTERS,
  loadConceptReport,
  type ReportFilters,
} from "@/lib/concept-report";
import { recommend } from "@/lib/recommendations";
import { useLoader } from "@/lib/use-loader";
import { useCatalog } from "./CatalogProvider";
import ScrollRegion from "./ScrollRegion";
import { Pill } from "./ui";

const box = "rounded-2xl border border-zinc-200 bg-white shadow-sm dark:border-zinc-800 dark:bg-zinc-900";
const th = "px-4 py-2";
const pct = (v: number | null) => (v === null ? "—" : `${Math.round(v * 100)}%`);
const field = "mt-1 rounded-xl border border-zinc-300 bg-white px-3 py-2 dark:border-zinc-700 dark:bg-zinc-950";

export default function ConceptPanel({ classId }: { classId: string }) {
  const { catalog } = useCatalog();
  const [f, setF] = useState<ReportFilters>(NO_FILTERS);
  const load = useCallback(() => loadConceptReport(classId, f), [classId, f]);
  const { data: r, error } = useLoader(
    `concepts:${classId}:${f.mode}:${f.days}:${f.world}:${f.module}`,
    load,
  );
  const modules = useMemo(
    () => catalog.modules.filter((m) => !f.world || m.worldId === f.world).sort((a, b) => a.position - b.position),
    [catalog, f.world],
  );
  const set = (patch: Partial<ReportFilters>) => setF((s) => ({ ...s, ...patch }));

  const ranked = useMemo(
    () => (r ? r.concepts.filter((c) => c.sufficient && c.error_rate !== null).sort((a, b) => (b.error_rate ?? 0) - (a.error_rate ?? 0)) : []),
    [r],
  );
  const recs = useMemo(() => (r ? recommend(r, classId) : []), [r, classId]);
  const worldName = (id: string | null) => catalog.worlds?.find((w) => w.id === id)?.title ?? "—";

  return (
    <div role="tabpanel" id="painel-conceitos" aria-labelledby="tab-conceitos" className="space-y-8">
      <section aria-label="Filtros" className="flex flex-wrap items-end gap-4 text-sm">
        <label>
          Modalidade
          <select value={f.mode} onChange={(e) => set({ mode: e.target.value as ReportFilters["mode"] })} className={`${field} block`}>
            <option value="">Todas</option>
            {(Object.keys(MODE_LABEL) as (keyof typeof MODE_LABEL)[]).map((m) => (
              <option key={m} value={m}>{MODE_LABEL[m]}</option>
            ))}
          </select>
        </label>
        <label>
          Período
          <select value={f.days} onChange={(e) => set({ days: Number(e.target.value) })} className={`${field} block`}>
            <option value={0}>Todo o período</option>
            <option value={7}>Últimos 7 dias</option>
            <option value={30}>Últimos 30 dias</option>
          </select>
        </label>
        <label>
          Mundo
          <select value={f.world} onChange={(e) => set({ world: e.target.value, module: "" })} className={`${field} block`}>
            <option value="">Todos</option>
            {(catalog.worlds ?? []).map((w) => (
              <option key={w.id} value={w.id}>{w.title}</option>
            ))}
          </select>
        </label>
        <label>
          Lição
          <select value={f.module} onChange={(e) => set({ module: e.target.value })} className={`${field} block`}>
            <option value="">Todas</option>
            {modules.map((m) => (
              <option key={m.id} value={m.id}>{m.title}</option>
            ))}
          </select>
        </label>
      </section>

      {error && (
        <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">{error}</p>
      )}
      {!r && !error && <p role="status" className="text-zinc-600 dark:text-zinc-400">Carregando...</p>}

      {r && (
        <>
          {r.students_total < r.min_students && (
            <p role="status" className="rounded-xl bg-amber-50 p-4 text-sm dark:bg-amber-950">
              <strong>Dados insuficientes para o painel da turma.</strong> A turma tem {r.students_total}{" "}
              {r.students_total === 1 ? "aluno" : "alunos"}; as conclusões por conceito só aparecem com{" "}
              {r.min_students} ou mais (faltam {r.min_students - r.students_total}). A análise de cada aluno, na aba
              Alunos, continua disponível.
            </p>
          )}

          <section aria-labelledby="recomendacoes">
            <h2 id="recomendacoes" className="mb-3 text-lg font-semibold">O que revisar</h2>
            {recs.length === 0 ? (
              <p className="text-sm text-zinc-600 dark:text-zinc-400">
                Nenhum conceito pede atenção agora. As recomendações aparecem quando há dados suficientes e um padrão
                claro de dificuldade.
              </p>
            ) : (
              <ul className="space-y-3">
                {recs.map((x) => (
                  <li key={x.id} className={`${box} p-4 text-sm`}>
                    <p>{x.text}</p>
                    {x.action && (
                      <Link
                        href={x.action.href}
                        className="mt-2 inline-block rounded-xl bg-emerald-700 px-4 py-2 font-medium text-white hover:bg-emerald-800"
                      >
                        {x.action.label}
                      </Link>
                    )}
                  </li>
                ))}
              </ul>
            )}
          </section>

          <section aria-labelledby="conceitos-turma">
            <h2 id="conceitos-turma" className="mb-1 text-lg font-semibold">Conceitos por taxa de erro</h2>
            <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
              Taxa de erro = erros ÷ tentativas nos exercícios do conceito, com mais peso nos exercícios em que o
              conceito é central. Só aparece com {MIN_ATTEMPTS} tentativas em {MIN_EXERCISES} exercícios, em turma
              com {r.min_students}+ alunos.
            </p>
            {ranked.length > 0 && (
              <ul aria-hidden="true" className="mb-4 space-y-1.5">
                {ranked.map((c) => (
                  <li key={c.concept_id} className="flex items-center gap-3 text-xs">
                    <span className="w-40 shrink-0 truncate sm:w-56">{c.title}</span>
                    <span className="h-3 flex-1 rounded bg-zinc-200 dark:bg-zinc-800">
                      <span className="block h-3 rounded bg-emerald-600" style={{ width: `${Math.round((c.error_rate ?? 0) * 100)}%` }} />
                    </span>
                    <span className="w-10 text-right">{pct(c.error_rate)}</span>
                  </li>
                ))}
              </ul>
            )}
            {r.concepts.length === 0 ? (
              <p className="text-sm text-zinc-600 dark:text-zinc-400">Ainda não há tentativas neste filtro.</p>
            ) : (
              <ScrollRegion label="Tabela de conceitos por taxa de erro" className={box}>
                <table className="w-full text-sm">
                  <caption className="sr-only">Conceitos, tentativas, taxa de erro e alunos por nível de domínio</caption>
                  <thead className="bg-zinc-50 text-left text-zinc-600 dark:bg-zinc-900 dark:text-zinc-400">
                    <tr>
                      <th scope="col" className={th}>Conceito</th>
                      <th scope="col" className={th}>Mundo</th>
                      <th scope="col" className={`${th} text-right`}>Tentativas</th>
                      <th scope="col" className={`${th} text-right`}>Taxa de erro</th>
                      <th scope="col" className={`${th} text-right`}>Ainda não demonstraram domínio</th>
                      <th scope="col" className={`${th} text-right`}>Bom desempenho</th>
                    </tr>
                  </thead>
                  <tbody>
                    {[...ranked, ...r.concepts.filter((c) => !c.sufficient)].map((c) => (
                      <tr key={c.concept_id} className="border-t border-zinc-200 dark:border-zinc-800">
                        <td className={th}>{c.title}</td>
                        <td className={th}>{worldName(c.world_id)}</td>
                        <td className={`${th} text-right`}>{c.attempts} em {c.exercises} {c.exercises === 1 ? "exercício" : "exercícios"}</td>
                        <td className={`${th} text-right`}>
                          {c.sufficient ? pct(c.error_rate) : <Pill>Dados insuficientes</Pill>}
                        </td>
                        <td className={`${th} text-right`}>
                          {c.sufficient ? `${c.dificuldade} de ${c.bom + c.em_desenvolvimento + c.dificuldade}` : "—"}
                        </td>
                        <td className={`${th} text-right`}>{c.sufficient ? c.bom : "—"}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </ScrollRegion>
            )}
            {ranked.length >= 2 && (
              <p className="mt-3 text-sm text-zinc-600 dark:text-zinc-400">
                Melhor compreendidos: {[...ranked].reverse().slice(0, 3).map((c) => `${c.title} (${pct(c.error_rate)} de erro)`).join(", ")}.
              </p>
            )}
          </section>

          <section aria-labelledby="erros">
            <h2 id="erros" className="mb-3 text-lg font-semibold">Erros recorrentes</h2>
            <div className="grid gap-4 sm:grid-cols-2">
              <div className={`${box} p-4 text-sm`}>
                <h3 className="mb-2 font-medium">Confusões nas questões de escolha</h3>
                {r.misconceptions.length === 0 ? (
                  <p className="text-zinc-600 dark:text-zinc-400">Nenhuma confusão registrada ainda.</p>
                ) : (
                  <ul className="space-y-1">
                    {r.misconceptions.map((m) => (
                      <li key={m.text}>{m.text} <span className="text-zinc-600 dark:text-zinc-400">· {m.count} respostas, {m.students} alunos</span></li>
                    ))}
                  </ul>
                )}
              </div>
              <div className={`${box} p-4 text-sm`}>
                <h3 className="mb-2 font-medium">Tipos de erro</h3>
                {r.error_categories.length === 0 ? (
                  <p className="text-zinc-600 dark:text-zinc-400">Nenhum erro registrado ainda.</p>
                ) : (
                  <ul className="space-y-1">
                    {r.error_categories.map((c) => (
                      <li key={c.category}>{CATEGORY_LABEL[c.category] ?? c.category} <span className="text-zinc-600 dark:text-zinc-400">· {c.count}</span></li>
                    ))}
                  </ul>
                )}
              </div>
            </div>
          </section>

          <section aria-labelledby="mais-erros">
            <h2 id="mais-erros" className="mb-3 text-lg font-semibold">Exercícios com mais respostas incorretas</h2>
            {r.hardest_exercises.length === 0 ? (
              <p className="text-sm text-zinc-600 dark:text-zinc-400">Nenhum exercício com {MIN_ATTEMPTS} ou mais tentativas e erros.</p>
            ) : (
              <ScrollRegion label="Tabela de exercícios com mais erros" className={box}>
                <table className="w-full text-sm">
                  <caption className="sr-only">Exercícios ordenados pela taxa de erro</caption>
                  <thead className="bg-zinc-50 text-left text-zinc-600 dark:bg-zinc-900 dark:text-zinc-400">
                    <tr>
                      <th scope="col" className={th}>Exercício</th>
                      <th scope="col" className={`${th} text-right`}>Tentativas</th>
                      <th scope="col" className={`${th} text-right`}>Erros</th>
                      <th scope="col" className={`${th} text-right`}>Taxa de erro</th>
                    </tr>
                  </thead>
                  <tbody>
                    {r.hardest_exercises.map((e) => (
                      <tr key={e.exercise_id} className="border-t border-zinc-200 dark:border-zinc-800">
                        <td className={th}>{e.title}</td>
                        <td className={`${th} text-right`}>{e.attempts}</td>
                        <td className={`${th} text-right`}>{e.errors}</td>
                        <td className={`${th} text-right`}>{pct(e.error_rate)}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </ScrollRegion>
            )}
          </section>

          <section aria-labelledby="modalidades">
            <h2 id="modalidades" className="mb-1 text-lg font-semibold">Por modalidade</h2>
            <p className="mb-3 text-sm text-zinc-600 dark:text-zinc-400">
              Aprendizagem livre, atividade e avaliação são contadas separadamente (esta tabela ignora o filtro de modalidade).
            </p>
            <ul className="grid gap-3 sm:grid-cols-3">
              {r.by_mode.map((m) => (
                <li key={m.mode} className={`${box} p-4 text-sm`}>
                  <div className="font-medium">{MODE_LABEL[m.mode]}</div>
                  <div className="text-zinc-600 dark:text-zinc-400">
                    {m.attempts} tentativas · {m.errors} erros ({pct(m.attempts ? m.errors / m.attempts : null)})
                  </div>
                </li>
              ))}
              {r.by_mode.length === 0 && <li className="text-sm text-zinc-600 dark:text-zinc-400">Sem tentativas neste filtro.</li>}
            </ul>
          </section>

          <section aria-labelledby="evolucao">
            <h2 id="evolucao" className="mb-3 text-lg font-semibold">Evolução da turma</h2>
            {r.timeline.length === 0 ? (
              <p className="text-sm text-zinc-600 dark:text-zinc-400">Sem tentativas neste filtro.</p>
            ) : (
              <details className="text-sm" open>
                <summary className="cursor-pointer font-medium">Tentativas e erros por dia (tabela)</summary>
                <ScrollRegion label="Tentativas e erros por dia" className={`${box} mt-3 max-h-72`}>
                  <table className="w-full text-sm">
                    <caption className="sr-only">Tentativas, erros e taxa de erro por dia</caption>
                    <thead className="bg-zinc-50 text-left text-zinc-600 dark:bg-zinc-900 dark:text-zinc-400">
                      <tr>
                        <th scope="col" className={th}>Dia</th>
                        <th scope="col" className={`${th} text-right`}>Tentativas</th>
                        <th scope="col" className={`${th} text-right`}>Erros</th>
                        <th scope="col" className={`${th} text-right`}>Taxa de erro</th>
                      </tr>
                    </thead>
                    <tbody>
                      {[...r.timeline].reverse().map((d) => (
                        <tr key={d.day} className="border-t border-zinc-200 dark:border-zinc-800">
                          <td className={th}>{d.day.slice(8, 10)}/{d.day.slice(5, 7)}</td>
                          <td className={`${th} text-right`}>{d.attempts}</td>
                          <td className={`${th} text-right`}>{d.errors}</td>
                          <td className={`${th} text-right`}>{pct(d.attempts ? d.errors / d.attempts : null)}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </ScrollRegion>
              </details>
            )}
          </section>
        </>
      )}
    </div>
  );
}
