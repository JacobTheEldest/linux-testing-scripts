#!/bin/bash

#Ensure that there is a valid argument
if [ -z $1 ]; then
    echo "Enter the target device as an argument"
    exit 1
fi

# Clear source media pacman cache to reduce size
echo "Clearing pacman cache to reduce size"
pacman -Scc --noconfirm
echo

# Partition Target Device
echo "Partitioning target device"
parted /dev/${1} mklabel msdos
parted /dev/${1} mkpart primary ext4 1MiB 100%
parted /dev/${1} set 1 boot on
mkfs.ext4 -O "^has_journal" /dev/${1}1

# Copy entire filesystem
echo
echo "Copying filesystem"
echo
mount /dev/${1}1 /mnt/
echo "Copying (1/13)"; cp -rp /bin /mnt/
echo "Copying (2/13)"; cp -rp /boot /mnt/
echo "Copying (3/13)"; cp -rp /etc /mnt/
echo "Copying (4/13)"; cp -rp /home /mnt/
echo "Copying (5/13)"; cp -rp /lib /mnt/
echo "Copying (6/13)"; cp -rp /lost+found /mnt/
echo "Copying (7/13)"; cp -rp /opt /mnt/
echo "Copying (8/13)"; cp -rp /root /mnt/
echo "Copying (9/13)"; cp -rp /run /mnt/
echo "Copying (10/13)"; cp -rp /sbin /mnt/
echo "Copying (11/13)"; cp -rp /srv /mnt/
echo "Copying (12/13)"; cp -rp /usr /mnt/
echo "Copying (13/13)"; cp -rp /var /mnt/
echo
mkdir /mnt/mnt
mkdir /mnt/dev
mkdir /mnt/proc
mkdir /mnt/sys
mkdir /mnt/tmp

# Fix fstab
echo "Fixing fstab"
uuid=$(blkid | grep ${1}1)
uuid=${uuid/"/dev/${1}1: "/}
uuid=$(echo $uuid | awk {'print $1'})
uuid=${uuid//\"/}
echo "$uuid	/         	ext4      	rw,relatime	0 1" > /mnt/etc/fstab
echo

# Install Grub
echo "Installing GRUB"
cd /mnt
mount -t proc proc proc/
mount --rbind /sys sys/
mount --rbind /dev dev/
chroot ./ grub-install --recheck /dev/${1}
chroot ./ grub-mkconfig -o /boot/grub/grub.cfg
echo

# Updating target scripts
echo "Updating target scripts"
cd /mnt/home/testing/linux-testing-scripts
git pull

# Shutdown
"Shutting down"
shutdown -h now
