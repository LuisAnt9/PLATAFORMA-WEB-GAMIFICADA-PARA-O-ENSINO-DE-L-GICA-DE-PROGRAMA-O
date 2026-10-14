# Testes de navegador (e2e)

Verificam, num Chromium de verdade, os fluxos de aluno e de professor e a acessibilidade.
O Supabase é **simulado** dentro do navegador (as chamadas à API são interceptadas), então não
precisam de conta, rede nem banco: servem para provar o comportamento do site, não o do Supabase
(o banco tem os seus próprios testes em `supabase/tests`).

## Como rodar

```bash
npm run build && npx next start -p 3100      # num terminal
npm run e2e                                    # em outro
```

Variáveis opcionais: `E2E_BASE_URL` (padrão `http://localhost:3100`), `CHROME_PATH` (caminho do
Chromium/Chrome) e `E2E_OUT` (onde guardar capturas e relatórios; padrão `e2e/.out`, ignorado pelo git).

## Suítes

| Arquivo | O que cobre |
|---|---|
| `turmas-e-alunos.mjs` | trilha, resolver exercício, entrar/sair de turma por código, área do professor restrita |
| `editor-de-codigo.mjs` | criar/editar exercício de código, validação com solução de referência, rascunho, reordenar, módulos |
| `analise-da-turma.mjs` | painel da turma: alertas, gráfico, grade de progresso, exercícios mais difíceis |
| `tipos-e-sequencia.mjs` | múltipla escolha, lacunas, sequência diária, medalha de constância e editor dos novos tipos |
| `acessibilidade.mjs` | axe-core (WCAG 2.2 AA) em 15 telas × celular/computador × claro/escuro, e rolagem horizontal |
