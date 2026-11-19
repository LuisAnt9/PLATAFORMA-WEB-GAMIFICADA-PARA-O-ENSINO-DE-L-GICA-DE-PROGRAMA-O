function crescente(v) {
  let i = 1;
  while (i < v.length && v[i] > v[i - 1]) {
    i++;
  }
  return i >= v.length;
}
