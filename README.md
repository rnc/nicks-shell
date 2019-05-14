nicks-shell
===========

Shell initialisation scripts.

Both bash and zsh initialisation utilise a common configuration file (```$HOME/.shell-configuration```) which may be used to stored common properties e.g.
* NS_PREFIX - where common support software (e.g. brew-koji & zsh-git-prompt) are stored in the filesystem.
* VMAN_HOME - installation of VMAN
* IP_CONFIG - location of IP configuration
* IP_TOOLING - location of IP_TOOLING

For even more colourful highlighting install https://github.com/zsh-users/zsh-syntax-highlighting in `NS_PREFIX` location..

For even more completions install https://github.com/zsh-users/zsh-completions in `NS_PREFIX` location.

### Prompt ###

#### Syntax Highlighting ####

It will check for existence (inside `NS_PREFIX`) for any of the below, in the following order:

* https://github.com/zdharma/fast-syntax-highlighting
* https://github.com/zdharma/zsh-syntax-highlighting


#### Git ####

It will check for existence (inside `NS_PREFIX`) for any of the below, in the following order:

* https://github.com/woefe/git-prompt.zsh use the 'Fork' branch.
* https://github.com/yonchu/zsh-vcs-prompt and ensure you are using ZSH >= 5.0.5
* https://github.com/rnc/zsh-git-prompt use the 'Fork' branch.

For Bash:
* Install https://github.com/yonchu/zsh-vcs-prompt in NS_PREFIX location.

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
.aliases

These contains various useful functions and aliases.

GitConfig
---------
Various useful aliases suitable for placing in /etc/gitconfig

Misc
----
.dir_colors contains a custom set of colours.
