function primeiroPar(v) {
  for (let i = 0; i < v.length; i++) {
    if (v[i] % 2 === 0) {
      return v[i];
    }
  }
  return -1;
}
