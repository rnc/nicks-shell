
# Setup my Fedora KDE Spin Workstation.

* Tested on F31/F32

Relies on python3 being available and uses local connection to setup the machine.

## Bootstrap

```
wget https://raw.githubusercontent.com/rnc/nicks-shell/master/ansible-linux/bootstrap.sh
./bootstrap.sh

```

## Run

Run using

    ansible-playbook --ask-vault-pass -v playbook.yml --ask-become-pass

or

    sudo ansible-playbook --ask-vault-pass -v playbook.yml

Alternatively, if using KDEWalletManager then as per https://ercpe.de/blog/use-kde-wallet-to-unlock-your-ansible-vault it is possible to utilise the wallet to store the vault password. If the wallet stores a ansible-vault key / password combination then it will retrieve the vault password automatically e.g. `ansible-playbook -v playbook.yml` ; and if the sudo password is also stored then it could also be retrieved and passed through with:

    ansible-playbook -v playbook.yml -e "ansible_become_pass=$(kwallet-query -l kdewallet -f ksshaskpass -v -r '')"


# Variables

A private variable file needs to contain

  * rcm_repo: "..."
  * csb_repo: "..."
  * vpn_username: "..."
  * vpn_connection: "..." # Name of the VPN connection
  * kerberos_ipa1: "..."
  * kerberos_ipa2: "..."
  * kerberos_domain1: "..."
  * kerberos_domain2: "..."
  * kerberos_kdc: "..."
  * kerberos_auth: "..."
  * hostname: "..."
  * user_account: "..."

By default this will use `vars/private.yml` ; pass `-e private_vars=<my-variable-file.yml>` to override.

A tar file containing VPN bootstrap information - this needs to contain:

  * etc/NetworkManager/system-connections/vpnconfig.ovpn
  * etc/pki/tls/certs/certificate.pem

By default this will use `files/bootstrapvpn.tar` ; pass `-e bootstrap_vpn=<my-bootstrap-file.tar>` to override.
To view this private file use:

    ansible-vault --vault-id ./vault.sh view vars/private.yml

# Thunderbolt Connection Information

Initially connecting a Lenovo T480s to the new Thunderbolt dock does *not* work. In order to get it working these background sites helped:

* https://www.youtube.com/watch?v=0XhRBILQIsE&feature=youtu.be&t=350
* https://funnelfiasco.com/blog/2018/06/29/thinkpad-thunderbolt-dock-fedora/
* https://christian.kellner.me/2017/12/14/introducing-bolt-thunderbolt-3-security-levels-for-gnulinux/

It is recommended to have the following BIOS setup:
* Assist : Enabled
* Wake : Disabled
* Security : User level
* Pre-Boot : ACL Boot

Then follow these instructions,:

* Ensure bolt is installed (the playbook will install it).
* The cable is connected into the correct socket (*not* the left-most one)
* `boltctl list`
* `boltctl enroll <uuid from above>`

Note: KDE only requires the boltctl commands due to https://bugs.kde.org/show_bug.cgi?id=395304

After its recognised, for KDE Plasma : Audio, you may need to enter `System Settings/Multimedia/Audio and Video` and configure each audio device to prefer the dock.

# Reinstallation Notes
Normally Anaconda creates a user of ID 1000. As the existing backup of `/home/...` is using that we need that one. Therefore create a dummy user and either:
* Use advanced settings to ensure the 'temporary' user uses a high non-clashing UID _(preferred option)_
* Follow https://muffinresearch.co.uk/linux-changing-uids-and-gids-for-user/ to swap the IDs.

Then add (without overwriting the home directories) the existing users e.g.

```
    useradd -U -u <existing-uid> -c "Human Name" <username>
    usermod -a -G wheel <username>
    passwd <id>
```
Once it is all confirmed working, delete the dummy user.

# TODO

* Consider further role refactoring using default vars, pre-task/post-task etc.
** https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html
* Is it possible to use nested blocks to simplify the Fedora conditionals.
