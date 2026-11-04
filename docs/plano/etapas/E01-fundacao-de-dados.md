# E1 — Fundação de dados

> Antes de começar, leia `docs/plano/00-especificacao.md`. Esta etapa é a base de tudo: sem ela o painel de dificuldades (E11) não existe.

## Objetivo
Passar a registrar **cada tentativa** do aluno e a ligar exercícios a **conceitos**, e criar a hierarquia **Mundo > Lição > Exercício**, sem quebrar nada do que já funciona.

## Entregáveis

1. **Migration `worlds`**: tabela `worlds` (id, título, objetivo, posição). Coluna `modules.world_id` (opcional no início) e os campos `modules.example` e `modules.review` (texto). Os 7 módulos atuais são agrupados em um mundo provisório, a ser ajustado na E2/E4.
2. **Migration `concepts`**: tabela `concepts` (id slug, título, descrição, `world_id`, posição) e `exercise_concepts` (exercício, conceito, peso). Leitura para todos os logados; escrita só professor.
3. **Migration `attempts`** (somente inserção, nunca editada): id, `user_id`, `exercise_id`, `created_at`, `passed`, `kind`, `answer` (texto/JSON: código enviado, alternativa marcada ou lacunas), `tests_passed`, `tests_total`, `error_category` (`sintaxe`, `execucao`, `tempo`, `saida_incorreta`, `escolha_incorreta`, `lacuna_incorreta`, ou nulo se acertou), `misconception` (texto, nulo se não houver), `duration_ms`, `mode` (`livre`, `atividade`, `avaliacao`) e `assignment_id` (nulo por enquanto). Índices por usuário, exercício e conceito.
4. **Função `record_attempt`** (SECURITY DEFINER) que valida os dados e insere a tentativa do próprio aluno. Sem INSERT direto na tabela. O aluno lê as próprias tentativas; o professor lê as dos alunos das suas turmas.
5. **Alternativas com `misconception`**: o campo `config.options` das questões de escolha passa a aceitar, de forma **opcional e compatível**, um formato com texto + rótulo da confusão. O formato antigo (lista de textos) continua válido.
6. **Executor (`src/lib/runner.ts`)** devolve a categoria de erro (sintaxe, execução, tempo, saída incorreta), e o `ExerciseView` chama `record_attempt` a cada envio (sem travar a tela se a gravação falhar).
7. **Tipos e funções puras** em `src/lib/` para ler os novos campos, com testes.

## Regras específicas
- Registrar a tentativa **não** pode alterar o cálculo atual de XP, medalhas ou sequência.
- Tentativas anteriores à E1 **não existem**: não inventar histórico.
- Tamanho: limitar o campo `answer` (por exemplo 4000 caracteres) para não estourar o plano gratuito de 500 MB. Registrar no README uma estimativa de crescimento.
- Se a migration ainda não foi aplicada, o site segue funcionando e apenas não registra tentativas.

## Critérios de pronto
- [ ] Testes de banco (PGlite): aluno só lê as próprias tentativas; professor só as dos seus alunos; ninguém insere/edita/apaga direto; `record_attempt` rejeita dados inválidos e exercício inexistente; `setup-completo.sql` regenerado e testado.
- [ ] Testes de unidade das funções novas; `lint`, `tsc`, `test`, `build`, `e2e` verdes.
- [ ] E2E: enviar uma resposta certa e uma errada de cada tipo grava as tentativas esperadas (com mock do Supabase).
- [ ] O usuário sabe que precisa rodar a migration no Supabase (com instruções).

## Ao terminar
Pare e mostre: o esquema novo (um diagrama em texto), o que foi testado e o passo manual.
