function contagem(n) {
  let texto = "";
  for (let i = 1; i <= n; i++) {
    texto += (texto === "" ? "" : " ") + i;
  }
  return texto;
}
