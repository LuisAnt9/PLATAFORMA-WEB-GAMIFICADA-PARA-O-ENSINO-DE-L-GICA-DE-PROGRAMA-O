import { createClient } from "@supabase/supabase-js";
import {
  DAILY_HINT_LIMIT,
  SYSTEM_PROMPT,
  buildHintPrompt,
  extractGeminiText,
  type HintContext,
} from "@/lib/ai-hint";
import { exerciseFromRow } from "@/lib/catalog";

// Dica com IA. A chave do Gemini existe só aqui, no servidor. A identidade do aluno e o limite diário
// vêm do Supabase (o aluno manda o próprio token; as regras RLS valem como no navegador).

const json = (body: Record<string, unknown>, status = 200) =>
  Response.json(body, { status, headers: { "Cache-Control": "no-store" } });

export async function POST(request: Request) {
  const apiKey = process.env.GEMINI_API_KEY;
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anon = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY;
  if (!apiKey || !url || !anon) {
    return json({ error: "A dica com IA não está configurada." }, 503);
  }

  const token = request.headers.get("authorization")?.replace(/^Bearer /i, "");
  if (!token)
    return json({ error: "Entre na sua conta para pedir dicas." }, 401);

  let body: { exerciseId?: unknown } & HintContext;
  try {
    body = await request.json();
  } catch {
    return json({ error: "Pedido inválido." }, 400);
  }
  if (typeof body.exerciseId !== "string") {
    return json({ error: "Pedido inválido." }, 400);
  }

  const db = createClient(url, anon, {
    global: { headers: { Authorization: `Bearer ${token}` } },
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const { data: user } = await db.auth.getUser(token);
  if (!user.user)
    return json({ error: "Sessão expirada. Entre de novo." }, 401);

  // O exercício vem do banco com o token do aluno: rascunhos continuam invisíveis para ele.
  const { data: row } = await db
    .from("exercises")
    .select("*")
    .eq("id", body.exerciseId)
    .maybeSingle();
  if (!row) return json({ error: "Exercício não encontrado." }, 404);

  const { data: used, error: quotaError } = await db.rpc("use_ai_hint", {
    p_exercise: body.exerciseId,
    p_limit: DAILY_HINT_LIMIT,
  });
  if (quotaError) {
    if (quotaError.message.includes("LIMITE_DIARIO")) {
      return json(
        {
          error: `Você usou as ${DAILY_HINT_LIMIT} dicas de hoje. Volte amanhã!`,
          remaining: 0,
        },
        429,
      );
    }
    const missing = /use_ai_hint|schema cache|does not exist/i.test(
      quotaError.message,
    );
    return json(
      {
        error: missing
          ? "A dica com IA ainda não foi ativada no banco."
          : "Não foi possível pedir a dica.",
      },
      missing ? 503 : 500,
    );
  }
  const { hint_id, remaining } = (
    used as { hint_id: number; remaining: number }[]
  )[0];

  const refund = () => void db.rpc("refund_ai_hint", { p_id: hint_id });
  try {
    const model = process.env.GEMINI_MODEL || "gemini-2.5-flash";
    const res = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(model)}:generateContent`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "x-goog-api-key": apiKey,
        },
        body: JSON.stringify({
          systemInstruction: { parts: [{ text: SYSTEM_PROMPT }] },
          contents: [
            {
              role: "user",
              parts: [
                {
                  text: buildHintPrompt(exerciseFromRow(row), {
                    code: asText(body.code),
                    attempt: asText(body.attempt),
                  }),
                },
              ],
            },
          ],
          generationConfig: { temperature: 0.4, maxOutputTokens: 1024 },
        }),
        signal: AbortSignal.timeout(20_000),
      },
    );
    if (!res.ok) throw new Error(`Gemini ${res.status}`);
    const text = extractGeminiText(await res.json());
    if (!text) throw new Error("resposta vazia");
    return json({ hint: text, remaining });
  } catch {
    refund(); // falha do serviço não gasta a dica do aluno
    return json(
      { error: "A IA não respondeu agora. Tente de novo em instantes." },
      502,
    );
  }
}

const asText = (v: unknown) => (typeof v === "string" ? v : undefined);
