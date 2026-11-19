function pares(n) {
  const resultado = [];
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      resultado.push(i);
    }
  }
  return resultado;
}
