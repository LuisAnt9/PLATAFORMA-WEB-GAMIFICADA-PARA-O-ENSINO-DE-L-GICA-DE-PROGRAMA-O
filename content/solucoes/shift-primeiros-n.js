function retirarPrimeiros(v, n) {
  const retirados = [];
  for (let i = 0; i < n && v.length > 0; i++) {
    retirados.push(v.shift());
  }
  return retirados;
}
