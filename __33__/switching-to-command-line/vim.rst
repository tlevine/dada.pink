[[!meta title="vim"]]
[[!meta description="Replacing graphical text editors for web development"]]

Ilda uses these 

* Notepad++
* Sublime text
* XAMPP
  (While XAMPP could be done all text-based, she explained that she
  installs and manages XAMPP with a graphical thing.)
* LibreOffice

How can we replace those with text-based things? Aside from XAMPP, let's
try to do everything in vim. Here are some basic aspects of vim that we
came up with that Ilda might use to replace the other programs.

Vim has modes.

* Press ``i`` to go into insert mode.
* Press ``ESC`` to leave a mode.
* All of the commands that I'm going to mention need to be run outside of modes.

Vim has commands that begin with colon.

``:w``
    Save
``:q``
    quit
``:wq``
    Save and quit

The other editors let you edit multiple files. Switching buffers and
windows is one way of doing that in vim.

* You can open multiple "buffers" in vim. Each buffer contains text that
  you edit, and it usually corresponds to a file.
* Vim starts with one window. Without creating new windows, you can use
  ``:badd`` to add buffers (files) and then ``:bn`` (next) and
  ``:bp`` (previous) to switch files. There are several other commands
  for switching buffers, but these are the only ones I know.

You can create multiple windows in vim with ``:split`` and ``:vsplit``
Once you have created the windows, use control + w and an appropriate arrow key.

You can browse directories inside vim. Here are some ways

* Open the directory when you start vim. For example, ``vim ./``.
* Opening directories inside vim, like ``:badd ./``.
* Run ``:Explore``.
* Use one of these fancy tree browser thingies.

  * http://vim.wikia.com/wiki/Use_Vim_like_an_IDE
  * https://github.com/scrooloose/nerdtree
  * http://www.vim.org/scripts/script.php?script_id=1658
