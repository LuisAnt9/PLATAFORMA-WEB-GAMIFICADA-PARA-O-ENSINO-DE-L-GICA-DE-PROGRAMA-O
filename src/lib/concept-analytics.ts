// Inteligência pedagógica (E11): funções puras do relatório de dificuldades por conceito.
// A mesma fórmula existe em SQL (supabase/migrations/0016_inteligencia_pedagogica.sql, função
// concept_report); um teste confere que os dois dão o mesmo resultado. Documentação em
// docs/inteligencia-pedagogica.md.

/** Mínimos para afirmar algo sobre UM aluno em um conceito (D8). */
export const MIN_ATTEMPTS = 3;
export const MIN_EXERCISES = 2;
/** Mínimo de alunos na turma para o painel agregado afirmar conclusões (D8). */
export const MIN_STUDENTS = 5;
/** Cada tentativa mais antiga pesa 0,8 da seguinte: as mais recentes contam mais. */
export const RECENCY = 0.8;
/** Pontuação de erro (0 a 1) até a qual o aluno está "bom" / "em desenvolvimento". */
export const GOOD_MAX = 0.25;
export const DEVELOPING_MAX = 0.5;

export type Mode = "livre" | "atividade" | "avaliacao";

export interface AttemptRow {
  id: number;
  user_id: string;
  exercise_id: string;
  passed: boolean;
  /** Instante em milissegundos. */
  at: number;
  mode: Mode;
  error_category: string | null;
  misconception: string | null;
}
export interface LinkRow {
  exercise_id: string;
  concept_id: string;
  weight: number;
}

export type Level = "bom" | "em_desenvolvimento" | "dificuldade" | "nao_avaliado";

export const LEVEL_LABEL: Record<Level, string> = {
  bom: "Bom desempenho",
  em_desenvolvimento: "Em desenvolvimento",
  dificuldade: "Ainda não demonstrou domínio",
  nao_avaliado: "Dados insuficientes",
};

export interface StudentConcept {
  student_id: string;
  concept_id: string;
  attempts: number;
  exercises: number;
  /** Pontuação de erro ponderada pela recência e pelo peso do conceito (0 = só acertos). */
  score: number;
  level: Level;
}

export interface ConceptStat {
  concept_id: string;
  attempts: number;
  exercises: number;
  students: number;
  sufficient: boolean;
  /** Taxa de erro ponderada pelo peso da ligação; null se não há dados suficientes. */
  error_rate: number | null;
  bom: number;
  em_desenvolvimento: number;
  dificuldade: number;
  nao_avaliado: number;
}

export interface ReportInput {
  attempts: AttemptRow[];
  links: LinkRow[];
  /** Quantos alunos a turma tem (não só os que tentaram algo). */
  studentsTotal: number;
  /** Para os filtros; as tentativas já devem vir filtradas por período, mundo e lição. */
  mode?: Mode | null;
}

/** Nível do aluno no conceito a partir da pontuação e das quantidades (regra D8). */
export function levelOf(attempts: number, exercises: number, score: number): Level {
  if (attempts < MIN_ATTEMPTS || exercises < MIN_EXERCISES) return "nao_avaliado";
  if (score <= GOOD_MAX) return "bom";
  if (score <= DEVELOPING_MAX) return "em_desenvolvimento";
  return "dificuldade";
}

/** Faltam quantas tentativas / exercícios / alunos para o dado deixar de ser "insuficiente". */
export function missingFor(attempts: number, exercises: number) {
  return {
    attempts: Math.max(0, MIN_ATTEMPTS - attempts),
    exercises: Math.max(0, MIN_EXERCISES - exercises),
  };
}

export function conceptReport({ attempts, links, studentsTotal, mode }: ReportInput) {
  const att = mode ? attempts.filter((a) => a.mode === mode) : attempts;
  const byExercise = new Map<string, LinkRow[]>();
  for (const l of links) byExercise.set(l.exercise_id, [...(byExercise.get(l.exercise_id) ?? []), l]);

  // uma linha por (tentativa, conceito)
  const linked = att.flatMap((a) =>
    (byExercise.get(a.exercise_id) ?? []).map((l) => ({ a, concept_id: l.concept_id, weight: l.weight })),
  );

  // aluno x conceito, mais recente primeiro
  const groups = new Map<string, typeof linked>();
  for (const x of linked) {
    const k = `${x.a.user_id}|${x.concept_id}`;
    groups.set(k, [...(groups.get(k) ?? []), x]);
  }
  const studentConcepts: StudentConcept[] = [];
  for (const [k, list] of groups) {
    const [student_id, concept_id] = k.split("|");
    const sorted = [...list].sort((p, q) => q.a.at - p.a.at || q.a.id - p.a.id);
    let num = 0;
    let den = 0;
    sorted.forEach((x, i) => {
      const w = x.weight * Math.pow(RECENCY, i);
      den += w;
      if (!x.a.passed) num += w;
    });
    const score = num / den;
    const exercises = new Set(list.map((x) => x.a.exercise_id)).size;
    studentConcepts.push({
      student_id,
      concept_id,
      attempts: list.length,
      exercises,
      score,
      level: levelOf(list.length, exercises, score),
    });
  }

  // conceito x turma
  const byConcept = new Map<string, typeof linked>();
  for (const x of linked) byConcept.set(x.concept_id, [...(byConcept.get(x.concept_id) ?? []), x]);
  const concepts: ConceptStat[] = [];
  for (const [concept_id, list] of byConcept) {
    const exercises = new Set(list.map((x) => x.a.exercise_id)).size;
    const sufficient = studentsTotal >= MIN_STUDENTS && list.length >= MIN_ATTEMPTS && exercises >= MIN_EXERCISES;
    const wSum = list.reduce((n, x) => n + x.weight, 0);
    const wErr = list.reduce((n, x) => n + (x.a.passed ? 0 : x.weight), 0);
    const lv = studentConcepts.filter((s) => s.concept_id === concept_id);
    const cnt = (l: Level) => lv.filter((s) => s.level === l).length;
    concepts.push({
      concept_id,
      attempts: list.length,
      exercises,
      students: new Set(list.map((x) => x.a.user_id)).size,
      sufficient,
      error_rate: sufficient ? wErr / wSum : null,
      bom: cnt("bom"),
      em_desenvolvimento: cnt("em_desenvolvimento"),
      dificuldade: cnt("dificuldade"),
      nao_avaliado: cnt("nao_avaliado"),
    });
  }

  // exercícios com mais erros (por tentativa, sem peso)
  const ex = new Map<string, { attempts: number; errors: number }>();
  for (const a of att) {
    const e = ex.get(a.exercise_id) ?? { attempts: 0, errors: 0 };
    e.attempts++;
    if (!a.passed) e.errors++;
    ex.set(a.exercise_id, e);
  }
  const hardest = [...ex.entries()]
    .filter(([, v]) => v.attempts >= MIN_ATTEMPTS && v.errors > 0)
    .map(([exercise_id, v]) => ({ exercise_id, ...v, error_rate: v.errors / v.attempts }))
    .sort((p, q) => q.error_rate - p.error_rate || q.attempts - p.attempts)
    .slice(0, 10);

  const count = <K extends string>(rows: AttemptRow[], key: (a: AttemptRow) => K | null) => {
    const m = new Map<K, { count: number; students: Set<string> }>();
    for (const a of rows) {
      if (a.passed) continue;
      const k = key(a);
      if (k === null) continue;
      const v = m.get(k) ?? { count: 0, students: new Set<string>() };
      v.count++;
      v.students.add(a.user_id);
      m.set(k, v);
    }
    return m;
  };
  const misconceptions = [...count(att, (a) => a.misconception).entries()]
    .map(([text, v]) => ({ text, count: v.count, students: v.students.size }))
    .sort((p, q) => q.count - p.count || p.text.localeCompare(q.text))
    .slice(0, 10);
  const categories = [...count(att, (a) => a.error_category).entries()]
    .map(([category, v]) => ({ category, count: v.count }))
    .sort((p, q) => q.count - p.count || p.category.localeCompare(q.category));

  return { concepts, studentConcepts, hardest, misconceptions, categories };
}

export type ConceptReportResult = ReturnType<typeof conceptReport>;
