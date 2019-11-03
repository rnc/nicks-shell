nicks-shell
===========

Shell initialisation scripts.

Tested on ZSH 5.7 and above.

Both bash and zsh initialisation utilise a common configuration file (```$HOME/.shell-configuration```) which may be used to stored common properties e.g.
* `NS_PREFIX` - where common support software (e.g. brew-koji & zsh-git-prompt) are stored in the filesystem.
* `SW_PREFIX` - where system software (such as the JDK, Maven, Gradle etc) are stored in the filesystem.

These prefixes are 'internal' ; specific to certain areas of my work and therefore not required generally.
* `VMAN_HOME` - installation of VMAN
* `IP_CONFIG` - location of IP configuration
* `IP_TOOLING` - location of IP_TOOLING

For even more completions install https://github.com/zsh-users/zsh-completions in `NS_PREFIX` location.

### Command line and Prompt ###

#### File Colours #####

It will check for existence (inside `NS_PREFIX`) for:

* https://github.com/trapd00r/LS_COLORS

#### Syntax Highlighting ####

It will check for existence (inside `NS_PREFIX`) for any of the below, in the following order:

* https://github.com/zdharma/fast-syntax-highlighting
* https://github.com/zdharma/zsh-syntax-highlighting


#### Git ####

It will check for existence (inside `NS_PREFIX`) for any of the below, in the following order:

* https://github.com/woefe/git-prompt.zsh
* https://github.com/yonchu/zsh-vcs-prompt
* https://github.com/rnc/zsh-git-prompt use the 'Fork' branch.

#### Completions ####

If either https://github.com/zsh-users/zsh-completions.git or https://github.com/gradle/gradle-completion are
installed in the `NS_PREFIX` directory it will add these to the completion system.

#### Python ####

If https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv/ is installed in the `NS_PREFIX` directory it will activate this for Python environments.


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

* .commonshell
* .aliases

These contains various useful functions and aliases.

GitConfig
---------
Various useful aliases suitable for placing in /etc/gitconfig
