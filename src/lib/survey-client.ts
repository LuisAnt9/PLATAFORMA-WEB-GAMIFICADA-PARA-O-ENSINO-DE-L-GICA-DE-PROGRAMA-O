import type { SurveyKind } from "./surveys";
import { getSupabase } from "./supabase";

function fail(error: { message: string; code?: string }): never {
  if (error.message.includes("JA_RESPONDIDO"))
    throw new Error("Você já respondeu a este questionário. Obrigado!");
  throw new Error(
    error.code === "P0001"
      ? error.message
      : "Não foi possível enviar. Verifique a conexão e tente de novo.",
  );
}

/** Quais questionários o aluno já respondeu (sem revelar as respostas anônimas). */
export async function loadDone(): Promise<SurveyKind[]> {
  const { data, error } = await getSupabase().from("survey_done").select("kind");
  if (error || !Array.isArray(data)) return [];
  return (data as { kind: SurveyKind }[]).map((r) => r.kind);
}

export async function submitSurvey(input: {
  kind: SurveyKind;
  answers: number[];
  comment: string;
  anonymous: boolean;
  classId: string | null;
}): Promise<number | null> {
  const { data, error } = await getSupabase().rpc("submit_survey", {
    p_kind: input.kind,
    p_answers: Object.fromEntries(input.answers.map((v, i) => [String(i + 1), v])),
    p_comment: input.comment.trim() || null,
    p_anonymous: input.anonymous,
    p_class: input.classId,
  });
  if (error) fail(error);
  return data === null || data === undefined ? null : Number(data);
}

export interface SurveySummary {
  sus: { n: number; sufficient: boolean; mean_score?: number; item_means?: Record<string, number>; anonymous?: number };
  likert: { n: number; sufficient: boolean; mean_score?: number; item_means?: Record<string, number>; anonymous?: number };
}

export interface AiComparison {
  sufficient: boolean;
  com_ia?: number;
  sem_ia?: number;
  min: number;
  grupos?: {
    grupo: "com" | "sem";
    alunos: number;
    tentativas_por_aluno: number;
    taxa_de_acerto: number;
    exercicios_resolvidos_por_aluno: number;
  }[];
}

export async function loadSummary(classId: string | null): Promise<SurveySummary> {
  const { data, error } = await getSupabase().rpc("survey_summary", { p_class: classId });
  if (error) fail(error);
  const d = (data ?? {}) as Partial<SurveySummary>;
  return {
    sus: d.sus ?? { n: 0, sufficient: false },
    likert: d.likert ?? { n: 0, sufficient: false },
  };
}

export async function loadAiComparison(classId: string | null): Promise<AiComparison> {
  const { data, error } = await getSupabase().rpc("ai_hint_comparison", { p_class: classId });
  if (error) fail(error);
  return data as AiComparison;
}

export async function exportCsv(classId: string | null): Promise<string> {
  const { data, error } = await getSupabase().rpc("export_survey_csv", { p_class: classId });
  if (error) fail(error);
  return String(data ?? "");
}
