Concepts
----------
There are four levels of security based on where data may be stored. Data storage that is appropriate for one of these groups is appropriate for all of the subsequent groups, and *not* vice-versa; when there is a breach at a particular level, subsequent levels will be compromised, and earlier levels will not be.

Laptop
    These data are to be stored only on laptops and other computers that I carry with me.

Home
    These data are to be stored only on servers that are quite secure and are exposing few services to the network, such as the one called "home". I mostly use this for email.

NSA
    These data are intended to be private but may be stored on servers that are running lots of servers and are quite open to the public, such as the one called "nsa".

Public
    These data are free for anyone to see.

Any piece of data will fall into exactly one of these groups.
Home and NSA are shared computers, so there is only so much I can do to
prevent administrators from seeing what is running on them. A first step,
though, is that everything except public data should be encrypted.

Computers
----------
Public data and associated NSA data (minimal credentials for accessing the services) can go in the following places.

NSA
    An account with the `Numb Server Association <http://the-nsa.org/>`_
GitHub
    https://github.com/tlevine/

Public data, NSA data and Home data can be stored on home, which is a VPS
from https://prometeus.net.

Laptop data can be stored on computers like these.

* phone
* laptop
* desktop

Backup locations
---------------------
All data should be in at least two places. For public git repositories,
the places are the laptop, nsa (http://dada.pink) and GitHub, at least.
For larger public stuff, the places are nsa (http://big.dada.pink) and
backup exchanges.

Numb data (private calendars, &c.) are used on nsa. At present, these
are small enough to fit in one git repository that is checked out on
all other computers.

Home data are stored on home. This is mostly email, so it is sometimes
on a laptop as well, but the laptop is usually behind in its synchronization,
so I don't count that as a backup.

Laptop data are stored on the laptop, of course.

Emails
-----------
Emails are classified as Home data initially, but individual emails can be
converted to Public data through a [mailbox interface](../email/#permissions).

If only one location is specified above
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Every piece of data should be stored in at least two places. One place is
often the laptop. If the above directions specify only one place for the
particular datum, a copy should go on a corresponding Safe box, which is
usually an account at https://rsync.net.

Backup pipeline
----------------
Git repositories are naturally backed-up by being checked out in two places.
The remotes are safe (laptop-level and home-level data), sensitive (nsa-level data),
and GitHub (public-level data).

Larger files get rsynced through home. A cron job runs on home to pull specific
directories from nsa to home, and a cron job runs on laptop to push specific
directories to home. Another cron job runs on home to push the entirity of ``~/safe``
to safe and the entirity of ``~/nsa/`` to nsa.
