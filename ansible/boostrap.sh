#!/bin/bash

sudo dnf install -y git ansible
git clone https://github.com/rnc/nicks-shell.git /tmp/nicks-shell
cd /tmp/nicks-shell/ansible
echo -e "Now run\n\tsudo ansible-playbook --ask-vault-pass -v playbook.yml"
