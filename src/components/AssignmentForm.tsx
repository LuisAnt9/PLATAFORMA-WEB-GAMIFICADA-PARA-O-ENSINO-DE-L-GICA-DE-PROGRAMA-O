"use client";

import { useRouter, useSearchParams } from "next/navigation";
import { useCallback, useMemo, useState } from "react";
import {
  RESULT_RULE_LABEL,
  createAssignment,
  isoToLocalInput,
  localInputToIso,
  type AssignmentKind,
  type ResultRule,
} from "@/lib/assignments";
import { KIND_LABEL, exercisesOf, type Exercise } from "@/lib/catalog";
import { listTeacherClasses } from "@/lib/classes";
import { useLoader } from "@/lib/use-loader";
import { usePageTitle } from "@/lib/use-page-title";
import { useAuth } from "./AuthProvider";
import { CatalogGate, useCatalog } from "./CatalogProvider";
import { BackLink, Pill, card, primaryButton } from "./ui";

/** Tipos que o banco corrige (os únicos aceitos em avaliações com nota). */
const GRADED_BY_DB = new Set(["choice", "interpretation", "blank", "order"]);

const input =
  "mt-1 w-full rounded-xl border border-zinc-300 bg-white px-3 py-2 dark:border-zinc-700 dark:bg-zinc-950";

function defaultDue() {
  const d = new Date();
  d.setDate(d.getDate() + 7);
  d.setHours(23, 59, 0, 0);
  return isoToLocalInput(d.toISOString());
}

function Content() {
  usePageTitle("Nova atividade");
  const router = useRouter();
  const { profile } = useAuth();
  const { catalog } = useCatalog();
  const uid = profile?.id ?? "";
  const loadClasses = useCallback(() => listTeacherClasses(uid), [uid]);
  const { data: classes } = useLoader(`teacher-classes:${uid}`, loadClasses);

  // vindo de uma recomendação do painel de conceitos: turma e exercícios do conceito já escolhidos
  const params = useSearchParams();
  const conceptId = params.get("conceito");
  const concept = catalog.concepts?.find((c) => c.id === conceptId);
  const [classId, setClassId] = useState(params.get("turma") ?? "");
  const [kind, setKind] = useState<AssignmentKind>("atividade");
  const [title, setTitle] = useState(concept ? `Reforço: ${concept.title}` : "");
  const [instructions, setInstructions] = useState("");
  const [from, setFrom] = useState(() => isoToLocalInput(new Date().toISOString()));
  const [due, setDue] = useState(defaultDue);
  const [required, setRequired] = useState(true);
  const [rule, setRule] = useState<ResultRule>("so_nota");
  const [picked, setPicked] = useState<{ id: string; points: number }[]>(() => {
    if (!concept) return [];
    const order = { facil: 0, medio: 1, dificil: 2 } as const;
    return (catalog.links ?? [])
      .filter((l) => l.conceptId === concept.id)
      .map((l) => catalog.exercises.find((e) => e.id === l.exerciseId))
      .filter((e): e is Exercise => !!e && e.published)
      .sort((a, b) => order[a.difficulty] - order[b.difficulty])
      .slice(0, 6)
      .map((e) => ({ id: e.id, points: 1 }));
  });
  const [search, setSearch] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const active = (classes ?? []).filter((c) => !c.archived);
  const selectedClass = classId || active[0]?.id || "";
  const isTest = kind === "avaliacao";
  const available = (e: Exercise) => e.published && (!isTest || GRADED_BY_DB.has(e.kind));

  const lessons = useMemo(
    () =>
      [...catalog.modules]
        .sort((a, b) => a.position - b.position)
        .map((m) => ({
          m,
          list: exercisesOf(catalog, m.id).filter(
            (e) =>
              e.published &&
              (search.trim() === "" ||
                e.title.toLowerCase().includes(search.trim().toLowerCase())),
          ),
        }))
        .filter((l) => l.list.length > 0),
    [catalog, search],
  );

  const toggle = (e: Exercise) =>
    setPicked((p) =>
      p.some((x) => x.id === e.id)
        ? p.filter((x) => x.id !== e.id)
        : [...p, { id: e.id, points: 1 }],
    );
  // ao trocar para avaliação, tira da seleção o que o banco não corrige
  function changeKind(k: AssignmentKind) {
    setKind(k);
    if (k === "avaliacao")
      setPicked((p) =>
        p.filter((x) => {
          const ex = catalog.exercises.find((e) => e.id === x.id);
          return ex && GRADED_BY_DB.has(ex.kind);
        }),
      );
  }
  const total = picked.reduce((n, p) => n + p.points, 0);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);
    if (!selectedClass) return setError("Escolha uma turma.");
    if (picked.length === 0) return setError("Escolha pelo menos um exercício.");
    setBusy(true);
    try {
      const id = await createAssignment({
        classId: selectedClass,
        kind,
        title: title.trim(),
        instructions: instructions.trim(),
        availableFrom: localInputToIso(from),
        dueAt: localInputToIso(due),
        required,
        resultRule: rule,
        items: picked.map((p) => ({ exercise_id: p.id, points: isTest ? p.points : 1 })),
      });
      router.push(`/professor/atividades/${id}`);
    } catch (err) {
      setError((err as Error).message);
      setBusy(false);
    }
  }

  return (
    <form onSubmit={submit} className="space-y-6">
      <BackLink href="/professor/atividades">Atividades</BackLink>
      <h1 className="text-2xl font-semibold tracking-tight">Nova atividade</h1>
      {concept && (
        <p role="status" className="rounded-xl bg-emerald-50 p-3 text-sm dark:bg-emerald-950">
          Atividade de reforço sobre <strong>{concept.title}</strong>: já escolhemos exercícios desse conceito
          (dos mais simples aos mais difíceis). Ajuste como quiser antes de publicar.
        </p>
      )}

      <fieldset className="space-y-3">
        <legend className="font-medium">Tipo</legend>
        <div className="flex flex-wrap gap-3 text-sm">
          {(
            [
              ["atividade", "Atividade para casa", "Exercícios sem nota, com prazo."],
              ["avaliacao", "Avaliação com nota", "Só questões corrigidas pelo banco; entrega única."],
            ] as const
          ).map(([v, label, hint]) => (
            <label
              key={v}
              className="flex flex-1 basis-60 cursor-pointer items-start gap-3 rounded-xl border border-zinc-300 p-3 has-[:checked]:border-emerald-600 has-[:checked]:bg-emerald-50 dark:border-zinc-700 dark:has-[:checked]:bg-emerald-950"
            >
              <input
                type="radio"
                name="tipo"
                checked={kind === v}
                onChange={() => changeKind(v)}
                className="mt-1"
              />
              <span>
                <span className="font-medium">{label}</span>
                <span className="block text-zinc-600 dark:text-zinc-400">{hint}</span>
              </span>
            </label>
          ))}
        </div>
      </fieldset>

      <div className="grid gap-4 sm:grid-cols-2">
        <label className="text-sm">
          Turma
          <select
            value={selectedClass}
            onChange={(e) => setClassId(e.target.value)}
            required
            className={input}
          >
            {active.length === 0 && <option value="">Nenhuma turma ativa</option>}
            {active.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </label>
        <label className="text-sm">
          Título
          <input value={title} onChange={(e) => setTitle(e.target.value)} required minLength={2} maxLength={120} className={input} placeholder="Ex.: Lista 1 — Condicionais" />
        </label>
        <label className="text-sm sm:col-span-2">
          Instruções para os alunos
          <textarea value={instructions} onChange={(e) => setInstructions(e.target.value)} maxLength={2000} rows={3} className={input} />
        </label>
        <label className="text-sm">
          Disponível a partir de
          <input type="datetime-local" value={from} onChange={(e) => setFrom(e.target.value)} required className={input} />
        </label>
        <label className="text-sm">
          Prazo
          <input type="datetime-local" value={due} onChange={(e) => setDue(e.target.value)} required className={input} />
        </label>
        {!isTest && (
          <label className="flex items-center gap-2 text-sm sm:col-span-2">
            <input type="checkbox" checked={required} onChange={(e) => setRequired(e.target.checked)} className="h-5 w-5" />
            Atividade obrigatória
          </label>
        )}
        {isTest && (
          <label className="text-sm sm:col-span-2">
            O que o aluno vê depois de entregar
            <select value={rule} onChange={(e) => setRule(e.target.value as ResultRule)} className={input}>
              {(Object.keys(RESULT_RULE_LABEL) as ResultRule[]).map((r) => (
                <option key={r} value={r}>
                  {RESULT_RULE_LABEL[r]}
                </option>
              ))}
            </select>
          </label>
        )}
      </div>

      <section aria-labelledby="escolha" className="space-y-3">
        <h2 id="escolha" className="text-lg font-semibold">
          Exercícios ({picked.length} escolhidos{isTest ? ` · ${total} pontos` : ""})
        </h2>
        {isTest && (
          <p className="rounded-xl bg-zinc-100 p-3 text-sm dark:bg-zinc-800">
            Avaliações aceitam só múltipla escolha, lacunas, interpretação e
            ordenação: o banco corrige e guarda o gabarito onde o aluno não lê.
            Exercícios de código são corrigidos no navegador e ficam de fora.
            Os alunos veem as questões em ordem embaralhada de passos, sem as
            respostas. Atenção: se o aluno já praticou o mesmo exercício, ele
            pode se lembrar da resposta.
          </p>
        )}
        <label className="block text-sm">
          Buscar exercício
          <input value={search} onChange={(e) => setSearch(e.target.value)} className={input} />
        </label>
        <div className="max-h-96 space-y-4 overflow-y-auto rounded-xl border border-zinc-200 p-3 dark:border-zinc-800">
          {lessons.map(({ m, list }) => (
            <fieldset key={m.id}>
              <legend className="text-sm font-medium">{m.title}</legend>
              <ul className="mt-1 space-y-1">
                {list.map((e) => {
                  const ok = available(e);
                  return (
                    <li key={e.id}>
                      <label className={`flex items-center gap-3 rounded-lg px-2 py-1.5 text-sm ${ok ? "cursor-pointer hover:bg-zinc-50 dark:hover:bg-zinc-800" : "opacity-50"}`}>
                        <input
                          type="checkbox"
                          checked={picked.some((p) => p.id === e.id)}
                          disabled={!ok}
                          onChange={() => toggle(e)}
                          className="h-5 w-5"
                        />
                        <span className="flex-1">{e.title}</span>
                        <Pill>{KIND_LABEL[e.kind]}</Pill>
                      </label>
                    </li>
                  );
                })}
              </ul>
            </fieldset>
          ))}
        </div>
        {isTest && picked.length > 0 && (
          <ul className={`${card} divide-y divide-zinc-200 dark:divide-zinc-800`}>
            {picked.map((p, i) => {
              const ex = catalog.exercises.find((e) => e.id === p.id);
              return (
                <li key={p.id} className="flex items-center justify-between gap-3 px-4 py-2 text-sm">
                  <span>
                    {i + 1}. {ex?.title}
                  </span>
                  <label className="flex items-center gap-2">
                    Pontos
                    <input
                      type="number"
                      min={1}
                      max={100}
                      value={p.points}
                      onChange={(e) =>
                        setPicked((list) =>
                          list.map((x) =>
                            x.id === p.id ? { ...x, points: Math.max(1, Math.min(100, Number(e.target.value) || 1)) } : x,
                          ),
                        )
                      }
                      className="w-20 rounded-lg border border-zinc-300 bg-white px-2 py-1 dark:border-zinc-700 dark:bg-zinc-950"
                    />
                  </label>
                </li>
              );
            })}
          </ul>
        )}
      </section>

      {error && (
        <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">
          {error}
        </p>
      )}
      <button type="submit" disabled={busy} className={`${primaryButton} disabled:opacity-50`}>
        Publicar {isTest ? "avaliação" : "atividade"}
      </button>
    </form>
  );
}

export default function AssignmentForm() {
  return (
    <CatalogGate>
      <Content />
    </CatalogGate>
  );
}
