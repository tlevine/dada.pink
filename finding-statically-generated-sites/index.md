# Examining source code of sites on GitHub Pages
I wanted to find whether a site used a static site generator and, if so,
which one it used.

## GitHub Pages
It's easy to find the source code or sites that use GitHub Pages.

    site=http://csv.nyc
    domain=$(echo "$site" | sed s/^https?:\/\//)
    if curl --head "$site"|grep 'Server: GitHub.com' > /dev/null; then
      echo "$site" is served from GitHub Pages.
      echo "I'm opening web searches for the source code."
      firefox "https://github.com/search?utf8=%E2%9C%93&q=in%3A%2F+$domain+filename%3ACNAME&type=Code&ref=searchresults"
    else
      echo "$site" is not served from GitHub Pages.
    fi
