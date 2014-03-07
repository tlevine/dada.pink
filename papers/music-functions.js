function ionian(base, n) {
  var steps = [0, 2, 4, 5, 7, 9, 11, 12]
  var scale = []
  var i = 0
  while (i < n) {
    scale.push(base * Math.pow(2, (Math.floor(i/12) + steps[i]) * (1/12)))
    i ++
  }
  return scale
}
console.log(ionian(440, 8))
