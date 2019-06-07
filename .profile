#
#
# This file only needs to be used if the default shell is not ZSH and we wish to
# automatically start ZSH
#
#

if [[ $- == *i* ]]
then
    which zsh >& /dev/null
    if [ "$?" == 0 ]
    then
        echo "Execing ZSH"
        export SHELL=`which zsh`
        zsh
        exit
    fi
fi

# Default to .bashrc
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
