

# Notes

## Table of Contents

<!-- TocDown Begin -->
  * [Installing Windows](#installing-windows)
  * [Pinned Package](#pinned-package)
  * [Comparison of Privacy Tools](#comparison-of-privacy-tools)
  * [Synology](#synology)
  * [Mounting SMB on Linux](#mounting-smb-on-linux)
  * [MS Built in Search](#ms-built-in-search)
  * [Windows default file associations ; use setuserfta and file association list](#windows-default-file-associations--use-setuserfta-and-file-association-list)
  * [Windows Account Setup](#windows-account-setup)
  * [Start Menu](#start-menu)
<!-- TocDown End -->

Helpful background links.


## Installing Windows

MS now doesn't allow a local account option to be selected unless the Ethenet connection is physically disabled:

https://www.ghacks.net/2019/09/30/how-to-create-a-local-account-in-windows-10-1909-if-the-option-is-not-available/

If you have multple disks in your machine, the advanced selection on lists 'disk 0/1' without identifying manufacturer
information. Press Shift-F10 to get a command prompt, use diskpart to display detail about the disk

```
    list disk
    select disk 1
    detail disk
```

https://neosmart.net/wiki/diskpart/
https://windowsreport.com/windows-10-cannot-be-installed-to-this-disk/

Note: To enter the bios on MSI machines press `del` on boot. See https://www.tomshardware.com/uk/reviews/bios-keys-to-access-your-firmware,5732.html for potential shortcuts.


## Pinned Package

To remove a package that is pinned (so it can be reinstalled), then follow https://github.com/chocolatey/choco/wiki/CommandsPin

## Comparison of Privacy Tools

https://www.ghacks.net/2015/08/14/comparison-of-windows-10-privacy-tools/

## Synology

* https://www.synology.com/en-global/knowledgebase/DSM/tutorial/General_Setup/How_to_login_to_DSM_with_root_permission_via_SSH_Telnet
* Exclude Photo/Folder from PhotoStation
    * https://community.synology.com/enu/forum/17/post/70808?page=3&sort=oldest
* https://unix.stackexchange.com/questions/198590/what-is-a-bind-mount
* https://www.albertogonzalez.net/how-to-create-a-symbolic-link-to-a-folder-on-a-synology-nas/
* https://synoguide.com/2019/04/12/synology-2019-configuration-guide-part-4-security-settings/


## Mounting SMB on Linux

* https://slice2.com/2018/03/11/howto-mount-a-synology-nas-smb-share-on-linux-with-smbv1-disabled/


## MS Built in Search

* https://www.thewindowsclub.com/set-google-default-search-windows-10-taskbar-search/
* https://github.com/TheoBr/Chrometana
* https://www.thewindowsclub.com/set-google-default-search-windows-10-taskbar-search/
* https://www.howtogeek.com/226638/make-the-windows-10-start-menu-and-cortana-search-google-instead-of-bing/


## Windows default file associations ; use setuserfta and file association list

* http://kolbi.cz/blog/2017/10/25/setuserfta-userchoice-hash-defeated-set-file-type-associations-per-user/

## Windows Account Setup

* https://www.lifewire.com/local-vs-microsoft-accounts-in-windows-3507003
* https://win10.guru/microsoft-account-vs-local-account-why-not-both/


## Start Menu

* https://www.techpowerup.com/forums/threads/editing-windows-10-start-menu.258193/
* https://www.makeuseof.com/tag/windows-start-menu-alternatives/
* https://www.stardock.com/products/start10/

## OneDrive

https://support.microsoft.com/en-us/office/change-the-location-of-your-onedrive-folder-f386fb81-1461-40a7-be2c-712676b2c4ae

Moved to 'D:' to avoid filling up C: drive. Excluded certain folders from my sync.
