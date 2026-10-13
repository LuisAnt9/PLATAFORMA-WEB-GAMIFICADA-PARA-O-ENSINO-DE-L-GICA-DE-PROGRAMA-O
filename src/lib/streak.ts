/** Dia local do navegador no formato AAAA-MM-DD. */
export function localDay(d: Date = new Date()): string {
  const mm = String(d.getMonth() + 1).padStart(2, "0");
  const dd = String(d.getDate()).padStart(2, "0");
  return `${d.getFullYear()}-${mm}-${dd}`;
}

const DAY_MS = 86_400_000;

/** Número inteiro de dias desde 1970 (calendário puro, sem fuso nem horário de verão). */
function dayNumber(day: string): number {
  const [y, m, d] = day.split("-").map(Number);
  return Math.round(Date.UTC(y, m - 1, d) / DAY_MS);
}

function fromDayNumber(n: number): string {
  return new Date(n * DAY_MS).toISOString().slice(0, 10);
}

export function addDays(day: string, n: number): string {
  return fromDayNumber(dayNumber(day) + n);
}

export interface StreakInfo {
  /** Dias seguidos até hoje (ou até ontem, se hoje ainda não praticou). */
  current: number;
  /** Maior sequência já alcançada. */
  best: number;
  activeToday: boolean;
}

export function computeStreak(
  days: Iterable<string>,
  today: string,
): StreakInfo {
  const t = dayNumber(today);
  const nums = [...new Set([...days].map(dayNumber))]
    .filter((n) => n <= t)
    .sort((a, b) => a - b);
  if (nums.length === 0) return { current: 0, best: 0, activeToday: false };

  let best = 1;
  let run = 1;
  for (let i = 1; i < nums.length; i++) {
    run = nums[i] === nums[i - 1] + 1 ? run + 1 : 1;
    best = Math.max(best, run);
  }
  // `run` agora é o tamanho da sequência que termina no último dia registrado.
  const last = nums[nums.length - 1];
  const alive = last === t || last === t - 1; // ainda dá tempo de continuar hoje
  return { current: alive ? run : 0, best, activeToday: last === t };
}

/** Últimos `n` dias terminando em `today` (do mais antigo ao mais recente), marcando os dias com prática. */
export function recentDays(
  days: Iterable<string>,
  today: string,
  n: number,
): { day: string; active: boolean }[] {
  const set = new Set(days);
  return Array.from({ length: n }, (_, i) => {
    const day = addDays(today, i - (n - 1));
    return { day, active: set.has(day) };
  });
}
