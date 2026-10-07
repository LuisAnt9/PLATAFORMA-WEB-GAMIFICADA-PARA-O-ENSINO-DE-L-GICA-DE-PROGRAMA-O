"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import ProfessorOnly from "./ProfessorOnly";

const TABS = [
  { href: "/professor", label: "Turmas" },
  { href: "/professor/exercicios", label: "Exercícios" },
];

export default function ProfessorShell({
  children,
}: {
  children: React.ReactNode;
}) {
  const pathname = usePathname();
  return (
    <ProfessorOnly>
      <nav
        aria-label="Área do professor"
        className="mb-6 flex gap-4 border-b border-zinc-200 text-sm dark:border-zinc-800"
      >
        {TABS.map((t) => {
          const active =
            t.href === "/professor"
              ? pathname === "/professor" ||
                pathname.startsWith("/professor/turmas")
              : pathname.startsWith(t.href);
          return (
            <Link
              key={t.href}
              href={t.href}
              aria-current={active ? "page" : undefined}
              className={`-mb-px border-b-2 px-1 pb-2 ${
                active
                  ? "border-emerald-600 font-medium text-emerald-700 dark:text-emerald-400"
                  : "border-transparent text-zinc-500 hover:text-foreground"
              }`}
            >
              {t.label}
            </Link>
          );
        })}
      </nav>
      {children}
    </ProfessorOnly>
  );
}
