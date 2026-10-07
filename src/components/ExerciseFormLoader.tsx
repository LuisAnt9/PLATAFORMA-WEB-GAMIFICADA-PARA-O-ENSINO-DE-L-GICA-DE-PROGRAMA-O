"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { getExercise } from "@/lib/catalog";
import { CatalogGate, useCatalog } from "./CatalogProvider";
import ExerciseForm from "./ExerciseForm";

/**
 * O Next mantém páginas já visitadas escondidas na memória (com o estado). Para o formulário isso
 * traria dados de um exercício anterior de volta; então ele recomeça do zero a cada nova exibição.
 */
function FreshOnShow({ children }: { children: React.ReactNode }) {
  const [visit, setVisit] = useState(0);
  useEffect(() => () => setVisit((v) => v + 1), []);
  return <div key={visit}>{children}</div>;
}

function Inner({ id }: { id?: string }) {
  const { catalog } = useCatalog();
  if (!id)
    return (
      <FreshOnShow>
        <ExerciseForm />
      </FreshOnShow>
    );
  const existing = getExercise(catalog, id);
  if (!existing)
    return (
      <div>
        <p className="mb-3">Exercício não encontrado.</p>
        <Link
          href="/professor/exercicios"
          className="text-emerald-700 hover:underline dark:text-emerald-400"
        >
          ← Exercícios
        </Link>
      </div>
    );
  return (
    <FreshOnShow key={existing.id}>
      <ExerciseForm existing={existing} />
    </FreshOnShow>
  );
}

export default function ExerciseFormLoader({ id }: { id?: string }) {
  return (
    <CatalogGate>
      <Inner id={id} />
    </CatalogGate>
  );
}
