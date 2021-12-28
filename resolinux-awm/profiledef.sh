#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="resonance-arch"
iso_label="RESONANCE-ARCH_$(date +%Y%m)"
iso_publisher="Resonance Arch <https://github.com/cronos-hash>"
iso_application="Resonance Arch DVD"
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
  ["/etc/skel/.config/awesome/theme-changer/cyberpunk/cyberpunk.sh"]="0:0:755"
  ["/etc/skel/.config/awesome/theme-changer/trains/trains.sh"]="0:0:755"
  ["/etc/skel/.config/awesome/current_theme/theme.sh"]="0:0:755"
  ["/usr/bin/sk"]="0:0:755"
  ["/usr/bin/theme"]="0:0:755"
  ["/usr/bin/resonance"]="0:0:755"
  ["/usr/bin/tweaks"]="0:0:755"
  ["/usr/bin/indefinite-picom"]="0:0:755"
  ["/etc/skel/.config/rofi/bin/launcher"]="0:0:755"
  ["/etc/skel/.config/rofi/bin/mpd"]="0:0:755"
  ["/etc/skel/.config/rofi/bin/network"]="0:0:755"
  ["/etc/skel/.config/rofi/bin/powermenu"]="0:0:755"
  ["/etc/skel/.config/rofi/bin/screenshot"]="0:0:755"
)