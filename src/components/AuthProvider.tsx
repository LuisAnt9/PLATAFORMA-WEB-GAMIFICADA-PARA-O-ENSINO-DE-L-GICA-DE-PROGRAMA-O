"use client";

import type { Session } from "@supabase/supabase-js";
import { usePathname, useRouter } from "next/navigation";
import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
} from "react";
import { clearActivity, loadActivity } from "@/lib/activity-store";
import { clearGamification, syncGamification } from "@/lib/gamification-store";
import { clearProgress, loadProgress } from "@/lib/progress-store";
import { getSupabase } from "@/lib/supabase";

export interface Profile {
  id: string;
  name: string;
  role: "aluno" | "professor";
  /** Escolha de aparecer no ranking da turma (migration 0014; ausente antes dela). */
  show_in_ranking?: boolean;
  /** Consentimento (migration 0017): null = ainda não aceitou o termo; ausente = migration não aplicada. */
  consent_at?: string | null;
  consent_version?: string | null;
  over_18?: boolean | null;
  /** Escolha de usar a dica com IA (migration 0017). */
  ai_hints_enabled?: boolean;
}

interface AuthState {
  loading: boolean;
  profile: Profile | null;
  loadError: string | null;
  signIn: (email: string, password: string) => Promise<string | null>;
  signUp: (
    name: string,
    email: string,
    password: string,
    consent?: { version: string; over18: boolean },
  ) => Promise<{ error: string | null; needsConfirmation: boolean }>;
  acceptTerms: (version: string, over18: boolean) => Promise<string | null>;
  setAiHintsEnabled: (value: boolean) => Promise<string | null>;
  exportData: () => Promise<unknown>;
  deleteAccount: () => Promise<string | null>;
  signOut: () => Promise<void>;
  updateName: (name: string) => Promise<string | null>;
  setRankingOptIn: (value: boolean) => Promise<string | null>;
}

const AuthContext = createContext<AuthState | null>(null);

export function useAuth(): AuthState {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth fora do AuthProvider");
  return ctx;
}

const PUBLIC_PATHS = ["/entrar"];
/** Páginas abertas a qualquer pessoa, com ou sem login (a política de privacidade). */
const OPEN_PATHS = ["/privacidade"];

/** Traduz as mensagens de erro mais comuns do Supabase Auth. */
export function authMessage(message: string): string {
  const m = message.toLowerCase();
  if (m.includes("invalid login credentials"))
    return "E-mail ou senha incorretos.";
  if (m.includes("email not confirmed"))
    return "Confirme seu e-mail antes de entrar (verifique a caixa de entrada).";
  if (m.includes("already registered") || m.includes("already been registered"))
    return "Este e-mail já está cadastrado.";
  if (m.includes("password") && m.includes("least"))
    return "A senha deve ter pelo menos 6 caracteres.";
  if (m.includes("rate limit"))
    return "Muitas tentativas. Aguarde alguns minutos e tente de novo.";
  if (m.includes("fetch"))
    return "Não foi possível conectar ao servidor. Verifique sua internet.";
  return message;
}

export default function AuthProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const router = useRouter();
  const pathname = usePathname();
  const [session, setSession] = useState<Session | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState<string | null>(null);

  const hydrate = useCallback(async (s: Session | null) => {
    setSession(s);
    if (!s) {
      setProfile(null);
      clearProgress();
      clearActivity();
      clearGamification();
      setLoading(false);
      return;
    }
    try {
      const { data, error } = await getSupabase()
        .from("profiles")
        .select("*")
        .eq("id", s.user.id)
        .single();
      if (error) throw new Error(error.message);
      await loadProgress(s.user.id);
      await syncGamification(); // nunca lança: sem a migration 0014 só some o bônus
      await loadActivity(s.user.id); // nunca lança: sem a migration 0004 só esconde a sequência
      setProfile(data as Profile);
      setLoadError(null);
    } catch (e) {
      setLoadError(
        e instanceof Error ? e.message : "Erro ao carregar seus dados.",
      );
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    const supabase = getSupabase();
    // O callback não deve chamar o Supabase de forma síncrona; adiamos com setTimeout.
    const { data } = supabase.auth.onAuthStateChange((_event, s) => {
      setTimeout(() => void hydrate(s), 0);
    });
    return () => data.subscription.unsubscribe();
  }, [hydrate]);

  const isPublic = PUBLIC_PATHS.includes(pathname);
  const isOpen = OPEN_PATHS.includes(pathname);
  useEffect(() => {
    if (loading) return;
    if (isOpen) return;
    if (!session && !isPublic) router.replace("/entrar");
    if (session && isPublic) router.replace("/");
  }, [loading, session, isPublic, isOpen, router]);

  const value = useMemo<AuthState>(
    () => ({
      loading,
      profile,
      loadError,
      signIn: async (email, password) => {
        const { error } = await getSupabase().auth.signInWithPassword({
          email,
          password,
        });
        return error ? authMessage(error.message) : null;
      },
      signUp: async (name, email, password, consent) => {
        const { data, error } = await getSupabase().auth.signUp({
          email,
          password,
          options: {
            data: {
              name,
              ...(consent
                ? {
                    consent_version: consent.version,
                    over_18: String(consent.over18),
                  }
                : {}),
            },
          },
        });
        if (error)
          return {
            error: authMessage(error.message),
            needsConfirmation: false,
          };
        return { error: null, needsConfirmation: !data.session };
      },
      signOut: async () => {
        await getSupabase().auth.signOut();
      },
      updateName: async (name) => {
        if (!profile) return "Sessão expirada.";
        const { error } = await getSupabase()
          .from("profiles")
          .update({ name })
          .eq("id", profile.id);
        if (error) return authMessage(error.message);
        setProfile({ ...profile, name });
        return null;
      },
      acceptTerms: async (version, over18) => {
        if (!profile) return "Sessão expirada.";
        const { error } = await getSupabase().rpc("accept_terms", {
          p_version: version,
          p_over_18: over18,
        });
        if (error) return authMessage(error.message);
        setProfile({
          ...profile,
          consent_at: new Date().toISOString(),
          consent_version: version,
          over_18: over18,
        });
        return null;
      },
      setAiHintsEnabled: async (value) => {
        if (!profile) return "Sessão expirada.";
        const { error } = await getSupabase()
          .from("profiles")
          .update({ ai_hints_enabled: value })
          .eq("id", profile.id);
        if (error) return authMessage(error.message);
        setProfile({ ...profile, ai_hints_enabled: value });
        return null;
      },
      exportData: async () => {
        const { data, error } = await getSupabase().rpc("export_my_data");
        if (error) throw new Error(authMessage(error.message));
        return data;
      },
      deleteAccount: async () => {
        const { error } = await getSupabase().rpc("delete_my_account");
        if (error) return authMessage(error.message);
        await getSupabase().auth.signOut();
        return null;
      },
      setRankingOptIn: async (value) => {
        if (!profile) return "Sessão expirada.";
        const { error } = await getSupabase()
          .from("profiles")
          .update({ show_in_ranking: value })
          .eq("id", profile.id);
        if (error) return authMessage(error.message);
        setProfile({ ...profile, show_in_ranking: value });
        return null;
      },
    }),
    [loading, profile, loadError],
  );

  if (!isOpen && (loading || (!session && !isPublic) || (session && isPublic))) {
    return (
      <AuthContext.Provider value={value}>
        <p
          className="p-8 text-center text-zinc-500 dark:text-zinc-400"
          role="status"
        >
          Carregando...
        </p>
      </AuthContext.Provider>
    );
  }

  if (session && loadError) {
    return (
      <AuthContext.Provider value={value}>
        <div className="mx-auto max-w-md p-8 text-center" role="alert">
          <p className="mb-4 text-red-700 dark:text-red-300">
            Não foi possível carregar seus dados: {loadError}
          </p>
          <button
            onClick={() => void value.signOut()}
            className="rounded-lg border border-zinc-300 px-4 py-2 dark:border-zinc-700"
          >
            Sair
          </button>
        </div>
      </AuthContext.Provider>
    );
  }

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}
