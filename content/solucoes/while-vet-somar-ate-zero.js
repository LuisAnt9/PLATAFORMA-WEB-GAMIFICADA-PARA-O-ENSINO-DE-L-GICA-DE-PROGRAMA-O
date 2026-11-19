function somarAteZero(v) {
  let i = 0;
  let soma = 0;
  while (i < v.length && v[i] !== 0) {
    soma += v[i];
    i++;
  }
  return soma;
}
