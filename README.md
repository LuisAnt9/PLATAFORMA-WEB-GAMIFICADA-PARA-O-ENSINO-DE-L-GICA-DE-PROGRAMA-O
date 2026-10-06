# Lógica Gamificada

Plataforma web gamificada para o ensino de lógica de programação (TCC — IFPI Campus Picos, ADS).

## Rodando localmente

```bash
npm install
npm run dev     # http://localhost:3000
```

Outros comandos: `npm run lint`, `npm test`, `npm run build`.

## Estado atual

- Trilha de 17 exercícios em JavaScript, organizada em 4 módulos (`src/lib/exercises.ts`).
- Correção automática no navegador, em Web Worker com limite de 2 s (`src/lib/runner.ts`).
- Feedback imediato por caso de teste.
- Gamificação: XP, níveis e medalhas (`src/lib/gamification.ts`). Cada medalha declara a dificuldade de aprendizagem a que responde.
- Editor com destaque de sintaxe (CodeMirror) e atalho Ctrl+Enter.
- Testes automatizados (Vitest): regras de gamificação e validação de todos os exercícios contra soluções de referência.
- Progresso salvo provisoriamente no `localStorage`.

## Próximos passos

1. Banco de dados e autenticação (aluno/professor).
2. Ranking.
3. Painel do professor (criar exercícios, acompanhar a turma).
4. Questionários SUS e Likert para a avaliação.
