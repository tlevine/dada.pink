var headers
var i = 0
var slidesInitialized = false

function initSlides() {
  headers = document.querySelectorAll('h1,h2,h3,h4,img,ul,ol')
  headers.map(function(h) h.style = 'display: none;')
  document.querySelectorAll('p').map(function(p) p.style = 'display: none;')
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
