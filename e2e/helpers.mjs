import fs from "node:fs";
import { chromium } from "playwright-core";

/** Endereço do site em teste (suba antes com `npm run build && npx next start -p 3100`). */
export const BASE = process.env.E2E_BASE_URL ?? "http://localhost:3100";
/** Pasta de capturas de tela e relatórios (ignorada pelo git). */
export const OUT = process.env.E2E_OUT ?? "e2e/.out";
fs.mkdirSync(`${OUT}/shots`, { recursive: true });

/** Procura um Chromium: CHROME_PATH, o do Playwright instalado, ou o Chrome do sistema. */
export async function launch() {
  const args = ["--no-sandbox"];
  if (process.env.CHROME_PATH) return chromium.launch({ executablePath: process.env.CHROME_PATH, args });
  const pw = "/opt/pw-browsers";
  if (fs.existsSync(pw)) {
    const dir = fs.readdirSync(pw).find((d) => d.startsWith("chromium-"));
    if (dir) return chromium.launch({ executablePath: `${pw}/${dir}/chrome-linux/chrome`, args });
  }
  return chromium.launch({ channel: "chrome", args });
}
