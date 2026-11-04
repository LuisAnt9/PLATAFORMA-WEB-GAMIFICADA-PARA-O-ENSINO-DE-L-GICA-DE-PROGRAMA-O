# E10 — Ambiente do professor: atividades, avaliações e acompanhamento

> Antes de começar, leia `docs/plano/00-especificacao.md`. Depende da E8.

## Objetivo
Permitir ao professor atribuir **atividades para casa** e **avaliações**, e acompanhar as entregas, mantendo claramente separadas as três modalidades (livre, atividade, avaliação).

## Entregáveis

### Dashboard do professor
Turmas, alunos, atividades (atribuídas, pendentes, concluídas), taxa de conclusão, aproveitamento, alunos que precisam de atenção, conceitos com mais erro (E11 completa esta parte).

### Turmas e alunos
Criar, editar, excluir (com confirmação), **arquivar**; remover aluno; código de entrada (já existe). Perfil do aluno para o professor: progresso, mundos concluídos, tentativas, desempenho por conceito.

### Atividades para casa
Fluxo: selecionar turma → escolher exercícios (do conteúdo existente) → título → instruções → data de disponibilização → prazo → obrigatória ou não → publicar. Tabelas `assignments`, `assignment_items`, e relação com a turma, via migration com RLS. As tentativas feitas a partir da atividade gravam `mode = atividade` e `assignment_id`.

### Acompanhamento
Por atividade: quem iniciou, concluiu, não iniciou, entregou atrasado; pontuação, tentativas, tempo quando disponível; desempenho por exercício e por conceito.

### Avaliações (D6)
Professor seleciona questões **apenas dos tipos corrigidos no banco**, define pontuação, prazo e critérios. A correção acontece em **função do banco**, com o gabarito em tabela que o aluno **não consegue ler**. O aluno recebe a nota e o resultado conforme a regra escolhida pelo professor. Gravar `mode = avaliacao`.

### Conteúdo
O professor consulta mundos, lições e exercícios; cria atividades personalizadas; edita enunciados **de exercícios próprios**; o currículo oficial mantém estrutura padronizada.

## Critérios de pronto
- [ ] Testes de banco: aluno não vê gabarito de avaliação; aluno só entrega uma vez (ou conforme regra); professor só vê as próprias turmas; prazo respeitado no servidor.
- [ ] Atividade atribuída aparece em "Minhas atividades" do aluno, com prazo e situação.
- [ ] E2E do ciclo completo: professor cria atividade → aluno resolve → professor acompanha.
- [ ] Acessibilidade e responsividade conferidas; `lint`, `tsc`, `test`, `build`, `e2e` verdes.

## Ao terminar
Pare e mostre o ciclo completo com capturas e a lista de ações manuais (migrations).
