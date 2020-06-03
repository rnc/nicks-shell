
# Setup my Windows Workstation.

## Table of Contents

<!-- TocDown Begin -->
  * [Introduction](#introduction)
  * [TODO:](#todo)
  * [Setup](#setup)
    * [WinRM](#winrm)
    * [SSH Setup](#ssh-setup)
  * [Ansible](#ansible)
  * [Notes](#notes)
    * [Pinned Package](#pinned-package)
    * [Comparison of Privacy Tools](#comparison-of-privacy-tools)
    * [Windows Useful Links](#windows-useful-links)
  * [Development](#development)
<!-- TocDown End -->


## Introduction

This is for Windows 10 (current update version). It will perform various features, install software from packages, disable services and tweak UI/privacy/etc configurations.

Use a powershell in admin mode to run the commands. Using https://www.howtogeek.com/235101/10-ways-to-open-the-command-prompt-in-windows-10/, one option is `WindowsKey & X`. To copy paths in Explorer press Shift before pressing right click.

## TODO:

 * Backup choice
 * Per user configuration for powershell (hidden files etc) and file associations
 * Windows default file associations ; use setuserfta and file association list
     * http://kolbi.cz/blog/2017/10/25/setuserfta-userchoice-hash-defeated-set-file-type-associations-per-user/
 * Disable Lock Screen Ads - does this still exist?
 * Disable WebSearch on May 2020 Update
     * https://www.ghacks.net/2018/04/07/microsoft-breaks-disable-web-search-in-windows-10-version-1803/
 * Custom pin menu - possibly not needed? Can create shortcut on desktop
 * Consider switching digikam to manual install as package 6.1 is older than 7 (in beta)

#### Notes on todo

 * Consider use of https://chocolatey.org/packages/choco-cleaner but would need to disable scheduled task perhaps.
 * Secondary admin user setup and child user setup.


## Setup

### WinRM

Originally was using SSH but switched to WinRM due to login issues (https://github.com/PowerShell/Win32-OpenSSH/issues/139). Following https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html#winrm-setup to configure it (if running within a VM remember to configure port forwarding to 5986).

``` sh
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file -verbose -DisableBasicAuth -GlobalHttpFirewallAccess false
```

### SSH Setup

Ensure OpenSSH server is installed on the Windows machine and the account has a password. Use the below instructions (even if running within a VM - remember to configure port forwarding).

Note the difference between the build in OpenSSH (https://blog.ipswitch.com/the-future-of-remoting-in-windows-openssh) and the newer version via Chocolatey.

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
    scp -o PreferredAuthentications=password -o PubkeyAuthentication=no -P 3022 ~/.ssh/id_rsa_windows.pub "rnc@192.168.42.1:C:\Users\rnc\.ssh\authorized_keys"
    scp -o PreferredAuthentications=password -o PubkeyAuthentication=no -P 3022 ~/.ssh/id_rsa_windows.pub "rnc@192.168.42.1:C:\ProgramData\ssh\administrators_authorized_keys"
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




## Notes

### Pinned Package

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

This can easily be tested using VirtualBox as Microsoft (at time of writing) makes available a VM image in various formats - see https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/  or https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/. We now follow https://www.concurrency.com/blog/may-2019/key-based-authentication-for-openssh-on-windows or https://www.microsoft.com/en-ca/software-download/windows10ISO

* Configure the VirtualBox network to add port forwarding e.g. 3022 (Host) -> 22 (Guest)
