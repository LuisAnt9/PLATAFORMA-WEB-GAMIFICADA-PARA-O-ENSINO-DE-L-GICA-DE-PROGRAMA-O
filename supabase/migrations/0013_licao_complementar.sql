-- Lição complementar (etapa E7): conteúdo que enriquece, mas não trava a trilha.
-- No modo aprendizado, a lição seguinte libera sem esperar a conclusão de uma lição complementar.
-- Execute depois de 0012. O site funciona sem esta migration (nenhuma lição é complementar).

alter table public.modules
  add column optional boolean not null default false;
