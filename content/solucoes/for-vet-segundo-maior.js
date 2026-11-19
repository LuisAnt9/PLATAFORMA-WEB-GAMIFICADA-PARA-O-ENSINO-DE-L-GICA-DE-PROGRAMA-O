function segundoMaior(v) {
  let primeiro = -Infinity;
  let segundo = -Infinity;
  for (let i = 0; i < v.length; i++) {
    if (v[i] > primeiro) {
      segundo = primeiro;
      primeiro = v[i];
    } else if (v[i] > segundo) {
      segundo = v[i];
    }
  }
  return segundo;
}
