// Gera o documento de revisão pedagógica de um mundo (para o professor ler e aprovar).
// Uso: npm run content:review -- mundo-1 [id-da-licao ...]
// Saída: docs/revisao/<mundo>.md
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { buildReviewMarkdown, loadContent } from "./content-lib.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const [worldId, ...lessonIds] = process.argv.slice(2);
if (!worldId) {
  console.log("Uso: npm run content:review -- mundo-1 [id-da-licao ...]");
  process.exit(1);
}
try {
  const md = buildReviewMarkdown(
    loadContent(path.resolve(here, "../content")),
    worldId,
    { lessonIds },
  );
  const out = path.resolve(here, `../docs/revisao/${worldId}.md`);
  fs.mkdirSync(path.dirname(out), { recursive: true });
  fs.writeFileSync(out, md);
  console.log(`ok: ${path.relative(path.resolve(here, ".."), out)}`);
} catch (e) {
  console.log(`ERRO: ${e.message}`);
  process.exit(1);
}
