-- DIAGNÓSTICO (só lê, não altera nada): mostra quais migrations já estão aplicadas no seu projeto.
-- Cole no SQL Editor do Supabase e clique em Run. A coluna "aplicada" diz true ou false.
-- Regra: aplique, em ordem, só as que estiverem false. Se todas de 0009 em diante estiverem false
-- (e as de 0001 a 0008 true), use o arquivo supabase/atualizar-0009-em-diante.sql.

select migration, aplicada from (values
  ('0001 perfis e progresso',                to_regclass('public.profiles') is not null and to_regclass('public.exercise_progress') is not null),
  ('0002 ranking',                           exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'leaderboard')),
  ('0003 turmas e catálogo',                 to_regclass('public.classes') is not null and to_regclass('public.exercises') is not null and to_regclass('public.modules') is not null),
  ('0004 sequência diária',                  to_regclass('public.daily_activity') is not null),
  ('0005 tipos de exercício (escolha e lacuna)', exists (select 1 from information_schema.columns where table_schema = 'public' and table_name = 'exercises' and column_name = 'kind')),
  ('0007 ping (mantém o plano gratuito ativo)', exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'ping')),
  ('0008 dicas com IA',                      to_regclass('public.ai_hints') is not null),
  ('0009 texto de conceito nos módulos',     exists (select 1 from information_schema.columns where table_schema = 'public' and table_name = 'modules' and column_name = 'intro')),
  ('0010 mundos, conceitos e registro de tentativas',        to_regclass('public.worlds') is not null and to_regclass('public.attempts') is not null),
  ('0011 origem do conteúdo (arquivo ou painel)',            exists (select 1 from information_schema.columns where table_schema = 'public' and table_name = 'exercises' and column_name = 'origem')),
  ('0012 tipos de exercício e solução comentada',            to_regclass('public.exercise_solutions') is not null),
  ('0013 lição complementar',                                exists (select 1 from information_schema.columns where table_schema = 'public' and table_name = 'modules' and column_name = 'optional')),
  ('0014 gamificação (XP no servidor, missões, ranking opcional)', to_regclass('public.mission_claims') is not null),
  ('0015 atividades e avaliações',                           to_regclass('public.assignments') is not null),
  ('0016 painel de conceitos',                               exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'concept_report')),
  ('0017 privacidade e pesquisa',                            to_regclass('public.survey_responses') is not null)
) as t(migration, aplicada);
