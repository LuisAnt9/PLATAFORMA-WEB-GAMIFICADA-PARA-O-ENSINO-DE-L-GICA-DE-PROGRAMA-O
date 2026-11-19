function posicaoDe(v, x) {
  let i = 0;
  while (i < v.length && v[i] !== x) {
    i++;
  }
  return i < v.length ? i : -1;
}
