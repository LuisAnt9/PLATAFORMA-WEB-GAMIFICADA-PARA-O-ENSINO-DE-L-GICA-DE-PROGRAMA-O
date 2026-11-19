function rotacionar(v) {
  if (v.length > 0) {
    v.push(v.shift());
  }
  return v;
}
