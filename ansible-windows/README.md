
# Setup my Windows Workstation.

## Table of Contents

<!-- TocDown Begin -->
<!-- TocDown End -->


## Introduction

This is for Windows 10 (current update version). It will perform various features, install software from packages, disable services and tweak UI/privacy/etc configurations.


### TODO:

* Disable Lock Screen Ads
* Turn off live tiles
* Uninstall extra games?
* Disable Cortana
  * Potentially _removing_ Cortana can break search (https://superuser.com/questions/977425/uninstall-cortana-windows-10)

#### Notes on todo

* Only reveal hidden files (etc) for single user not all.
* Consider use of https://chocolatey.org/packages/choco-cleaner but would need to disable scheduled task perhaps.
* Secondary admin user setup and child user setup.

## SSH Setup

Ensure OpenSSH server is installed on the Windows machine and the account has a password. Use the below instructions (even if running within a VM - remember to configure port forwarding).

First, ensure OpenSSH server is enabled:

``` sh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

Start-Service sshd
# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'
# Confirm the Firewall rule is configured. It should be created automatically by setup.
Get-NetFirewallRule -Name *ssh*
# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
# If the firewall does not exist, create one
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

```
Test via running `ssh localhost` (which also creates the `.ssh` directory).

Copy the public key across to the Windows Virtual Machine. Don't use `ssh-copy-id` as that only works on Linux. Note that the key must also be placed in `C:\ProgramData\ssh\administrators_authorized_keys`. Use (from Linux):

``` sh
    scp -o PreferredAuthentications=password -o PubkeyAuthentication=no -P 3022 ~/.ssh/id_rsa_windows.pub "User@192.168.42.1:C:\Users\User\.ssh\authorized_keys"
    scp -o PreferredAuthentications=password -o PubkeyAuthentication=no -P 3022 ~/.ssh/id_rsa_windows.pub "User@192.168.42.1:C:\ProgramData\ssh\administrators_authorized_keys"
```

Then, to correct the permissions on the administrator key use:
```
$acl = Get-Acl C:\ProgramData\ssh\administrators_authorized_keys
$acl.SetAccessRuleProtection($true, $false)
$administratorsRule = New-Object system.security.accesscontrol.filesystemaccessrule("Administrators","FullControl","Allow")
$systemRule = New-Object system.security.accesscontrol.filesystemaccessrule("SYSTEM","FullControl","Allow")
$acl.SetAccessRule($administratorsRule)
$acl.SetAccessRule($systemRule)
$acl | Set-Acl
```

## Ansible

Run using

    ansible-playbook --ask-vault-pass -v playbook.yml --ask-become-pass

or

    sudo ansible-playbook --ask-vault-pass -v playbook.yml

Alternatively, if using KDEWalletManager then as per https://ercpe.de/blog/use-kde-wallet-to-unlock-your-ansible-vault it is possible to utilise the wallet to store the vault password. If the wallet stores a ansible-vault key / password combination then it will retrieve the vault password automatically e.g. `ansible-playbook -v playbook.yml` ; and if the sudo password is also stored then it could also be retrieved and passed through with:

    ansible-playbook -v playbook.yml -e "ansible_become_pass=$(kwallet-query -l kdewallet -f ksshaskpass -v -r '')"




## Background

### Packages Installed


## Pinned Package

To remove a package that is pinned (so it can be reinstalled), then follow https://github.com/chocolatey/choco/wiki/CommandsPin

### Comparison of Privacy Tools

https://www.ghacks.net/2015/08/14/comparison-of-windows-10-privacy-tools/

### Windows Useful Links

| **Description** | **URL** |
|:-:|:-:|
| Microsoft OpenSSH | https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse |
| Use a custom private key  | https://stackoverflow.com/questions/44734179/specifying-ssh-key-in-ansible-playbook-file  |
| SSH Keys in Windows  | https://superuser.com/questions/1342411/setting-ssh-keys-on-windows-10-openssh-server  |
| SSH / Windows and Admin Users | https://www.concurrency.com/blog/may-2019/key-based-authentication-for-openssh-on-windows |
| Ansible and SSH  | https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html#windows-ssh-setup  |
| Folder IDs | https://docs.microsoft.com/en-us/windows/win32/shell/knownfolderid |


## Development

This can easily be tested using VirtualBox as Microsoft (at time of writing) makes available a VM image in various formats - see https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/  or https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/. We now follow https://www.concurrency.com/blog/may-2019/key-based-authentication-for-openssh-on-windows

* Configure the VirtualBox network to add port forwarding e.g. 3022 (Host) -> 22 (Guest)
