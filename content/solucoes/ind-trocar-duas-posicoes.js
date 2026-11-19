function trocar(v, i, j) {
  const auxiliar = v[i];
  v[i] = v[j];
  v[j] = auxiliar;
  return v;
}
