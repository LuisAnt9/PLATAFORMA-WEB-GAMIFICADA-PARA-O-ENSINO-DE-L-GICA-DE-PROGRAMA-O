function contarPares(n) {
  let pares = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      pares++;
    }
  }
  return pares;
}
