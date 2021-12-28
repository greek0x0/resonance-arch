#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="resolinux-bareboned"
iso_label="RESOLINUX_$(date +%Y%m)"
iso_publisher="ResoLinux Team <https://github.com/cronos-hash>"
iso_application="ResoLinux Bareboned DVD"
iso_version="$(date +%Y.%m.%d)"

install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')

arch="x86_64"
pacman_conf="./pacman.conf"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')

file_permissions=(
  ["/etc/shadow"]="0:0:0400"
  ["/etc/gshadow"]="0:0:0400"
  ["/etc/sudoers"]="0:0:0440"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/bin/resonance-m"]="0:0:755"
  ["/usr/share/resonance/Scripts/resonance.bios"]="0:0:755"
  ["/usr/share/resonance/Scripts/resonance.uefi"]="0:0:755"
  ["/usr/share/resonance/Scripts/resonance-m"]="0:0:755"
  ["/usr/bin/background"]="0:0:755"
  ["/usr/bin/sk"]="0:0:755"
  ["/usr/bin/tweaks"]="0:0:755"
  ["/usr/bin/indefinite-picom"]="0:0:755"
)
# eof
