# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

### Configuration file may contain
# Useful if user name does not equal remote login name
# REMOTEUSER=xxx
#
# Prefix where useful things are stored in the users file system
# PREFIX=xxx
# e.g. brew-koji zsh completion code. For example set it to $HOME/Work/Miscellaneous
# PREFIX is added to the fpath and used to source zsh-git-prompt.
#
# Any other functions etc can also be put in here.
[[ -f $HOME/.shell-configuration ]] && source $HOME/.shell-configuration

# Defs
set show-all-if-ambiguous on
set expand-tilde on
set command_oriented_history
set glob_dot_filenames
set notify
set noclobber
set autologout
set pushd_silent=true

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

unset COLUMNS
export COLUMNS
[[ -z "$COLUMNS" ]] && COLUMNS=`tput cols` && echo "Forcing columns value to $COLUMNS"

#
# Get common aliases and functions
#
source $HOME/.commonshell

# Setup prompt
if [ -n "`shopt | grep "login_shell.*off"`" ] && [ -n "$PS1" ]
then
    echo "Running .bashrc..."

    export PS1='\[\e[1;32m\]\h:\W $\[\e[0m\] '
    export PS1='\[\e[1;32m\]\h:\W $\[\e[0m\] '
fi
