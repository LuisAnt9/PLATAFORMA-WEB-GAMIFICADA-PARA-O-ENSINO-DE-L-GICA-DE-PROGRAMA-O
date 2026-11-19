# Desempenho e limites do plano gratuito (etapa E15)

## Medições
Teste automatizado (`supabase/tests/auditoria.test.ts`), em Postgres embutido (PGlite, mais lento que o Postgres real):

| Cenário | Resultado |
| --- | --- |
| 40 alunos, 40 mil tentativas, 10 conceitos: `concept_report` (painel de conceitos) | ~300 ms |
| Mesmo banco: `leaderboard` | ~5 ms |

Os índices principais existem em `attempts (user_id, exercise_id, created_at)`, `(exercise_id, created_at)` e `(created_at)`.

## Estimativa de tamanho (Supabase Free: 500 MB de banco)
| Item | Estimativa |
| --- | --- |
| Uma tentativa (`attempts`) | ~0,5 KB com o código enviado (limitado a 4.000 caracteres) |
| 60 alunos × 600 exercícios × 3 tentativas médias | ~108 mil linhas ≈ 55 MB |
| Catálogo (≈ 600 exercícios, soluções, conceitos) | < 5 MB |
| Demais tabelas (progresso, atividade diária, medalhas...) | < 10 MB |

Folga ampla para uma turma ao longo de um semestre. O risco real é de outro tipo: o **plano gratuito pausa o projeto após
cerca de 7 dias de inatividade**. O fluxo `.github/workflows/keep-alive.yml` chama a função `ping()` todo dia para evitar.

## Consultas por tela
O catálogo (módulos, exercícios, conceitos, mundos) é carregado uma vez por sessão (5 consultas) e o progresso, uma. Cada
exercício resolvido faz: gravar o progresso (1), registrar a tentativa (1) e conferir missões e mundos (`sync_gamification`, 1
chamada). Painéis do professor usam uma função SQL por tela. Não há consultas em laço por aluno.

## Outros limites do plano
- Auth: limite de e-mails de confirmação por hora (o site mostra mensagem amigável).
- Vercel Hobby: função `/api/dica` com tempo curto; o servidor interrompe a chamada ao Gemini em 20 s e devolve a cota.
- Gemini gratuito: 10 dicas por aluno por dia (cota no banco); se o limite do Google for atingido, o aluno recebe aviso e a dica é devolvida.
- Se um dia faltar espaço: apagar `attempts` antigos de turmas encerradas depois de exportar os dados da pesquisa.
