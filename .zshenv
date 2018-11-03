# -*- zsh -*-
#
#
# $Id: .zshenv,v 1.20 2010/03/15 12:18:52 rnc Exp $
#
# .zshenv is sourced (first ) on all invocations of the
# shell, unless the -f option is set.  It should
# contain commands to set the command search path,
# plus other important environment variables.
# .zshenv should not contain commands that product
# output or assume the shell is attached to a tty.
#

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
export SHELL=`which zsh`

if [[ $- == *i* ]]
then
    unset COLUMNS
    export COLUMNS
    [[ -z "$COLUMNS" ]] && COLUMNS=`tput cols` && echo "Forcing columns value to $COLUMNS"
fi
