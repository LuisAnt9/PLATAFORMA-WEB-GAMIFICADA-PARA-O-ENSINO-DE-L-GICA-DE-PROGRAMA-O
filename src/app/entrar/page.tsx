"use client";

import { usePageTitle } from "@/lib/use-page-title";
import { useState } from "react";
import { useAuth } from "@/components/AuthProvider";

export default function EntrarPage() {
  usePageTitle("Entrar");
  const { signIn, signUp } = useAuth();
  const [mode, setMode] = useState<"entrar" | "cadastrar">("entrar");
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [info, setInfo] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setBusy(true);
    setError(null);
    setInfo(null);
    if (mode === "entrar") {
      setError(await signIn(email.trim(), password));
    } else {
      const r = await signUp(name.trim(), email.trim(), password);
      setError(r.error);
      if (!r.error && r.needsConfirmation) {
        setInfo(
          "Cadastro feito! Enviamos um link de confirmação para o seu e-mail. Depois de confirmar, volte e entre.",
        );
        setMode("entrar");
      }
    }
    setBusy(false);
  }

  const field =
    "mt-1 w-full rounded-xl border border-zinc-300 bg-white px-3 py-2.5 dark:border-zinc-700 dark:bg-zinc-950";

  return (
    <div className="mx-auto mt-4 max-w-sm rounded-2xl border border-zinc-200 bg-white p-6 shadow-sm dark:border-zinc-800 dark:bg-zinc-900 sm:mt-10 sm:p-8">
      <span
        aria-hidden
        className="mb-4 flex h-11 w-11 items-center justify-center rounded-xl bg-emerald-700 font-mono text-white"
      >
        {"</>"}
      </span>
      <h1 className="mb-1 text-2xl font-semibold tracking-tight">
        {mode === "entrar" ? "Entrar" : "Criar conta"}
      </h1>
      <p className="mb-6 text-sm text-zinc-600 dark:text-zinc-400">
        Plataforma de lógica de programação — IFPI Campus Picos.
      </p>

      <form onSubmit={onSubmit} className="space-y-4">
        {mode === "cadastrar" && (
          <label className="block text-sm">
            Nome
            <input
              className={field}
              value={name}
              onChange={(e) => setName(e.target.value)}
              required
              minLength={2}
              maxLength={80}
              autoComplete="name"
            />
          </label>
        )}
        <label className="block text-sm">
          E-mail
          <input
            className={field}
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            autoComplete="email"
          />
        </label>
        <label className="block text-sm">
          Senha
          <input
            className={field}
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            minLength={6}
            autoComplete={
              mode === "entrar" ? "current-password" : "new-password"
            }
          />
        </label>

        {error && (
          <p
            role="alert"
            className="rounded-lg bg-red-50 p-3 text-sm text-red-800 dark:bg-red-950 dark:text-red-200"
          >
            {error}
          </p>
        )}
        {info && (
          <p
            role="status"
            className="rounded-lg bg-emerald-50 p-3 text-sm dark:bg-emerald-950"
          >
            {info}
          </p>
        )}

        <button
          type="submit"
          disabled={busy}
          className="w-full rounded-xl bg-emerald-700 px-4 py-2.5 font-medium text-white hover:bg-emerald-800 disabled:opacity-50"
        >
          {busy ? "Aguarde..." : mode === "entrar" ? "Entrar" : "Cadastrar"}
        </button>
      </form>

      <button
        onClick={() => {
          setMode(mode === "entrar" ? "cadastrar" : "entrar");
          setError(null);
        }}
        className="mt-4 text-sm text-emerald-700 hover:underline dark:text-emerald-400"
      >
        {mode === "entrar"
          ? "Não tem conta? Cadastre-se"
          : "Já tem conta? Entrar"}
      </button>
    </div>
  );
}
