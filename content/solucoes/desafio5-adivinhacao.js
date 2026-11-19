function adivinhar(segredo, tentativas) {
  for (let i = 1; i <= tentativas; i++) {
    const palpite = Number(lerEntrada());
    if (palpite === segredo) {
      console.log("Acertou! Tentativas: " + i);
      return;
    } else if (palpite < segredo) {
      console.log("O número é maior");
    } else {
      console.log("O número é menor");
    }
  }
  console.log("Fim de jogo! O número era " + segredo);
}
