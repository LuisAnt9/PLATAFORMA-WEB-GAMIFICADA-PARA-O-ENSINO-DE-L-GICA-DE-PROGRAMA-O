// Roda todas as suítes de navegador, uma de cada vez, e resume o resultado.
// Pré-requisito: site rodando em E2E_BASE_URL (padrão http://localhost:3100):
//   npm run build && npx next start -p 3100
import { spawnSync } from "node:child_process";
import path from "node:path";
import { fileURLToPath } from "node:url";

const dir = path.dirname(fileURLToPath(import.meta.url));
const suites = [
  ["turmas-e-alunos", "Turmas, código de entrada, trilha e perfil"],
  ["editor-de-codigo", "Editor de exercícios de código e módulos"],
  ["analise-da-turma", "Painel de análise da turma"],
  ["tipos-e-sequencia", "Múltipla escolha, lacunas, sequência diária e editor dos novos tipos"],
  ["acessibilidade", "Acessibilidade (axe) e layout em celular/computador, claro/escuro"],
];

let failed = 0;
for (const [file, label] of suites) {
  console.log(`\n=== ${label} (${file})`);
  const r = spawnSync("node", [path.join(dir, `${file}.mjs`)], { encoding: "utf8", env: process.env });
  const lines = (r.stdout ?? "").split("\n").filter((l) => /^(✓|✗|TODOS|\d+ FALHA|Nenhuma|\[|ROLAGEM|FATAL)/.test(l) || l.startsWith("  em ") || l.startsWith("  ex:"));
  console.log(lines.join("\n") || (r.stdout ?? "").slice(-500));
  if (r.status !== 0) {
    failed++;
    if (r.stderr) console.log((r.stderr ?? "").split("\n").filter((l) => !l.includes("agent-proxy") && !l.includes("connect_rejected")).slice(0, 8).join("\n"));
  }
}
console.log(failed ? `\n${failed} suíte(s) com problema` : "\nTODAS AS SUÍTES PASSARAM");
process.exit(failed ? 1 : 0);
