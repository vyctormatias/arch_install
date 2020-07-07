#!/usr/bin/env bash

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

hwclock --systohc

sed -i '/#en_US.UTF-8/ s/^#//' /etc/locale.gen
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
echo "LANG=en_US.UTF-8" > /etc/locale.conf

locale-gen

echo "arch" > /etc/hostname

useradd -m -g users -G wheel -s /bin/bash mhf

echo "Senha do usuario"
passwd mhf

printf "\nSenha do root\n"
passwd

grub-install /dev/sda
mkinitcpio -p linux
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable dhcpcd.service
