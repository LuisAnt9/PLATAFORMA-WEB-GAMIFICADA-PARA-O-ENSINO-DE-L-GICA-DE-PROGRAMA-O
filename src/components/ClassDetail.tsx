"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useCallback, useMemo, useState } from "react";
import { orderedExercises } from "@/lib/catalog";
import {
  classOverview,
  exerciseStats,
  hardestExercises,
  progressMatrix,
  solvedPerDay,
  studentAlerts,
} from "@/lib/class-analytics";
import { daysSince, memberSummaries } from "@/lib/class-stats";
import {
  deleteClass,
  getTeacherClass,
  loadClassData,
  removeMember,
  renameClass,
} from "@/lib/classes";
import { useLoader } from "@/lib/use-loader";
import ActivityChart from "./ActivityChart";
import { CatalogGate, useCatalog } from "./CatalogProvider";
import ProgressMatrix from "./ProgressMatrix";

const TABS = [
  { id: "geral", label: "Visão geral" },
  { id: "alunos", label: "Alunos" },
  { id: "exercicios", label: "Exercícios" },
  { id: "config", label: "Configurações" },
] as const;
type TabId = (typeof TABS)[number]["id"];

const card = "rounded-lg border border-zinc-200 p-4 dark:border-zinc-800";
const pct = (v: number | null) =>
  v === null ? "—" : `${Math.round(v * 100)}%`;
const num = (v: number | null) =>
  v === null ? "—" : v.toFixed(1).replace(".", ",");

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
  const [tab, setTab] = useState<TabId>("geral");
  const [nameDraft, setNameDraft] = useState<string | null>(null);
  const [msg, setMsg] = useState<{ ok: boolean; text: string } | null>(null);
  const [copied, setCopied] = useState(false);
  // Momento e fuso fixados uma vez: mantém a renderização pura e os números estáveis.
  const [env] = useState(() => ({
    now: Date.now(),
    offset: -new Date().getTimezoneOffset(),
  }));

  const published = useMemo(
    () => orderedExercises(catalog).filter((e) => e.published),
    [catalog],
  );
  const analytics = useMemo(() => {
    const data = loaded?.data;
    if (!data) return null;
    const validIds = new Set(published.map((e) => e.id));
    const summaries = memberSummaries(data, validIds);
    const stats = exerciseStats(data, published);
    return {
      data,
      summaries,
      overview: classOverview(summaries, published.length, env.now),
      alerts: studentAlerts(summaries, data, validIds, env.now),
      stats,
      hardest: hardestExercises(stats),
      perDay: solvedPerDay(data, 14, env.now, env.offset),
      matrix: progressMatrix(data, published),
    };
  }, [loaded, published, env]);

  if (loadError)
    return (
      <p role="alert" className="text-red-700 dark:text-red-300">
        {loadError}
      </p>
    );
  if (!loaded || !analytics) {
    if (loaded && !loaded.info) return <NotFound />;
    return <p className="text-zinc-500">Carregando...</p>;
  }
  if (!loaded.info) return <NotFound />;

  const cls = loaded.info; // referência já sem null, usada nas funções abaixo
  const name = nameDraft ?? cls.name;
  const { summaries, overview, alerts, stats, hardest, perDay, matrix } =
    analytics;

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
    <div className="space-y-6">
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

      <div
        role="tablist"
        aria-label="Seções da turma"
        className="flex gap-4 overflow-x-auto border-b border-zinc-200 text-sm dark:border-zinc-800"
      >
        {TABS.map((t) => (
          <button
            key={t.id}
            role="tab"
            id={`tab-${t.id}`}
            aria-selected={tab === t.id}
            aria-controls={`painel-${t.id}`}
            onClick={() => setTab(t.id)}
            className={`-mb-px whitespace-nowrap border-b-2 px-1 pb-2 ${
              tab === t.id
                ? "border-emerald-600 font-medium text-emerald-700 dark:text-emerald-400"
                : "border-transparent text-zinc-500 hover:text-foreground"
            }`}
          >
            {t.label}
          </button>
        ))}
      </div>

      {tab === "geral" && (
        <div
          role="tabpanel"
          id="painel-geral"
          aria-labelledby="tab-geral"
          className="space-y-8"
        >
          {summaries.length === 0 ? (
            <p className="text-sm text-zinc-500">
              Nenhum aluno entrou ainda. Passe o código acima para a turma.
            </p>
          ) : (
            <>
              <section
                aria-label="Resumo"
                className="grid grid-cols-2 gap-3 sm:grid-cols-4"
              >
                <div className={card}>
                  <div className="text-2xl font-semibold">
                    {overview.students}
                  </div>
                  <div className="text-xs text-zinc-500">alunos na turma</div>
                </div>
                <div className={card}>
                  <div className="text-2xl font-semibold">
                    {overview.activeRecently}
                    <span className="text-base font-normal text-zinc-500">
                      {" "}
                      de {overview.students}
                    </span>
                  </div>
                  <div className="text-xs text-zinc-500">
                    ativos nos últimos 7 dias
                  </div>
                </div>
                <div className={card}>
                  <div className="text-2xl font-semibold">
                    {pct(overview.avgCompletion)}
                  </div>
                  <div className="text-xs text-zinc-500">
                    da trilha concluída (média)
                  </div>
                </div>
                <div className={card}>
                  <div className="text-2xl font-semibold">{overview.avgXp}</div>
                  <div className="text-xs text-zinc-500">XP médio</div>
                </div>
              </section>

              <section>
                <h2 className="mb-3 text-lg font-semibold">
                  Precisam de atenção
                </h2>
                {alerts.length === 0 ? (
                  <p className="text-sm text-zinc-500">
                    Nenhum aluno em alerta agora: todos têm atividade recente e
                    ninguém está travado.
                  </p>
                ) : (
                  <ul className="divide-y divide-zinc-200 rounded-lg border border-amber-300 dark:divide-zinc-800 dark:border-amber-700">
                    {alerts.map((a) => (
                      <li
                        key={a.studentId}
                        className="flex flex-wrap items-baseline gap-x-4 gap-y-1 px-4 py-2 text-sm"
                      >
                        <span className="font-medium">⚠ {a.name}</span>
                        <span className="text-zinc-500">
                          {a.reasons.join(" · ")}
                        </span>
                      </li>
                    ))}
                  </ul>
                )}
              </section>

              <section>
                <ActivityChart
                  data={perDay}
                  title="Exercícios resolvidos por dia (últimos 14 dias)"
                />
              </section>
            </>
          )}
        </div>
      )}

      {tab === "alunos" && (
        <div
          role="tabpanel"
          id="painel-alunos"
          aria-labelledby="tab-alunos"
          className="space-y-8"
        >
          {summaries.length === 0 ? (
            <p className="text-sm text-zinc-500">
              Nenhum aluno entrou ainda. Passe o código acima para a turma.
            </p>
          ) : (
            <>
              <section>
                <h2 className="mb-3 text-lg font-semibold">Alunos</h2>
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
                        const d = daysSince(s.lastActivity, env.now);
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
                            <td className="px-4 py-2 text-right">
                              {s.attempts}
                            </td>
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
              </section>
              <section>
                <h2 className="mb-3 text-lg font-semibold">
                  Grade de progresso
                </h2>
                <ProgressMatrix rows={matrix} exercises={published} />
              </section>
            </>
          )}
        </div>
      )}

      {tab === "exercicios" && (
        <div
          role="tabpanel"
          id="painel-exercicios"
          aria-labelledby="tab-exercicios"
          className="space-y-8"
        >
          {summaries.length === 0 ? (
            <p className="text-sm text-zinc-500">
              Nenhum aluno entrou ainda. Passe o código acima para a turma.
            </p>
          ) : (
            <>
              <section>
                <h2 className="mb-1 text-lg font-semibold">
                  Onde a turma mais tem dificuldade
                </h2>
                <p className="mb-3 text-sm text-zinc-500">
                  Ordenado pela menor taxa de acerto entre quem tentou.
                </p>
                {hardest.length === 0 ? (
                  <p className="text-sm text-zinc-500">
                    Ninguém tentou exercícios ainda.
                  </p>
                ) : (
                  <ol className="divide-y divide-zinc-200 rounded-lg border border-zinc-200 text-sm dark:divide-zinc-800 dark:border-zinc-800">
                    {hardest.map((s, i) => (
                      <li
                        key={s.exercise.id}
                        className="flex flex-wrap items-baseline gap-x-4 gap-y-1 px-4 py-2"
                      >
                        <span className="w-5 text-zinc-500 tabular-nums">
                          {i + 1}.
                        </span>
                        <span className="min-w-40 flex-1 font-medium">
                          {s.exercise.title}
                        </span>
                        <span className="text-zinc-500">
                          {s.solved} de {s.attempted} acertaram (
                          {pct(s.solveRate)})
                          {s.stuck > 0 &&
                            ` · ${s.stuck} ${s.stuck === 1 ? "travado" : "travados"}`}
                        </span>
                      </li>
                    ))}
                  </ol>
                )}
              </section>
              <section>
                <h2 className="mb-3 text-lg font-semibold">
                  Todos os exercícios
                </h2>
                <div className="overflow-x-auto rounded-lg border border-zinc-200 dark:border-zinc-800">
                  <table className="w-full text-sm">
                    <caption className="sr-only">
                      Estatísticas por exercício
                    </caption>
                    <thead className="bg-zinc-50 text-left text-zinc-500 dark:bg-zinc-900">
                      <tr>
                        <th scope="col" className="px-4 py-2">
                          Exercício
                        </th>
                        <th scope="col" className="px-4 py-2 text-right">
                          Tentaram
                        </th>
                        <th scope="col" className="px-4 py-2 text-right">
                          Acertaram
                        </th>
                        <th scope="col" className="px-4 py-2 text-right">
                          Tentativas até acertar
                        </th>
                        <th scope="col" className="px-4 py-2 text-right">
                          De primeira
                        </th>
                        <th scope="col" className="px-4 py-2 text-right">
                          Travados
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      {stats.map((s) => (
                        <tr
                          key={s.exercise.id}
                          className="border-t border-zinc-200 dark:border-zinc-800"
                        >
                          <th
                            scope="row"
                            className="px-4 py-2 text-left font-normal"
                          >
                            {s.exercise.title}
                          </th>
                          <td className="px-4 py-2 text-right tabular-nums">
                            {s.attempted}
                          </td>
                          <td className="px-4 py-2 text-right tabular-nums">
                            {s.solved}{" "}
                            <span className="text-zinc-500">
                              ({pct(s.solveRate)})
                            </span>
                          </td>
                          <td className="px-4 py-2 text-right tabular-nums">
                            {num(s.avgAttempts)}
                          </td>
                          <td className="px-4 py-2 text-right tabular-nums">
                            {pct(s.firstTryRate)}
                          </td>
                          <td
                            className={`px-4 py-2 text-right tabular-nums ${s.stuck > 0 ? "font-medium" : "text-zinc-500"}`}
                          >
                            {s.stuck}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </section>
            </>
          )}
        </div>
      )}

      {tab === "config" && (
        <div role="tabpanel" id="painel-config" aria-labelledby="tab-config">
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
        </div>
      )}
    </div>
  );
}

function NotFound() {
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
}

export default function ClassDetail({ id }: { id: string }) {
  return (
    <CatalogGate>
      <Content id={id} />
    </CatalogGate>
  );
}
