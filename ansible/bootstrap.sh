#!/bin/bash

if [ "$( rpm -q ansible git)" == "0" ]
then
    echo -e "\033[49;32;1mBootstraps to /tmp/nicks-shell...\033[0m"
    dnf install -y ansible git
    git clone https://github.com/rnc/nicks-shell.git /tmp/nicks-shell
else
    echo -e "\033[49;32;1mBootstrap already performed ; executing ansible using vault method...\033[0m"
    if [ "`basename $(pwd)`" != "ansible" ]
    then
        echo "Run from ansible directory"
        exit 1
    fi

    ansible-playbook -v playbook.yml -e "ansible_become_pass=$(kwallet-query -l kdewallet -f ksshaskpass -v -r '')"
fi
