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

if [[ $- == *i* ]]
then
    unset COLUMNS
    export COLUMNS
    [[ -z "$COLUMNS" ]] && COLUMNS=`tput cols` && echo "Forcing columns value to $COLUMNS"
fi


##############################
### ZSH Specific functions ###
##############################

# Handle logging and colour
function mytee()
{
    if [[ $SHELL != *"zsh" ]]
    then
        echo "mytee valid only with zsh"
        return
    fi
    # try / catch to ensure we always perform the sed.
    {
        printf "$INFO" "Running my tee with:"
        printf "$INFO" "${@[1, $(expr $# - 1)]}"
        printf "\t$INFO" "and log file is ${@: -1} "
        # https://superuser.com/questions/352697/preserve-colors-while-piping-to-tee
        unbuffer -p ${@[1, $#argv-1]} |& tee ${@: -1}
    } always {
        # https://superuser.com/questions/380772/removing-ansi-color-codes-from-text-stream/380778#380778
        sed -i 's/\x1b\[[0-9;]*m//g' ${@: -1}
    }
}
