import { PGlite } from "@electric-sql/pglite";
import fs from "node:fs";
import path from "node:path";

const migrationsDir = path.resolve(import.meta.dirname, "../migrations");

/** Postgres embutido com o essencial do Supabase (schema auth, auth.uid(), papéis) e todas as migrations aplicadas. */
export async function createDb(): Promise<PGlite> {
  const db = new PGlite();
  await db.exec(`
    create role anon nologin; create role authenticated nologin;
    grant usage on schema public to anon, authenticated;
    create schema auth;
    create table auth.users (id uuid primary key default gen_random_uuid(), email text, raw_user_meta_data jsonb default '{}');
    create function auth.uid() returns uuid language sql stable as $$ select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid $$;
    grant usage on schema auth to authenticated, anon; grant execute on function auth.uid() to authenticated, anon;
  `);
  for (const f of fs.readdirSync(migrationsDir).sort()) {
    await db.exec(fs.readFileSync(path.join(migrationsDir, f), "utf8"));
  }
  return db;
}
