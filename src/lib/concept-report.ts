import type { Level, Mode } from "./concept-analytics";
import { getSupabase } from "./supabase";

export interface ConceptRow {
  concept_id: string;
  title: string;
  world_id: string | null;
  attempts: number;
  exercises: number;
  students: number;
  sufficient: boolean;
  error_rate: number | null;
  bom: number;
  em_desenvolvimento: number;
  dificuldade: number;
  nao_avaliado: number;
}

export interface StudentConceptRow {
  student_id: string;
  name: string;
  concept_id: string;
  attempts: number;
  exercises: number;
  score: number;
  level: Level;
}

export interface ConceptReportData {
  students_total: number;
  min_students: number;
  concepts: ConceptRow[];
  student_concepts: StudentConceptRow[];
  hardest_exercises: { exercise_id: string; title: string; attempts: number; errors: number; error_rate: number }[];
  misconceptions: { text: string; count: number; students: number }[];
  error_categories: { category: string; count: number }[];
  by_mode: { mode: Mode; attempts: number; errors: number }[];
  timeline: { day: string; attempts: number; errors: number }[];
}

export interface ReportFilters {
  mode: Mode | "";
  /** Dias para trás a partir de agora (0 = todo o período). */
  days: number;
  world: string;
  module: string;
}

export const NO_FILTERS: ReportFilters = { mode: "", days: 0, world: "", module: "" };

export const MODE_LABEL: Record<Mode, string> = {
  livre: "Aprendizagem livre",
  atividade: "Atividade",
  avaliacao: "Avaliação",
};

export const CATEGORY_LABEL: Record<string, string> = {
  sintaxe: "Erro de sintaxe",
  execucao: "Erro de execução",
  tempo: "Tempo esgotado",
  saida_incorreta: "Saída incorreta",
  escolha_incorreta: "Alternativa incorreta",
  lacuna_incorreta: "Lacuna incorreta",
  ordem_incorreta: "Ordem incorreta",
};

const arr = <T>(x: unknown): T[] => (Array.isArray(x) ? (x as T[]) : []);

export async function loadConceptReport(
  classId: string,
  f: ReportFilters,
): Promise<ConceptReportData> {
  const { data, error } = await getSupabase().rpc("concept_report", {
    p_class: classId,
    p_mode: f.mode || null,
    p_from: f.days > 0 ? new Date(Date.now() - f.days * 864e5).toISOString() : null,
    p_to: null,
    p_world: f.world || null,
    p_module: f.module || null,
  });
  if (error) {
    throw new Error(
      error.code === "P0001"
        ? error.message
        : "Não foi possível carregar o relatório. A migration 0016 já foi aplicada?",
    );
  }
  const d = (data ?? {}) as Partial<ConceptReportData>;
  return {
    students_total: Number(d.students_total ?? 0),
    min_students: Number(d.min_students ?? 5),
    concepts: arr(d.concepts),
    student_concepts: arr(d.student_concepts),
    hardest_exercises: arr(d.hardest_exercises),
    misconceptions: arr(d.misconceptions),
    error_categories: arr(d.error_categories),
    by_mode: arr(d.by_mode),
    timeline: arr(d.timeline),
  };
}
