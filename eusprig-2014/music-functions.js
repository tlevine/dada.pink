function ionian(base, n) {
  var steps = [0, 2, 4, 5, 7, 9, 11, 12]
  function freq(i) {
    return base * Math.pow(2, (Math.floor(i/12) + steps[i]) * (1/12))
  }
  var scale = []; for (var i = 0; i < n; i++) scale.push(i)
  return scale.map(freq)
}
console.log(ionian(440, 8))
