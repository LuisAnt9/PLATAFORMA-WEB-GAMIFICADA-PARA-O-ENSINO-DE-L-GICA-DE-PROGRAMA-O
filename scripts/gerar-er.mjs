// Gera o diagrama entidade-relacionamento (Mermaid) a partir das migrations, aplicando-as em um
// Postgres embutido. Uso: npm run docs:er  →  docs/tcc/diagrama-er.md
import fs from "node:fs";
import path from "node:path";
import { PGlite } from "@electric-sql/pglite";

const root = path.resolve(import.meta.dirname, "..");
const db = new PGlite();
await db.exec(`
  create role anon nologin; create role authenticated nologin;
  grant usage on schema public to anon, authenticated;
  create schema auth;
  create table auth.users (id uuid primary key default gen_random_uuid(), email text, raw_user_meta_data jsonb default '{}');
  create function auth.uid() returns uuid language sql stable as $$ select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid $$;
  grant usage on schema auth to authenticated, anon; grant execute on function auth.uid() to authenticated, anon;
`);
const dir = path.join(root, "supabase/migrations");
for (const f of fs.readdirSync(dir).sort()) await db.exec(fs.readFileSync(path.join(dir, f), "utf8"));

const cols = (await db.query(`
  select c.table_name, c.column_name, c.data_type, c.is_nullable,
         exists (select 1 from information_schema.table_constraints tc
                 join information_schema.key_column_usage k on k.constraint_name = tc.constraint_name and k.table_schema = tc.table_schema
                 where tc.table_schema = 'public' and tc.table_name = c.table_name and tc.constraint_type = 'PRIMARY KEY' and k.column_name = c.column_name) as pk
  from information_schema.columns c
  join information_schema.tables t on t.table_schema = c.table_schema and t.table_name = c.table_name and t.table_type = 'BASE TABLE'
  where c.table_schema = 'public' order by c.table_name, c.ordinal_position`)).rows;
const fks = (await db.query(`
  select cl.relname as child, pa.relname as parent, a.attname as col,
         (select not a2.attnotnull from pg_attribute a2 where a2.attrelid = con.conrelid and a2.attnum = con.conkey[1]) as optional
  from pg_constraint con
  join pg_class cl on cl.oid = con.conrelid join pg_class pa on pa.oid = con.confrelid
  join pg_namespace n on n.oid = cl.relnamespace
  join pg_attribute a on a.attrelid = con.conrelid and a.attnum = con.conkey[1]
  where con.contype = 'f' and n.nspname = 'public' and pa.relnamespace = n.oid
  order by 1, 2, 3`)).rows;
const fkCols = new Set(fks.map((f) => `${f.child}.${f.col}`));

const type = (t) => ({ "character varying": "text", "timestamp with time zone": "timestamptz", "timestamp without time zone": "timestamp", "double precision": "float" }[t] ?? t).replace(/\s+/g, "_");
const byTable = new Map();
for (const c of cols) byTable.set(c.table_name, [...(byTable.get(c.table_name) ?? []), c]);

let out = `# Diagrama entidade-relacionamento\n\n> Gerado automaticamente das migrations por \`npm run docs:er\` (não edite à mão). Colunas marcadas PK (chave primária) e FK (chave estrangeira). Só as tabelas do esquema \`public\`; as contas de login ficam em \`auth.users\` (Supabase Auth) e se ligam a \`profiles\`.\n\n\`\`\`mermaid\nerDiagram\n`;
for (const [t, list] of byTable) {
  out += `  ${t} {\n`;
  for (const c of list) {
    const key = c.pk ? " PK" : fkCols.has(`${t}.${c.column_name}`) ? " FK" : "";
    out += `    ${type(c.data_type)} ${c.column_name}${key}\n`;
  }
  out += `  }\n`;
}
for (const f of fks) out += `  ${f.parent} ${f.optional ? "|o--o{" : "||--o{"} ${f.child} : "${f.col}"\n`;
out += "```\n\n## Tabelas\n\n";
out += `Total: ${byTable.size} tabelas e ${fks.length} relacionamentos.\n`;
fs.mkdirSync(path.join(root, "docs/tcc"), { recursive: true });
fs.writeFileSync(path.join(root, "docs/tcc/diagrama-er.md"), out);
console.log(`ok: docs/tcc/diagrama-er.md (${byTable.size} tabelas, ${fks.length} relacionamentos)`);
