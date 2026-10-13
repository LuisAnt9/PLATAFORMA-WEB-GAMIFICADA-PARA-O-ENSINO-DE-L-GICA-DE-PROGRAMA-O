// Gerado a partir do conteúdo da migration 0006. Soluções de referência dos exercícios de código extras.
export const extraSolutions: Record<string, string> = {
  quadrado: "function quadrado(n) { return n * n; }",
  "media-ponderada":
    "function mediaPonderada(a, b) { return (a * 3 + b * 7) / 10; }",
  "dentro-do-intervalo":
    "function dentroDoIntervalo(n, min, max) { return n >= min && n <= max; }",
  "tipo-de-triangulo":
    "function tipoTriangulo(a, b, c) { if (a === b && b === c) return 'equilatero'; if (a === b || a === c || b === c) return 'isosceles'; return 'escaleno'; }",
  "soma-dos-pares":
    "function somaPares(n) { let s = 0; for (let i = 2; i <= n; i += 2) s += i; return s; }",
  potencia:
    "function potencia(base, exp) { let r = 1; for (let i = 0; i < exp; i++) r *= base; return r; }",
  "conta-digitos":
    "function contaDigitos(n) { let c = 1; while (n >= 10) { n = Math.floor(n / 10); c++; } return c; }",
  mdc: "function mdc(a, b) { while (b !== 0) { const r = a % b; a = b; b = r; } return a; }",
  "conta-pares":
    "function contaPares(v) { let c = 0; for (const x of v) if (x % 2 === 0) c++; return c; }",
  "media-do-vetor":
    "function mediaVetor(v) { let s = 0; for (const x of v) s += x; return s / v.length; }",
  "segundo-maior":
    "function segundoMaior(v) { let a = -Infinity, b = -Infinity; for (const x of v) { if (x > a) { b = a; a = x; } else if (x < a && x > b) { b = x; } } return b; }",
  "maior-de-dois": "function maiorDeDois(a, b) { return a > b ? a : b; }",
  hipotenusa: "function hipotenusa(a, b) { return Math.sqrt(a * a + b * b); }",
  "inverter-texto":
    "function inverterTexto(s) { let r = ''; for (let i = s.length - 1; i >= 0; i--) r += s[i]; return r; }",
  "conta-vogais":
    "function contaVogais(s) { let c = 0; for (const ch of s) if ('aeiou'.includes(ch)) c++; return c; }",
  palindromo:
    "function ehPalindromo(s) { for (let i = 0, j = s.length - 1; i < j; i++, j--) if (s[i] !== s[j]) return false; return true; }",
};
