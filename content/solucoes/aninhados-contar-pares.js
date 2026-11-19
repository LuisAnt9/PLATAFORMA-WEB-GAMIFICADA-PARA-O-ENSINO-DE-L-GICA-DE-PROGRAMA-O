function contarPares(n) {
  let pares = 0;
  for (let i = 1; i <= n; i++) {
    for (let j = i + 1; j <= n; j++) {
      pares++;
    }
  }
  return pares;
}
