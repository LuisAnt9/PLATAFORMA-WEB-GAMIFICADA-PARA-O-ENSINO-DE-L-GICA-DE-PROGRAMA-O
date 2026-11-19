function analisarTurma() {
  const quantidade = Number(lerEntrada());
  const notas = [];
  for (let i = 0; i < quantidade; i++) {
    notas.push(Number(lerEntrada()));
  }
  let soma = 0;
  let maior = notas[0];
  for (let i = 0; i < notas.length; i++) {
    soma += notas[i];
    if (notas[i] > maior) {
      maior = notas[i];
    }
  }
  const media = soma / notas.length;
  let acima = 0;
  for (let i = 0; i < notas.length; i++) {
    if (notas[i] > media) {
      acima++;
    }
  }
  console.log("Média:", media);
  console.log("Maior nota:", maior);
  console.log("Acima da média:", acima);
}
