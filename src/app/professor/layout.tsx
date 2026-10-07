import ProfessorShell from "@/components/ProfessorShell";

export default function ProfessorLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return <ProfessorShell>{children}</ProfessorShell>;
}
