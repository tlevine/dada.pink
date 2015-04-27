# Examining source code of sites on GitHub Pages
I wanted to find whether a site used a static site generator and, if so,
which one it used.

## GitHub Pages
It's easy to find the source code or sites that use GitHub Pages.

    curl --head http://csv.nyc/|grep 'Server: GitHub.com'

