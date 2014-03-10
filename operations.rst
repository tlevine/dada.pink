## Concepts
There are four levels of security based on where data may be stored. Data storage that is appropriate for one of these groups is appropriate for all of the subsequent groups,and *not* vice-versa; when there is a breach at a particular level, subsequent levels will be compromised, and earlier levels will not be.

Physical
    These data are to be stored only on computers that I can touch.

Locked
    These data are to be stored only on servers that are quite secure and are exposing few services to the network.

Numb
    These data are intended to be private but may be stored on servers that are running lots of servers and are quite open to the public.

Public
    These data are free for anyone to see.

Any piece of data will fall into exactly one of these groups. Also, all data should be in at least two places.

Physical, locked and numb data should be encrypted. Public data should not be encrypted.

## Computers
Public data and associated numb data (minimal credentials for accessing the services) can go in the following places.

NSA
    An account with the `Numb Server Association <http://the-nsa.org/>`_
GitHub
    https://github.com/tlevine/
Prudence
    A potential exchange of backups with Prudence Katze

Public data, numb data and locked data can be stored on

rsync.net
    An account at https://rsync.net
home
    An account at https://prometeus.net

Physical data can be stored on computers like these.

* phone
* laptop
* desktop
