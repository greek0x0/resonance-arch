# ---- BASH Configuraion ---- #
# - by vicsave, greek


# -- Startup -- #
clear && [[ $- != *i* ]] && return

PS1="\[\e[34m\][ \[\e[m\]\[\e[36m\]\u\[\e[0m\]@\[\e[m\]\[\e[1;33m\]\h\[\e[m\] \[\e[37m\]\W\[\e[m\]\[\e[34m\]]\[\e[m\]\e[1;33m\n - >_\e[0m  "

# - feel urself like a hacker :)
echo "  -- Script Kiddie Park :: System Security Interface --" | lolcat
echo "    -- Booting up systems... :: User Logged IN found"    | lolcat

figlet -f slant $USER | lolcat

echo "
  -- Welcome Home! Here's your base aliases:
    - cb        : return back
    - neofetch  : colorized fetch
    - fuck      : fuck.
  -- Enjoy your freedom!
" | lolcat

[ -f "~/.bash/keep.bash" ] && . "~/.bash/keep"


# -- Configuration -- #
LS_COLORS='di=35:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export LS_COLORS



# -- User Aliases -- #
alias cb="cd .."
alias neofetch="neofetch | lolcat"
alias fuck='sudo $(history -p !!)'

# - Crypto rates - #
alias eth='curl rate.sx/$2'
alias bitcoin='curl rate.sx/BTC'
alias btc='curl rate.sx/btc'
alias xrp='curl rate.sx/xrp'
alias xmr='curl rate.sx/xmr'

# - Goodbye - #
alias emergency="shred -uzvn3"

# - Git - #
alias gc="git clone"
alias gp="git push"
