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

    for directory in dotfiles secrets-home; do
        for dotfile in git/"$directory"/dotfiles/.[a-z]*; do
            ln -s "$dotfile" $(basename "$dotfile")
        fi
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

