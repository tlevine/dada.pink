# Static site generator usage
I wanted to find whether a site used a static site generator and, if so,
which one it used.

## GitHub Pages
It's easy to find the source code or sites that use GitHub Pages.

First, determine whether a site uses GitHub Pages.

    #!/bin/sh
    domain="$1"
    curl --head "http://$domain/"|grep 'Server: GitHub.com' > /dev/null

I saved the above file as `~/bin/is-gh-pages` and made it executable.

`~/bin` is in my `PATH` because I have this in my `~/.bash_profile`,

    export PATH="${PATH}:${HOME}/bin"

so I can do this.

    is-gh-pages thomaslevine.com
    is-gh-pages csv.nyc

Second, search for the source code. This search will find you the appropriate
files.

> in:/ $domain filename:CNAME

Here are the results for
[thomaslevine.com](https://github.com/search?utf8=%E2%9C%93&q=in%3A%2F+thomaslevine.com+filename%3ACNAME&type=Code)
and [csv.nyc](https://github.com/search?utf8=%E2%9C%93&q=in%3A%2F+csv.nyc+filename%3ACNAME&type=Code).

Note that there are several resulting repositories for thomaslevine.com
even though none of them are served from GitHub pages; they used to be.

You unfortunately can't do this from the API, as one is required to specify a
[user, organization, or repository](https://developer.github.com/changes/#new-validation-rule).
That is, the following query produces an error.

> [https://api.github.com/search/code?q=in:/+csv.nyc+filename:CNAME](https://api.github.com/search/code?q=in:/+csv.nyc+filename:CNAME)

The first result seems to be good enough.

## Listing the sites to check.
Then I needed to list which sites to check.

This gets them from my shell alias file.

    #!/bin/sh
    sed 's/[^<]*<\([^@]*\)@\([^>]*\)>.*/\2/' ~/.mutt/aliases/people | sort -u

Call it `~/bin/mutt-alias-domains`.

## Putting everything together
I wrote up the GitHub stuff
[more cleanly](http://dada.pink/find-static-websites/github.py).
I installed it

    wget -O ~/bin/find-gh-pages-repositories http://dada.pink/find-static-websites/github.py
    chmod +x ~/bin/find-gh-pages-repositories

and then ran this.

    mutt-alias-domains | find-gh-pages-repositories > gh-pages.csv
