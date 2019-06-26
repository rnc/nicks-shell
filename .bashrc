# -*- sh -*-
#
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

### Configuration file may contain
#
# Prefix where useful things are stored in the users file system
# NS_PREFIX=xxx
# e.g. brew-koji zsh completion code. For example set it to $HOME/Work/Miscellaneous
# NS_PREFIX is added to the fpath and used to source zsh-git-prompt.
#
# Any other functions etc can also be put in here.
[[ -f $HOME/.shell-configuration ]] && source $HOME/.shell-configuration

# Defs
if [ -z "$BASH" ]
then
    set -o show-all-if-ambiguous on
    set -o expand-tilde on
    set -o command_oriented_history
    set -o glob_dot_filenames
    set -o autologout
    set -o pushd_silent=true
fi

set -o notify
set -o noclobber

cd()
{
   # Need to recognize that there are no arguments so
   # we jump to HOME directory correctly.
   if [ -z "$@" ]
   then
      pushd "$HOME" > /dev/null
   else
      pushd "$@" > /dev/null
   fi
}

# List functions the same way as ZSH
alias functions='typeset -f'

#################
### CLASSPATH ###
#################

CLASSPATH=.

###############
### Exports ###
###############

export LD_LIBRARY_PATH
export CLASSPATH
export PATH
export SHELL=`which bash`

#
# Get common aliases and functions
#
source $HOME/.commonshell
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# Setup prompt and columns
if [[ $- == *i* ]]
then
    unset COLUMNS
    export COLUMNS
    [[ -z "$COLUMNS" ]] && COLUMNS=`tput cols` && echo "Forcing columns value to $COLUMNS"

    echo "Running .bashrc..."

    if [ -d $NS_PREFIX/zsh-vcs-prompt ]
    then
        unset $(compgen -v | grep ZSH_VCS_)
        source $NS_PREFIX/zsh-vcs-prompt/zshrc.sh
        export PS1='\[\e[1;32m\]\h:$(vcs_super_info) $\[\e[0m\] '
    else
        export PS1='\[\e[1;32m\]\h:\W $\[\e[0m\] '
    fi
fi
