function classificar(nota) {
  if (nota >= 7) {
    return "aprovado";
  } else if (nota >= 5) {
    return "recuperacao";
  } else {
    return "reprovado";
  }
}
