export interface MemberRow {
  id: string;
  name: string;
  joinedAt: string;
}

export interface ProgressRow {
  user_id: string;
  exercise_id: string;
  attempts: number;
  solved: boolean;
  first_try: boolean;
  xp: number;
  updated_at: string;
}

export interface ClassData {
  members: MemberRow[];
  progress: ProgressRow[];
}

export interface MemberSummary extends MemberRow {
  xp: number;
  solved: number;
  attempts: number;
  /** ISO da última atividade, ou null se nunca tentou nada. */
  lastActivity: string | null;
}

/** Resume o desempenho de cada aluno da turma. `validIds` limita a contagem a exercícios publicados. */
export function memberSummaries(
  data: ClassData,
  validIds?: Set<string>,
): MemberSummary[] {
  return data.members.map((m) => {
    const rows = data.progress.filter((p) => p.user_id === m.id);
    const counted = validIds
      ? rows.filter((r) => validIds.has(r.exercise_id))
      : rows;
    return {
      ...m,
      xp: counted.reduce((n, r) => n + (r.solved ? r.xp : 0), 0),
      solved: counted.filter((r) => r.solved).length,
      attempts: rows.reduce((n, r) => n + r.attempts, 0),
      lastActivity: rows.reduce<string | null>(
        (max, r) => (max === null || r.updated_at > max ? r.updated_at : max),
        null,
      ),
    };
  });
}

export const DAY_MS = 24 * 60 * 60 * 1000;

/** Dias desde a última atividade (null = nunca teve). */
export function daysSince(iso: string | null, now = Date.now()): number | null {
  if (!iso) return null;
  return Math.max(0, Math.floor((now - new Date(iso).getTime()) / DAY_MS));
}
