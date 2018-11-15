#!/bin/bash

dnf install -y git ansible
git clone https://github.com/rnc/nicks-shell.git /tmp/nicks-shell
echo -e "Now run\n\tcd /tmp/nicks-shell/ansible\n\tsudo ansible-playbook --ask-vault-pass -v playbook.yml"
