title: Configuring web servers
description: How to ask for help, because you're definitely going to be confused
-----------------------
# Configuring web servers: Asking questions
Do you want to host a website? If yes, you might wind up configuring a
web server, like Apache or Nginx. Unfortunately, you are going to get it
wrong the first 100 times you try, and you are going to have no idea why.
Fortunately, someone else will know exactly why you got it wrong and can
tell you the magic incantation that will do what you want.

If you're having trouble configuring your webserver, give up at figuring
it out yourself, and ask someone for help. Give the person lots of
information about what you want to do and what is going wrong, because
he or she will get very annoyed if you don't. The present article explains
how to ask for help without being annoying.

## The theory

## Examples to give

## Template
Fill out this template, and send it to whomever you're asking the question
to. Send it even if you're asking the person in person.

> Hi [person],
>
> I am having trouble configuring [Apache/Nginx/whatever]. This is what
> I want to happen.
>
> * When I go to http://thomaslevine.com, I should be redirected to
>   https://thomaslevine.com.
> * When I go to https://thomaslevine.com/blah, files should be served
>   from /blah/blah.
> * ...
>
> In my present configuration, this is happening instead. [Explain, explain].
>
>     (Include any error messages that you see.)
>
> Here are the relevant configuration files.
>
>     # apache.conf, nginx.conf, &c. goes here.
>     # ...
>
> Could you tell me what I'm doing wrong or at least point me to an
> appropriate section of the manual? Thanks
>
> [Name]

If you don't feel like writing the whole letter, write it anyway.
If you insist on not writing the whole letter, then the explanation
of what is presently happening can be short. If it is absent,
the person(s) you're asking will probably get annoyed, and if it is short,
there's a chance the person(s) won't get annoyed.

## Where to ask
There are so many places that you could ask people. There's obviously
the Apache and Nginx IRC channels, mailing lists, &c., but you could probably
ask on pretty much any forum for communication about free software.
And you can ask people in person. As mentioned above, provide the above
letter even if you are asking in person.
