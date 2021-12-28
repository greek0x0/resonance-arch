#!/bin/bash
# GNU/General Public License version 3.0

# -- Define Variables -- #

LCLST="en_US"
KEYMP="us"
KEYMOD="pc105"
MYUSERNM="reso"
MYUSRPASSWD="reso"
RTPASSWD="toor"
MYHOSTNM="resolinux-livecd"

# ---- Functions ----  #

rootuser () {  # root check
  if [[ "$EUID" = 0 ]]; then
    continue
  else
    echo -e "\e[1;31mERROR: ROOT IS REQUIRED\e[m"
    exit
  fi
}


handlerror () {  # error display
	clear
	set -uo pipefail
	trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
}


cleanup () {  # WD cleanup
	[[ -d ./eccolab ]] && rm -r ./eccolab
	[[ -d ./work ]] && rm -r ./work
	[[ -d ./out ]] && mv ./out ../
	sleep 2
}

prepreqs () {  # preparation and deps
	pacman -S --noconfirm archlinux-keyring
	pacman -S --needed --noconfirm archiso mkinitcpio-archiso
}

cpeccolab () {  # copy local repo into WD
	cp -r /usr/share/archiso/configs/releng/ ./eccolab

	rm -r ./eccolab/efiboot
	rm -r ./eccolab/syslinux
}


cpeccorepo () {  # copy local repo into /opt
	cp -r ./opt/eccojams /opt
}

rmeccorepo () {  # remove local repo from /opt (who even reads this?)
	rm -r /opt/eccojams 
}

nalogin () {  # disable autologin
	[[ -d ./eccolab/airootfs/etc/systemd/system/getty@tty1.service.d ]] && rm -r ./eccolab/airootfs/etc/systemd/system/getty@tty1.service.d
}

rmunitsd () {  # remove targets and reflector config
	[[ -d ./eccolab/airootfs/etc/systemd/system/cloud-init.target.wants ]] && rm -r ./eccolab/airootfs/etc/systemd/system/cloud-init.target.wants
	[[ -f ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/iwd.service ]] && rm ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/iwd.service
	[[ -f ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/qemu-guest-agent.service ]] && rm ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/qemu-guest-agent.service
	[[ -f ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/vboxservice.service ]] && rm ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/vboxservice.service
	[[ -f ./eccolab/airootfs/etc/xdg/reflector/reflector.conf ]] && rm ./eccolab/airootfs/etc/xdg/reflector/reflector.conf
}

addnmlinks () {  # enable base services
	[[ ! -d ./eccolab/airootfs/etc/systemd/system/sysinit.target.wants ]] && mkdir -p ./eccolab/airootfs/etc/systemd/system/sysinit.target.wants
	[[ ! -d ./eccolab/airootfs/etc/systemd/system/network-online.target.wants ]] && mkdir -p ./eccolab/airootfs/etc/systemd/system/network-online.target.wants
	[[ ! -d ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants ]] && mkdir -p ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants
	ln -sf /usr/lib/systemd/system/NetworkManager-wait-online.service ./eccolab/airootfs/etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service
	ln -sf /usr/lib/systemd/system/NetworkManager.service ./eccolab/airootfs/etc/systemd/system/multi-user.target.wants/NetworkManager.service
	ln -sf /usr/lib/systemd/system/NetworkManager-dispatcher.service ./eccolab/airootfs/etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service
	ln -sf /usr/lib/systemd/system/haveged.service ./eccolab/airootfs/etc/systemd/system/sysinit.target.wants/haveged.service
}



cpmyfiles () {  # copy files into iso
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

sethostname () {  # set hostname
	echo "${MYHOSTNM}" > ./eccolab/airootfs/etc/hostname
}

crtpasswd () {  # create passwd file
	echo "root:x:0:0:root:/root:/usr/bin/bash
"${MYUSERNM}":x:1010:1010::/home/"${MYUSERNM}":/bin/bash" > ./eccolab/airootfs/etc/passwd
}


crtgroup () {  # create groups
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
crtshadow () {  # create shadow file
	usr_hash=$(openssl passwd -6 "${MYUSRPASSWD}")
	root_hash=$(openssl passwd -6 "${RTPASSWD}")
	echo "root:"${root_hash}":14871::::::
"${MYUSERNM}":"${usr_hash}":14871::::::" > ./eccolab/airootfs/etc/shadow
}

crtgshadow () {  # create gshadow
	echo "root:!*::root
"${MYUSERNM}":!*::" > ./eccolab/airootfs/etc/gshadow
}


setkeylayout () {  # set kb layout
	echo "KEYMAP="${KEYMP}"" > ./eccolab/airootfs/etc/vconsole.conf
}


# Uncomment following function to create base X11 keyboard configuration

# crtkeyboard () {  
# mkdir -p ./eccolab/airootfs/etc/X11/xorg.conf.d
# echo "Section \"InputClass\"
#         Identifier \"system-keyboard\"
#         MatchIsKeyboard \"on\"
#         Option \"XkbLayout\" \""${KEYMP}"\"
#         Option \"XkbModel\" \""${KEYMOD}"\"
# EndSection" > ./eccolab/airootfs/etc/X11/xorg.conf.d/00-keyboard.conf
# }


crtlocalec () {  # 40-locale-gen.hook fix / locale.conf creation
	sed -i "s/en_US/"${LCLST}"/g" ./eccolab/airootfs/etc/pacman.d/hooks/40-locale-gen.hook
	echo "LANG="${LCLST}".UTF-8" > ./eccolab/airootfs/etc/locale.conf
}

runmkarchiso () {  # build iso
	mkarchiso -v -w ./work -o ./out ./eccolab
}


# -- installation steps -- #

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
# crtkeyboard
crtlocalec
runmkarchiso
rmeccorepo

# eof
