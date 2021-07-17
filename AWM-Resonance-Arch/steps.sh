#!/bin/bash

# (GNU/General Public License version 3.0)

# ----------------------------------------
# Define Variables
# ----------------------------------------

LCLST="en_US"
# Format is language_COUNTRY where language is lower case two letter code
# and country is upper case two letter code, separated with an underscore

KEYMP="us"
# Use lower case two letter country code

KEYMOD="pc105"
# pc105 and pc104 are modern standards, all others need to be researched

MYUSERNM="live"
# use all lowercase letters only

MYUSRPASSWD="live"
# Pick a password of your choice

RTPASSWD="toor"
# Pick a root password

MYHOSTNM="resonance"
# Pick a hostname for the machine

# ----------------------------------------
# Functions
# ----------------------------------------

# Test for root user
rootuser () {
  if [[ "$EUID" = 0 ]]; then
    continue
  else
    echo "Please Run As Root"
    sleep 2
    exit
  fi
}

# Display line error
handlerror () {
clear
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
}

# Clean up working directories
cleanup () {
[[ -d ./eccolab ]] && rm -r ./eccolab
[[ -d ./work ]] && rm -r ./work
[[ -d ./out ]] && mv ./out ../
sleep 2
}

# Requirements and preparation
prepreqs () {
pacman -S --noconfirm archlinux-keyring
pacman -S --needed --noconfirm archiso mkinitcpio-archiso
}

# Copy eccolab to working directory
cpeccolab () {
cp -r /usr/share/archiso/configs/releng/ ./eccolab
rm -r ./eccolab/efiboot
rm -r ./eccolab/syslinux
#remove other themes and fonts
}

# Copy repo to opt
cpeccorepo () {
cp -r ./opt/eccojams /opt/
}

# Remove repo from opt
rmeccorepo () {
rm -r /opt/eccojams
}

# Delete automatic login
nalogin () {
[[ -d ./eccolab/airootfs/etc/systemd/system/getty@tty1.service.d ]] && rm -r ./eccolab/airootfs/etc/systemd/system/getty@tty1.service.d
}

# Remove cloud-init and other stuff
rmunitsd () {
[[ -d ./eccolab/airootfs/etc/systemd/system/cloud-init.target.wants ]] && rm -r ./eccolab/airootfs/etc/systemd/system/cloud-init.target.wants
[[ -f ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/iwd.service ]] && rm ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/iwd.service
[[ -f ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/qemu-guest-agent.service ]] && rm ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/qemu-guest-agent.service
[[ -f ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/vboxservice.service ]] && rm ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/vboxservice.service
[[ -f ./eccolab/airootfs/etc/xdg/reflector/reflector.conf ]] && rm ./eccolab/airootfs/etc/xdg/reflector/reflector.conf
}

# Add NetworkManager, lightdm, & haveged systemd links
addnmlinks () {
[[ ! -d ./eccolab/airootfs/etc/systemd/system/sysinit.target.wants ]] && mkdir -p ./eccolab/airootfs/etc/systemd/system/sysinit.target.wants
[[ ! -d ./eccolab/airootfs/etc/systemd/system/network-online.target.wants ]] && mkdir -p ./eccolab/airootfs/etc/systemd/system/network-online.target.wants
[[ ! -d ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants ]] && mkdir -p ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants
ln -sf /usr/lib/systemd/system/NetworkManager-wait-online.service ./eccolab/airootfs/etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service
ln -sf /usr/lib/systemd/system/NetworkManager.service ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/NetworkManager.service
ln -sf /usr/lib/systemd/system/NetworkManager-dispatcher.service ./eccolab/airootfs/etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service
ln -sf /usr/lib/systemd/system/lightdm.service ./eccolab/airootfs/etc/systemd/system/display-manager.service
ln -sf /usr/lib/systemd/system/haveged.service ./eccolab/airootfs/etc/systemd/system/sysinit.target.wants/haveged.service
}

# Copy files to customize the ISO
cpmyfiles () {
cp packages.x86_64 ./eccolab/
cp pacman.conf ./eccolab/
cp profiledef.sh ./eccolab/
cp -r efiboot ./eccolab/
cp -r syslinux ./eccolab/
cp -r usr ./eccolab/airootfs/
cp -r etc ./eccolab/airootfs/
cp -r opt ./eccolab/airootfs/
ln -sf /usr/share/resonance ./eccolab/airootfs/etc/skel/resonance
}

# Set hostname
sethostname () {
echo "${MYHOSTNM}" > ./eccolab/airootfs/etc/hostname
}

# Create passwd file
crtpasswd () {
echo "root:x:0:0:root:/root:/usr/bin/bash
"${MYUSERNM}":x:1010:1010::/home/"${MYUSERNM}":/bin/bash" > ./eccolab/airootfs/etc/passwd
}

# Create group file
crtgroup () {
echo "root:x:0:root
sys:x:3:"${MYUSERNM}"
adm:x:4:"${MYUSERNM}"
wheel:x:10:"${MYUSERNM}"
log:x:19:"${MYUSERNM}"
network:x:90:"${MYUSERNM}"
floppy:x:94:"${MYUSERNM}"
scanner:x:96:"${MYUSERNM}"
power:x:98:"${MYUSERNM}"
rfkill:x:850:"${MYUSERNM}"
users:x:985:"${MYUSERNM}"
video:x:860:"${MYUSERNM}"
storage:x:870:"${MYUSERNM}"
optical:x:880:"${MYUSERNM}"
lp:x:840:"${MYUSERNM}"
audio:x:890:"${MYUSERNM}"
"${MYUSERNM}":x:1010:" > ./eccolab/airootfs/etc/group
}

# Create shadow file
crtshadow () {
usr_hash=$(openssl passwd -6 "${MYUSRPASSWD}")
root_hash=$(openssl passwd -6 "${RTPASSWD}")
echo "root:"${root_hash}":14871::::::
"${MYUSERNM}":"${usr_hash}":14871::::::" > ./eccolab/airootfs/etc/shadow
}

# create gshadow file
crtgshadow () {
echo "root:!*::root
"${MYUSERNM}":!*::" > ./eccolab/airootfs/etc/gshadow
}

# Set the keyboard layout
setkeylayout () {
echo "KEYMAP="${KEYMP}"" > ./eccolab/airootfs/etc/vconsole.conf
}

# Create 00-keyboard.conf file
crtkeyboard () {
mkdir -p ./eccolab/airootfs/etc/X11/xorg.conf.d
echo "Section \"InputClass\"
        Identifier \"system-keyboard\"
        MatchIsKeyboard \"on\"
        Option \"XkbLayout\" \""${KEYMP}"\"
        Option \"XkbModel\" \""${KEYMOD}"\"
EndSection" > ./eccolab/airootfs/etc/X11/xorg.conf.d/00-keyboard.conf
}

# Fix 40-locale-gen.hook and create locale.conf
crtlocalec () {
sed -i "s/en_US/"${LCLST}"/g" ./eccolab/airootfs/etc/pacman.d/hooks/40-locale-gen.hook
echo "LANG="${LCLST}".UTF-8" > ./eccolab/airootfs/etc/locale.conf
}

# Start mkarchiso
runmkarchiso () {
mkarchiso -v -w ./work -o ./out ./eccolab
}


rootuser
handlerror
prepreqs
cleanup
cpeccolab
addnmlinks
cpeccorepo
nalogin
rmunitsd
cpmyfiles
sethostname
crtpasswd
crtgroup
crtshadow
crtgshadow
setkeylayout
crtkeyboard
crtlocalec
runmkarchiso
rmeccorepo

