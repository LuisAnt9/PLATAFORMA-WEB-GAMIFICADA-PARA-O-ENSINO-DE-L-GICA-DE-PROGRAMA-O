function ehPrimo(n) {
  if (n < 2) {
    return false;
  }
  let primo = true;
  for (let i = 2; i < n; i++) {
    if (n % i === 0) {
      primo = false;
      break;
    }
  }
  return primo;
}
