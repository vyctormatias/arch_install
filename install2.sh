#!/usr/bin/env bash

pacman-key --init
pacman-key --populate archlinux

mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt

cp -f ./files/mirrorlist /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel linux linux-firmware e2fsprogs dhcpcd man-db man-pages texinfo grub neovim

cp -f ./files/mirrorlist /mnt/etc/pacman.d/mirrorlist
cp -f ./files/{fstab,sudoers} /mnt/etc/
cp -f ./configure.sh /mnt/

chmod 644 /mnt/etc/fstab
chmod 600 /mnt/etc/sudoers

arch-chroot /mnt
