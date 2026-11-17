import LessonPage from "@/components/LessonPage";

export default async function LicaoPage({ params }: PageProps<"/licao/[id]">) {
  const { id } = await params;
  return <LessonPage id={id} />;
}
