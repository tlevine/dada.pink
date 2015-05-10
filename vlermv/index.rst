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
