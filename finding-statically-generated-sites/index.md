# Examining source code of sites on GitHub Pages
I wanted to find whether a site used a static site generator and, if so,
which one it used.

## GitHub Pages
It's easy to find the source code or sites that use GitHub Pages.

First, determine whether a site uses GitHub Pages.

    #!/bin/sh
    domain="$1"
    curl --head "http://$domain/"|grep 'Server: GitHub.com' > /dev/null

I saved the above file as `~/bin/is-gh-pages`.

`~/bin` is in my `PATH` because I have this in my `~/.bash_profile`,

    export PATH="${PATH}:${HOME}/bin"

so I can do this.

    is-gh-pages thomaslevine.com
    is-gh-pages csv.nyc

Second, search for the source code. This search will find you the appropriate
files.

> in:/ $domain filename:CNAME

Here are the results for
[thomaslevine.com](https://github.com/search?utf8=%E2%9C%93&q=in%3A%2F+thomaslevine.com+filename%3ACNAME&type=Code&ref=searchresults)
and [csv.nyc](https://github.com/search?utf8=%E2%9C%93&q=in%3A%2F+csv.nyc+filename%3ACNAME&type=Code&ref=searchresults).

Note that there are several resulting repositories for the `thomaslevine.com`
even though none of them are served from GitHub pages; they used to be.

## Listing the sites to check.
Then I needed to list which sites to check.

This gets them from my shell alias file.

    #!/bin/sh
    sed 's/[^<]*<\([^@]*\)@\([^>]*\)>.*/\2/' ~/.mutt/aliases/people | sort -u

Call it `~/bin/mutt-alias-domains`.

Then I wanted to check all of them. I put this in `~/bin/is-gh-pages-many`.

    #!/bin/sh
    echo When a browser window opens, find the repository URL, and paste it here. > /dev/stderr
    echo You probably want to direct STDOUT to a file, like this.
    echo
    echo '  is-gh-pages-many > repositories.csv'
    echo
    echo Hit enter when you are ready.
    read
    echo domain,repository
    while test $# -gt 0; do
      domain="$1"
      if is-gh-pages "$domain"; then
        find-gh-pages-repository "$domain"
        read url
        echo "$domain,$url" > /dev/stdout
      fi
      shift
    done
