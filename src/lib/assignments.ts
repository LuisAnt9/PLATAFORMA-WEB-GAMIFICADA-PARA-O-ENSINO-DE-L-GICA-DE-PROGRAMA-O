import { getSupabase } from "./supabase";

export type AssignmentKind = "atividade" | "avaliacao";
export type ResultRule = "so_nota" | "nota_e_gabarito" | "gabarito_apos_prazo";

export type AssignmentStatus =
  | "nao_iniciada"
  | "em_andamento"
  | "concluida"
  | "concluida_atrasada"
  | "atrasada"
  | "entregue"
  | "nao_entregue";

export const STATUS_LABEL: Record<AssignmentStatus, string> = {
  nao_iniciada: "Não iniciada",
  em_andamento: "Em andamento",
  concluida: "Concluída",
  concluida_atrasada: "Concluída com atraso",
  atrasada: "Atrasada",
  entregue: "Entregue",
  nao_entregue: "Não entregue",
};

export const KIND_NAME: Record<AssignmentKind, string> = {
  atividade: "Atividade",
  avaliacao: "Avaliação",
};

export const RESULT_RULE_LABEL: Record<ResultRule, string> = {
  so_nota: "O aluno vê só a nota",
  nota_e_gabarito: "O aluno vê a nota e o gabarito logo após entregar",
  gabarito_apos_prazo: "O aluno vê a nota, e o gabarito só depois do prazo",
};

/** Situações em que ainda há algo a fazer (entram em "pendentes"). */
export const isPending = (s: AssignmentStatus) =>
  s === "nao_iniciada" || s === "em_andamento" || s === "atrasada";

export interface MyAssignment {
  id: number;
  kind: AssignmentKind;
  title: string;
  instructions: string;
  class_name: string;
  available_from: string;
  due_at: string;
  required: boolean;
  result_rule: ResultRule;
  items_total: number;
  items_done: number;
  submitted_at: string | null;
  score: number | null;
  max_score: number | null;
  status: AssignmentStatus;
}

export interface AssessmentQuestion {
  id: number;
  kind: "choice" | "interpretation" | "blank" | "order";
  title: string;
  statement: string;
  payload: {
    options?: string[];
    code?: string;
    template?: string;
    blanks?: number;
    items?: string[];
  };
  points: number;
}

export interface Assessment {
  id: number;
  title: string;
  instructions: string;
  due_at: string;
  result_rule: ResultRule;
  questions: AssessmentQuestion[];
}

export interface AssessmentResult {
  score: number;
  max: number;
  submitted_at: string;
  late: boolean;
  details:
    | {
        question_id: number;
        title: string;
        points: number;
        correct: boolean;
        given: unknown;
        answer: unknown;
      }[]
    | null;
}

export interface ReportStudent {
  id: string;
  name: string;
  items_total: number;
  items_done: number;
  attempts: number;
  last_attempt: string | null;
  duration_ms: number;
  score: number | null;
  max_score: number | null;
  submitted_at: string | null;
  status: AssignmentStatus;
}

export interface AssignmentReport {
  assignment: {
    id: number;
    kind: AssignmentKind;
    title: string;
    instructions: string;
    class_id: string;
    class_name: string;
    available_from: string;
    due_at: string;
    required: boolean;
    result_rule: ResultRule;
  };
  students: ReportStudent[];
  exercises: {
    exercise_id: string;
    title: string;
    attempted: number;
    solved: number;
    attempts: number;
  }[];
  concepts: {
    concept_id: string;
    title: string;
    attempts: number;
    wrong: number;
  }[];
}

export interface AssignmentSummary {
  id: number;
  kind: AssignmentKind;
  title: string;
  class_id: string;
  class_name: string;
  available_from: string;
  due_at: string;
  required: boolean;
  archived: boolean;
  students: number;
  started: number;
  completed: number;
}

export interface NewAssignment {
  classId: string;
  kind: AssignmentKind;
  title: string;
  instructions: string;
  availableFrom: string; // ISO
  dueAt: string; // ISO
  required: boolean;
  resultRule: ResultRule;
  items: { exercise_id: string; points: number }[];
}

/** Mensagens do banco (já em português) viram texto para o usuário. */
function fail(error: { message: string; code?: string }): never {
  const known: Record<string, string> = {
    JA_ENTREGUE: "Você já entregou esta avaliação.",
    FORA_DO_PRAZO: "O prazo desta avaliação terminou.",
    NAO_DISPONIVEL: "Esta avaliação ainda não está disponível.",
  };
  const hit = Object.keys(known).find((k) => error.message.includes(k));
  throw new Error(
    hit
      ? known[hit]
      : error.code === "P0001"
        ? error.message
        : "Não foi possível concluir a operação. Tente novamente.",
  );
}

async function rpc<T>(fn: string, args?: Record<string, unknown>): Promise<T> {
  const { data, error } = await getSupabase().rpc(fn, args);
  if (error) fail(error);
  return data as T;
}

/** Listas devolvidas pelo banco: qualquer outra coisa vira lista vazia (ex.: migration 0015 ainda não aplicada). */
const asList = <T>(x: unknown): T[] => (Array.isArray(x) ? (x as T[]) : []);

export const listMyAssignments = async () =>
  asList<MyAssignment>(await rpc<unknown>("my_assignments"));
export const getAssessment = (id: number) =>
  rpc<Assessment>("get_assessment", { p_assignment: id });
export const getAssessmentResult = (id: number) =>
  rpc<AssessmentResult | null>("assessment_result", { p_assignment: id });
export const submitAssessment = (id: number, answers: Record<string, unknown>) =>
  rpc<AssessmentResult>("submit_assessment", {
    p_assignment: id,
    p_answers: answers,
  });
export const assignmentReport = (id: number) =>
  rpc<AssignmentReport>("assignment_report", { p_assignment: id });
export const teacherSummaries = async () =>
  asList<AssignmentSummary>(await rpc<unknown>("teacher_assignment_summaries"));

export const createAssignment = (a: NewAssignment) =>
  rpc<number>("create_assignment", {
    p_class: a.classId,
    p_kind: a.kind,
    p_title: a.title,
    p_instructions: a.instructions,
    p_available_from: a.availableFrom,
    p_due_at: a.dueAt,
    p_required: a.required,
    p_result_rule: a.resultRule,
    p_items: a.items,
  });

/** Exercícios de uma atividade (só atividades; em avaliação o aluno não vê a origem). */
export async function listAssignmentItems(id: number): Promise<string[]> {
  const { data, error } = await getSupabase()
    .from("assignment_items")
    .select("exercise_id, position")
    .eq("assignment_id", id)
    .order("position");
  if (error) fail(error);
  return (data as { exercise_id: string }[]).map((r) => r.exercise_id);
}

export async function setAssignmentArchived(
  id: number,
  archived: boolean,
): Promise<void> {
  const { error } = await getSupabase()
    .from("assignments")
    .update({ archived })
    .eq("id", id);
  if (error) fail(error);
}

export async function deleteAssignment(id: number): Promise<void> {
  const { error } = await getSupabase()
    .from("assignments")
    .delete()
    .eq("id", id);
  if (error) fail(error);
}

export async function setClassArchived(
  classId: string,
  archived: boolean,
): Promise<void> {
  const { error } = await getSupabase()
    .from("classes")
    .update({ archived })
    .eq("id", classId);
  if (error) fail(error);
}

// ---- formatação ----

/** "20/11 às 23:59" no horário do navegador. */
export function formatDue(iso: string): string {
  const d = new Date(iso);
  return `${d.toLocaleDateString("pt-BR", { day: "2-digit", month: "2-digit" })} às ${d.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" })}`;
}

/** Valor de <input type="datetime-local"> (horário local) para ISO e de volta. */
export function localInputToIso(v: string): string {
  return new Date(v).toISOString();
}
export function isoToLocalInput(iso: string): string {
  const d = new Date(iso);
  const p = (n: number) => String(n).padStart(2, "0");
  return `${d.getFullYear()}-${p(d.getMonth() + 1)}-${p(d.getDate())}T${p(d.getHours())}:${p(d.getMinutes())}`;
}

export function formatDuration(ms: number): string {
  if (!ms) return "—";
  const min = Math.round(ms / 60000);
  return min < 1 ? "menos de 1 min" : `${min} min`;
}

/** Aproveitamento e conclusão da turma, para o painel. */
export function completionRate(s: AssignmentSummary): number {
  return s.students ? s.completed / s.students : 0;
}
