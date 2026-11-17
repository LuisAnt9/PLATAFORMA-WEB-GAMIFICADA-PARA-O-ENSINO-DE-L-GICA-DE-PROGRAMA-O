import { describe, expect, it } from "vitest";
import {
  completionRate,
  formatDuration,
  isPending,
  isoToLocalInput,
  localInputToIso,
  type AssignmentSummary,
} from "./assignments";

describe("assignments (puro)", () => {
  it("pendentes: ainda há algo a fazer", () => {
    expect(isPending("nao_iniciada")).toBe(true);
    expect(isPending("em_andamento")).toBe(true);
    expect(isPending("atrasada")).toBe(true);
    expect(isPending("concluida")).toBe(false);
    expect(isPending("concluida_atrasada")).toBe(false);
    expect(isPending("entregue")).toBe(false);
    expect(isPending("nao_entregue")).toBe(false);
  });
  it("converte data local de e para ISO sem mudar o instante", () => {
    const iso = localInputToIso("2026-03-10T23:59");
    expect(isoToLocalInput(iso)).toBe("2026-03-10T23:59");
  });
  it("formata o tempo gasto", () => {
    expect(formatDuration(0)).toBe("—");
    expect(formatDuration(20_000)).toBe("menos de 1 min");
    expect(formatDuration(5 * 60_000)).toBe("5 min");
  });
  it("taxa de conclusão", () => {
    const s = { students: 4, completed: 3 } as AssignmentSummary;
    expect(completionRate(s)).toBe(0.75);
    expect(completionRate({ students: 0, completed: 0 } as AssignmentSummary)).toBe(0);
  });
});
