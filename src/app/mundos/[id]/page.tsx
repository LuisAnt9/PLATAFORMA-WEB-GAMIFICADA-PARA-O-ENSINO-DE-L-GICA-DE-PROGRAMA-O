import WorldDetail from "@/components/WorldDetail";

export default async function MundoPage({ params }: PageProps<"/mundos/[id]">) {
  const { id } = await params;
  return <WorldDetail id={id} />;
}
