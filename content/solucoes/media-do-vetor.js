function mediaVetor(v) {
  let s = 0;
  for (const x of v) s += x;
  return s / v.length;
}
