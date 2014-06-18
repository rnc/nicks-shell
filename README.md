nicks-shell
===========

Shell initialisation scripts.

Both bash and zsh initialisation utilise a common configuration file (```$HOME/.shell-configuration```) which may be used to stored common properties e.g.
* PREFIX - where common support software (e.g. brew-koji & zsh-git-prompt) are stored in the filesystem.
* VMAN_HOME - installation of VMAN
* IP_CONFIG - location of IP configuration
* IP_TOOLING - location of IP_TOOLING

For ZSH, it is recommended to install https://github.com/rnc/zsh-git-prompt in PREFIX location and use the 'Fork' branch.

For even more colourful highlighting install https://github.com/zsh-users/zsh-syntax-highlighting in PREFIX location..

For even more completions install https://github.com/zsh-users/zsh-completions in PREFIX location.

Installation
------------
For all of the files the recommended installation is to place a symbolic link in your home directory pointing to the relevant file in the checkout.

ZSH
---
* .zshenv
* .zshrc

Bash
----
* .bashrc

Common
------
.commonshell
This contains various useful functions and aliases.

GitConfig
---------
Various useful aliases suitable for placing in /etc/gitconfig

Misc
----
.gtkrc-2.0-eclipse contains override settings for GTK under KDE.
.dir_colors contains a custom set of colours.
