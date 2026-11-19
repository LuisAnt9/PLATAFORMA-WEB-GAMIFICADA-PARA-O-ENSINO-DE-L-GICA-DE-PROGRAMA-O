# Privacidade e LGPD (etapa E15)

Resumo técnico do que a plataforma faz com dados pessoais e do que ficou combinado (decisão D14). O texto para o aluno
está em `src/lib/privacy.ts` e aparece em `/privacidade`.

## O que é guardado
| Dado | Onde | Para quê |
| --- | --- | --- |
| Nome, e-mail, senha (protegida pelo Supabase Auth) | `auth.users`, `profiles` | Login e identificação na turma |
| Consentimento: versão do termo, data, "tem 18 anos ou mais?" | `profiles` | Prova do aceite e atenção a menores |
| Progresso, tentativas (resposta, acerto, tempo, dica usada, tipo de erro), XP, medalhas, missões, dias de prática | `exercise_progress`, `attempts`, `user_badges`, `mission_claims`, `world_bonuses`, `daily_activity` | Aprendizagem e acompanhamento do professor |
| Turmas, atividades e entregas | `class_members`, `assignments`, `assessment_submissions` | Uso em sala |
| Uso da dica com IA | `ai_hints` | Cota diária e comparação agregada |
| Respostas SUS/Likert | `survey_responses` (+ `survey_done`) | Avaliação do TCC |

## Consentimento
- **Cadastro:** exige declarar a idade e aceitar a política. A versão do termo (`TERMS_VERSION`) e a declaração vão nos
  metadados do cadastro e o gatilho `handle_new_user` as grava em `profiles` (migration 0017).
- **Contas antigas e mudanças no texto:** o `ConsentGate` bloqueia o uso até aceitar a versão atual (função `accept_terms`).
  Ao alterar a política, mude `TERMS_VERSION` em `src/lib/privacy.ts`: todos serão convidados a ler e aceitar de novo.
- **Menores de 18:** o sistema registra a declaração e mostra o aviso. **A coleta da autorização do responsável é
  processo da instituição** (orientador/CEP): não há como o site verificá-la. Ver pendências para a defesa.

## Direitos do titular
- **Acesso e portabilidade:** `export_my_data()` devolve todos os dados da própria pessoa em JSON (Perfil → "Baixar meus dados").
- **Exclusão:** `delete_my_account()` apaga o usuário em `auth.users` e, em cascata, tudo que é dele (testado: nenhuma
  tabela com `user_id` mantém linhas). Em contas de professor, as turmas e atividades também são apagadas.
- **Correção:** o aluno edita o nome no Perfil.
- **Opções:** desligar a dica com IA e sair do ranking, no Perfil.

## Dica com IA (Google)
O servidor (`/api/dica`) envia ao Gemini o enunciado e o código/resposta do aluno. A chave fica só no servidor. O aluno pode
**desligar** (`profiles.ai_hints_enabled`); o banco recusa a cota (`IA_DESLIGADA`) e a rota devolve 403. O aviso aparece no
botão, na dica e na política.

## Retenção
Dados ficam enquanto a conta existir e são apagados na exclusão. Proposta para o fim da pesquisa: excluir contas de
estudantes sem uso por mais de 12 meses (ação do responsável; não automatizada).

## Pesquisa (SUS e Likert)
- **Anônima ou identificada**, escolha do aluno em cada envio. A anônima grava `user_id = null`: não há ligação com a pessoa
  (uma tabela separada, `survey_done`, só impede responder duas vezes).
- O professor só lê respostas das turmas dele e só as que tenham turma informada. Resumo agregado só com 5 ou mais respostas.
- **CSV:** `export_survey_csv` (professor); escapa aspas e neutraliza fórmulas do Excel (`=`, `+`, `-`, `@`).
- **Comparação com e sem IA:** só agregada e só com 5 alunos em cada grupo; não mostra dados individuais.

## Limites
- Respostas anônimas não podem ser apagadas a pedido (não há como saber de quem são): está dito na política.
- O Supabase e a Vercel podem armazenar dados fora do Brasil (também dito na política).
- Não há registro de acesso (log de auditoria) a dados pelo professor.
