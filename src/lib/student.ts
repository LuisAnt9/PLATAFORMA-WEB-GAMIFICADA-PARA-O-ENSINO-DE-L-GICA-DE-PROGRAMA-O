import {
  exercisesOf,
  type Catalog,
  type Exercise,
  type Module,
  type World,
} from "./catalog";
import type { Progress } from "./gamification";
import type { ModuleState } from "./learning";

// ---------------------------------------------------------------------------------------------
// Mundos
// ---------------------------------------------------------------------------------------------

export type WorldStatus =
  | "em-breve"
  | "bloqueado"
  | "nao-iniciado"
  | "em-andamento"
  | "concluido";

export const WORLD_STATUS_LABEL: Record<WorldStatus, string> = {
  "em-breve": "Em breve",
  bloqueado: "Bloqueado",
  "nao-iniciado": "Não iniciado",
  "em-andamento": "Em andamento",
  concluido: "Concluído",
};

export interface WorldSummary {
  world: World;
  lessons: Module[];
  total: number;
  done: number;
  status: WorldStatus;
}

const published = (c: Catalog, moduleId: string) =>
  exercisesOf(c, moduleId).filter((e) => e.published);

/** Lições (módulos) de um mundo, em ordem; só as que têm exercícios publicados. */
export function lessonsOfWorld(c: Catalog, worldId: string): Module[] {
  return c.modules
    .filter((m) => m.worldId === worldId && published(c, m.id).length > 0)
    .sort((a, b) => a.position - b.position);
}

/**
 * Resumo de cada mundo. Um mundo está "concluído" quando todas as lições obrigatórias atingiram
 * o mínimo da liberação (as complementares não contam); "bloqueado" quando a primeira lição
 * ainda está bloqueada pela regra de liberação; "em breve" quando ainda não tem exercícios.
 */
export function worldSummaries(
  c: Catalog,
  progress: Progress,
  states: Record<string, ModuleState>,
  enforced: boolean,
): WorldSummary[] {
  const worlds = [...(c.worlds ?? [])].sort((a, b) => a.position - b.position);
  const known = new Set(worlds.map((w) => w.id));
  // Lições de mundos desconhecidos (conteúdo antigo) entram em um grupo à parte.
  const orphans = c.modules.filter(
    (m) =>
      (!m.worldId || !known.has(m.worldId)) && published(c, m.id).length > 0,
  );
  const all: { world: World; lessons: Module[] }[] = worlds.map((w) => ({
    world: w,
    lessons: lessonsOfWorld(c, w.id),
  }));
  if (orphans.length > 0) {
    all.push({
      world: {
        id: "outras-licoes",
        title: "Outras lições",
        objective: "Lições avulsas fora dos mundos.",
        position: 999,
      },
      lessons: orphans.sort((a, b) => a.position - b.position),
    });
  }
  return all.map(({ world, lessons }) => {
    const ex = lessons.flatMap((m) => published(c, m.id));
    const done = ex.filter((e) => progress[e.id]?.solved).length;
    const required = lessons.filter((m) => !m.optional);
    let status: WorldStatus;
    if (ex.length === 0) status = "em-breve";
    else if (
      required.length > 0 &&
      required.every((m) => states[m.id]?.complete)
    )
      status = "concluido";
    else if (enforced && states[lessons[0].id]?.unlocked === false)
      status = "bloqueado";
    else if (done > 0) status = "em-andamento";
    else status = "nao-iniciado";
    return { world, lessons, total: ex.length, done, status };
  });
}

// ---------------------------------------------------------------------------------------------
// Passos da lição
// ---------------------------------------------------------------------------------------------

export type StepId =
  | "introducao"
  | "explicacao"
  | "exemplo"
  | "interpretacao"
  | "pratica"
  | "desafio"
  | "revisao";

export const STEP_LABEL: Record<StepId, string> = {
  introducao: "Introdução",
  explicacao: "Explicação",
  exemplo: "Exemplo",
  interpretacao: "Interpretação",
  pratica: "Prática",
  desafio: "Desafio",
  revisao: "Revisão",
};

/** Em qual passo da lição cada tipo de exercício aparece. */
export function stepOfExercise(e: Exercise): StepId {
  if (e.kind === "challenge") return "desafio";
  if (e.kind === "code" || e.kind === "fix") return "pratica";
  return "interpretacao"; // escolha, lacuna, interpretação e ordenação: ler e compreender
}

export interface LessonStep {
  id: StepId;
  label: string;
  exercises: Exercise[];
}

/**
 * Os 7 passos da lição, na ordem. Passos sem conteúdo (por exemplo "Desafio" numa lição sem
 * desafio, ou "Exemplo" numa lição antiga) não aparecem. A introdução sempre existe.
 */
export function lessonSteps(c: Catalog, m: Module): LessonStep[] {
  const ex = published(c, m.id);
  const of = (id: StepId) => ex.filter((e) => stepOfExercise(e) === id);
  const steps: LessonStep[] = [
    { id: "introducao", label: STEP_LABEL.introducao, exercises: [] },
  ];
  if (m.intro.trim())
    steps.push({ id: "explicacao", label: STEP_LABEL.explicacao, exercises: [] });
  if (m.example.trim())
    steps.push({ id: "exemplo", label: STEP_LABEL.exemplo, exercises: [] });
  for (const id of ["interpretacao", "pratica", "desafio"] as const) {
    const list = of(id);
    if (list.length > 0) steps.push({ id, label: STEP_LABEL[id], exercises: list });
  }
  if (m.review.trim())
    steps.push({ id: "revisao", label: STEP_LABEL.revisao, exercises: [] });
  return steps;
}

/** Posição (a partir de 0) do passo na lista; passo inválido volta para o primeiro. */
export function stepIndex(steps: LessonStep[], id: string | null): number {
  const i = steps.findIndex((s) => s.id === id);
  return i < 0 ? 0 : i;
}

// ---------------------------------------------------------------------------------------------
// Desempenho por conceito (regra D8)
// ---------------------------------------------------------------------------------------------

/** Mínimos para afirmar algo sobre o aluno em um conceito. */
export const MIN_ATTEMPTS = 3;
export const MIN_EXERCISES = 2;

export type ConceptLevel = "insuficiente" | "praticar" | "em-bom-caminho";

export interface ConceptPerformance {
  conceptId: string;
  title: string;
  worldId: string | null;
  /** Exercícios do conceito em que o aluno já tentou algo. */
  exercisesTried: number;
  exercisesSolved: number;
  attempts: number;
  level: ConceptLevel;
}

/**
 * Desempenho do próprio aluno em cada conceito que ele já praticou. Com menos de 3 tentativas
 * em pelo menos 2 exercícios, o resultado é "dados insuficientes": nada é afirmado. O nível
 * descreve o conceito neste momento, não o aluno: a leitura é sempre "para praticar" ou
 * "em bom caminho".
 */
export function conceptPerformance(
  c: Catalog,
  progress: Progress,
): ConceptPerformance[] {
  const concepts = new Map((c.concepts ?? []).map((x) => [x.id, x]));
  const byExercise = new Map(c.exercises.map((e) => [e.id, e]));
  const acc = new Map<
    string,
    { tried: number; solved: number; attempts: number }
  >();
  for (const link of c.links ?? []) {
    const ex = byExercise.get(link.exerciseId);
    const p = progress[link.exerciseId];
    if (!ex || !ex.published || !p || p.attempts === 0) continue;
    const a = acc.get(link.conceptId) ?? { tried: 0, solved: 0, attempts: 0 };
    a.tried += 1;
    a.attempts += p.attempts;
    if (p.solved) a.solved += 1;
    acc.set(link.conceptId, a);
  }
  const out: ConceptPerformance[] = [];
  for (const [conceptId, a] of acc) {
    const concept = concepts.get(conceptId);
    if (!concept) continue;
    const enough = a.attempts >= MIN_ATTEMPTS && a.tried >= MIN_EXERCISES;
    let level: ConceptLevel = "insuficiente";
    if (enough) {
      // Em bom caminho: resolveu ao menos 70% do que tentou, sem precisar de mais de
      // 3 tentativas por exercício em média.
      level =
        a.solved / a.tried >= 0.7 && a.attempts / a.tried <= 3
          ? "em-bom-caminho"
          : "praticar";
    }
    out.push({
      conceptId,
      title: concept.title,
      worldId: concept.worldId,
      exercisesTried: a.tried,
      exercisesSolved: a.solved,
      attempts: a.attempts,
      level,
    });
  }
  const order = (id: string) =>
    (c.concepts ?? []).findIndex((x) => x.id === id);
  return out.sort((x, y) => order(x.conceptId) - order(y.conceptId));
}

// ---------------------------------------------------------------------------------------------
// Atividade ao longo do tempo
// ---------------------------------------------------------------------------------------------

/** Dias de prática por semana (7 dias cada), das mais antigas para a mais recente. */
export function weeklyActivity(
  days: Iterable<string>,
  today: string,
  weeks: number,
  addDays: (day: string, n: number) => string,
): { start: string; count: number }[] {
  const set = new Set(days);
  return Array.from({ length: weeks }, (_, w) => {
    const start = addDays(today, -(weeks - w) * 7 + 1);
    let count = 0;
    for (let i = 0; i < 7; i++) if (set.has(addDays(start, i))) count++;
    return { start, count };
  });
}
