#!/bin/bash

if [ "$( grep '^ID=fedora' /etc/os-release )" ]
then
    kwallet-query -r ansible-vault kdewallet
else
    read -p "Enter password: "
fi
