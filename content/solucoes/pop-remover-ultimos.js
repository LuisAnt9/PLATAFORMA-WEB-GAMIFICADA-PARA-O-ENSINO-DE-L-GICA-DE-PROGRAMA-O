function removerUltimos(v, n) {
  for (let i = 0; i < n && v.length > 0; i++) {
    v.pop();
  }
  return v;
}
