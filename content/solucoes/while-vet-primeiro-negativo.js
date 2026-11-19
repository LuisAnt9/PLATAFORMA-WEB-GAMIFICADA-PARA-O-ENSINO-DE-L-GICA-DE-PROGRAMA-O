function primeiroNegativo(v) {
  let i = 0;
  while (i < v.length && v[i] >= 0) {
    i++;
  }
  return i < v.length ? i : -1;
}
