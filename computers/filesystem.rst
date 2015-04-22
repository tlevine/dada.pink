Organization of the filesystem
===================================
The following directories or symlinks to directories should
be present on every computer.

* ``~/git/`` contains git repositories.
* ``~/safe/`` contains data that will be sychronized via
  rsync with the computer called "safe".
* ``~/nsa/`` contains data that will be synchronized via
  rsync with the computer called "nsa".

You can see this as corresponding with four groups.

* Private stuff in a git repository goes to ``~/git/``
* Public stuff in a git repository also goes to ``~/git/``
* Private stuff with rsync backup goes in ``~/safe/``
* Public stuff with rsync backup goes in ``~/nsa/``

These directories are divided by their permissions and means of
synchronization, but they should be seen as having one namespace.
If a project called "cloud-beds" has a small git repository but
produces lots of large files, it should store the git repository
in ``~/git/cloud-beds/`` and the large files in ``~/nsa/cloud-beds/``
(if they're public) or ``~/safe/cloud-beds/`` (if they're private).

The above structure is the case for all computers, even the weakest
security computer "nsa". nsa has a ``~/safe/`` directory for sensitive
things that nsa created, such as shell history files and wtmp logs.
The files in ``~/safe/`` are retrieved by a backup server that runs
minimal services.

Practical distinctions between the directories
------------------------------------------------
Files in git repositories get synchronized by git to a place specified
in the git configuration file for that particular repository. Usually,
the remotes include one that is either on "nsa" or "safe". If the remote
is on "nsa", the master branch will be checked out and served on
http://dada.pink (named ``http://dada.pink/$(repository-name)``).

Files in ``~/safe/`` and ``~/nsa/`` get synchronized to the appropriate
backup server by rsync. If they are sent to "nsa", they are also exposed on
http://big.dada.pink.

To be clear, "safe" does not run an HTTP server.

Special cases for special computers
----------------------------------------
The directories on the "safe" computers are a bit different, as I
don't really do anything on them. The directories are just
``~/git/`` (for private git) and ``~/rsync/`` (for private rsync).
