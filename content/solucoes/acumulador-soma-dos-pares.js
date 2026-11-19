function somaDosPares(n) {
  let soma = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 2 === 0) {
      soma += i;
    }
  }
  return soma;
}
