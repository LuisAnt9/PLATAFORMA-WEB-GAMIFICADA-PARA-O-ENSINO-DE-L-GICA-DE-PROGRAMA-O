"use client";

import type { ChoiceView } from "@/lib/grading";

export default function ChoiceBody({
  view,
  selected,
  result,
  onSelect,
  onSubmit,
  disabled,
}: {
  view: ChoiceView;
  selected: number | null;
  /** null = ainda não verificou a escolha atual. */
  result: boolean | null;
  onSelect: (i: number) => void;
  onSubmit: () => void;
  disabled: boolean;
}) {
  return (
    <form
      onSubmit={(e) => {
        e.preventDefault();
        if (selected !== null) onSubmit();
      }}
      className="space-y-3"
    >
      <fieldset className="space-y-2">
        <legend className="sr-only">Alternativas</legend>
        {view.options.map((option, i) => {
          const chosen = selected === i;
          const state =
            chosen && result === true
              ? "border-emerald-500 bg-emerald-50 dark:bg-emerald-950"
              : chosen && result === false
                ? "border-red-400 bg-red-50 dark:bg-red-950"
                : chosen
                  ? "border-emerald-500"
                  : "border-zinc-200 hover:border-zinc-400 dark:border-zinc-800 dark:hover:border-zinc-600";
          return (
            <label
              key={i}
              className={`flex cursor-pointer items-start gap-3 rounded-lg border p-3 ${state}`}
            >
              <input
                type="radio"
                name="alternativa"
                className="mt-1 accent-emerald-600"
                checked={chosen}
                onChange={() => onSelect(i)}
              />
              <span className="whitespace-pre-line">{option}</span>
            </label>
          );
        })}
      </fieldset>
      <button
        type="submit"
        disabled={disabled || selected === null}
        className="rounded-lg bg-emerald-600 px-4 py-2 font-medium text-white hover:bg-emerald-700 disabled:opacity-50"
      >
        Verificar resposta
      </button>
    </form>
  );
}
