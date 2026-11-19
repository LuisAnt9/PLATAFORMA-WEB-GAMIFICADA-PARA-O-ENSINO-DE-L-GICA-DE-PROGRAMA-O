"use client";

import Link from "next/link";
import { useState } from "react";
import { TERMS_VERSION } from "@/lib/privacy";
import { useAuth } from "./AuthProvider";
import { primaryButton } from "./ui";

/** Quem ainda não aceitou o termo vê esta tela antes de usar a plataforma (contas criadas antes da E15). */
export default function ConsentGate({ children }: { children: React.ReactNode }) {
  const { profile, acceptTerms, signOut } = useAuth();
  const [agree, setAgree] = useState(false);
  const [over18, setOver18] = useState<boolean | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // `undefined` = banco sem a migration 0017 (não bloqueia). Pede o aceite de novo se nunca aceitou
  // (`null`) ou se aceitou uma versão antiga do termo.
  const accepted =
    profile?.consent_at !== null && profile?.consent_version === TERMS_VERSION;
  if (!profile || profile.consent_at === undefined || accepted)
    return <>{children}</>;
  async function submit(e: React.FormEvent) {
    e.preventDefault();
    if (over18 === null) return;
    setBusy(true);
    setError(null);
    const err = await acceptTerms(TERMS_VERSION, over18);
    if (err) setError(err);
    setBusy(false);
  }
  return (
    <form
      onSubmit={submit}
      aria-labelledby="termo-titulo"
      className="mx-auto max-w-lg space-y-4 rounded-2xl border border-zinc-200 bg-white p-6 shadow-sm dark:border-zinc-800 dark:bg-zinc-900"
    >
      <h1 id="termo-titulo" className="text-xl font-semibold">
        Antes de continuar
      </h1>
      <p className="text-sm leading-relaxed">
        Atualizamos o termo de uso e a política de privacidade. Resumindo: guardamos
        o seu progresso e as suas tentativas para mostrar a sua evolução e ajudar o
        professor a ver o que a turma precisa revisar. Você pode baixar ou apagar
        seus dados quando quiser.
      </p>
      <Termo over18={over18} setOver18={setOver18} agree={agree} setAgree={setAgree} />
      {error && (
        <p role="alert" className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200">
          {error}
        </p>
      )}
      <div className="flex flex-wrap items-center gap-3">
        <button type="submit" disabled={busy || !agree || over18 === null} className={`${primaryButton} disabled:opacity-50`}>
          Aceitar e continuar
        </button>
        <button type="button" onClick={() => void signOut()} className="text-sm text-zinc-600 underline dark:text-zinc-400">
          Não aceito, sair
        </button>
      </div>
    </form>
  );
}

/** Campos do termo, usados no cadastro e aqui. */
export function Termo({
  over18,
  setOver18,
  agree,
  setAgree,
}: {
  over18: boolean | null;
  setOver18: (v: boolean) => void;
  agree: boolean;
  setAgree: (v: boolean) => void;
}) {
  return (
    <>
      <fieldset className="space-y-2 text-sm">
        <legend className="font-medium">Você tem 18 anos ou mais?</legend>
        {(
          [
            [true, "Sim, tenho 18 anos ou mais"],
            [false, "Não, tenho menos de 18 anos"],
          ] as const
        ).map(([v, label]) => (
          <label key={String(v)} className="flex items-center gap-2">
            <input type="radio" name="idade" checked={over18 === v} onChange={() => setOver18(v)} className="h-5 w-5" />
            {label}
          </label>
        ))}
        {over18 === false && (
          <p className="rounded-lg bg-amber-50 p-3 dark:bg-amber-950">
            Menores de 18 anos precisam da autorização de um responsável. Converse
            com o professor responsável, que orienta como colhê-la.
          </p>
        )}
      </fieldset>
      <label className="flex items-start gap-3 text-sm">
        <input type="checkbox" checked={agree} onChange={(e) => setAgree(e.target.checked)} className="mt-0.5 h-5 w-5" />
        <span>
          Li e concordo com a{" "}
          <Link href="/privacidade" target="_blank" className="text-emerald-700 underline dark:text-emerald-400">
            política de privacidade
          </Link>{" "}
          e com o uso dos meus dados de estudo na pesquisa, de forma agregada.
        </span>
      </label>
    </>
  );
}
