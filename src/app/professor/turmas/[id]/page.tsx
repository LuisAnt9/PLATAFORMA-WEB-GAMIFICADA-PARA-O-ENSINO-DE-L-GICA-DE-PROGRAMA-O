import ClassDetail from "@/components/ClassDetail";

export default async function ClassPage({
  params,
}: PageProps<"/professor/turmas/[id]">) {
  const { id } = await params;
  return <ClassDetail id={id} />;
}
