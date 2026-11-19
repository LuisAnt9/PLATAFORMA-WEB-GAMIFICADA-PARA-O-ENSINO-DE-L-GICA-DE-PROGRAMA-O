function contarMultiplos(n, k) {
  let contador = 0;
  for (let i = 1; i <= n; i++) {
    if (i % k === 0) {
      contador++;
    }
  }
  return contador;
}
