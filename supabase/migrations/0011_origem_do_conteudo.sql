-- Origem do conteúdo (etapa E2): distingue o que veio dos arquivos em `content/` do que o professor
-- criou ou editou no painel, para o importador nunca sobrescrever edições feitas à mão.
-- Execute depois de 0010. O site funciona sem esta migration.

alter table public.exercises
  add column origem text not null default 'painel' check (origem in ('painel', 'arquivo'));
alter table public.modules
  add column origem text not null default 'painel' check (origem in ('painel', 'arquivo'));

-- Exercícios criados pelas migrations (sem autor) e as 7 lições de exemplo vêm dos arquivos.
update public.exercises set origem = 'arquivo' where created_by is null;
update public.modules set origem = 'arquivo'
  where id in ('primeiros-passos', 'fundamentos', 'condicionais', 'repeticao', 'vetores', 'funcoes', 'textos');

-- Quando o professor altera o conteúdo pelo painel (papel "authenticated"), a linha passa a ser
-- dele: o importador não mexe mais nela. Publicar, despublicar e reordenar NÃO contam como edição.
-- O SQL Editor e as migrations rodam como outro papel e, por isso, não disparam isso.
create function public.mark_panel_edit()
returns trigger
language plpgsql
as $$
declare
  ignored text[] := array['origem', 'published', 'position', 'updated_at', 'created_at', 'created_by'];
begin
  if current_user in ('authenticated', 'anon')
     and old.origem = 'arquivo'
     and new.origem = 'arquivo'
     and (to_jsonb(new) - ignored) is distinct from (to_jsonb(old) - ignored) then
    new.origem := 'painel';
  end if;
  return new;
end;
$$;

create trigger exercises_mark_panel_edit before update on public.exercises
  for each row execute function public.mark_panel_edit();
create trigger modules_mark_panel_edit before update on public.modules
  for each row execute function public.mark_panel_edit();
