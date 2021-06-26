#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias ddown='docker-compose down'
alias archcraft='update-archcraft-config --openbox'
alias archcraft2='update-archcraft-config --base'
#Important shortcuts
alias wallpaper='xwinwrap -g 1920x1080 -ni -s -nf -b -un -ov -fdt -argb -- mpv --mute=yes --no-audio --no-osc --no-osd-bar --quiet --screen=0 --geometry=1920x1080+0+0 -wid WID --loop $1'
alias isodrive='sudo mount /dev/sda1 /home/greek/media/iso'
alias audio='scream -i virbr0'
alias syslib='sudo systemctl start libvirtd.service'
alias win11='bash /home/greek/scripts/win11.sh'
alias virt='sudo virt-manager'
alias look1='looking-glass-client -F -G -m 63 opengl:vsync input:rawMouse opengl:vsync win:minimizeOnFocusLoss'
alias look2='looking-glass-client -G -m 63 input:rawMouse win:minimizeOnFocusLoss'
alias peak='looking-glass-client -d -a -m 63'
alias peak2='looking-glass-client -G -m 63 input:rawMouse win:minimizeOneFocusLoss win:borderless win:size=1780x1020'
alias peak3='looking-glass-client -G -m 63 input:rawMouse opengl:vsync win:borderless win:size=1920x1080'
alias macos='bash /home/greek/scripts/macos.sh'
alias win10='bash /home/greek/scripts/win10.sh'
alias shutdown='bash ~/scripts/virt-menu.sh'
alias song='youtube-dl --extract-audio -o "/home/greek/Music/%(title)s.%(ext)s" --audio-format mp3 $1'
alias music='mpc update && ncmpcpp'
alias dup='docker-compose up'
alias gc='git clone'
alias dshow='docker ps -a'
alias dexecute='docker exec -it'
alias crypto='cd /home/greek/miner && sudo python3 /home/greek/miner/crypto.py'
alias eth='curl rate.sx/$2'
alias bitcoin='curl rate.sx/BTC'
alias btc='curl rate.sx/btc'
alias xrp='curl rate.sx/xrp'
alias xmr='curl rate.sx/xmr'

alias viewalias='cat ~/.bashrc'
alias youtube='ytfzf -t'
alias vmlist='sudo virsh list --all'
alias vmstart='sudo virsh start'
alias vmforceoff='sudo virsh destroy'
alias edit='nvim'
alias image='sxiv'
alias detach='tmux detach'
alias attach='tmux attach'
alias new='tmux'
alias ls='exa'
alias cat='bat'
alias grep='rg'
alias nf='neofetch'
alias rebuildconfig='sudo mkinitcpio -p linux'
alias die='sudo shutdown -r now'
alias gimme='sudo pacman -S'
alias files='ranger'
alias cloud='ssh vps1'
alias backupbash='cp ~/.bashrc ~/.bashrc.bak'
alias copybash='cp ~/.bashrc.bak .'
alias search='bash ~/scripts/search.sh'
alias ipconfig='curl ifconfig.me/ip'
alias fuck='sudo $(history -p !!)'
alias yeet='sudo pacman -R'
alias l='abduco'
alias relax='sudo pacman -Syu'
alias editbash='nvim ~/.bashrc'
alias mine='sudo sysctl -w vm.nr_hugepages=128 && sudo ./xmr-stak-rx --noTest'
#alias nsesh='tmux new -s $1'
#alias osesh='tmux a -t $1'
#replace with abducoo ^
alias sesh='abduco -A $1 $2'
alias vpn='echo "mullvad relay list" && echo "mullvad commands" && echo "mullvad account get" && echo "mullvad relay set location" && echo "mullvad connect" && echo "mullvad status" && echo "mullvad relay update" && echo "mullvad auto-connect set on/off" && echo "mullvad-exclude <program>" && echo "mullvad split-tunnel pid list" && echo "mullvad split-tunnel pid add <pid>" && echo "mullvad split-tunnel pid delete <pid>" && echo "mullvad split-tunnel pid clear" '
alias sls='tmux ls'
alias ksesh='tmux kill-ses -t $1'
alias detach='tmux detach'
alias c="echo 'CMDS: isodrive, virt, macos, windows, linux, crypto, xmr, youtube, attach, detach, sls, nsesh, opsesh, die, relax, yeet, files, gimme, cloud , c' | lolcat"
eval "$(starship init bash)"
figlet -f small "comp" -w 10000 | lolcat
#mullvad status #NOT EVERYONE USES MULLVAD
task

