/** Versão do termo de consentimento e da política de privacidade. Mude ao alterar o texto: quem aceitou
 *  uma versão antiga é convidado a ler e aceitar de novo. */
export const TERMS_VERSION = "2026-11";

/** Política de privacidade em linguagem simples (mostrada em /privacidade). */
export const POLICY: { title: string; body: string[] }[] = [
  {
    title: "Quem somos e para que serve esta plataforma",
    body: [
      "Esta é uma plataforma de estudo de lógica de programação, feita como projeto de conclusão de curso (TCC) no IFPI, Campus Picos. Ela ajuda você a aprender e ajuda o professor a entender quais conceitos a turma ainda não compreendeu.",
    ],
  },
  {
    title: "Quais dados guardamos",
    body: [
      "Dados da conta: nome, e-mail e senha (a senha é guardada de forma protegida pelo serviço de login; nós não a vemos).",
      "Dados de estudo: os exercícios que você tenta e resolve, cada tentativa (o que você respondeu, se acertou, quanto tempo levou, qual dica usou e o tipo de erro), seus pontos, medalhas, missões e os dias em que praticou.",
      "Dados da turma: as turmas em que você entrou, as atividades e avaliações, e as suas entregas.",
      "Uso da dica com IA: quantas dicas você pediu e para quais exercícios.",
      "Respostas dos questionários de avaliação da plataforma (SUS e escala Likert), quando você decide responder.",
    ],
  },
  {
    title: "Para que usamos esses dados",
    body: [
      "Mostrar o seu progresso e liberar as lições.",
      "Permitir que o seu professor acompanhe a turma e veja quais conceitos precisam de revisão. O professor só vê as turmas dele.",
      "Pesquisa acadêmica do TCC: avaliar a usabilidade e a experiência de aprendizagem. Os resultados são apresentados de forma agregada, sem identificar você.",
      "Não vendemos nem compartilhamos seus dados com empresas, e não usamos para publicidade.",
    ],
  },
  {
    title: "Dica com inteligência artificial",
    body: [
      "Quando você pede uma dica com IA, o enunciado do exercício e o código ou a resposta que você escreveu são enviados ao Google (serviço Gemini) para gerar a dica. Não envie dados pessoais no código.",
      "Você pode desligar a dica com IA a qualquer momento no seu Perfil. Com ela desligada, nada é enviado ao Google.",
    ],
  },
  {
    title: "Quem pode ver o quê",
    body: [
      "Você vê só os seus dados. Colegas não veem seu progresso.",
      "O ranking é opcional: só aparece nele quem escolhe, e só para a própria turma, com o nome abreviado.",
      "O professor da turma vê o progresso e as tentativas dos alunos da turma dele.",
      "As respostas dos questionários podem ser anônimas (sem ligação com você) ou identificadas, conforme a sua escolha na hora de responder.",
    ],
  },
  {
    title: "Seus direitos e como exercê-los",
    body: [
      "Acessar e levar os seus dados: em Perfil, \"Baixar meus dados\" gera um arquivo com tudo que guardamos sobre você.",
      "Excluir a conta: em Perfil, \"Excluir minha conta\" apaga a conta e todos os seus dados (progresso, tentativas, medalhas, entregas e respostas identificadas). Respostas anônimas de questionários não têm ligação com você e, por isso, não podem ser localizadas nem apagadas.",
      "Corrigir o nome, desligar a dica com IA e sair do ranking: tudo em Perfil.",
    ],
  },
  {
    title: "Por quanto tempo guardamos",
    body: [
      "Enquanto a sua conta existir. Quando você a exclui, os dados são apagados na hora. Contas de estudantes sem uso por mais de 12 meses ao fim da pesquisa serão excluídas pelo responsável.",
    ],
  },
  {
    title: "Menores de 18 anos",
    body: [
      "Se você tem menos de 18 anos, é necessária a autorização de um responsável para participar, conforme orientação da instituição. No cadastro, informamos se você é maior ou menor de idade; o professor orientador cuida de colher a autorização do responsável.",
    ],
  },
  {
    title: "Onde os dados ficam",
    body: [
      "Em serviços de nuvem (Supabase para o banco de dados e o login, Vercel para o site), que podem armazenar dados fora do Brasil. As conexões são protegidas.",
    ],
  },
  {
    title: "Contato",
    body: [
      "Dúvidas ou pedidos sobre os seus dados: fale com o professor responsável pela disciplina ou pelo projeto.",
    ],
  },
];

/** Baixa um objeto como arquivo JSON (só no navegador). */
export function downloadFile(name: string, content: string, type: string) {
  const blob = new Blob([content], { type });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = name;
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(() => URL.revokeObjectURL(url), 1000);
}
