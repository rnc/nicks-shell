#!/bin/bash

if [ "$( grep '^ID=fedora' /etc/os-release )" ]
then
    kwallet-query -r ansible-vault kdewallet 2> /dev/null
    if [ $? != 0 ]
    then
       read -p "Enter password: "
    fi
else
    read -p "Enter password: "
fi
