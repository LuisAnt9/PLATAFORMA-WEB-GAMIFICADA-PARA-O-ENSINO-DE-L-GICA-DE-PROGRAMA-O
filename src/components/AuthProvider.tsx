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
import { clearProgress, loadProgress } from "@/lib/progress-store";
import { getSupabase } from "@/lib/supabase";

export interface Profile {
  id: string;
  name: string;
  role: "aluno" | "professor";
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
  ) => Promise<{ error: string | null; needsConfirmation: boolean }>;
  signOut: () => Promise<void>;
}

const AuthContext = createContext<AuthState | null>(null);

export function useAuth(): AuthState {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth fora do AuthProvider");
  return ctx;
}

const PUBLIC_PATHS = ["/entrar"];

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
      setLoading(false);
      return;
    }
    try {
      const { data, error } = await getSupabase()
        .from("profiles")
        .select("id, name, role")
        .eq("id", s.user.id)
        .single();
      if (error) throw new Error(error.message);
      await loadProgress(s.user.id);
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
  useEffect(() => {
    if (loading) return;
    if (!session && !isPublic) router.replace("/entrar");
    if (session && isPublic) router.replace("/");
  }, [loading, session, isPublic, router]);

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
      signUp: async (name, email, password) => {
        const { data, error } = await getSupabase().auth.signUp({
          email,
          password,
          options: { data: { name } },
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
    }),
    [loading, profile, loadError],
  );

  if (loading || (!session && !isPublic) || (session && isPublic)) {
    return (
      <AuthContext.Provider value={value}>
        <p className="p-8 text-center text-zinc-500" role="status">
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
