import type { Exercise } from "./catalog";
import {
  buildStarterCode,
  type Draft,
  type DraftValidation,
} from "./exercise-draft";
import { getSupabase } from "./supabase";

function fail(error: { message: string }): never {
  // PostgREST responde assim quando uma coluna não existe (migration ainda não aplicada).
  if (/column|schema cache/i.test(error.message)) {
    throw new Error(
      "O banco ainda não tem os recursos deste exercício. Rode as migrations mais recentes (0005) no SQL Editor do Supabase.",
    );
  }
  throw new Error(`Não foi possível salvar: ${error.message}`);
}

/** Próxima posição dentro do módulo (fim da lista). */
function nextPosition(exercises: Exercise[], moduleId: string): number {
  return (
    exercises
      .filter((e) => e.moduleId === moduleId)
      .reduce((m, e) => Math.max(m, e.position), 0) + 1
  );
}

/**
 * Colunas a gravar. As colunas novas (kind, config, lesson) só vão quando necessárias, para que
 * exercícios de código comuns continuem salvando mesmo em um banco sem a migration 0005.
 */
function fields(
  d: Draft,
  v: DraftValidation,
  published: boolean,
  previousLesson: string | null = null,
) {
  const common = {
    module_id: d.moduleId,
    title: d.title.trim(),
    difficulty: d.difficulty,
    statement: d.statement.trim(),
    hint: d.hint.trim(),
    published,
    ...(d.lesson.trim() || previousLesson
      ? { lesson: d.lesson.trim() || null }
      : {}),
  };
  if (d.kind === "code") {
    const name = d.functionName.trim();
    return {
      ...common,
      function_name: name,
      starter_code: buildStarterCode(name, d.params),
      tests: v.tests,
    };
  }
  return {
    ...common,
    kind: d.kind,
    config: v.config,
    function_name: null,
    starter_code: "",
    tests: [],
  };
}

export async function createExercise(
  id: string,
  userId: string,
  d: Draft,
  v: DraftValidation,
  published: boolean,
  all: Exercise[],
): Promise<void> {
  const { error } = await getSupabase()
    .from("exercises")
    .insert({
      id,
      created_by: userId,
      position: nextPosition(all, d.moduleId),
      ...fields(d, v, published),
    });
  if (error) fail(error);
}

export async function updateExercise(
  existing: Exercise,
  d: Draft,
  v: DraftValidation,
  published: boolean,
  all: Exercise[],
): Promise<void> {
  const moved = existing.moduleId !== d.moduleId;
  const { error } = await getSupabase()
    .from("exercises")
    .update({
      ...fields(d, v, published, existing.lesson),
      ...(moved ? { position: nextPosition(all, d.moduleId) } : {}),
    })
    .eq("id", existing.id);
  if (error) fail(error);
}

export async function setPublished(
  id: string,
  published: boolean,
): Promise<void> {
  const { error } = await getSupabase()
    .from("exercises")
    .update({ published })
    .eq("id", id);
  if (error) fail(error);
}

/** Troca de lugar dois exercícios vizinhos do mesmo módulo. */
export async function swapPositions(a: Exercise, b: Exercise): Promise<void> {
  const supabase = getSupabase();
  // Posições temporárias evitam depender de unicidade; as duas escritas são independentes.
  const [r1, r2] = await Promise.all([
    supabase.from("exercises").update({ position: b.position }).eq("id", a.id),
    supabase.from("exercises").update({ position: a.position }).eq("id", b.id),
  ]);
  if (r1.error) fail(r1.error);
  if (r2.error) fail(r2.error);
}

export async function createModule(
  id: string,
  title: string,
  focus: string,
  position: number,
): Promise<void> {
  const { error } = await getSupabase()
    .from("modules")
    .insert({ id, title: title.trim(), focus: focus.trim(), position });
  if (error) fail(error);
}

export async function updateModule(
  id: string,
  title: string,
  focus: string,
): Promise<void> {
  const { error } = await getSupabase()
    .from("modules")
    .update({ title: title.trim(), focus: focus.trim() })
    .eq("id", id);
  if (error) fail(error);
}
