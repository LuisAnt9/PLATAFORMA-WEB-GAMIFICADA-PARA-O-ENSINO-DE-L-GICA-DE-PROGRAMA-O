"use client";

import { javascript } from "@codemirror/lang-javascript";
import { HighlightStyle, syntaxHighlighting } from "@codemirror/language";
import { Prec } from "@codemirror/state";
import { EditorView } from "@codemirror/view";
import { tags } from "@lezer/highlight";
import CodeMirror from "@uiw/react-codemirror";
import { useMemo, useSyncExternalStore } from "react";

const query = "(prefers-color-scheme: dark)";

function useDarkMode() {
  return useSyncExternalStore(
    (cb) => {
      const mq = window.matchMedia(query);
      mq.addEventListener("change", cb);
      return () => mq.removeEventListener("change", cb);
    },
    () => window.matchMedia(query).matches,
    () => false,
  );
}

export default function CodeEditor({
  value,
  onChange,
  onRun,
  label = "Editor de código",
}: {
  value: string;
  onChange: (v: string) => void;
  /** Atalho Ctrl/Cmd+Enter. */
  onRun: () => void;
  /** Nome do campo para leitores de tela. */
  label?: string;
}) {
  const dark = useDarkMode();
  const extensions = useMemo(
    () => [
      // Modo escuro: as cores do tema padrão ficavam abaixo de 4,5:1 (comentários e a linha ativa),
      // então escurecemos o fundo e clareamos só o comentário. Todas as cores passam em >= 4,6:1.
      ...(dark
        ? [
            Prec.highest(
              EditorView.theme(
                {
                  "&": { backgroundColor: "#1c1f26" },
                  ".cm-gutters": { backgroundColor: "#1c1f26" },
                  ".cm-activeLine": { backgroundColor: "#232831" },
                  ".cm-activeLineGutter": { backgroundColor: "#232831" },
                },
                { dark: true },
              ),
            ),
            Prec.highest(
              syntaxHighlighting(
                HighlightStyle.define([
                  { tag: tags.comment, color: "#9aa3b2" },
                ]),
              ),
            ),
          ]
        : []),
      javascript(),
      EditorView.contentAttributes.of({ "aria-label": label }),
    ],
    [label, dark],
  );
  return (
    <div
      className="overflow-hidden rounded-lg border border-zinc-300 text-sm dark:border-zinc-700"
      onKeyDown={(e) => {
        if ((e.ctrlKey || e.metaKey) && e.key === "Enter") {
          e.preventDefault();
          onRun();
        }
      }}
    >
      <CodeMirror
        value={value}
        onChange={onChange}
        extensions={extensions}
        theme={dark ? "dark" : "light"}
        height="16rem"
        basicSetup={{
          lineNumbers: true,
          foldGutter: false,
          highlightActiveLine: true,
        }}
      />
    </div>
  );
}
