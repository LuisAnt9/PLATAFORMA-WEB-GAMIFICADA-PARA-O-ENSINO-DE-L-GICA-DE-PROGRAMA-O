// Valida e gera o SQL de importação do conteúdo. Uso: npm run content:build
// Saída: supabase/importar-conteudo.sql (cole no SQL Editor do Supabase; pode rodar várias vezes).
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import {
  buildImportSql,
  loadContent,
  validateContent,
} from "./content-lib.mjs";

const here = path.dirname(fileURLToPath(import.meta.url));
export const OUT = path.resolve(here, "../supabase/importar-conteudo.sql");

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  const content = loadContent(path.resolve(here, "../content"));
  const { errors } = validateContent(content);
  if (errors.length > 0) {
    for (const e of errors) console.log(`ERRO: ${e}`);
    console.log(
      `\n${errors.length} erro(s): o SQL não foi gerado. Rode "npm run content:check".`,
    );
    process.exit(1);
  }
  fs.writeFileSync(OUT, buildImportSql(content));
  console.log(`ok: ${path.relative(path.resolve(here, ".."), OUT)}`);
}
