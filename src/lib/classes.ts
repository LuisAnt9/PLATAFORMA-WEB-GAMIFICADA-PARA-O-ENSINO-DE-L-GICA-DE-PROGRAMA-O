import type { ClassData, MemberRow, ProgressRow } from "./class-stats";
import { getSupabase } from "./supabase";

export interface MyClass {
  id: string;
  name: string;
}

export interface TeacherClass extends MyClass {
  code: string;
  createdAt: string;
  members: number;
}

/** Mensagens "raise exception" do banco já vêm em português; o resto vira texto genérico. */
function fail(error: { message: string; code?: string }): never {
  const friendly =
    error.code === "P0001"
      ? error.message
      : "Não foi possível concluir a operação. Tente novamente.";
  throw new Error(friendly);
}

// ---------- Aluno ----------

export async function listMyClasses(): Promise<MyClass[]> {
  const { data, error } = await getSupabase()
    .from("classes")
    .select("id, name")
    .order("name");
  if (error) fail(error);
  return data as MyClass[];
}

export async function joinClass(code: string): Promise<MyClass> {
  const { data, error } = await getSupabase().rpc("join_class", {
    class_code: code,
  });
  if (error) fail(error);
  return (data as MyClass[])[0];
}

export async function leaveClass(
  classId: string,
  userId: string,
): Promise<void> {
  const { error } = await getSupabase()
    .from("class_members")
    .delete()
    .eq("class_id", classId)
    .eq("student_id", userId);
  if (error) fail(error);
}

// ---------- Professor ----------

export async function listTeacherClasses(
  userId: string,
): Promise<TeacherClass[]> {
  const supabase = getSupabase();
  const [c, m] = await Promise.all([
    supabase
      .from("classes")
      .select("id, name, code, created_at")
      .eq("teacher_id", userId)
      .order("created_at", { ascending: false }),
    supabase.from("class_members").select("class_id"),
  ]);
  if (c.error) fail(c.error);
  if (m.error) fail(m.error);
  const counts = new Map<string, number>();
  for (const r of m.data as { class_id: string }[])
    counts.set(r.class_id, (counts.get(r.class_id) ?? 0) + 1);
  return (
    c.data as { id: string; name: string; code: string; created_at: string }[]
  ).map((r) => ({
    id: r.id,
    name: r.name,
    code: r.code,
    createdAt: r.created_at,
    members: counts.get(r.id) ?? 0,
  }));
}

export async function getTeacherClass(
  classId: string,
): Promise<{ id: string; name: string; code: string } | null> {
  const { data, error } = await getSupabase()
    .from("classes")
    .select("id, name, code")
    .eq("id", classId)
    .maybeSingle();
  if (error) fail(error);
  return data;
}

export async function createClass(name: string): Promise<void> {
  const { error } = await getSupabase().rpc("create_class", {
    class_name: name,
  });
  if (error) fail(error);
}

export async function renameClass(
  classId: string,
  name: string,
): Promise<void> {
  const { error } = await getSupabase()
    .from("classes")
    .update({ name })
    .eq("id", classId);
  if (error) fail(error);
}

export async function deleteClass(classId: string): Promise<void> {
  const { error } = await getSupabase()
    .from("classes")
    .delete()
    .eq("id", classId);
  if (error) fail(error);
}

export async function removeMember(
  classId: string,
  studentId: string,
): Promise<void> {
  const { error } = await getSupabase()
    .from("class_members")
    .delete()
    .eq("class_id", classId)
    .eq("student_id", studentId);
  if (error) fail(error);
}

/** Alunos da turma e o progresso deles (o banco só devolve o que este professor pode ver). */
export async function loadClassData(classId: string): Promise<ClassData> {
  const supabase = getSupabase();
  const mem = await supabase
    .from("class_members")
    .select("student_id, joined_at")
    .eq("class_id", classId);
  if (mem.error) fail(mem.error);
  const rows = mem.data as { student_id: string; joined_at: string }[];
  if (rows.length === 0) return { members: [], progress: [] };
  const ids = rows.map((r) => r.student_id);
  const [prof, prog] = await Promise.all([
    supabase.from("profiles").select("id, name").in("id", ids),
    supabase
      .from("exercise_progress")
      .select(
        "user_id, exercise_id, attempts, solved, first_try, xp, updated_at",
      )
      .in("user_id", ids),
  ]);
  if (prof.error) fail(prof.error);
  if (prog.error) fail(prog.error);
  const names = new Map(
    (prof.data as { id: string; name: string }[]).map((p) => [p.id, p.name]),
  );
  const members: MemberRow[] = rows
    .map((r) => ({
      id: r.student_id,
      name: names.get(r.student_id) ?? "(sem nome)",
      joinedAt: r.joined_at,
    }))
    .sort((a, b) => a.name.localeCompare(b.name, "pt-BR"));
  return { members, progress: prog.data as ProgressRow[] };
}
