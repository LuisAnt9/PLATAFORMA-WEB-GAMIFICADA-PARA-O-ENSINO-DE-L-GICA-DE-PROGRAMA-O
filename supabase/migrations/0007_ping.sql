-- Função mínima que só devolve 1. Serve para a rotina diária do GitHub (.github/workflows/keep-alive.yml)
-- dar um "toque" real no banco e evitar que o plano gratuito do Supabase pause o projeto por inatividade.
-- Pode ser chamada sem login e não lê nem altera dado nenhum.

create function public.ping()
returns integer
language sql
stable
as $$ select 1; $$;

revoke execute on function public.ping() from public;
grant execute on function public.ping() to anon, authenticated;
