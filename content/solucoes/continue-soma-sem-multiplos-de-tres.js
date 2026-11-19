function somaSemMultiplosDeTres(n) {
  let soma = 0;
  for (let i = 1; i <= n; i++) {
    if (i % 3 === 0) {
      continue;
    }
    soma += i;
  }
  return soma;
}
