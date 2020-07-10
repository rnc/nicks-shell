#!/bin/bash
#
# Mount / bind some folders on startup and umount them on shutdown /reboot
# Place in /usr/local/etc/rc.d/
#
# References:
#  https://unix.stackexchange.com/questions/198590/what-is-a-bind-mount
#  https://www.synology-wiki.de/index.php/Mount_Bind
#  https://forum.synology.com/enu/viewtopic.php?f=90&t=126899

declare -A mappings
mappings=(
    ["Photographs"]="nick/Photographs/"
    ["NicksPictures"]="nick/Pictures/"
    ["SoniaPictures"]="sonia/Pictures/"
    ["MiaPictures"]="mia/Pictures/"
    ["EthanPictures"]="ethan/Pictures/"
    )

case "$1" in
  start)
    # Key is $i, value is ${mappings[$i]}
    for i in "${!mappings[@]}"
    do
        # Can't use findmnt on synology devices
        if [ -z "$(mount -l -t btrfs | grep /volume1/photo/$i)" ]
        then
            mkdir -p /volume1/photo/$i
            mount --bind /volume1/onedrive/${mappings[$i]} /volume1/photo/$i
        fi
    done
    ;;
  stop)
    for i in "${!mappings[@]}"
    do
        umount /volume1/photo/$i
    done
    ;;
  *)
    echo "Usage: $0 [start | stop]"
    ;;
esac
