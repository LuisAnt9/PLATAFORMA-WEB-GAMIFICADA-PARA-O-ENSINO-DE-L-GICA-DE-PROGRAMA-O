import ExerciseFormLoader from "@/components/ExerciseFormLoader";

export default async function EditExercisePage({
  params,
}: PageProps<"/professor/exercicios/[id]">) {
  const { id } = await params;
  return <ExerciseFormLoader id={id} />;
}
