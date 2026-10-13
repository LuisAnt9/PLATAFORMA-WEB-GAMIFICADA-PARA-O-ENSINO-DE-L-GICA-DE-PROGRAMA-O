// Junta todas as migrations (em ordem) num único arquivo para colar de uma vez no SQL Editor do Supabase.
// Uso: npm run db:bundle
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const dir = path.join(root, "supabase/migrations");
export const OUT = path.join(root, "supabase/setup-completo.sql");

export function buildBundle() {
  const files = fs.readdirSync(dir).filter((f) => f.endsWith(".sql")).sort();
  const parts = files.map((f) => `-- ============================================================\n-- ${f}\n-- ============================================================\n\n${fs.readFileSync(path.join(dir, f), "utf8").trimEnd()}\n`);
  return (
    `-- GERADO por "npm run db:bundle" a partir de supabase/migrations. Não edite à mão.\n` +
    `-- Cria o banco inteiro do zero num projeto Supabase NOVO (cole tudo no SQL Editor e clique em Run).\n` +
    `-- Não rode num projeto que já tenha as tabelas: use apenas as migrations que faltam.\n\n` +
    parts.join("\n")
  );
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  fs.writeFileSync(OUT, buildBundle());
  console.log(`ok: ${path.relative(root, OUT)}`);
}
