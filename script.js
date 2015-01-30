var headers
var i = 0
var slidesInitialized = false

function initSlides() {
  headers = document.querySelectorAll('h1,h2,h3,h4,img,ul,ol')
  for (var j = 0; j < headers.length; j++) headers[j].style = 'display: none;'
  var p = document.querySelectorAll('p')
  for (var j = 0; j < p.length; j++) p[j].style = 'display: none;'
  slidesInitialized = true
}
function nextSlide() {
  if (!slidesInitialized) initSlides()

  if (i == 0) {
    headers[i].style = ''
    headers[i]++
  } else if (i < headers.length) {
    headers[i].style = ''
    headers[i]++
    headers[i].style = 'display: none;'
  } else {
    headers[i].style = ''
    i = 0
  }
}
window.addEventListener('keypress', function (ev) { if (ev.keyCode === 80) nextSlide()})
