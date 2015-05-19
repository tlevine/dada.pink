description: Why I made it, how I use it, and what it has to do with dada
-------------------
Vlermv
=========
Here are some notes for a talk I gave on
`vlermv <https://pypi.python.org/pypi/vlermv>`_,
originally at `PyGrunn <http://www.pygrunn.org/>`_ on
May 22, 2015.

There are also `slides <?slides>`_.

About Tom
------------

    Python for ten years

I have been writing Python for about ten years.

    Traveling but not sight-seeing

I'm traveling around Europe for a couple months, but I find that
I prefer computering over sight-seeing. While walking through beautiful
Swedish woods a few weeks ago, I realized that I would rather be sitting
in a hackerspace.

    First Python conference

PyGrunn is my first Python conference! I think.

Dada
^^^^^^^^^^^^
One day, I read the Dada Manifesto. It spoke to me. From then on, I have
been a dada artist rather than a data scientist.

Here I am making CSV files by hand on letterpress. This is how they made
computer-readable spreadsheets in the good-old analog days.

.. image:: /!/print-formaldehyde/csv-print-square.jpg

I also make music from spreadsheets.

.. image:: /!/sheetmusic/sheetmusic-side-by-side-highlighted-rowbeat.png

Each beat in the music corresponds to a row in the spreadsheet.

Data
^^^^^^^^^^^^^^^^
Dada art doesn't pay, of course. If I'm making money, I'm doing
`data </!/data/>`_.

* Acquire data
* Model/predict/learn stuff
* Present findings

As you'll see later on, much of my work involves acquiring
data from various sources and using it in ways that weren't
intended.

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

    `Vlermv <https://pypi.python.org/pypi/vlermv>`_

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

    # vlermv['filename'] -> '/tmp/a-directory/filename'
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

::

    >>> open('needle', 'rb').read()
    b'\x80\x03\x88.'

You can switch this to JSON, for example. ::

    import json
    from vlermv import Vlermv
    vlermv = Vlermv('./', serializer = json)
    vlermv['needle'] = True

Now ``./needle`` contains the JSON encoding of ``True``.

::

    >>> open('needle', 'rb').read()
    b'true'

Serializers are usually just anything with ``load`` and ``dump`` methods.
More are available in this module. ::

    vlermv.serializers

They can optionally have two other attributes that relate to other
features of Vlermv; you can read about this in the Vlermv documentation.

Transformers
^^^^^^^^^^^^^^^^^^^^^^
The other pluggable thing is transformers. In the present example, ::

    from vlermv import Vlermv
    vlermv = Vlermv('./')
    vlermv['needle'] = True

``True`` is saved to ``./needle``.

    "needle" -> "./needle"

The transformer is responsible for deciding that this is how the key
turns into a file. Here are some other keys. ::

    vlermv['haystack/needle']
    vlermv[('mango', 'apple', 'orange', 'banana')]
    vlermv[datetime.date.today()]

Here's how the default magic transformer handles these keys. :: 

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

    That's all there is to transformers!

That's all you need to know in order to write your own transformers,

::

    vlermv.transformers

and you can also use the included ones.


Review so far
^^^^^^^^^^^^^^^^
So far, I have been telling you how vlermv works.

    How vlermv works

The main concepts are


* Dict-like Vlermv
* Serializers
* Transformers

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

vlermv.cache takes the usual vlermv.Vlermv arguments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
For example, I can pass transformers. ::

    @vlermv.cache(DIR, 'directory', key_transformer = int_transformer)
    def directory(timestamp):
        url = 'http://spaceapi.net/directory.json'
        return requests.get(url, headers = HEADERS)

(``int_transformer`` is a custom transformer.)

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

    Dada

I write new packages all the time, and naming them is a lot of work.
I have adopted the dadaist practice of making up words. It is so much
easier. I just bang on the keyboard and tweak the results until I get
something that is vaguely pronouncable.

    (Imagine Tom pounding on his keyboard.)

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

And this is how I wound up with the name "vlermv".

    Back to the show

Thanks for indulging me in this tangent. Let's get back to the main event.


Review so far
^^^^^^^^^^^^^^^^

1. How vlermv works
2. **How I use it**
3. How it relates to testing and debugging
4. Interesting parts of the implementation
5. When to use other tools instead

How I use Vlermv
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

::

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
that ``feed``,

::

    # The response that caused the error is in this vlermv
    usace.public_notices.download.feed

from ``for link in parse.feed(download.{feed}(str(site)))``
is a function cached with vlermv and that it is defined in the module
``usace.public_notices.download`` as ``feed``.

To inspect the vlermv, open another console, and type this. ::

    from usace.public_notices.download import feed

``feed`` is a vlermv, so now I can look at the data however I like. ::

    print(list(feed.keys()))

This query is wound up uncovering the problem. ::

    print(feed[('461',)])

You can also open the file in normal Python. ::

    with open('~/usace-public-noties/feed', 'rb') as fp:
        response = pickle.load(fp)

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

Mocking your database
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Because a vlermv looks like a dictionary, you can mock vlermvs with
dictionaries. Consider the following query. ::

    def mean_field(db, field, keys):
        xs = (db[key].get(field) for key in keys)
        return sum(filter(None, xs)) / len(keys)

Ordinarily, we might use it like this. ::

    db = Vlermv('db')
    people = ['Tom', 'Suzie', 'Carol']
    print(mean_field(db, 'shoe-size', people))

It would be nice not to create so many files in our tests, so we can
mock the database like this. ::

    db = {'Tom': {'shoe-size': 43},
          'Suzie': {'shoe-size': 39},
          'Carol': {},
          'Chris': {'shoe-size': 46}}

    def test_mean_field():
        people = ['Tom', 'Suzie', 'Carol']
        assert mean_field(db, 'shoe-size', people) == 41

Review so far
^^^^^^^^^^^^^^^^

1. How vlermv works
2. How I use it
3. How it relates to testing and debugging
4. **When to use other tools instead**
5. Interesting parts of the implementation

When to use other tools instead
----------------------------------------------
Other things are often more appropriate than Vlermv. Let's review Vlermv's
main features and then discuss other tools that provide similar things.

1. Easily serialize Python objects.
2. Produce a legible filesystem.
3. Navigate directories simply.
4. It's a "database" but doesn't run its own process.

Other libraries, even standard Python libraries, provide some of these features.

Serialize with shelve
^^^^^^^^^^^^^^^^^^^^^^^^^

Shelve is a key-value store, where the values are Python objects that
can be pickled. ::

    d = shelve.open(filename)
    d[key] = data

A main difference between shelve and vlermv is that shelve stores everything
in one file. This has implications for performance, durability, and thread
safety.

Compose paths with pathlib
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I only just recently learned of pathlib. It is so much easier to use than
``os.path``. ::

    from pathlib import Path
    p = Path('/etc')
    q = p / 'init.d' / 'reboot'
    print(list(p.glob('**/*.py')))

Vlermv abstracts path manipulation for you. If you want to compose paths
easily but don't care for this abstraction, try pathlib.

Databases without servers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Vlermv stores complicated stuff and can access the stuff from other processes;
it's a "database", maybe.

Many databases run another service, which you might not like for whatever
reason. The reason is often that you don't want another thing to think about,
and that's totally reasonable.

    Databases with servers: PostgreSQL, MongoDB

Vlermv doesn't run its own server, and other databases do this too.

    Database without servers: SQLite, LevelDB

So consider SQLite and LevelDB if you just want a database without a server.
There are lots of reasons to choose these over Vlermv.

    Vlermv is slow
    
I did not try very hard to make Vlermv fast. This is the most obvious reason
to prefer something else.

    Vlermv is a Python library, only

Other databases have libraries in several languages. Vlermv is only in
Python. You can still access the files from other languages, but you might
wind up writing your own library to assist in that.

The advantage that Vlermv might have over these other databases is that
it might be easier to use.

    SQLite and LevelDB APIs may be less convenient.

Do use Vlermv if it is exactly what you want, but consider other things
if it isn't quite what you want.

On the overuse of fancy databases
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
People talk about fancy databases a lot. Nowadays it's usually something
like Mongo, previously it might have been MySQL. While they can be mildly
annoying, they are very helpful in the appropriate context.

    Fancy databases are powerful

They are highly optimized monsters that can handle lots of connections at
once without breaking or slowing down too much.

    Do you really need the power?

These optimizations are helpful if you care for them, but you often don't
need them. Fancy databases add complexity to your software, and simpler
software is easier to maintain.

Fanyc databases are good for storing and accessing complicated data really quickly.

    Good if you need speed and complex queries

Let's consider Mongo,

    Mongo is popular.

a popular database that shares many similarities with Vlermv.

    Mongo is fast and stuff.

It can handle complex data and complex queries at high speeds, but
I think that's not the reason why it's so popular.

    Why is Mongo so popular?

I think its popularity has a lot to do with the ease of creating a new mongo
database.

    Easy to start using

It's really easy. ::

    mongo [database name]

If you don't care for the speed or the complex queries, files are probably
easier to deal with. So why do people use Mongo?

    Why people use Mongo unnecessarily

I classify Mongo as a "fancy" database. Using it makes me feel fancy.

    Fanciness

Why is it so fancy?

1. Popular
2. Heavy marketing
3. New

Well, it's pretty popular, it's marketed pretty heavily, and it's reasonably
new. When you combine these, it's easy to feel pressure to use it.

    If you need high speed, distributed access, &c.,

If you need the fancy features,

    use a fancy database like Mongo.

If not,

    If you don't need high speeds, distributed access, &c.,

you can just use files.

    use files (or vlermv).


Review so far
^^^^^^^^^^^^^^^^

1. How vlermv works
2. How I use it
3. How it relates to testing and debugging
4. When to use other tools instead
5. **Interesting parts of the implementation**

Interesting parts of the implementation
----------------------------------------------

``__call__``
^^^^^^^^^^^^^^^^^^^^^^
In Python we define a function like this. ::

    def f(x):
        pass

And then we run them like this. ::

    f(8)

Interestingly, this is the same way that we instantiate an object. ::

    class g:
        pass

    g(8)

How does Python know what to do when it sees the parantheses?
Python checks the ``__call__`` method of an object. Functions and
types/classes have a ``__call__`` method. Ordinary objects don't,
but you can define one. ::

    class MetaFunction:
        def __call__(self, x):
            return x + 3

    function = MetaFunction()
    function(8)
    # 11

posixpath, macpath, ntpath
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I had heard of ``os.path`` but not of ``posixpath``, ``macpath``, ``ntpath``.
``os.path`` is simply an alias for the path library that is appropriate for
your system. ::

    >>> # On my (POSIX) computer
    >>> import os, posixpath
    >>> os.path == posixpath
    True

Parametrized decorators
^^^^^^^^^^^^^^^^^^^^^^^^^^^
``vlermv.cache`` is a function that creates a decorator. We could call
it a "parametrized decorator".
Every explanation I have seen of parametrized decorators makes them more
complicated than they need to be.

A decorator is simply a function that takes a function and returns a
new function. ::

    def decorate(func):
        def wrapper(*args, **kwargs):
            print('This %s function is wrapped.' % func.__name__)
            return func(*args, **kwargs)

    @decorate
    def f(x):
        return x + 3

The at-sign syntax is equivalent to this. ::

    def f(x):
        return x + 3
    f = decorate(f)

This made sense to me, but it took me a while to understand a parametrized
decorator. ::

    @meta_decorate('blah', 'blah', 'blah')
    def f(x):
        return x + 3

To parametrize the decorator, we simply write a function that returns
a decorator. ::

    decorate = meta_decorate('This function is wrapped.')

``decorate`` is now a decorator. ::

    @decorate
    def f(x):
        return x + 3

Said otherwise, these two are the same thing! ::

    @meta_decorate('blah', 'blah', 'blah')
    def f(x):
        return x + 3

    decorate = meta_decorate('This function is wrapped.')
    @decorate
    def f(x):
        return x + 3

This is what the definition of ``meta_decorate`` might look like. ::

    def meta_decorate(msg):
        def decorator(func):
            def wrapper(*args, **kwargs):
                print(msg)
                return func(*args, **kwargs)
        return decorator

Review
---------------
We talked about

1. How vlermv works
2. How I use it
3. How it relates to testing and debugging
4. Interesting parts of the implementation
5. When to use other tools instead

Alternatives to consider

* shelve, pickledb
* pathlib
* sqlite, leveldb

Some cool things I learned

* ``__call__``
* ``os.path``
* parametrized decorators

Roadmap for Vlermv
--------------------
Here are some future changes that I see for Vlermv.

I think the "cache" decorator needs a better name.

    ``vlermv.cache`` needs a better name

"cache" is a misleading name, as it implies that the result changes.
Perhaps "archive" is a better name. Tell me if you have suggestions.

I also think I could add some error messages to make debugging easier

    Debugging

But mainly, I just want to try using it in a few projects

    I want to use vlermv more.

I have gotten quite good at finding places where vlermv can make code
simpler.

    Can I put vlermv in your project?

I want to try putting vlermv in more projects, so that I may refine the
API further and develop more transformers and serializers. Do you have
a project that vlermv might help with? I would love to try putting vlermv in.

Roadmap for Tom
---------------------

    Looking for a place to sleep

I haven't figured out where I'm sleeping tonight, so tips are welcome.

End
-------------

::

    $ pip install vlermv
    $
    $ # https://thomaslevine.com
    $ # _@thomaslevine.com
    $ pip install tlevine




Appendix
====================

An example of vlermv.cache use
----------------------------------
Here is a more practical example. Here I have an RSS feed that I
download every day. I also have a bunch of articles; I download
each article once ever; I never download a second version of the
same article.

::

    @cache('~/.usace-public-notices/rss_feed')
    def rss_feed(date, site, max = 100000):
        # ...
        return requests.get(url, params = params)

    @cache('~/.usace-public-notices/article')
    def article(url):
        return requests.get(url)

cache
------------
On the first call, the decorated function checks the cache
for ``3``. It finds nothing, so it runs
the function and saves the result under the ``3``
key. On the next next two calls, the decorated function does find
``3`` in its cache, so it uses that rather than running the function.
On the fourth call, the decorated function finds no ``8``, so it
runs the function. ::

    function.__name__

(XXX I need to explain this more.)

By default, vlermv stores its files in a directory named after the function.
For example, this goes in "identity". ::

    @vlermv.cache()
    def identity(x):
        return x

But you can change that. ::

    @vlermv.cache('not-identity-directory')
    def identity(x):
        return x

(XXX Aside from this, ``cache`` has all of
the same arguments as vlermv, so we can pass any vlermv arguments to it.)

dada
--------

Just one more dada. Here we plot data as döner kebabs.

.. image:: /!/geom_doner/geom_doner.jpg

Each kebab is a make of car. Their positions form a scatterplot;
the x-axis is highway milage, and the y-axis is city milage.
The two in the bottom-left are spicy; this means that they have
automatic transmission. The one to the bottom-left is in bread,
rather than in a box; this means that it has four-wheel drive.

This plot uses all of the senses to convey multivariate data.
From this plot, we can taste, see, feel, smell, and hear that
manual transmission and two-wheel drive are associated with better
milage.
