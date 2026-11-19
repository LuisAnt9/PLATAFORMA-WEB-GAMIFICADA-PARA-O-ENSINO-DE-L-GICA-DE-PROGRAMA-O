function somarImpares(n) {
  let i = 0;
  let soma = 0;
  while (i < n) {
    i++;
    if (i % 2 === 0) {
      continue;
    }
    soma += i;
  }
  return soma;
}
