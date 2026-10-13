import { describe, expect, it } from "vitest";
import type { Exercise } from "./catalog";
import {
  classOverview,
  exerciseStats,
  hardestExercises,
  niceMax,
  progressMatrix,
  solvedPerDay,
  studentAlerts,
} from "./class-analytics";
import {
  memberSummaries,
  type ClassData,
  type ProgressRow,
} from "./class-stats";

const NOW = new Date("2026-10-14T15:00:00Z").getTime();
const daysAgo = (n: number, hour = 12) => {
  const d = new Date(NOW - n * 86_400_000);
  d.setUTCHours(hour, 0, 0, 0);
  return d.toISOString();
};

const ex = (id: string, position: number): Exercise => ({
  id,
  moduleId: "m",
  title: `Ex ${id}`,
  difficulty: "facil",
  statement: "",
  functionName: id,
  starterCode: "",
  tests: [],
  hint: "",
  position,
  published: true,
});
const exercises = [ex("a", 1), ex("b", 2), ex("c", 3)];

const row = (
  user: string,
  exercise: string,
  o: Partial<ProgressRow> = {},
): ProgressRow => ({
  user_id: user,
  exercise_id: exercise,
  attempts: 1,
  solved: false,
  first_try: false,
  xp: 0,
  solved_at: null,
  updated_at: daysAgo(1),
  ...o,
});

const data: ClassData = {
  members: [
    { id: "ana", name: "Ana", joinedAt: daysAgo(20) },
    { id: "beto", name: "Beto", joinedAt: daysAgo(20) },
    { id: "caio", name: "Caio", joinedAt: daysAgo(1) }, // recém-chegado, nunca tentou
    { id: "duda", name: "Duda", joinedAt: daysAgo(10) }, // nunca tentou, entrou há 10 dias
  ],
  progress: [
    row("ana", "a", {
      solved: true,
      first_try: true,
      xp: 15,
      solved_at: daysAgo(0),
      updated_at: daysAgo(0),
    }),
    row("ana", "b", {
      solved: true,
      attempts: 3,
      xp: 10,
      solved_at: daysAgo(2),
      updated_at: daysAgo(2),
    }),
    row("beto", "a", {
      solved: true,
      attempts: 2,
      xp: 10,
      solved_at: daysAgo(9),
      updated_at: daysAgo(9),
    }),
    row("beto", "b", { attempts: 5, updated_at: daysAgo(9) }), // travado e parado há 9 dias
    row("beto", "c", { attempts: 4, updated_at: daysAgo(9) }), // travado
    row("estranho", "a", { solved: true, xp: 15, solved_at: daysAgo(0) }), // fora da turma: deve ser ignorado
  ],
};
const summaries = memberSummaries(data);

describe("exerciseStats", () => {
  const stats = Object.fromEntries(
    exerciseStats(data, exercises).map((s) => [s.exercise.id, s]),
  );
  it("conta tentaram/acertaram e ignora quem não é da turma", () => {
    expect(stats.a).toMatchObject({ attempted: 2, solved: 2, solveRate: 1 });
    expect(stats.b).toMatchObject({
      attempted: 2,
      solved: 1,
      solveRate: 0.5,
      stuck: 1,
    });
  });
  it("média de tentativas e acerto de primeira só entre quem acertou", () => {
    expect(stats.a.avgAttempts).toBe(1.5);
    expect(stats.a.firstTryRate).toBe(0.5);
    expect(stats.b.avgAttempts).toBe(3);
  });
  it("exercício sem tentativas fica com taxas nulas", () => {
    const none = exerciseStats(
      { members: data.members, progress: [] },
      exercises,
    )[0];
    expect(none).toMatchObject({
      attempted: 0,
      solveRate: null,
      avgAttempts: null,
      firstTryRate: null,
      stuck: 0,
    });
  });
});

describe("hardestExercises", () => {
  it("ordena do mais difícil (menor taxa de acerto) e ignora os não tentados", () => {
    const list = hardestExercises(
      exerciseStats(data, [...exercises, ex("d", 4)]),
    );
    expect(list.map((s) => s.exercise.id)).toEqual(["c", "b", "a"]); // c: 0%, b: 50%, a: 100%; d sem tentativas fora
  });
  it("respeita o limite", () => {
    expect(hardestExercises(exerciseStats(data, exercises), 1)).toHaveLength(1);
  });
});

describe("studentAlerts", () => {
  const alerts = studentAlerts(summaries, data, undefined, NOW);
  const by = Object.fromEntries(alerts.map((a) => [a.name, a.reasons]));
  it("alerta aluno inativo e travado, com os dois motivos primeiro", () => {
    expect(by.Beto).toHaveLength(2);
    expect(by.Beto[0]).toContain("Sem atividade há 9 dias");
    expect(by.Beto[1]).toContain("Travado em 2 exercícios");
    expect(alerts[0].name).toBe("Beto");
  });
  it("aluno que nunca tentou só vira alerta depois de alguns dias na turma", () => {
    expect(by.Duda?.[0]).toContain(
      "Ainda não tentou nenhum exercício (entrou há 10 dias)",
    );
    expect(by.Caio).toBeUndefined();
  });
  it("aluno ativo e sem travas não gera alerta", () => {
    expect(by.Ana).toBeUndefined();
  });
  it("trava só conta exercícios válidos quando a lista é informada", () => {
    const a = studentAlerts(summaries, data, new Set(["a"]), NOW).find(
      (x) => x.name === "Beto",
    )!;
    expect(a.reasons.some((r) => r.startsWith("Travado"))).toBe(false);
  });
});

describe("solvedPerDay", () => {
  it("devolve exatamente `days` dias terminando hoje e conta resolvidos por dia", () => {
    const r = solvedPerDay(data, 7, NOW);
    expect(r).toHaveLength(7);
    expect(r[6]).toEqual({ date: "2026-10-14", count: 1 }); // ana/a hoje (o "estranho" não conta)
    expect(r.find((d) => d.date === "2026-10-12")?.count).toBe(1); // ana/b (o beto/a é de 9 dias atrás)
    expect(r.reduce((n, d) => n + d.count, 0)).toBe(2);
  });
  it("respeita o fuso: 02:00 UTC de 14/10 ainda é 13/10 no Brasil (UTC-3)", () => {
    const d: ClassData = {
      members: [{ id: "u", name: "U", joinedAt: daysAgo(5) }],
      progress: [
        row("u", "a", { solved: true, solved_at: "2026-10-14T02:00:00Z" }),
      ],
    };
    const utc = solvedPerDay(d, 3, NOW, 0);
    const br = solvedPerDay(d, 3, NOW, -180);
    expect(utc.find((x) => x.date === "2026-10-14")?.count).toBe(1);
    expect(br.find((x) => x.date === "2026-10-13")?.count).toBe(1);
    expect(br.find((x) => x.date === "2026-10-14")?.count).toBe(0);
  });
  it("ignora resoluções antigas fora da janela", () => {
    expect(solvedPerDay(data, 1, NOW)[0].count).toBe(1);
  });
});

describe("progressMatrix", () => {
  const m = progressMatrix(data, exercises);
  it("uma linha por aluno e uma célula por exercício", () => {
    expect(m).toHaveLength(4);
    expect(m.every((r) => r.cells.length === 3)).toBe(true);
  });
  it("classifica resolvido, tentando e nada", () => {
    expect(m.find((r) => r.name === "Ana")!.cells.map((c) => c.state)).toEqual([
      "solved",
      "solved",
      "none",
    ]);
    const beto = m.find((r) => r.name === "Beto")!;
    expect(beto.cells.map((c) => c.state)).toEqual([
      "solved",
      "trying",
      "trying",
    ]);
    expect(beto.cells[1].attempts).toBe(5);
    expect(
      m.find((r) => r.name === "Duda")!.cells.every((c) => c.state === "none"),
    ).toBe(true);
  });
});

describe("classOverview", () => {
  it("turma vazia não divide por zero", () => {
    expect(classOverview([], 3, NOW)).toEqual({
      students: 0,
      avgXp: 0,
      avgCompletion: 0,
      activeRecently: 0,
    });
  });
  it("médias e alunos ativos nos últimos 7 dias", () => {
    const o = classOverview(summaries, 3, NOW);
    expect(o.students).toBe(4);
    expect(o.avgXp).toBe(9); // (25 + 10 + 0 + 0) / 4 = 8,75 -> 9
    expect(o.avgCompletion).toBeCloseTo((2 / 3 + 1 / 3) / 4);
    expect(o.activeRecently).toBe(1); // só a Ana; o Beto parou há 9 dias
  });
  it("sem exercícios publicados, a conclusão é 0", () => {
    expect(classOverview(summaries, 0, NOW).avgCompletion).toBe(0);
  });
});

describe("niceMax", () => {
  it("usa limites redondos e nunca fica abaixo do máximo", () => {
    expect(niceMax(0)).toBe(4);
    expect(niceMax(4)).toBe(4);
    expect(niceMax(5)).toBe(6);
    expect(niceMax(9)).toBe(10);
    expect(niceMax(11)).toBe(20);
    expect(niceMax(2500)).toBe(3000);
    for (const m of [0, 1, 7, 33, 99, 150, 999])
      expect(niceMax(m)).toBeGreaterThanOrEqual(m);
  });
  it("o limite é par, para que a marca do meio seja inteira", () => {
    for (const m of [0, 3, 5, 9, 15, 70]) expect(niceMax(m) % 2).toBe(0);
  });
});
