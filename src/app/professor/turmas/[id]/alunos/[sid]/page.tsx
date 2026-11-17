import StudentProfile from "@/components/StudentProfile";

export default async function AlunoPage({
  params,
}: PageProps<"/professor/turmas/[id]/alunos/[sid]">) {
  const { id, sid } = await params;
  return <StudentProfile classId={id} studentId={sid} />;
}
