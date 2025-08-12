#!/bin/bash

###
### About: Script to automaticly add Chaotic-AUR and ALHP repos to Arch Linux.
###

### Warning

echo -e ""
echo -e "Make sure you're connected to the internet!"
echo -e "Otherwise, this script will mess up your repos."
echo -e "Backup of the original repos will be created"
echo -e "from /etc/pacman.conf to /etc/pacman.conf.bak"
echo -e "just in case something goes wrong."
echo -e ""
read -p "Press any key to continue... " -n1 -s
echo -e ""
cp /etc/pacman.conf /etc/pacman.conf.bak

### Chaotic-AUR install

pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sed -i -e '89i[chaotic-aur]\' /etc/pacman.conf
sed -i -e '90iInclude = /etc/pacman.d/chaotic-mirrorlist\' /etc/pacman.conf
sed -i -e '91i\\' /etc/pacman.conf
pacman -Sy

### ALHP install

pacman -Sqs alhp | pacman -S --noconfirm -

PS3='Please enter your x86-64 level: '
options=("V3 [AVX2 - Haswell, Zen 3 or newer]" "V4 [AVX-512 - Skylake, Zen 4 or newer]")
select opt in "${options[@]}"
do
    case $opt in
        "V3 [AVX2 - Haswell, Zen 3 or newer]")
			sed -i -e '74i[core-x86-64-v3]\' /etc/pacman.conf
			sed -i -e '75iInclude = /etc/pacman.d/alhp-mirrorlist\' /etc/pacman.conf
			sed -i -e '76i\\' /etc/pacman.conf
			sed -i -e '83i[extra-x86-64-v3]\' /etc/pacman.conf
			sed -i -e '84iInclude = /etc/pacman.d/alhp-mirrorlist\' /etc/pacman.conf
			sed -i -e '85i\\' /etc/pacman.conf
			break
            ;;
        "V4 [AVX-512 - Skylake, Zen 4 or newer]")
			sed -i -e '74i[core-x86-64-v4]\' /etc/pacman.conf
			sed -i -e '75iInclude = /etc/pacman.d/alhp-mirrorlist\' /etc/pacman.conf
			sed -i -e '76i\\' /etc/pacman.conf
			sed -i -e '83i[extra-x86-64-v4]\' /etc/pacman.conf
			sed -i -e '84iInclude = /etc/pacman.d/alhp-mirrorlist\' /etc/pacman.conf
			sed -i -e '85i\\' /etc/pacman.conf
			break
            ;;
    esac
done

pacman -Sy

echo -e ""
echo -e "Successfully installed ALHP repos"
echo -e ""

### Misc stuff
