"use client";

import { javascript } from "@codemirror/lang-javascript";
import CodeMirror from "@uiw/react-codemirror";
import { useSyncExternalStore } from "react";

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
}: {
  value: string;
  onChange: (v: string) => void;
  /** Atalho Ctrl/Cmd+Enter. */
  onRun: () => void;
}) {
  const dark = useDarkMode();
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
        extensions={[javascript()]}
        theme={dark ? "dark" : "light"}
        height="16rem"
        aria-label="Editor de código"
        basicSetup={{ lineNumbers: true, foldGutter: false, highlightActiveLine: true }}
      />
    </div>
  );
}
