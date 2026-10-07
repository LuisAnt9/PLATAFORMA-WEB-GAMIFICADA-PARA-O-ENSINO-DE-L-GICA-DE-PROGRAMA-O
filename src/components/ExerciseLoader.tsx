"use client";

import Link from "next/link";
import { getExercise } from "@/lib/catalog";
import { CatalogGate, useCatalog } from "./CatalogProvider";
import ExerciseView from "./ExerciseView";

function Inner({ id }: { id: string }) {
  const { catalog } = useCatalog();
  const exercise = getExercise(catalog, id);
  if (!exercise) {
    return (
      <div>
        <p className="mb-3">Exercício não encontrado.</p>
        <Link
          href="/"
          className="text-emerald-700 hover:underline dark:text-emerald-400"
        >
          ← Voltar à trilha
        </Link>
      </div>
    );
  }
  // key força reinício do editor ao trocar de exercício
  return <ExerciseView key={exercise.id} exercise={exercise} />;
}

export default function ExerciseLoader({ id }: { id: string }) {
  return (
    <CatalogGate>
      <Inner id={id} />
    </CatalogGate>
  );
}
