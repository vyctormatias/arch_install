#!/usr/bin/env bash

HOSTS=("archlinux.c3sl.ufpr.br" "linorg.usp.br" "br.mirror.archlinux-br.org")

for i in "${HOSTS[@]}"
do
	if ping -c1 ${i} 1>/dev/null 2>&1
	then
		HOST="${i}"
		break
	fi
done

VERSION=$(curl ${HOST}/iso/ | awk '{ if (match($0,/[0-9.]{10}/,m)) a=m[0] } END{print a}')

printf "Baixando o bootstrap\n\n"
wget -O /tmp/bootstrap.tar.gz ${HOST}/iso/${VERSION}/archlinux-bootstrap-${VERSION}-x86_64.tar.gz

cd /tmp && tar xzvf bootstrap.tar.gz

cp -R /arch_install /tmp/root.x86_64/

mount --bind /tmp/root.x86_64 /tmp/root.x86_64
cd root.x86_64
cp /etc/resolv.conf etc
mount -t proc /proc proc
mount --make-rslave --rbind /sys sys
mount --make-rslave --rbind /dev dev
[ -d /run ] && mount --make-rslave --rbind /run run    # (presumindo que /run existe no sistema)

echo "Entrando em chroot"; sleep 2
chroot /tmp/root.x86_64 /bin/bash
