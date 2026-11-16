function situacao(nota) {
  let texto = "";
  if (nota >= 7) {
    texto = "aprovado";
  } else {
    texto = "reprovado";
  }
  return texto;
}
