function regressiva(n) {
  let texto = "";
  for (let i = n; i >= 1; i--) {
    texto += (texto === "" ? "" : " ") + i;
  }
  return texto;
}
