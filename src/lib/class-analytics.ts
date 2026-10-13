import type { Exercise } from "./catalog";
import {
  DAY_MS,
  daysSince,
  type ClassData,
  type MemberSummary,
} from "./class-stats";

/** Tentativas sem acertar a partir das quais consideramos o aluno "travado" num exercício. */
export const STUCK_ATTEMPTS = 4;
export const INACTIVE_DAYS = 7;
/** Um aluno recém-chegado só vira alerta por "nunca tentou" depois de alguns dias. */
export const NEWCOMER_DAYS = 3;

export interface ExerciseStat {
  exercise: Exercise;
  attempted: number;
  solved: number;
  /** solved / attempted (null se ninguém tentou). */
  solveRate: number | null;
  /** Média de tentativas dos alunos que acertaram. */
  avgAttempts: number | null;
  /** Fração dos que acertaram que acertou de primeira. */
  firstTryRate: number | null;
  /** Alunos com STUCK_ATTEMPTS+ tentativas e ainda sem acertar. */
  stuck: number;
}

export function exerciseStats(
  data: ClassData,
  exercises: Exercise[],
): ExerciseStat[] {
  const memberIds = new Set(data.members.map((m) => m.id));
  return exercises.map((exercise) => {
    const rows = data.progress.filter(
      (p) => p.exercise_id === exercise.id && memberIds.has(p.user_id),
    );
    const attemptedRows = rows.filter((r) => r.attempts > 0);
    const solvedRows = rows.filter((r) => r.solved);
    return {
      exercise,
      attempted: attemptedRows.length,
      solved: solvedRows.length,
      solveRate: attemptedRows.length
        ? solvedRows.length / attemptedRows.length
        : null,
      avgAttempts: solvedRows.length
        ? solvedRows.reduce((n, r) => n + r.attempts, 0) / solvedRows.length
        : null,
      firstTryRate: solvedRows.length
        ? solvedRows.filter((r) => r.first_try).length / solvedRows.length
        : null,
      stuck: rows.filter((r) => !r.solved && r.attempts >= STUCK_ATTEMPTS)
        .length,
    };
  });
}

/** Exercícios que a turma mais tem dificuldade: menor taxa de acerto, depois mais tentativas, depois mais travados. */
export function hardestExercises(
  stats: ExerciseStat[],
  limit = 5,
): ExerciseStat[] {
  return stats
    .filter((s) => s.attempted > 0)
    .sort(
      (a, b) =>
        (a.solveRate ?? 1) - (b.solveRate ?? 1) ||
        (b.avgAttempts ?? 0) - (a.avgAttempts ?? 0) ||
        b.stuck - a.stuck ||
        a.exercise.position - b.exercise.position,
    )
    .slice(0, limit);
}

export interface StudentAlert {
  studentId: string;
  name: string;
  reasons: string[];
}

const plural = (n: number, one: string, many: string) =>
  `${n} ${n === 1 ? one : many}`;

export function studentAlerts(
  summaries: MemberSummary[],
  data: ClassData,
  validIds?: Set<string>,
  now = Date.now(),
): StudentAlert[] {
  const alerts: StudentAlert[] = [];
  for (const s of summaries) {
    const reasons: string[] = [];
    const idle = daysSince(s.lastActivity, now);
    if (idle === null) {
      const joined = daysSince(s.joinedAt, now) ?? 0;
      if (joined >= NEWCOMER_DAYS)
        reasons.push(
          `Ainda não tentou nenhum exercício (entrou há ${plural(joined, "dia", "dias")})`,
        );
    } else if (idle >= INACTIVE_DAYS) {
      reasons.push(`Sem atividade há ${plural(idle, "dia", "dias")}`);
    }
    const stuck = data.progress.filter(
      (p) =>
        p.user_id === s.id &&
        !p.solved &&
        p.attempts >= STUCK_ATTEMPTS &&
        (!validIds || validIds.has(p.exercise_id)),
    ).length;
    if (stuck > 0)
      reasons.push(
        `Travado em ${plural(stuck, "exercício", "exercícios")} (${STUCK_ATTEMPTS}+ tentativas sem acertar)`,
      );
    if (reasons.length) alerts.push({ studentId: s.id, name: s.name, reasons });
  }
  return alerts.sort(
    (a, b) =>
      b.reasons.length - a.reasons.length ||
      a.name.localeCompare(b.name, "pt-BR"),
  );
}

export interface DayCount {
  /** AAAA-MM-DD no fuso informado. */
  date: string;
  count: number;
}

/** Exercícios resolvidos por dia nos últimos `days` dias (inclui hoje). `offsetMinutes` = fuso do navegador (ex.: -180 = UTC-3). */
export function solvedPerDay(
  data: ClassData,
  days = 14,
  now = Date.now(),
  offsetMinutes = 0,
): DayCount[] {
  const shift = offsetMinutes * 60_000;
  const key = (ts: number) => new Date(ts + shift).toISOString().slice(0, 10);
  const buckets = new Map<string, number>();
  for (let i = days - 1; i >= 0; i--) buckets.set(key(now - i * DAY_MS), 0);
  const memberIds = new Set(data.members.map((m) => m.id));
  for (const p of data.progress) {
    if (!p.solved || !p.solved_at || !memberIds.has(p.user_id)) continue;
    const k = key(new Date(p.solved_at).getTime());
    if (buckets.has(k)) buckets.set(k, buckets.get(k)! + 1);
  }
  return [...buckets].map(([date, count]) => ({ date, count }));
}

export type CellState = "solved" | "trying" | "none";
export interface Cell {
  state: CellState;
  attempts: number;
}
export interface MatrixRow {
  studentId: string;
  name: string;
  cells: Cell[];
}

/** Grade aluno × exercício: resolvido, tentando (com nº de tentativas) ou nada. */
export function progressMatrix(
  data: ClassData,
  exercises: Exercise[],
): MatrixRow[] {
  return data.members.map((m) => ({
    studentId: m.id,
    name: m.name,
    cells: exercises.map((e) => {
      const row = data.progress.find(
        (p) => p.user_id === m.id && p.exercise_id === e.id,
      );
      if (!row || row.attempts === 0) return { state: "none", attempts: 0 };
      return {
        state: row.solved ? "solved" : "trying",
        attempts: row.attempts,
      };
    }),
  }));
}

export interface Overview {
  students: number;
  avgXp: number;
  /** Média de exercícios resolvidos / total publicado (0..1). */
  avgCompletion: number;
  /** Alunos com atividade nos últimos INACTIVE_DAYS dias. */
  activeRecently: number;
}

export function classOverview(
  summaries: MemberSummary[],
  totalExercises: number,
  now = Date.now(),
): Overview {
  const n = summaries.length;
  if (n === 0)
    return { students: 0, avgXp: 0, avgCompletion: 0, activeRecently: 0 };
  return {
    students: n,
    avgXp: Math.round(summaries.reduce((t, s) => t + s.xp, 0) / n),
    avgCompletion: totalExercises
      ? summaries.reduce((t, s) => t + s.solved / totalExercises, 0) / n
      : 0,
    activeRecently: summaries.filter((s) => {
      const d = daysSince(s.lastActivity, now);
      return d !== null && d < INACTIVE_DAYS;
    }).length,
  };
}

const AXIS_STEPS = [4, 6, 8, 10, 20, 40, 60, 100, 200, 400, 1000, 2000];

/** Limite superior "redondo" do eixo de um gráfico de contagem (o eixo tem 3 marcas: 0, metade e o limite). */
export function niceMax(max: number): number {
  return AXIS_STEPS.find((s) => s >= max) ?? Math.ceil(max / 1000) * 1000;
}
