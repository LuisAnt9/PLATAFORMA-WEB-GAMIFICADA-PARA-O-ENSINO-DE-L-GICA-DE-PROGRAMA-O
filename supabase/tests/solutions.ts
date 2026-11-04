import fs from "node:fs";
import path from "node:path";

const dir = path.resolve(import.meta.dirname, "../../content/solucoes");

/** Soluções de referência dos exercícios de código (content/solucoes/<id>.js). Só os testes as leem. */
export function loadSolutions(): Record<string, string> {
  const out: Record<string, string> = {};
  for (const f of fs.readdirSync(dir).filter((x) => x.endsWith(".js"))) {
    out[f.slice(0, -3)] = fs.readFileSync(path.join(dir, f), "utf8");
  }
  return out;
}
