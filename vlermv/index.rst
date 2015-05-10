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
----------------

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

> `Vlermv <https://pypi.python.org/pypi/vlermv>`

My solution is `Vlermv <https://pypi.python.org/pypi/vlermv>`,
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

How I use it
----------------------------------------------

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
