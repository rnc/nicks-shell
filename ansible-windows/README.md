
# Setup my Windows Workstation.

## Table of Contents

<!-- TocDown Begin -->
<!-- TocDown End -->


* Tested on Windows 10

## Usage

### SSH

* Ensure OpenSSH server is installed on the Windows machine - if you can't SSH from a local powershell into `localhost` then follow https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse

### Changes made

* Turn off live tiles
* Windows update on demand (???)
* Uninstall extra games?
* Remove advertisments
* Remove tracking
* Disable Cortana
  * Potentially _removing_ Cortana can break search (https://superuser.com/questions/977425/uninstall-cortana-windows-10)
* Disable People icon, and possibly Ink Workspace and touch keyboard buttons.
* Disable Uploading Updates to Other PCs Over the Internet
* Disable Lock Screen Ads
* Stop Suggested Apps From Appearing in the Start Menu
* Get Rid of Nagging Taskbar Pop-ups
* Prevent Notification Ads From Appearing
* Remove Advertisements From File Explorer
* Banish “Get Office” Notifications
* Avoid the Built-in Solitaire Game
* Remove windows ink

#### Powershell Invocations


### Run

Run using

    ansible-playbook --ask-vault-pass -v playbook.yml --ask-become-pass

or

    sudo ansible-playbook --ask-vault-pass -v playbook.yml

Alternatively, if using KDEWalletManager then as per https://ercpe.de/blog/use-kde-wallet-to-unlock-your-ansible-vault it is possible to utilise the wallet to store the vault password. If the wallet stores a ansible-vault key / password combination then it will retrieve the vault password automatically e.g. `ansible-playbook -v playbook.yml` ; and if the sudo password is also stored then it could also be retrieved and passed through with:

    ansible-playbook -v playbook.yml -e "ansible_become_pass=$(kwallet-query -l kdewallet -f ksshaskpass -v -r '')"



## Background

### Packages


## Pinned Package

To remove a package that is pinned (so it can be reinstalled), then follow https://github.com/chocolatey/choco/wiki/CommandsPin

### Comparison of Privacy Tools

https://www.ghacks.net/2015/08/14/comparison-of-windows-10-privacy-tools/

### Windows Useful Links

| **Description** | **URL** |
|:-:|:-:|
| Use a custom private key  | https://stackoverflow.com/questions/44734179/specifying-ssh-key-in-ansible-playbook-file  |
| SSH Keys in Windows  | https://superuser.com/questions/1342411/setting-ssh-keys-on-windows-10-openssh-server  |
| SSH / Windows and Admin Users | https://www.concurrency.com/blog/may-2019/key-based-authentication-for-openssh-on-windows |
| Ansible and SSH  | https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html#windows-ssh-setup  |



## Development

This can easily be tested using VirtualBox as Microsoft (at time of writing) makes available a VM image in various formats - see https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/  or https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/

Then the following setup needs to be done:

* Ensure OpenSSH server is running in Windows (See above).
* Configure the VirtualBox network to add port forwarding e.g. 3022 (Host) -> 22 (Guest)
* Copy the public key across to the Windows Virtual Machine. Don't use `ssh-copy-id` as that only works on Linux. Instead use

``` sh
    scp -o PreferredAuthentications=password -o PubkeyAuthentication=no -P 3022 ~/.ssh/id_rsa_windows.pub "User@192.168.42.1:C:\Users\User\.ssh\authorized_keys"
```


* Follow https://www.concurrency.com/blog/may-2019/key-based-authentication-for-openssh-on-windows
  The key must be placed in `C:\ProgramData\ssh\administrators_authorized_keys` so run following powershell:

```
    cp C:\Users\User\.ssh\authorized_keys 'C:\ProgramData\ssh\administrators_authorized_keys'
```

```
$acl = Get-Acl C:\ProgramData\ssh\administrators_authorized_keys
$acl.SetAccessRuleProtection($true, $false)
$administratorsRule = New-Object system.security.accesscontrol.filesystemaccessrule("Administrators","FullControl","Allow")
$systemRule = New-Object system.security.accesscontrol.filesystemaccessrule("SYSTEM","FullControl","Allow")
$acl.SetAccessRule($administratorsRule)
$acl.SetAccessRule($systemRule)
$acl | Set-Acl
```



# TODO:

How to _reuse_ other powershell scripts. Zero point in duplicating in my ansible. Can we wget a version, then use it? Which one?

Can we wget a script, install program etc.
