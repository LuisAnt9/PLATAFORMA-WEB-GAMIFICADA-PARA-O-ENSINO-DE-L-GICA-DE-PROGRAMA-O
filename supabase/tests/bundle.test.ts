import { PGlite } from "@electric-sql/pglite";
import fs from "node:fs";
import { describe, expect, it } from "vitest";
import { OUT, OUT_UPDATE, buildBundle, buildUpdate } from "../../scripts/bundle-migrations.mjs";

describe("setup-completo.sql", () => {
  it("está em dia com as migrations (rode `npm run db:bundle` se falhar)", () => {
    expect(fs.readFileSync(OUT, "utf8")).toBe(buildBundle());
  });

  it("atualizar-0009-em-diante.sql está em dia e leva um banco 0008 ao mesmo resultado do banco completo", async () => {
    expect(fs.readFileSync(OUT_UPDATE, "utf8")).toBe(buildUpdate());
    const dir = new URL("../migrations/", import.meta.url).pathname;
    const db = new PGlite();
    await db.exec(`
      create role anon nologin; create role authenticated nologin;
      grant usage on schema public to anon, authenticated;
      create schema auth;
      create table auth.users (id uuid primary key default gen_random_uuid(), email text, raw_user_meta_data jsonb default '{}');
      create function auth.uid() returns uuid language sql stable as $$ select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid $$;
      grant usage on schema auth to authenticated, anon; grant execute on function auth.uid() to authenticated, anon;
    `);
    for (const f of fs.readdirSync(dir).sort().filter((x) => x < "0009")) await db.exec(fs.readFileSync(dir + f, "utf8"));
    await db.exec(fs.readFileSync(OUT_UPDATE, "utf8"));
    const r = await db.query<{ t: number }>("select count(*)::int as t from pg_tables where schemaname = 'public'");
    expect(r.rows[0].t).toBe(24);
  }, 60_000);

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
    expect(r.rows[0]).toEqual({ m: 7, e: 53, t: 24 }); // 7 módulos, 53 exercícios, 24 tabelas (+4 da E9, +5 da E10, +2 da E15)
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
