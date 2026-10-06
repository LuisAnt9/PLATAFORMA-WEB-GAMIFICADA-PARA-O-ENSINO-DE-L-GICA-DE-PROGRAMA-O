import { notFound } from "next/navigation";
import ExerciseView from "@/components/ExerciseView";
import { exercises, getExercise } from "@/lib/exercises";

export function generateStaticParams() {
  return exercises.map((e) => ({ id: e.id }));
}

export default async function ExercisePage({
  params,
}: PageProps<"/exercicio/[id]">) {
  const { id } = await params;
  const exercise = getExercise(id);
  if (!exercise) notFound();
  return <ExerciseView exercise={exercise} />;
}
