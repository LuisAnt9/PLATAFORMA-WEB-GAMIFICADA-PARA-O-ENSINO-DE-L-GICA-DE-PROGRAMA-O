import { PGlite } from "@electric-sql/pglite";
import fs from "node:fs";
import { describe, expect, it } from "vitest";
import { OUT, buildBundle } from "../../scripts/bundle-migrations.mjs";

describe("setup-completo.sql", () => {
  it("está em dia com as migrations (rode `npm run db:bundle` se falhar)", () => {
    expect(fs.readFileSync(OUT, "utf8")).toBe(buildBundle());
  });

  it("roda de uma vez num banco limpo, como no SQL Editor, e cria o catálogo completo", async () => {
    const db = new PGlite();
    await db.exec(`
      create role anon nologin; create role authenticated nologin;
      grant usage on schema public to anon, authenticated;
      create schema auth;
      create table auth.users (id uuid primary key default gen_random_uuid(), email text, raw_user_meta_data jsonb default '{}');
      create function auth.uid() returns uuid language sql stable as $$ select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid $$;
      grant usage on schema auth to authenticated, anon; grant execute on function auth.uid() to authenticated, anon;
    `);
    await db.exec(fs.readFileSync(OUT, "utf8"));
    const r = await db.query<{ m: number; e: number; t: number }>(
      "select (select count(*) from public.modules)::int as m, (select count(*) from public.exercises)::int as e, (select count(*) from pg_tables where schemaname = 'public')::int as t",
    );
    expect(r.rows[0]).toEqual({ m: 7, e: 53, t: 7 }); // 7 módulos, 53 exercícios, 7 tabelas
  }, 60_000);

  it("falha por inteiro (nada fica pela metade) se um trecho der erro", async () => {
    const db = new PGlite();
    await expect(
      db.exec("create table a (id int); select 1/0;"),
    ).rejects.toThrow();
    const r = await db.query<{ n: number }>(
      "select count(*)::int as n from pg_tables where tablename = 'a'",
    );
    expect(r.rows[0].n).toBe(0);
  });
});
