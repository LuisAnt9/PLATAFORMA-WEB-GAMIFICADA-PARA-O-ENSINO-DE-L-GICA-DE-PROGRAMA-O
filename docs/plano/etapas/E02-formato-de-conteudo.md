# E2 — Formato de conteúdo, importador e validação

> Antes de começar, leia `docs/plano/00-especificacao.md`. Depende da E1 aplicada.

## Objetivo
Criar a forma de **escrever, versionar, validar e importar** centenas de exercícios sem digitar um a um no formulário, e migrar os 53 exercícios atuais para esse formato, já ligados a conceitos.

## Entregáveis

1. **Formato de conteúdo** em arquivos versionados: `content/mundo-N/licao-XX-slug.json` (ou `.md` com cabeçalho), contendo a lição (título, foco, `intro`, `example` com código comentado, `review`) e a lista de exercícios (tipo, dificuldade, enunciado, mini-explicação, dicas em níveis, conceitos, config, e **alternativas com `misconception`**). Documentar o formato em `content/README.md` com exemplos de cada tipo.
2. **Conceitos** em `content/conceitos.json` (slug, título, mundo), com os conceitos de todos os mundos (as listas estão nas etapas de conteúdo).
3. **Script de validação** (`npm run content:check`) que **falha** se:
   - exercício sem conceito, ou conceito inexistente;
   - questão de escolha com alternativa errada sem `misconception` (para as lições marcadas como "diagnósticas");
   - exercício de código sem solução de referência, ou cuja solução **não passa nos próprios testes**, ou cujos testes não **reprovam** o código inicial;
   - gabarito ambíguo (mais de uma alternativa correta), lacunas sem resposta, ids duplicados;
   - texto vazio, enunciado maior que o limite do banco.
4. **Importador** (`npm run content:build`) que gera uma migration SQL idempotente (`insert ... on conflict do update`) a partir de `content/`, para o usuário colar no SQL Editor. Nunca sobrescrever exercícios que o professor editou à mão no painel: tratar conflitos explicitamente (por exemplo, só atualizar o que veio do `content/` e marcar a origem).
5. **Migração dos 53 exercícios atuais** para o novo formato, mantendo os **mesmos ids** (o progresso dos alunos não pode se perder), ligados aos conceitos corretos e distribuídos nos mundos.
6. **Soluções de referência** em arquivo separado (`content/solucoes/`), usado só pelos testes. **Risco a registrar:** se o repositório for público, as soluções ficam públicas. Recomendar ao usuário tornar o repositório privado ou manter as soluções fora do git.

## Critérios de pronto
- [ ] `content:check` passa nos 53 exercícios e falha de propósito em casos de teste ruins (testes do próprio validador).
- [ ] `content:build` gera SQL que, aplicado sobre o banco de teste (PGlite), reproduz os 53 exercícios sem alterar ids.
- [ ] Documentação clara para o professor adicionar uma lição nova.
- [ ] `lint`, `tsc`, `test`, `build`, `e2e` verdes.

## Ao terminar
Pare e mostre um exemplo de lição completa no formato novo e o resultado do `content:check`.
