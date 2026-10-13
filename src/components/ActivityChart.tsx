"use client";

import { useState } from "react";
import { niceMax, type DayCount } from "@/lib/class-analytics";

// Verde validado (dataviz): passa a faixa de luminosidade e contraste ≥ 3:1 nos dois modos.
const BAR = "#059669";
const fmt = (iso: string) => `${iso.slice(8, 10)}/${iso.slice(5, 7)}`;
const noun = (n: number) =>
  `${n} ${n === 1 ? "exercício resolvido" : "exercícios resolvidos"}`;

export default function ActivityChart({
  data,
  title,
}: {
  data: DayCount[];
  title: string;
}) {
  const [active, setActive] = useState<number | null>(null);
  const [asTable, setAsTable] = useState(false);

  const max = Math.max(0, ...data.map((d) => d.count));
  const top = niceMax(max);
  const total = data.reduce((n, d) => n + d.count, 0);
  const peak = max > 0 ? data.findIndex((d) => d.count === max) : -1;
  const last = data.length - 1;

  return (
    <figure>
      <div className="mb-2 flex flex-wrap items-baseline justify-between gap-2">
        <figcaption>
          <span className="font-medium">{title}</span>
          <span className="ml-2 text-sm text-zinc-500">{total} no período</span>
        </figcaption>
        <button
          onClick={() => setAsTable((v) => !v)}
          className="text-sm text-zinc-500 hover:underline"
        >
          {asTable ? "Ver como gráfico" : "Ver como tabela"}
        </button>
      </div>

      {asTable ? (
        <div className="max-h-64 overflow-auto rounded-lg border border-zinc-200 dark:border-zinc-800">
          <table className="w-full text-sm">
            <caption className="sr-only">{title}</caption>
            <thead className="bg-zinc-50 text-left text-zinc-500 dark:bg-zinc-900">
              <tr>
                <th scope="col" className="px-4 py-2">
                  Dia
                </th>
                <th scope="col" className="px-4 py-2 text-right">
                  Resolvidos
                </th>
              </tr>
            </thead>
            <tbody>
              {data.map((d) => (
                <tr
                  key={d.date}
                  className="border-t border-zinc-200 dark:border-zinc-800"
                >
                  <th scope="row" className="px-4 py-1.5 text-left font-normal">
                    {fmt(d.date)}
                  </th>
                  <td className="px-4 py-1.5 text-right tabular-nums">
                    {d.count}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      ) : (
        <div className="flex gap-2 pt-7" onMouseLeave={() => setActive(null)}>
          {/* eixo y */}
          <div
            aria-hidden
            className="relative h-40 w-6 shrink-0 text-right text-xs text-zinc-500"
          >
            {[top, top / 2, 0].map((v, i) => (
              <span
                key={v}
                className="absolute right-0 -translate-y-1/2 tabular-nums"
                style={{ top: `${i * 50}%` }}
              >
                {v}
              </span>
            ))}
          </div>

          <div className="min-w-0 flex-1">
            <div className="relative h-40">
              {/* grade: hairline, recessiva */}
              {[0, 50, 100].map((p) => (
                <div
                  key={p}
                  aria-hidden
                  className="absolute inset-x-0 border-t border-zinc-200 dark:border-zinc-800"
                  style={{ top: `${p}%` }}
                />
              ))}
              <ul className="absolute inset-0 flex items-stretch gap-1">
                {data.map((d, i) => {
                  const pct = (d.count / top) * 100;
                  const edge =
                    i < 2
                      ? "left-0"
                      : i > last - 2
                        ? "right-0"
                        : "left-1/2 -translate-x-1/2";
                  return (
                    <li
                      key={d.date}
                      className="relative flex min-w-0 flex-1 items-end justify-center"
                    >
                      <button
                        type="button"
                        aria-label={`${fmt(d.date)}: ${noun(d.count)}`}
                        onMouseEnter={() => setActive(i)}
                        onFocus={() => setActive(i)}
                        onBlur={() => setActive(null)}
                        className="group flex h-full w-full items-end justify-center rounded-sm outline-offset-2 focus-visible:outline focus-visible:outline-2 focus-visible:outline-emerald-600"
                      >
                        <span
                          className={`block w-full max-w-6 rounded-t-[4px] transition-opacity ${active !== null && active !== i ? "opacity-40" : ""}`}
                          style={{ height: `${pct}%`, background: BAR }}
                        />
                      </button>
                      {i === peak && active === null && (
                        <span
                          aria-hidden
                          className="pointer-events-none absolute -translate-y-1 text-xs font-medium tabular-nums"
                          style={{ bottom: `${pct}%` }}
                        >
                          {d.count}
                        </span>
                      )}
                      {active === i && (
                        <div
                          role="status"
                          className={`pointer-events-none absolute bottom-full z-10 mb-1 whitespace-nowrap rounded-md bg-zinc-900 px-2 py-1 text-xs text-white shadow dark:bg-zinc-100 dark:text-zinc-900 ${edge}`}
                        >
                          {fmt(d.date)} · {noun(d.count)}
                        </div>
                      )}
                    </li>
                  );
                })}
              </ul>
            </div>
            {/* eixo x: rótulos esparsos para não colidir em telas estreitas */}
            <ul aria-hidden className="mt-1 flex gap-1 text-xs text-zinc-500">
              {data.map((d, i) => (
                <li key={d.date} className="relative h-4 min-w-0 flex-1">
                  {i % 3 === last % 3 && (
                    <span className="absolute left-1/2 -translate-x-1/2 whitespace-nowrap">
                      {fmt(d.date)}
                    </span>
                  )}
                </li>
              ))}
            </ul>
          </div>
        </div>
      )}
    </figure>
  );
}
