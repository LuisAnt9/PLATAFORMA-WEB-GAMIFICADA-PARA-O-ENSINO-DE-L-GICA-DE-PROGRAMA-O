import { describe, expect, it } from "vitest";
import { THEME_SCRIPT, resolveTheme } from "./theme";

describe("resolveTheme", () => {
  it("a escolha salva vence o sistema", () => {
    expect(resolveTheme("claro", false, true)).toBe("claro");
    expect(resolveTheme("escuro", true, false)).toBe("escuro");
  });
  it("sem escolha, segue o sistema", () => {
    expect(resolveTheme(null, true, false)).toBe("claro");
    expect(resolveTheme(null, false, true)).toBe("escuro");
  });
  it("sem escolha e sem preferência do sistema, escuro", () => {
    expect(resolveTheme(null, false, false)).toBe("escuro");
    expect(resolveTheme("lixo", false, false)).toBe("escuro");
  });
  it("o script do layout é JavaScript válido e usa a mesma chave", () => {
    expect(() => new Function(THEME_SCRIPT)).not.toThrow();
    expect(THEME_SCRIPT).toContain("logica-gamificada:tema");
  });
});
