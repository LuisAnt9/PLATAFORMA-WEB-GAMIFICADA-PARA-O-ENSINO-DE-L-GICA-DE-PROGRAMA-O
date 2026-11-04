// Valida o conteúdo de content/. Uso: npm run content:check
import path from "node:path";
import { fileURLToPath } from "node:url";
import { loadContent, validateContent } from "./content-lib.mjs";

const root = path.resolve(
  path.dirname(fileURLToPath(import.meta.url)),
  "../content",
);
const { errors, warnings, stats } = validateContent(loadContent(root));

for (const w of warnings) console.log(`aviso: ${w}`);
for (const e of errors) console.log(`ERRO: ${e}`);
const kinds = Object.entries(stats.byKind)
  .map(([k, n]) => `${n} ${k}`)
  .join(", ");
console.log(
  `\n${stats.worlds} mundos, ${stats.concepts} conceitos, ${stats.lessons} lições, ${stats.exercises} exercícios (${kinds}).`,
);
if (errors.length > 0) {
  console.log(`${errors.length} erro(s). Corrija antes de gerar o SQL.`);
  process.exit(1);
}
console.log("Conteúdo válido.");
