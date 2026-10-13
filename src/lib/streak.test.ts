import { describe, expect, it } from "vitest";
import { addDays, computeStreak, localDay, recentDays } from "./streak";

describe("localDay / addDays", () => {
  it("formata no fuso local com zeros à esquerda", () => {
    expect(localDay(new Date(2026, 0, 5, 23, 59))).toBe("2026-01-05");
    expect(localDay(new Date(2026, 11, 31, 0, 0))).toBe("2026-12-31");
  });
  it("soma dias atravessando mês, ano e bissexto", () => {
    expect(addDays("2026-10-31", 1)).toBe("2026-11-01");
    expect(addDays("2026-12-31", 1)).toBe("2027-01-01");
    expect(addDays("2028-02-28", 1)).toBe("2028-02-29");
    expect(addDays("2026-03-01", -1)).toBe("2026-02-28");
  });
});

describe("computeStreak", () => {
  it("sem atividade: tudo zero", () => {
    expect(computeStreak([], "2026-10-14")).toEqual({
      current: 0,
      best: 0,
      activeToday: false,
    });
  });
  it("conta dias seguidos terminando hoje", () => {
    expect(
      computeStreak(["2026-10-12", "2026-10-13", "2026-10-14"], "2026-10-14"),
    ).toEqual({ current: 3, best: 3, activeToday: true });
  });
  it("a sequência continua viva se a última prática foi ontem (ainda dá tempo hoje)", () => {
    expect(computeStreak(["2026-10-12", "2026-10-13"], "2026-10-14")).toEqual({
      current: 2,
      best: 2,
      activeToday: false,
    });
  });
  it("quebra quando passa um dia inteiro sem praticar, mas guarda a melhor sequência", () => {
    const s = computeStreak(
      ["2026-10-01", "2026-10-02", "2026-10-03", "2026-10-04", "2026-10-12"],
      "2026-10-14",
    );
    expect(s).toEqual({ current: 0, best: 4, activeToday: false });
  });
  it("uma sequência nova depois de uma quebra recomeça em 1", () => {
    const s = computeStreak(
      ["2026-10-01", "2026-10-02", "2026-10-14"],
      "2026-10-14",
    );
    expect(s).toEqual({ current: 1, best: 2, activeToday: true });
  });
  it("ignora repetidos, ordem embaralhada e dias no futuro", () => {
    const s = computeStreak(
      ["2026-10-14", "2026-10-13", "2026-10-13", "2026-10-20"],
      "2026-10-14",
    );
    expect(s).toEqual({ current: 2, best: 2, activeToday: true });
  });
  it("atravessa virada de mês e de ano", () => {
    const s = computeStreak(
      ["2026-12-30", "2026-12-31", "2027-01-01"],
      "2027-01-01",
    );
    expect(s.current).toBe(3);
  });
  it("a melhor sequência pode estar no meio do histórico", () => {
    const days = [
      "2026-09-01",
      "2026-09-02",
      "2026-09-03",
      "2026-09-04",
      "2026-09-05",
      "2026-10-13",
      "2026-10-14",
    ];
    expect(computeStreak(days, "2026-10-14")).toEqual({
      current: 2,
      best: 5,
      activeToday: true,
    });
  });
});

describe("recentDays", () => {
  it("devolve n dias terminando hoje, marcando os ativos", () => {
    const r = recentDays(["2026-10-14", "2026-10-12"], "2026-10-14", 4);
    expect(r).toEqual([
      { day: "2026-10-11", active: false },
      { day: "2026-10-12", active: true },
      { day: "2026-10-13", active: false },
      { day: "2026-10-14", active: true },
    ]);
  });
});
