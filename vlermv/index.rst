description: Why I made it, how I use it, and what it has to do with dada
-------------------
Vlermv
=========

I like files
----------------

I like to store my data as ordinary files whenever I can. This
way, I'm not locked into a particular database software, I can
use ordinary file manipulation tools for debugging, and I don't
have to remember how my database works in order to look at my
data.

But accessing files is very verbose in Python!
----------------------------------------------------------

Low-level APIs yay!
^^^^^^^^^^^^^^^^^^^
Python has lots of wonderful low-level APIs for manipulating files,
and that allows us to design very systems with very specialized,
high-performance file access, with the appropriate trade-offs for our
application.


Low-level APIs boo!
^^^^^^^^^^^^^^^^^^^
Much of the time, however, we do not need all of these features.
The disadvantage of having so many separate components of filesystem
access is that any sort of filesystem access is very verbose.
Here's what it looks like if you do it sloppily. ::

    # Write
    with open(filename, 'w') as fp:
        fp.write(string)

    # Read
    with open(filename, 'r') as fp:
        fp.read()

As I said, this is the code for the *sloppy* version; here are some
features that it does not have.

1. Recovery from incomplete writes (if the program is killed during
   ``fp.write``)
2. Serialization (pickle, json, &c.)
3. Handling filenames that contain slashes
4. Composing filenames and checking whether paths exist (os.path or pathlib)

Making file access more concise
---------------------------------
As I said earlier, it is important in certain circumstances that you be
able to control the details of file access, and filesystem access needs
to be verbose. In many circumstances, however, we can use something
standard that works well most of the time. This is what I tried to do.

> `Vlermv <https://pypi.python.org/pypi/vlermv>`_

My solution is `Vlermv <https://pypi.python.org/pypi/vlermv>`_,
an open source
NoSQL database implemented as a Python library that lets me
pretend that my filesystem is a dictionary.
The present articles discusses the following.

1. How vlermv works
2. How I use it
3. How it relates to testing and debugging
4. Interesting parts of the implementation
5. When to use other tools instead

How vlermv works
----------------------------------------------

Basic usage
^^^^^^^^^^^^^^^^

The most basic use of Vlermv goes something like this. ::

    from vlermv import Vlermv
    vlermv = Vlermv('/tmp/a-directory')

``vlermv`` is now a dict-like object, so we can do things like this. ::

    vlermv['filename'] = range(100)

The keys correspond to file names, and the values get serialized to files.
The default serialization is pickle. ::

    import pickle
    range(100) == pickle.load(open('/tmp/a-directory/filename', 'rb'))

You can also get and delete things. ::

    # Read
    range(100) == vlermv['filename']

    # Delete
    del(vlermv['filename'])

And remember that vlermv is a dict-like object, so things
like this work too. ::

    vlermv.items()
    vlermv.update({'a': 1, 'b': 2})

Pluggable architecture
^^^^^^^^^^^^^^^^^^^^^^^^
Vlermv has the concepts of "serializers" and "transformers". You can
switch them or define your own.

Serializers
^^^^^^^^^^^^^^^^^^^^^^
I already alluded to serializers earlier. If you do something like this, ::

    from vlermv import Vlermv
    vlermv = Vlermv('./')
    vlermv['needle'] = True

vlermv stores a file ``./needle`` that is a pickle of the value ``True``.
You can switch this to JSON, for example. ::

    import json
    from vlermv import Vlermv
    vlermv = Vlermv('./', serializer = json)
    vlermv['needle'] = True

Now ``./needle`` contains the JSON encoding of ``True``.
Serializers are usually just anything with ``load`` and ``dump`` methods.
More are available in this module.

> vlermv.serializers

They can optionally have two other attributes that relate to other
features of Vlermv; you can read about this in the Vlermv documentation.

Transformers
^^^^^^^^^^^^^^^^^^^^^^
The other pluggable thing is transformers. In the present example, ::

    from vlermv import Vlermv
    vlermv = Vlermv('./')
    vlermv['needle'] = True

``True`` is saved to ``./needle``. What happens if we change that? ::

    vlermv['haystack/needle']
    vlermv[('mango', 'apple', 'orange', 'banana')]
    vlermv[datetime.date.today()]

The transformer is what decides how to map dictionary keys to file names.
The default magic transformer does this. 

    vlermv = Vlermv('./')
    vlermv['haystack/needle'] # ./haystack/needle
    vlermv[('mango', 'apple', 'orange')] # ./mango/apple/orange
    vlermv[datetime.date(2015,5,22)] # ./2015/5/22

But you can change that! For example, this is what the ``slash``
transformer does.

    vlermv = Vlermv('./',
        key_transformer = vlermv.transformers.slash)
    vlermv['haystack/needle'] # ./haystack/needle
    vlermv[('mango', 'apple', 'orange')] # error
    vlermv[datetime.date(2015,5,22)] # error

Transformers are objects with two methods.

* ``to_path`` (key to path)
* ``from_path`` (path to key)

Internally, paths are stored as tuples of strings, ::

    ('this', 'is', 'a', 'path')

Keys can be whatever you want; it's your responsibility to convert them.

> That's all there is to transformers!

That's all you need to know in order to write your own transformers,

> Included transformers: vlermv.transformers

and you can also use the included ones.

As a cache/archive
----------------------
A particular thing I often find myself wanting is to cache the results
of calls to external services. It scares me when repeated calls of the
same function give different results, so external services scare me.

I first wrote an early version of Vlermv in February 2014. It had only
the dictionary interface. To implement caching/archiving, I found myself
doing this a lot. ::

    v = Vlermv('/tmp/dir')
    def f(x):
        # ...
        if key not in v:
            return v[key]
        else:
            # ...
            v[key] = something
            return something

And then I abstracted this as the cache decorator.

To deal with that, I store whatever I get from the service, and I use
the ``cache`` decorator for this.

> vlermv.cache

Here's a very simple, contrived example of that. Define our function. ::

    import vlermv

    @vlermv.cache()
    def identity(x):
        print('This is running for the first time.')
        return x

What will this function do, ignoring the decorator? It will print
"This is running for the first time." and then return whatever was passed
to it. When we run it, this is what we get. ::

    In [1]: identity(3)                                               
    This is running for the first time.
    Out[1]: 3

    In [2]: identity(3)
    Out[2]: 3

    In [3]: identity(3)
    Out[3]: 3

    In [4]: identity(8)
    This is running for the first time.
    Out[4]: 8

On the first call, the decorated function checks the cache
for ``3``. It finds nothing, so it runs
the function and saves the result under the ``3``
key. On the next next two calls, the decorated function does find
``3`` in its cache, so it uses that rather than running the function.
On the fourth call, the decorated function finds no ``8``, so it
runs the function.

> function.__name__

By default, vlermv stores its files in a directory named after the function.
For example, this goes in "identity". ::

    @vlermv.cache()
    def identity(x):
        return x

But you can change that. ::

    @vlermv.cache('not-identity-directory')
    def identity(x):
        return x

Nota bene
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> ``cache`` needs a better name

Note that "cache" is a misleading name, as it implies that the result
changes. Perhaps "archive" is a better name. Tell me if you have suggestions.

An aside: Two hard things
--------------------------------
Before we talk about how I use Vlermv, let's talk about something totally
unrelated.

There are two hard things in computers, and I have addressed both of them
with Vlermv. Do you know what the two hard things in computers are?
They're

1. Cache invalidation
2. Naming things

I have already discussed the first of these. Let's talk about the second.

> Data

One day, I read the Dada Manifesto. It spoke to me. From then on, I have
been a dada artist rather than a data scientist.

> Dada

I write new packages all the time, and naming them is a lot of work.
I have adopted the dadaist practice of making up words. It is so much
easier. I just bang on the keyboard and tweak the results until I get
something that is vaguely pronouncable.

> picture of me smashing a keyboard?

Let me show you how the name "Vlermv" specifically came about. I use
the Dvorak keyboard.

.. blockquote::
    ',.pyfgcrl/=\
     aoeuidhtns-
     ;qjkxbmwvz

My right hand was clearly a bit more energetic that day.

.. blockquote::
    ',.pyfgc**rl**/=\
     ao**e**uidhtns-
     ;qjkxb**m**w**v**z

How I use it
----------------------------------------------
I use Vlermv through the ``cache`` decorator most of the time, and
usually for downloading web pages.
Let's say I'm download websites with simple GET
requests (like typing the URL into your browser bar). ::

    import vlermv, requests

    @vlermv.cache()
    def download_webpage(url):
        return requests.get(url)

Now, let's start downloading webpages. ::

    r1 = download_webpage('https://thomaslevine.com')
    r2 = download_webpage('https://thomaslevine.com')
    r1 == r2

On the first download, the decorated function checks the cache
for ``'https://thomaslevine.com'``. It finds nothing, so it runs
the function and saves the result under the ``'https://thomaslevine.com'``
key. On the next run, the decorated function does find
``'https://thomaslevine.com'`` in its cache, so it uses that rather
than running the function.

Here is a more practical example. I often have several functions that
I want to cache, and I want them all to go in the same directory. ::

    DIR = '~/.usace-public-notices'
    @cache(parent_directory = DIR)
    def rss_feed(date, site, max = 100000):
        # ...
        return requests.get(url, params = params)

    @cache(parent_directory = DIR)
    def article(url):
        return requests.get(url)

In this example, files for ``rss_feed`` go in
``~/.usace-public-notices/rss_feed/``,

> ``rss_feed`` -> ``~/.usace-public-notices/rss_feed/``

and files for ``article`` go in ``~/.usace-public-notices/article/``.

> ``article`` -> ``~/.usace-public-notices/article/``

The ``parent_directory`` flag allows me to still use the automatic naming
by function name.
I must say, I'm not particularly pleased with this interface, as I
think it's a bit confusing, and am still looking for a better way to do this.



How it relates to testing and debugging
----------------------------------------------

Interesting parts of the implementation
----------------------------------------------

When to use other tools instead
----------------------------------------------

Related things
----------------

* pathlib
* shelve
