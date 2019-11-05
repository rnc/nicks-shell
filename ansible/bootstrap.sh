#!/bin/bash

if [ "$( grep '^ID=fedora' /etc/os-release )" ]
then
    PKGQ="rpm -q"
    PKGI="dnf"
    WALLET="ansible_become_pass=$(kwallet-query -l kdewallet -f ksshaskpass -v -r '' ) "
else
    PKGQ="dpkg-query -W"
    PKGI="apt-get"
    WALLET=" "
fi

EXTRA="$WALLET $@"

$PKGQ ansible git > /dev/null
if [ "$?" == "2" ]
then
    echo -e "\033[49;32;1mBootstraps to /tmp/nicks-shell...\033[0m"
    $PKGI install -y ansible git
    [[ "$?" == 1 ]] && exit 1
    git clone https://github.com/rnc/nicks-shell.git /tmp/nicks-shell
    cd /tmp/nicks-shell
else
    echo -e "\033[49;32;1mBootstrap already performed ; executing ansible using vault method...\033[0m"
    if [ "`basename $(pwd)`" != "ansible" ]
    then
        echo "Run from ansible directory"
        exit 1
    fi
fi
ansible-playbook -v playbook.yml -e $EXTRA

