function maior(v) {
  let maior = v[0];
  for (let i = 1; i < v.length; i++) {
    if (v[i] > maior) {
      maior = v[i];
    }
  }
  return maior;
}
