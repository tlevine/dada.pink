Installing a new system
=========================
Installing a new Tom computer

Base
^^^^^^
Set up the home directory structure. ::

    mkdir ~/{git,safe,nsa}

SSH
^^^^^^
Create an SSH key for the system and add it to the
``~/.ssh/authorized_keys`` file in the following places.

* "safe" backup computer(s)
* GitHub

Clone the repository with most open SSH configurations. ::

    cd ~/git
    git clone $user@$ip_address:secrets-nsa.git

And symlink the ssh config. ::

    ln -s ~/git/secrets-sensitive/.ssh/config ~/.ssh/config

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

    for directory in dotfiles secrets-home; do
        for dotfile in git/"$directory"/dotfiles/.[a-z]*; do
            ln -s "$dotfile" $(basename "$dotfile")
        done
    done

Before running the above command, you should remove the symlinks to the
``~/.ssh`` directory.

You should also set up the appropriate crontab. Take the crontab from the
appropriate secrets directory (for example, secrets-laptop if you're on laptop).

    crontab ~/git/secrets-laptop/crontab-tlevine

Further installation
^^^^^^^^^^^^^^^^^^^^^^
You might find these install scripts to be helpful. ::

    git clone git@github.com:tlevine/desk

Checks
^^^^^^^^^^^^^^^^^^^
With the exception of phones, the following should be the case for all computers.

Environment variables are such.

* ``$USER`` is ``tlevine``
* ``$HOME`` is ``/home/tlevine``

There should be a ``~/git`` directory for files that are backed up in git.
It should contain:

* ``~/git/profile``: The standard profile configuration across all computers.
    This repository is public.
* ``~/git/secrets-${computer}``, where ``$computer`` is ``laptop``, ``home``, ``nsa``.

The following links should be set.

* Everything in ``~/git/secrets-*/dotfiles/*`` should be linked to files in ``~``.
* The shell profile should source ``~/git/profile/profile`` and ``~/git/secrets-*/profile``.
* In turn, ``~/git/profile/sources/*`` should be sourced.


For NSA, specifically
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
``~/dada.pink`` and ``~/big.dada.pink`` should be served publically over
HTTP. (They can be symlinks to the actual directories.)

A jail should be set up for sharing backups with other people. I presently
use SFTP for this.

Configuration files for NSA are all stored in the ``secrets-nsa`` repository.
Look at the Apache configuration in particular.

* git bare hooks
