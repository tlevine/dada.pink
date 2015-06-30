# When to use fancy databases
Databases are abstractions on top of files with lots of fancy features
to help you store things efficiently, find things quickly and easily,
not break your file structure, share things between computers, and do
many other things.

## Simplicity and files
I like to write programs that are very simple and robust. My rule of
thumb is that someone else should be able to figure out how my data
are encoded if he or she has the data but not the program nor the
documentation.

If I store my data in a fancy database, the person who wants to use
my program needs to have some understanding of that database, which
is not guaranteed even if the person programs a lot. On the other hand,
most people who use computers these days have some concept of how files
work, even if they don't consider themselves programmers at all.

This is also for myself; I expect myself to forget how everything I
wrote works, and I expect my documentation to be incomplete, so it has
to be easy to reverse-engineer.

I also like to reuse good software. We have several decades of Unix-style
software for managing files, and we have fewer decades of software for
managing data in each particular database format.

## When to use databases
Databases are very popular. But I like [files](/!/vlermv/) too.

That is,
I like implementing my own minimal abstractions for accessing files
rather than using things like PostgreSQL, Redis, and Mongo.

In the end, databases are interfaces for editing these files


Interfacing with databases is usually a bit easier than interfacing
with files, so databases are usually a good place to start, regardless
of your application.

This is when it's good.

2. If you have lots of unpredictable reads and writes by many different processes
3. For interactive querying


## Specific situations where databases are overused

If not, then this:
Once you start to optimize, there's a good chance that it will be easier
in the long run to develop your own minimal database, with only


## Why people overuse databases
Not finished...
