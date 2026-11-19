"use client";

import Link from "next/link";
import { useState } from "react";
import { downloadFile } from "@/lib/privacy";
import { useAuth } from "./AuthProvider";
import RankingOptIn from "./RankingOptIn";

/** Escolhas e direitos de privacidade: dica com IA, ranking, baixar dados e excluir a conta. */
export default function PrivacySettings() {
  const { profile, setAiHintsEnabled, exportData, deleteAccount } = useAuth();
  const [busy, setBusy] = useState(false);
  const [msg, setMsg] = useState<{ ok: boolean; text: string } | null>(null);
  const [confirming, setConfirming] = useState(false);
  const [typed, setTyped] = useState("");
  if (!profile) return null;
  const aiOn = profile.ai_hints_enabled !== false;

  async function download() {
    setBusy(true);
    setMsg(null);
    try {
      const data = await exportData();
      downloadFile(
        "meus-dados-logica-gamificada.json",
        JSON.stringify(data, null, 2),
        "application/json",
      );
      setMsg({ ok: true, text: "Arquivo gerado. Ele inclui tudo que guardamos sobre você." });
    } catch (e) {
      setMsg({ ok: false, text: (e as Error).message });
    }
    setBusy(false);
  }
  async function remove() {
    setBusy(true);
    const err = await deleteAccount();
    if (err) {
      setMsg({ ok: false, text: err });
      setBusy(false);
    }
  }

  return (
    <section aria-labelledby="privacidade-e-dados" className="space-y-5">
      <h2 id="privacidade-e-dados" className="text-lg font-semibold">
        Privacidade e dados
      </h2>
      <label className="flex items-start gap-3 text-sm">
        <input
          type="checkbox"
          checked={aiOn}
          disabled={busy}
          onChange={async (e) => {
            setBusy(true);
            const err = await setAiHintsEnabled(e.target.checked);
            setMsg(err ? { ok: false, text: err } : null);
            setBusy(false);
          }}
          className="mt-0.5 h-5 w-5"
        />
        <span>
          <span className="font-medium">Usar a dica com IA</span>
          <span className="block text-zinc-600 dark:text-zinc-400">
            Ao pedir uma dica, o enunciado e o seu código são enviados ao Google (Gemini). Desligada, nada é enviado.
          </span>
        </span>
      </label>
      {profile.role === "aluno" && <RankingOptIn />}
      <div className="flex flex-wrap gap-3">
        <button
          type="button"
          onClick={() => void download()}
          disabled={busy}
          className="rounded-xl border border-zinc-300 px-4 py-2 text-sm hover:bg-zinc-50 disabled:opacity-50 dark:border-zinc-700 dark:hover:bg-zinc-800"
        >
          Baixar meus dados
        </button>
        <Link href="/privacidade" className="self-center text-sm text-emerald-700 underline dark:text-emerald-400">
          Política de privacidade
        </Link>
      </div>
      {!confirming ? (
        <button
          type="button"
          onClick={() => setConfirming(true)}
          className="text-sm text-red-700 underline dark:text-red-300"
        >
          Excluir minha conta
        </button>
      ) : (
        <div role="alertdialog" aria-label="Confirmar exclusão da conta" className="space-y-3 rounded-xl border border-red-300 bg-red-50 p-4 text-sm dark:border-red-900 dark:bg-red-950">
          <p>
            Isso apaga a sua conta e <strong>todos</strong> os seus dados (progresso, tentativas, medalhas, entregas e
            respostas identificadas). Não dá para desfazer.
            {profile.role === "professor" && " Como professor, as suas turmas e atividades também serão apagadas."}
          </p>
          <label className="block">
            Digite <strong>EXCLUIR</strong> para confirmar
            <input
              value={typed}
              onChange={(e) => setTyped(e.target.value)}
              className="mt-1 w-full max-w-xs rounded-lg border border-zinc-400 bg-white px-3 py-2 dark:bg-zinc-950"
            />
          </label>
          <div className="flex gap-2">
            <button
              type="button"
              disabled={busy || typed !== "EXCLUIR"}
              onClick={() => void remove()}
              className="rounded-xl bg-red-700 px-4 py-2 font-medium text-white hover:bg-red-800 disabled:opacity-50"
            >
              Excluir definitivamente
            </button>
            <button type="button" onClick={() => { setConfirming(false); setTyped(""); }} className="rounded-xl border border-zinc-400 px-4 py-2">
              Cancelar
            </button>
          </div>
        </div>
      )}
      {msg && (
        <p role={msg.ok ? "status" : "alert"} className={`text-sm ${msg.ok ? "text-emerald-700 dark:text-emerald-400" : "text-red-700 dark:text-red-300"}`}>
          {msg.text}
        </p>
      )}
    </section>
  );
}
