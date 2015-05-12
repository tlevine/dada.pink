description: Why I made it, how I use it, and what it has to do with dada
-------------------
Vlermv
=========

About Tom
------------

    Python for ten years

I have been writing Python for about ten years.

    Traveling but not sight-seeing

I'm traveling around Europe for a couple months, but I find that
I prefer computering over sight-seeing.

    First Python conference

PyGrunn is my first Python conference! I think.

Dada
^^^^^^^^^^^^
One day, I read the Dada Manifesto. It spoke to me. From then on, I have
been a dada artist rather than a data scientist.

Here I am making CSV files by hand on letterpress. This is how they made
computer-readable spreadsheets in the good-old analog days.

.. image:: /!/print-formaldehyde/csv-print.jpg

I also make music from spreadsheets.

.. image:: /!/sheetmusic/sheetmusic-side-by-side-highlighted-rowbeat.png

Each beat in the music corresponds to a row in the spreadsheet.

Just one more dada. Here we plot data as döner kebabs.

.. image:: /!/geom_doner/geom_doner.jpg

Each kebab is a make of car. Their positions form a scatterplot;
the x-axis is highway milage, and the y-axis is city milage.
The two in the bottom-left are spicy; this means that they have
automatic transmission. The one to the bottom-left is in bread,
rather than in a box; this means that it has four-wheel drive.

    Multisensory and multivariate

This plot uses all of the senses to convey multivariate data.
From this plot, we can taste, see, feel, smell, and hear that
manual transmission and two-wheel drive are associated with better
milage.

Data
^^^^^^^^^^^^^^^^
Dada art doesn't pay, of course, so I still do other stuff too.
As you'll see later on, much of my work involves acquiring
data from various sources and using it in ways that weren't
intended. Here are some projects

    Anti-fraud

I looked for signs of fraud in projects financed by a bank

    Human interfaces for data cleaning

I built software tools to help an environmental organization collect,
clean, and link regulatory information.

Why Vlermv
----------------
Now, on with the show. I'm going to tell you about my library Vlermv.
Let's start with the motivation behind it.

I like files
^^^^^^^^^^^^^^^^

I like to store my data as ordinary files whenever I can. This
way, I'm not locked into a particular database software, I can
use ordinary file manipulation tools for debugging, and I don't
have to remember how my database works in order to look at my
data.

But accessing files is very verbose in Python!
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Python exposes many low-level APIs for writing files.
Here are some implications of that.

Low-level APIs yay!
^^^^^^^^^^^^^^^^^^^
Python has lots of wonderful low-level APIs for manipulating files,
and that allows us to design complex systems with very specialized,
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

1. Incomplete writes
2. Serialization
3. Filenames with slashes
4. Paths

First, it doesn't know how to recovery from incomplete writes
(if the program is killed during ``fp.write``).
Second, it can only serialize strings; it doesn't know about pickle or json.
Third, it can't handle filenames that contain slashes.
Fourh, it can't composing filenames or checking whether paths exist (os.path or pathlib).

I want to have all these things with less code than my sloppy version.

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
transformer does. ::

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

::

    vlermv.transformers

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

::

    vlermv.cache

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

> Dada

I write new packages all the time, and naming them is a lot of work.
I have adopted the dadaist practice of making up words. It is so much
easier. I just bang on the keyboard and tweak the results until I get
something that is vaguely pronouncable.

> picture of me smashing a keyboard?

Let me show you how the name "Vlermv" specifically came about. I use
the Dvorak keyboard. ::

    Dvorak keyboard
    ---------------
    ',.pyfgcrl/=\
     aoeuidhtns-
     ;qjkxbmwvz

My right hand was clearly a bit more energetic that day. ::

    "Vlermv"
    ---------------
            rl   
       e        
           m v 

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

Here is a more practical example. Here I have an RSS feed that I
download every day. I also have a bunch of articles; I download
each article once ever; I never download a second version of the
same article.

    @cache('~/.usace-public-notices/rss_feed')
    def rss_feed(date, site, max = 100000):
        # ...
        return requests.get(url, params = params)

    @cache('~/.usace-public-notices/article')
    def article(url):
        return requests.get(url)

How it relates to testing and debugging
----------------------------------------------
As I said earlier, impure functions scare me. That is, I don't like functions
that can give you different answers when you run this twice. Because of this,
I am scared of external services. Vlermv helps me cope with this.

Inspecting inputs
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Suppose we have an error in a function that depends on external data.
In debugging the error, it is usually nice to see the input data that
caused the error.

If you want to look at the contents of a vlermv in the console, open Python
shell and import the vlermv. Consider the following (abridged) exception

.. code-block:: python
   :emphasize-lines: 3

   Traceback (most recent call last):
     File "/home/tlevine/git/scott2/usace/public_notices/__init__.py", line 11, in public_notices
       for link in parse.feed(download.feed(str(site))):
     File "/home/tlevine/git/scott2/usace/public_notices/parse.py", line 10, in feed
       rss = parse_xml_fp(StringIO(response.text))
     File "/usr/lib/python3.4/xml/etree/ElementTree.py", line 1187, in parse
       tree.parse(source, parser)
     File "/usr/lib/python3.4/xml/etree/ElementTree.py", line 598, in parse
       self._root = parser._parse_whole(source)
   xml.etree.ElementTree.ParseError: syntax error: line 1, column 0

I happen to know, because I wrote the program that generated the traceback,
that :samp:`feed`,
from :samp:`for link in parse.feed(download.{feed}(str(site)))`
is a function cached with vlermv and that it is defined in the module
:samp:`usace.public_notices.download` as :samp:`feed`.

To inspect the vlermv, open another console, and type this. ::

    from usace.public_notices.download import feed

:samp:`feed` is a vlermv, so now I can look at the data however I like. ::

    print(list(feed.keys()))

This query is wound up uncovering the problem. ::

    print(feed[('461',)])

You can also open the file in normal Python. ::

    with open('~/usace-public-noties/feed', 'rb') as fp:
        response = json.load(fp)

Either way, the point is that we can easily access the crucial
data input.

Mocking external services
^^^^^^^^^^^^^^^^^^^^^^^^^^^
All of your responses from external services can instantly become quick
features for your tests. It's also good to write very simplified features
manually, but actual responses are good for checking that all of your
edge cases are covered.

When something breaks in the program because it received unexpected data,
find the appropriate file in the vlermv directory, copy it to a fixtures
directory, and load it in your tests like this. ::

    with open(os.path.join('package_name', 'test', 'fixtures', 'web-page'), 'rb') as fp:
        response = pickle.load(fp)

Now find whatever function failed at processing the ``response``, write
a test for that function with this fixture, and then figure out what's wrong.


Interesting parts of the implementation
----------------------------------------------

When to use other tools instead
----------------------------------------------

Related things
----------------

* pathlib
* shelve
