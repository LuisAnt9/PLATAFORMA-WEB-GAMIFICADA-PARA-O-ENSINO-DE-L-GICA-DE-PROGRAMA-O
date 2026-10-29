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
      <nav aria-label="Área do professor" className="mb-6 flex gap-1 text-sm">
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
              className={`rounded-lg px-3 py-1.5 ${
                active
                  ? "bg-emerald-100 font-medium text-emerald-900 dark:bg-emerald-950 dark:text-emerald-200"
                  : "text-zinc-600 hover:bg-zinc-100 hover:text-foreground dark:text-zinc-400 dark:hover:bg-zinc-800"
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
