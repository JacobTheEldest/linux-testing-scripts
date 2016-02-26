#!/bin/bash

#Ensure that there is a valid argument
if [ -z $1 ]; then
    echo "Enter an argument"
    exit 1
fi

# Partition Target Device
parted /dev/${1} mklabel msdos
parted /dev/${1} mkpart primary ext4 1MiB 100%
parted /dev/${1} set 1 boot on
mkfs.ext4 -O "^has_journal" /dev/${1}1

# Copy entire filesystem
mount /dev/${1}1 /mnt/
rsync -avP --numeric-ids --exclude='/dev' --exclude='/proc' --exclude='/sys' --exclude=’/mnt’ / /mnt
mkdir /mnt/mnt
mkdir /mnt/dev
mkdir /mnt/proc
mkdir /mnt/sys

# Fix fstab
uuid=$(blkid | grep ${1}1)
uuid=${uuid/"/dev/${1}1: "/}
uuid=$(echo $uuid | awk {'print $1'})
uuid=${uuid//\"/}
echo "$uuid	/         	ext4      	rw,relatime	0 1" > /mnt/target/etc/fstab

# Install Grub
cd /mnt
mount -t proc proc proc/
mount --rbind /sys sys/
mount --rbind /dev dev/
chroot ./ grub-install --recheck /dev/${1}
chroot ./ grub-mkconfig -o /boot/grub/grub.cfg

shutdown -h now
