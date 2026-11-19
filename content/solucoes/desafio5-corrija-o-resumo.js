function resumo(n) {
  let soma = 0;
  let pares = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      pares++;
      continue;
    }
    soma += i;
  }
  return soma + " " + pares;
}
