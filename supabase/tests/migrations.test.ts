import { PGlite } from "@electric-sql/pglite";
import fs from "node:fs";
import path from "node:path";
import { beforeAll, describe, expect, it } from "vitest";

// Aplica todas as migrations num Postgres embutido que imita o essencial do Supabase
// (schema auth, auth.uid(), papéis anon/authenticated) e testa as regras de segurança.

const dir = path.resolve(import.meta.dirname, "../migrations");
let db: PGlite;
let ana: string, bia: string, caio: string, prof: string;

async function as(uid: string | null, sql: string) {
  await db.exec(
    `set role ${uid ? "authenticated" : "anon"}; select set_config('request.jwt.claim.sub','${uid ?? ""}',false);`,
  );
  try {
    return {
      ok: true as const,
      rows: (await db.query<Record<string, unknown>>(sql)).rows,
    };
  } catch (e) {
    return {
      ok: false as const,
      error: (e as Error).message,
      rows: [] as Record<string, unknown>[],
    };
  } finally {
    await db.exec("reset role;");
  }
}

async function newUser(email: string, name?: string) {
  const meta = name ? JSON.stringify({ name }) : "{}";
  const r = await db.query<{ id: string }>(
    `insert into auth.users(email, raw_user_meta_data) values ($1, $2) returning id`,
    [email, meta],
  );
  return r.rows[0].id;
}

beforeAll(async () => {
  db = new PGlite();
  await db.exec(`
    create role anon nologin; create role authenticated nologin;
    grant usage on schema public to anon, authenticated;
    create schema auth;
    create table auth.users (id uuid primary key default gen_random_uuid(), email text, raw_user_meta_data jsonb default '{}');
    create function auth.uid() returns uuid language sql stable as $$ select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid $$;
    grant usage on schema auth to authenticated, anon; grant execute on function auth.uid() to authenticated, anon;
  `);
  for (const f of fs.readdirSync(dir).sort())
    await db.exec(fs.readFileSync(path.join(dir, f), "utf8"));

  ana = await newUser("ana@x.com", "Ana Souza Lima");
  bia = await newUser("bia@x.com");
  caio = await newUser("caio@x.com", "Caio");
  prof = await newUser("prof@x.com", "Prof Lima");
  await db.exec(
    `update public.profiles set role='professor' where id='${prof}'`,
  );
});

describe("0001: perfis e progresso", () => {
  it("trigger cria perfil com nome do cadastro e fallback do e-mail", async () => {
    const names = (
      await db.query<{ name: string }>("select name from public.profiles")
    ).rows.map((r) => r.name);
    expect(names).toContain("Ana Souza Lima");
    expect(names).toContain("bia");
  });
  it("aluno vê só o próprio perfil; professor vê todos", async () => {
    expect((await as(ana, "select * from public.profiles")).rows).toHaveLength(
      1,
    );
    expect((await as(prof, "select * from public.profiles")).rows).toHaveLength(
      4,
    );
  });
  it("aluno não consegue virar professor, mas edita o próprio nome", async () => {
    expect(
      (
        await as(
          ana,
          `update public.profiles set role='professor' where id='${ana}'`,
        )
      ).ok,
    ).toBe(false);
    expect(
      (
        await as(
          ana,
          `update public.profiles set name='Ana Souza Lima' where id='${ana}'`,
        )
      ).ok,
    ).toBe(true);
    expect(
      (
        await as(
          ana,
          `update public.profiles set name='x' where id='${bia}' returning id`,
        )
      ).rows,
    ).toHaveLength(0);
  });
  it("progresso: só em nome próprio, XP limitado, resolvido fica travado", async () => {
    expect(
      (
        await as(
          ana,
          `insert into public.exercise_progress(user_id,exercise_id,attempts,solved,first_try,xp) values ('${ana}','soma',1,true,true,15)`,
        )
      ).ok,
    ).toBe(true);
    expect(
      (
        await as(
          ana,
          `insert into public.exercise_progress(user_id,exercise_id) values ('${bia}','soma')`,
        )
      ).ok,
    ).toBe(false);
    expect(
      (
        await as(
          ana,
          `insert into public.exercise_progress(user_id,exercise_id,xp) values ('${ana}','media',9999)`,
        )
      ).ok,
    ).toBe(false);
    await as(
      ana,
      `update public.exercise_progress set solved=false, xp=0 where user_id='${ana}' and exercise_id='soma'`,
    );
    const r = (
      await db.query<{ solved: boolean; xp: number }>(
        `select solved, xp from public.exercise_progress where user_id='${ana}'`,
      )
    ).rows[0];
    expect(r).toEqual({ solved: true, xp: 15 });
  });
  it("aluno não vê progresso alheio; professor vê; anônimo não lê", async () => {
    expect(
      (await as(bia, "select * from public.exercise_progress")).rows,
    ).toHaveLength(0);
    expect(
      (await as(prof, "select * from public.exercise_progress")).rows,
    ).toHaveLength(1);
    expect((await as(null, "select * from public.profiles")).ok).toBe(false);
  });
});

describe("0002: ranking", () => {
  beforeAll(async () => {
    await as(
      caio,
      `insert into public.exercise_progress(user_id,exercise_id,attempts,solved,first_try,xp) values ('${caio}','soma',2,true,false,10),('${caio}','media',1,true,true,15),('${caio}','fatorial',1,false,false,0)`,
    );
  });

  it("ordena por XP e abrevia o sobrenome", async () => {
    const rows = (await as(bia, "select * from public.leaderboard(20)")).rows;
    const nomes = rows.map((r) => r.display_name);
    expect(nomes[0]).toBe("Caio"); // 25 XP
    expect(nomes[1]).toBe("Ana L."); // 15 XP
    expect(Number(rows[0].total_xp)).toBe(25);
    expect(Number(rows[0].solved)).toBe(2);
  });
  it("nunca expõe e-mail nem identificadores", async () => {
    const rows = (await as(bia, "select * from public.leaderboard(20)")).rows;
    expect(Object.keys(rows[0]).sort()).toEqual([
      "display_name",
      "is_me",
      "pos",
      "solved",
      "total_xp",
    ]);
  });
  it("aluno sem acertos aparece só para si mesmo, com is_me", async () => {
    const mine = (
      await as(bia, "select * from public.leaderboard(20)")
    ).rows.filter((r) => r.is_me);
    expect(mine).toHaveLength(1);
    expect(mine[0].display_name).toBe("bia");
    const outros = (
      await as(caio, "select * from public.leaderboard(20)")
    ).rows.map((r) => r.display_name);
    expect(outros).not.toContain("bia");
  });
  it("professor fica fora do ranking", async () => {
    const nomes = (
      await as(ana, "select * from public.leaderboard(20)")
    ).rows.map((r) => r.display_name);
    expect(nomes).not.toContain("Prof L.");
  });
  it("mostra a própria posição mesmo fora do top N", async () => {
    const rows = (await as(ana, "select * from public.leaderboard(1)")).rows;
    expect(rows.map((r) => r.display_name)).toEqual(["Caio", "Ana L."]);
    expect(Number(rows.find((r) => r.is_me)?.pos)).toBe(2);
  });
  it("anônimo não executa a função", async () => {
    expect((await as(null, "select * from public.leaderboard(20)")).ok).toBe(
      false,
    );
  });
});
