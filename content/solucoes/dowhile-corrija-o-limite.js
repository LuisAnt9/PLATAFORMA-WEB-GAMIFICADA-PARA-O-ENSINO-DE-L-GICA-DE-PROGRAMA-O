function contarAte(n) {
  let i = 1;
  let texto = "";
  do {
    texto += (texto === "" ? "" : " ") + i;
    i++;
  } while (i <= n);
  return texto;
}
