nicks-shell
===========

Shell initialisation scripts.

Both bash and zsh initialisation utilise a common configuration file (```$HOME/.shell-configuration```) which may be used to stored common properties e.g.
* REMOTEUSER - if the local user does not match remote logins
* PREFIX - where common support software (e.g. brew-koji & zsh-git-prompt) are stored in the filesystem.
* VMAN_HOME - installation of VMAN
* MAKE_MEAD - installation of MakeMEAD.

For ZSH, it is recommended to install https://github.com/rnc/zsh-git-prompt and use the 'Fork' branch.

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
