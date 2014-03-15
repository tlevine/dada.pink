The following directories or symlinks to directories should
be present on each general-purpose computer.

* ``~/git/`` contains git repositories.
* ``~/safe/`` contains data that will be sychronized via
  rsync with the computer called "safe".
* ``~/bigdada/`` contains data that will be synchronized via
  rsync with the computer called "nsa".

You can see this as corresponding with four groups.

* Private stuff in a git repository goes to ``~/git/``
* Public stuff in a git repository also goes to ``~/git/``
* Private stuff with rsync backup goes in ``~/safe/``
* Public stuff with rsync backup goes in ``~/bigdada/``

These directories are divided by their permissions and means of
synchronization, but they should be seen as having one namespace.
If a project called "cloud-beds" has a small git repository but
produces lots of large files, it should store the git repository
in ``~/git/cloud-beds/`` and the large files in ``~/bigdada/cloud-beds/``
(if they're public) or ``~/safe/cloud-beds/`` (if they're private).

The directories on the "safe" computer are a bit different;
they're just ``~/git/`` (for private git) and ``~/rsync/``
(for private rsync).

The directories for "nsa" are also a bit different, because it
functions as both a general-purpose computer and as a server of
git and HTTP. In addition to the aforementioned directiories,
"nsa" contains ``~/smalldada.thomaslevine.com/``, which stores
public git repsositories, and ``~/bigdada.thomaslevine.com/``,
which stores public big stuff.
