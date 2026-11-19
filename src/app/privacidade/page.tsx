"use client";

import Link from "next/link";
import { POLICY, TERMS_VERSION } from "@/lib/privacy";
import { usePageTitle } from "@/lib/use-page-title";

export default function PrivacidadePage() {
  usePageTitle("Privacidade");
  return (
    <article className="space-y-6">
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">
          Política de privacidade
        </h1>
        <p className="mt-1 text-sm text-zinc-600 dark:text-zinc-400">
          Versão {TERMS_VERSION}. Escrita em linguagem simples, de acordo com a
          Lei Geral de Proteção de Dados (LGPD).
        </p>
      </header>
      {POLICY.map((s) => (
        <section key={s.title} aria-labelledby={`s-${s.title}`}>
          <h2 id={`s-${s.title}`} className="mb-2 text-lg font-semibold">
            {s.title}
          </h2>
          <ul className="list-disc space-y-1.5 pl-5 leading-relaxed">
            {s.body.map((p) => (
              <li key={p}>{p}</li>
            ))}
          </ul>
        </section>
      ))}
      <p>
        <Link
          href="/"
          className="text-emerald-700 underline dark:text-emerald-400"
        >
          Voltar ao início
        </Link>
      </p>
    </article>
  );
}
