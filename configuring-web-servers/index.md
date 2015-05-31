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
You are going to write a letter with these parts.

1. Explanation of what you want to happen
2. Your current configuration files
3. What is happening now
4. A request for a very tiny bit of help

The hardest part is the explanation of what you want to happen. If you
don't know how to do this, it will take you a while to write, and it still
won't make sense to anyone. Let's talk about that!

## Come up with examples
If you are trying to configure something very complicated, your explanation
won't make sense even if you do know what you're doing. Fortunately, you are
probably setting up something quite typical, and you can probably explain
what you want by anwering three simple questions.

You are going to come up with a few examples to explain how your site should
work. Each example is a thing that happens when you type something into your
web browser; for each example, you must answer these questions.

1. What URL do I type into my browser? This should be the full URL, not just
  the domain name.
2. Should I get redirected to a different URL? If yes, to what URL?
3. If I shouldn't be redirected, what file or application should be served?
   * If it's a file, there's a good chance that it will have an extension like
       "html", "js", or "css".
   * Applications are really files too, so determine the directory or file
       that the application is in and mention what languages and libraries
       it uses.

To show the example to other people, you can probably just write out your
answers to the questions. You can sometimes make your answer more concise
by omitting question two. If the answer to the second question is "no", you
don't have to mention redirects; by answering the third question, you imply
that there should be no redirect.

If the behavior you desire is more complicated, you must still include these
things. After that, you should add further explanation of what you want.

Come up with enough examples that you think people will understand what you
want. It is quite likely that one example will be enough.

## Template
Fill out this template, and send it to whomever you're asking the question
to. Send it even if you're asking the person in person.

> Hi [person],
>
> I am having trouble configuring **[Apache/Nginx/whatever]**. This is what
> I want to happen.
>
> * When I go to http://thomaslevine.com, I should be redirected to
>     https://thomaslevine.com.
> * When I go to https://thomaslevine.com/blah, the file
>     /blah/blah/index.html should be served.
> * ...
>
> Here are my present versions of the relevant configuration files.
>
>     # apache.conf, nginx.conf, &c. goes here.
>     # ...
>
> With this configuration, this **[explain, explain]** is happening instead.
>
>     [Include any error messages that you see.]
>
> Could you tell me what I'm doing wrong or at least point me to an
> appropriate section of the manual? Thanks
>
> **[Name]**

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
