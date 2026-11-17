import AssignmentPage from "@/components/AssignmentPage";

export default async function AtividadePage({
  params,
}: PageProps<"/atividades/[id]">) {
  const { id } = await params;
  return <AssignmentPage id={Number(id)} />;
}
