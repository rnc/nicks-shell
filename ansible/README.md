
# Setup my Fedora KDE Spin Workstation.

## Bootstrap

```
wget https://github.com/rnc/nicks-shell/blob/master/ansible/boostrap.
./bootstrap.sh

```

## Run

Run using

```
sudo ansible-playbook --ask-vault-pass -v playbook.yml
```


# TODO

Switch to using a hosts file? And a ansible.cfg file ( https://sudo-science.com/setting-up-fedora-28-using-ansible/ )
Is there any way of automatically connecting to the VPN apart from manually exiting
Add devel packages


# Devel Packages

```
dbus-devel
dbus-glib-devel
expat-devel
gdbm-devel
GeoIP-devel
glib2-devel
glibc-devel
java-1.8.0-openjdk-devel
kernel-devel
keyutils-libs-devel
kf5-attica-devel
kf5-kactivities-devel
kf5-karchive-devel
kf5-kauth-devel
kf5-kbookmarks-devel
kf5-kcmutils-devel
kf5-kcodecs-devel
kf5-kcompletion-devel
kf5-kconfig-devel
kf5-kconfigwidgets-devel
kf5-kcoreaddons-devel
kf5-kcrash-devel
kf5-kdbusaddons-devel
kf5-kdeclarative-devel
kf5-kdelibs4support-devel
kf5-kdoctools-devel
kf5-kemoticons-devel
kf5-kglobalaccel-devel
kf5-kguiaddons-devel
kf5-ki18n-devel
kf5-kiconthemes-devel
kf5-kinit-devel
kf5-kio-devel
kf5-kitemmodels-devel
kf5-kitemviews-devel
kf5-kjobwidgets-devel
kf5-knewstuff-devel
kf5-knotifications-devel
kf5-kpackage-devel
kf5-kparts-devel
kf5-kservice-devel
kf5-ktextwidgets-devel
kf5-kunitconversion-devel
kf5-kwallet-devel
kf5-kwayland-devel
kf5-kwidgetsaddons-devel
kf5-kwindowsystem-devel
kf5-kxmlgui-devel
kf5-networkmanager-qt-devel
kf5-plasma-devel
kf5-solid-devel
kf5-sonnet-devel
krb5-devel
libcom_err-devel
libdb-devel
libdrm-devel
libfakekey-devel
libgcrypt-devel
libglvnd-core-devel
libglvnd-devel
libgpg-error-devel
libICE-devel
libpciaccess-devel
libselinux-devel
libsepol-devel
libSM-devel
libstdc++-devel
libverto-devel
libvirt-devel
libX11-devel
libXau-devel
libxcb-devel
libxcrypt-devel
libXdamage-devel
libXext-devel
libXfixes-devel
libXi-devel
libxml2-devel
libxslt-devel
libXtst-devel
libXxf86vm-devel
mariadb-connector-c-devel
mariadb-devel
mesa-libEGL-devel
mesa-libGL-devel
NetworkManager-glib-devel
NetworkManager-libnm-devel
openssl-devel
pcre2-devel
pcre-devel
perl-devel
python2-devel
qca-qt5-devel
qt5-qtbase-devel
qt5-qtdeclarative-devel
qt5-qttools-devel
qt5-qtx11extras-devel
ruby-devel
systemtap-sdt-devel
unixODBC-devel
uthash-devel
valgrind-devel
xcb-util-devel
xorg-x11-proto-devel
xz-devel
zlib-devel

```
