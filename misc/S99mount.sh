#!/bin/bash
#
# Mount / bind some folders on startup and umount them on shutdown /reboot
# Place in /usr/local/etc/rc.d/
#
# References:
#  https://unix.stackexchange.com/questions/198590/what-is-a-bind-mount
#  https://www.synology-wiki.de/index.php/Mount_Bind
#  https://forum.synology.com/enu/viewtopic.php?f=90&t=126899


# Key is location in synology shared drive to onedrive cloud storage location
declare -A mappings
mappings=(
    ["photo/Photographs"]="nick/Photographs/"
    ["photo/NicksPictures"]="nick/Pictures/"
    ["photo/SoniaPictures"]="sonia/Pictures/"
    ["photo/MiaPictures"]="mia/Pictures/"
    ["photo/EthanPictures"]="ethan/Pictures/"
    ["music"]="nick/Music/"
    ["video"]="nick/Films/"
    )

case "$1" in
  start)
    # Key is $i, value is ${mappings[$i]}
    for i in "${!mappings[@]}"
    do
        # Can't use findmnt on synology devices
        if [ -z "$(mount -l -t btrfs | grep /volume1/$i)" ]
        then
            mkdir -p /volume1/$i
            mount --bind /volume1/onedrive/${mappings[$i]} /volume1/$i
        fi
    done
    ;;
  stop)
    for i in "${!mappings[@]}"
    do
        umount -v /volume1/$i
    done
    ;;
  *)
    echo "Usage: $0 [start | stop]"
    ;;
esac
