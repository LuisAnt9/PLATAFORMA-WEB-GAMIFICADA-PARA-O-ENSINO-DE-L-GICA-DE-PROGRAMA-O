"use client";

import Link from "next/link";
import { useAuth } from "./AuthProvider";

/** Barreira de interface; a proteção real dos dados está nas políticas do banco (RLS). */
export default function ProfessorOnly({
  children,
}: {
  children: React.ReactNode;
}) {
  const { profile } = useAuth();
  if (profile?.role !== "professor") {
    return (
      <div role="alert">
        <p className="mb-3">Esta área é restrita a professores.</p>
        <Link
          href="/"
          className="text-emerald-700 hover:underline dark:text-emerald-400"
        >
          ← Voltar à trilha
        </Link>
      </div>
    );
  }
  return <>{children}</>;
}
