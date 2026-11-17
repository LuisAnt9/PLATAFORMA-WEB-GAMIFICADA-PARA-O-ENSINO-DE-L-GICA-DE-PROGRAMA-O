import AssignmentReportView from "@/components/AssignmentReportView";

export default async function RelatorioPage({
  params,
}: PageProps<"/professor/atividades/[id]">) {
  const { id } = await params;
  return <AssignmentReportView id={Number(id)} />;
}
