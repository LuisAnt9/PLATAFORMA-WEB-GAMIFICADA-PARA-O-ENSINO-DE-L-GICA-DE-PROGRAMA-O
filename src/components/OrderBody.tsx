"use client";

import { useEffect, useRef, useState } from "react";
import type { OrderView } from "@/lib/grading";

export interface OrderResult {
  passed: boolean;
  /** Quantos passos já estão na posição certa. */
  inPlace: number;
}

/**
 * Ordenação de passos pelo teclado e por toque: cada passo tem botões "para cima" e "para baixo".
 * O foco acompanha o passo movido e a nova posição é anunciada para leitores de tela.
 */
export default function OrderBody({
  view,
  order,
  result,
  onChange,
  onSubmit,
  disabled,
}: {
  view: OrderView;
  order: string[];
  /** null = ainda não verificou a ordem atual. */
  result: OrderResult | null;
  onChange: (order: string[]) => void;
  onSubmit: () => void;
  disabled: boolean;
}) {
  const buttons = useRef(new Map<string, HTMLButtonElement>());
  const [focus, setFocus] = useState<{
    text: string;
    dir: "up" | "down";
  } | null>(null);
  const [announce, setAnnounce] = useState("");

  // devolve o foco ao botão do passo que acabou de ser movido
  useEffect(() => {
    if (!focus) return;
    const el =
      buttons.current.get(`${focus.text}|${focus.dir}`) ??
      buttons.current.get(
        `${focus.text}|${focus.dir === "up" ? "down" : "up"}`,
      );
    el?.focus();
  }, [focus, order]);

  function move(index: number, dir: "up" | "down") {
    const to = dir === "up" ? index - 1 : index + 1;
    if (to < 0 || to >= order.length) return;
    const next = [...order];
    [next[index], next[to]] = [next[to], next[index]];
    onChange(next);
    setFocus({ text: order[index], dir });
    setAnnounce(
      `"${order[index]}" agora na posição ${to + 1} de ${order.length}.`,
    );
  }

  return (
    <form
      onSubmit={(e) => {
        e.preventDefault();
        onSubmit();
      }}
      className="space-y-3"
    >
      <p id="ordem-ajuda" className="text-sm text-zinc-600 dark:text-zinc-400">
        Coloque os passos na ordem certa usando os botões de seta de cada passo.
      </p>
      <ol aria-describedby="ordem-ajuda" className="space-y-2">
        {order.map((text, i) => (
          <li
            key={text}
            className="flex items-center gap-3 rounded-xl border border-zinc-200 bg-white p-3 dark:border-zinc-800 dark:bg-zinc-900"
          >
            <span
              aria-hidden
              className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-zinc-100 text-sm font-medium text-zinc-700 dark:bg-zinc-800 dark:text-zinc-300"
            >
              {i + 1}
            </span>
            <span className="min-w-0 flex-1 whitespace-pre-line">{text}</span>
            {(["up", "down"] as const).map((dir) => {
              const edge = dir === "up" ? i === 0 : i === order.length - 1;
              return (
                <button
                  key={dir}
                  type="button"
                  ref={(el) => {
                    if (el) buttons.current.set(`${text}|${dir}`, el);
                    else buttons.current.delete(`${text}|${dir}`);
                  }}
                  disabled={edge || disabled}
                  aria-label={`Mover para ${dir === "up" ? "cima" : "baixo"}: ${text} (posição ${i + 1} de ${order.length})`}
                  onClick={() => move(i, dir)}
                  className="flex h-10 w-10 items-center justify-center rounded-lg border border-zinc-300 bg-white text-lg hover:bg-zinc-50 disabled:opacity-30 dark:border-zinc-700 dark:bg-zinc-900 dark:hover:bg-zinc-800"
                >
                  <span aria-hidden>{dir === "up" ? "↑" : "↓"}</span>
                </button>
              );
            })}
          </li>
        ))}
      </ol>
      <p role="status" className="sr-only">
        {announce}
      </p>
      {result && !result.passed && (
        <p role="status" className="text-sm text-zinc-600 dark:text-zinc-400">
          {result.inPlace} de {view.items.length} passos já estão na posição
          certa. Continue ajustando.
        </p>
      )}
      <button
        type="submit"
        disabled={disabled}
        className="rounded-xl bg-emerald-700 px-5 py-2.5 font-medium text-white hover:bg-emerald-800 disabled:opacity-50"
      >
        Verificar ordem
      </button>
    </form>
  );
}
