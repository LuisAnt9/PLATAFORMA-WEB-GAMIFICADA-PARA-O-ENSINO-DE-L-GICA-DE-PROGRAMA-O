// Gera o SQL que publica (ou despublica) o conteúdo de um mundo, depois da revisão do professor.
// Uso: npm run content:publish -- mundo-1 [id-da-licao ...] [--despublicar]
// Saída: supabase/publicar-<mundo>.sql (ou supabase/despublicar-<mundo>.sql)
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  buildPublishSql,
  loadContent,
  validateContent,
} from "./content-lib.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
const args = process.argv.slice(2);
const publish = !args.includes("--despublicar");
const [worldId, ...rest] = args.filter((a) => !a.startsWith("--"));
if (!worldId) {
  console.log(
    "Uso: npm run content:publish -- mundo-1 [id-da-licao ...] [--despublicar]",
  );
  process.exit(1);
}
const content = loadContent(path.resolve(here, "../content"));
const { errors } = validateContent(content);
if (errors.length > 0) {
  errors.forEach((e) => console.log(`ERRO: ${e}`));
  console.log('\nCorrija o conteúdo antes ("npm run content:check").');
  process.exit(1);
}
try {
  const sql = buildPublishSql(content, worldId, { lessonIds: rest, publish });
  const out = path.resolve(
    here,
    `../supabase/${publish ? "publicar" : "despublicar"}-${worldId}${rest.length ? "-parcial" : ""}.sql`,
  );
  fs.writeFileSync(out, sql);
  console.log(`ok: ${path.relative(path.resolve(here, ".."), out)}`);
} catch (e) {
  console.log(`ERRO: ${e.message}`);
  process.exit(1);
}
