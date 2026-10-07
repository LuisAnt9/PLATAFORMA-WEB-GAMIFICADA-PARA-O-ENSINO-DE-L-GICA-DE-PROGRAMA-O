import { describe, expect, it } from "vitest";
import { daysSince, memberSummaries, type ClassData } from "./class-stats";

const data: ClassData = {
  members: [
    { id: "u1", name: "Ana", joinedAt: "2026-10-01T00:00:00Z" },
    { id: "u2", name: "Beto", joinedAt: "2026-10-01T00:00:00Z" },
  ],
  progress: [
    {
      user_id: "u1",
      exercise_id: "a",
      attempts: 1,
      solved: true,
      first_try: true,
      xp: 15,
      updated_at: "2026-10-03T10:00:00Z",
    },
    {
      user_id: "u1",
      exercise_id: "b",
      attempts: 3,
      solved: false,
      first_try: false,
      xp: 0,
      updated_at: "2026-10-05T10:00:00Z",
    },
    {
      user_id: "u1",
      exercise_id: "velho",
      attempts: 1,
      solved: true,
      first_try: true,
      xp: 15,
      updated_at: "2026-10-02T10:00:00Z",
    },
  ],
};

describe("memberSummaries", () => {
  it("soma XP, resolvidos e tentativas e acha a última atividade", () => {
    const [ana, beto] = memberSummaries(data);
    expect(ana).toMatchObject({
      xp: 30,
      solved: 2,
      attempts: 5,
      lastActivity: "2026-10-05T10:00:00Z",
    });
    expect(beto).toMatchObject({
      xp: 0,
      solved: 0,
      attempts: 0,
      lastActivity: null,
    });
  });
  it("limita a contagem aos exercícios válidos (publicados)", () => {
    const [ana] = memberSummaries(data, new Set(["a", "b"]));
    expect(ana).toMatchObject({ xp: 15, solved: 1, attempts: 5 });
  });
});

describe("daysSince", () => {
  const now = new Date("2026-10-10T12:00:00Z").getTime();
  it("conta dias inteiros e trata ausência de atividade", () => {
    expect(daysSince("2026-10-10T08:00:00Z", now)).toBe(0);
    expect(daysSince("2026-10-07T12:00:00Z", now)).toBe(3);
    expect(daysSince(null, now)).toBeNull();
  });
});
