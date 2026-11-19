function media(v) {
  let soma = 0;
  for (let i = 0; i < v.length; i++) {
    soma += v[i];
  }
  return soma / v.length;
}
