import type { Exercise } from "./catalog";
import { optionText } from "./grading";
import type { BlankResult } from "./grading";
import type { RunResult } from "./runner";
import { getSupabase } from "./supabase";

export type AttemptMode = "livre" | "atividade" | "avaliacao";

const MAX_ANSWER = 4000;
const MAX_DURATION_MS = 3_600_000;

/** O que o aluno enviou, por tipo de exercício. */
export type Submission =
  | { kind: "code"; code: string; result: RunResult }
  | { kind: "choice"; selected: number }
  | { kind: "blank"; answers: string[]; result: BlankResult };

export interface AttemptInput {
  exercise: Exercise;
  submission: Submission;
  passed: boolean;
  /** Tempo gasto nesta tentativa, em milissegundos. */
  durationMs: number;
  mode?: AttemptMode;
  assignmentId?: number | null;
}

/** Parâmetros da função `record_attempt` do banco (puro, para poder testar). */
export function buildAttemptParams(
  input: AttemptInput,
): Record<string, unknown> {
  const { exercise, submission, passed } = input;
  const params: Record<string, unknown> = {
    p_exercise: exercise.id,
    p_passed: passed,
    p_duration_ms: Math.min(
      MAX_DURATION_MS,
      Math.max(0, Math.round(input.durationMs)),
    ),
    p_mode: input.mode ?? "livre",
    p_assignment_id: input.assignmentId ?? null,
  };
  if (submission.kind === "code") {
    const total = exercise.tests.length;
    params.p_answer = submission.code.slice(0, MAX_ANSWER);
    params.p_tests_total = total;
    params.p_tests_passed = Math.min(
      total,
      submission.result.tests.filter((t) => t.passed).length,
    );
    params.p_error_category = passed
      ? null
      : (submission.result.errorCategory ?? "saida_incorreta");
  } else if (submission.kind === "choice") {
    const option = exercise.config.options?.[submission.selected];
    params.p_selected = submission.selected;
    params.p_answer = JSON.stringify({
      selected: submission.selected,
      text: option === undefined ? null : optionText(option),
    }).slice(0, MAX_ANSWER);
  } else {
    params.p_answer = JSON.stringify(submission.answers).slice(0, MAX_ANSWER);
    params.p_tests_total = submission.result.correct.length;
    params.p_tests_passed = submission.result.correct.filter(Boolean).length;
  }
  return params;
}

/**
 * Registra a tentativa no banco. É "melhor esforço": se a migration 0010 ainda não foi aplicada,
 * se a rede cair ou se o limite por minuto for atingido, o aluno nem percebe e o exercício segue normal.
 */
export async function saveAttempt(input: AttemptInput): Promise<void> {
  try {
    await getSupabase().rpc("record_attempt", buildAttemptParams(input));
  } catch {
    /* sem registro, sem problema para o aluno */
  }
}
