function primeiroDivisor(n) {
  let divisor = n;
  for (let i = 2; i <= n; i++) {
    if (n % i === 0) {
      divisor = i;
      break;
    }
  }
  return divisor;
}
