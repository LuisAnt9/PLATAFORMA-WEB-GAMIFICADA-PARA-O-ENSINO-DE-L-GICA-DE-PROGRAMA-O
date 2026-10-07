import ExerciseLoader from "@/components/ExerciseLoader";

export default async function ExercisePage({
  params,
}: PageProps<"/exercicio/[id]">) {
  const { id } = await params;
  return <ExerciseLoader id={id} />;
}
