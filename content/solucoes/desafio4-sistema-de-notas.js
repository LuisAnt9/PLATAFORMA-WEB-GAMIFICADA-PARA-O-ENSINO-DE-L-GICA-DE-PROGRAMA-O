function sistemaDeNotas() {
  const n1 = Number(lerEntrada());
  const n2 = Number(lerEntrada());
  const n3 = Number(lerEntrada());
  const media = (n1 + n2 + n3) / 3;
  let situacao;
  if (media >= 7) {
    situacao = "Aprovado";
  } else if (media >= 5) {
    situacao = "Recuperação";
  } else {
    situacao = "Reprovado";
  }
  console.log("Média:", media);
  console.log("Situação:", situacao);
}
