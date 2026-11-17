# Atividades e avaliações (etapa E10)

Três modalidades, sempre separadas em `attempts.mode`:

| Modalidade | Quem define | Nota | Como é gravada |
| --- | --- | --- | --- |
| **Livre** | o aluno, por conta própria (inclui o modo prática) | não | `record_attempt` com `mode = livre` |
| **Atividade** | o professor, para uma turma | não (prazo e situação) | `record_attempt` com `mode = atividade` e `assignment_id` (validado no servidor) |
| **Avaliação** | o professor, para uma turma | **sim** | `submit_assessment`, com `mode = avaliacao` em cada questão |

## Atividade para casa
- O professor escolhe a turma, os exercícios (publicados), título, instruções, disponibilização, prazo e se é obrigatória.
- Situação do aluno: não iniciada, em andamento, concluída, **concluída com atraso** (resolveu depois do prazo), atrasada (prazo passou sem concluir).
- Entregar depois do prazo é possível e fica marcado como atraso (o prazo de atividade não bloqueia).
- O servidor só aceita tentativa de atividade se o aluno é da turma, a atividade já foi liberada, não está arquivada e o exercício faz parte dela.

## Avaliação com nota (decisão D6)
- Só tipos que o banco corrige: múltipla escolha, interpretação, lacuna e ordenação. Exercícios de código são corrigidos no navegador e **não entram** (o banco recusa).
- Ao criar, o banco **copia cada questão sem a resposta** (`assessment_questions`) e guarda o gabarito em `assessment_keys`, tabela que o aluno não consegue ler (RLS sem acesso). O aluno também não lê de qual exercício do catálogo a questão veio. Os passos de ordenação chegam embaralhados e as alternativas, sem a "confusão" de cada uma.
- **Uma única entrega** (`unique (assignment_id, user_id)`), e o **prazo é conferido no servidor** (`FORA_DO_PRAZO`, `NAO_DISPONIVEL`, `JA_ENTREGUE`).
- A nota é ponderada pelos pontos de cada questão. Regra de resultado (escolhida pelo professor): só a nota; nota e gabarito logo após entregar; ou nota e, só depois do prazo, o gabarito.
- **Limite conhecido:** como as questões vêm do catálogo, um aluno que já praticou o mesmo exercício pode se lembrar da resposta. Para provas, vale escolher exercícios que a turma ainda não viu.

## Acompanhamento
- Por atividade: quem iniciou, concluiu, atrasou; tentativas e tempo (soma de `duration_ms`); desempenho por exercício e por conceito (só tentativas da atividade; menos de 3 tentativas = "dados insuficientes"); notas, nas avaliações.
- Painel do professor: turmas ativas, atividades atribuídas, prazos em aberto, conclusão média.
- Perfil do aluno para o professor: progresso, mundos, tentativas e desempenho por conceito (regra D8), sem rotular a pessoa.
- Turmas podem ser **arquivadas** (saem da lista, não recebem atividades; nada é apagado).

## Ações manuais
Rodar a migration `0015_atividades_e_avaliacoes.sql` no SQL Editor do Supabase (depois das anteriores, até a `0014`); ou usar o `supabase/setup-completo.sql` atualizado num banco novo.
