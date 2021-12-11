#
# ~/.bashrc
#
#timeout -k 1 1 ~/./endoh1 < endoh1.c | lolcat
clear
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias cb='cd ..' #change back
PS1="\[\e[34m\][\[\e[m\]\[\e[35m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[1;33m\]\h\[\e[m\] \[\e[36m\]\W\[\e[m\]\[\e[34m\]]\[\e[m\]\e[1;33m\n:  "
echo "
  Script Kiddie Park, System Security Interface
  "
LS_COLORS='di=35:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export LS_COLORS
#set -o vi #vim configuration for prompt
alias ddown='docker-compose down'
#Important shortcuts
alias wallpaper='xwinwrap -g 1920x1080 -ni -s -nf -b -un -ov -fdt -argb -- mpv --mute=yes --no-audio --no-osc --no-osd-bar --quiet --screen=0 --geometry=1920x1080+0+0 -wid WID --loop $1'
alias isodrive='sudo mount /dev/sda1 /home/greek/media/iso'
alias audio='scream -i virbr0'
alias syslib='sudo systemctl start libvirtd.service'
alias win11='bash /home/greek/scripts/win11.sh'
alias virt='sudo virt-manager'
#input:rawMouse
alias peak='looking-glass-client -G -m 63 input:rawMouse spice:alwaysShowCursor win:borderless win:size=3440x1440'
alias macos='bash /home/greek/scripts/macos.sh'
alias win10='bash /home/greek/scripts/win10.sh'
alias shutdown='bash ~/scripts/virt-menu.sh'
alias song='youtube-dl --extract-audio -o "/home/greek/Music/%(title)s.%(ext)s" --audio-format mp3 $1'
alias music='mpc update && ncmpcpp'
alias sound='scream -m /dev/shm/scream-ivshmem'
alias dup='docker-compose up'
alias gc='git clone'
alias dshow='docker ps -a'
alias dexecute='docker exec -it'
alias crypto='cd /home/greek/miner && sudo python3 /home/greek/miner/crypto.py'
alias regen='sudo mkinitcpio -p linux'
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
alias ls='lsd'
#alias cat='bat'
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
alias l='tmux ls'
alias d='detach'
alias relax='sudo pacman -Syu'
alias editbash='nvim ~/.bashrc'
alias mine='sudo sysctl -w vm.nr_hugepages=128 && sudo ./xmr-stak-rx --noTest'
alias nsesh='tmux new -s $1'
alias osesh='tmux a -t $1'
alias yt='ytfzf -t'
#replace with abducoo ^
alias sesh='tmux a -t $1'
alias s='tmux a -t $1'
alias S='code'
alias gpgsearch='pg --keyserver keyserver.ubuntu.com --search-keys $1'
alias ksesh='tmux kill-ses -t $1'
alias detach='tmux detach'
alias c="echo 'CMDS: isodrive, virt, macos, windows, linux, crypto, xmr, youtube, attach, detach, sls, nsesh, opsesh, die, relax, yeet, files, gimme, cloud , c' | lolcat"
#export PATH="$PATH:/home/$USER/bin" #for xmonad
#figlet -f catwalk "comp" -w 10000 | lolcat
#cowsay come here often? | lolcat -a -s 400
figlet -f slant "greek" | lolcat 
mullvad status | lolcat
#mullvad status | lolcat
alias p='keep'
#task | lolcat
ip addr | grep "inet" | lolcat
tmux ls
alias vim='nvim'
alias gh="cat ~/repo/token/token && git push"
#export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33'
#cowsay enter the sk command to get started | lolcat
#fm6000 -f ~/Art -o 'Resonance Arch' -n -c blue
alias erase='shred -uzvn3'
#colorscript random
#gif-for-cli /home/greek/IsWDJWa.gif | lolcat
timeout --foreground 0.455s asciiquarium

 [ -f "~/.bash/keep.bash" ] && . "~/.bash/keep"
