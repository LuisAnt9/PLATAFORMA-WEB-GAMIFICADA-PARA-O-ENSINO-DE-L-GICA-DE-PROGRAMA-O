function contarDigitos(n) {
  let digitos = 0;
  while (n > 0) {
    n = Math.floor(n / 10);
    digitos++;
  }
  return digitos;
}
