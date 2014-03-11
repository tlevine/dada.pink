Concepts
----------
There are four levels of security based on where data may be stored. Data storage that is appropriate for one of these groups is appropriate for all of the subsequent groups,and *not* vice-versa; when there is a breach at a particular level, subsequent levels will be compromised, and earlier levels will not be.

Laptop
    These data are to be stored only on laptops and other computers that I can touch.

Home
    These data are to be stored only on servers that are quite secure and are exposing few services to the network, such as the one called "home".

NSA
    These data are intended to be private but may be stored on servers that are running lots of servers and are quite open to the public, such as the one called "nsa".

Public
    These data are free for anyone to see.

Any piece of data will fall into exactly one of these groups.
Physical, locked and numb data should be encrypted. Public data should not be encrypted.

Computers
----------
Public data and associated NSA data (minimal credentials for accessing the services) can go in the following places.

NSA
    An account with the `Numb Server Association <http://the-nsa.org/>`_
GitHub
    https://github.com/tlevine/
Prudence
    A potential exchange of backups with Prudence Katze
sensitive
    A tiny account at (decide where)

Public data, NSA data and Home data can be stored on

safe
    An account at https://rsync.net
home
    An larger account at https://prometeus.net

Laptop data can be stored on computers like these.

* phone
* laptop
* desktop

Installing a new system
-------------------------

Base
^^^^^^
Set up the home directory structure. ::

    mkdir ~/{git,safe,history}

SSH
^^^^^^
Create an SSH key for the system and add it to the
``~/.ssh/authorized_keys`` file in the following places.

* sensitive
* GitHub
* wiki.thomaslevine.com

Clone the repository with most open SSH configurations. ::

    cd ~/git
    git clone $user@$ip_address:secrets-nsa.git

And symlink the configuration files. ::

    ln -s ~/git/secrets-sensitive/.ssh/* ~/.ssh

This configures ssh so you can use alises. Now clone these. ::

    cd ~/git
    git clone github:tlevine/profile.git
    git clone github:tlevine/dotfiles.git
    git clone github:tlevine/historian.git
    git clone b-wiki-thomaslevine.com@wiki.thomaslevine.com:/ wiki.thomaslevine.com

Now you can symlink ``.shrc``, ``.bashrc``, &c. ::

    ln -s ~/git/profile/profile ~/.shrc

Clone additional secrets directories if as appropriate. ::

    git clone safe:git/secrets-home # for home
    git clone safe:git/secrets-laptop # for physical computers

Most of the dotfiles are in secrets-home. If you're on home or laptop,
you can symlink the dotfiles to the places they belong like so. ::

    for dotfile in git/secrets-home/dotfiles/.[a-z]*; do
        ln -s "$dotfile" $(basename "$dotfile")
    fi

Before running the above command, you should remove the symlinks to the
``~/.ssh`` directory.

Further installation
^^^^^^^^^^^^^^^^^^^^^^
You might find these install scripts to be helpful. ::

    git clone git@github.com:tlevine/desk


Backups
^^^^^^^^^
All data should be in at least two places. For public git repositories,
the places are nsa (http://small.dadawarehouse.thomaslevine.com) and GitHub, at least.
For larger public stuff, the places are nsa (http://big.dadawarehouse.thomaslevine.com)
and Prudence.

Numb data (private calendars, &c.) are used on nsa and also stored on sensitive.
And all of the other computers will probably have the same repository checked out.

Locked data are stored on home and on safe, and sometimes on a laptop and whatnot.

Physical data are stored on the laptop and on safe. home actually does have access to
these data too, so I might eventually get two separate rsync.net accounts to deal with
this.
