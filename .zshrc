# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

autoload bashcompinit
bashcompinit

plugins=(
  zsh-syntax-highlighting
)

export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="afowler"

plugins=(git)

source $ZSH/oh-my-zsh.sh

PROMPT='[%D{%L:%M:%S}] '$PROMPT

export EDITOR='vim'
export WWW_HOME='google.co.fr'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

setopt no_share_history
alias l='ls -ah'
alias ll='ls -alh'
alias ld='du -h -d 1'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias apti='sudo apt-get install'
alias aptr='sudo apt-get remove'
alias xc='xclip -selection clipboard'
alias del='rm -rf'
alias internet='ping 8.8.8.8'
alias Ginternet='ping www.google.com'
alias s='sudo'
alias fixsshtmux='export $(tmux showenv SSH_AUTH_SOCK)' # Need this first: ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
alias szsh='source ~/.zshrc'
alias gs='git status'
alias n='nvim'
#ROS
alias tf='cd /var/tmp && rosrun tf view_frames && okular frames.pdf &'
#translate shell
alias trans='~/envconfig/install/trans'
#gif_recorder
alias gif_recorder='~/envconfig/utils/gif_recorder'
#dos2unix
alias dos2unix_everything='find . -type f -print0 | xargs -0 dos2unix'
#Python
alias create_venv='python3 -m venv .venv'
alias activate_venv='. .venv/bin/activate'

# snap
alias snappy-debug='sudo sysctl -w kernel.printk_ratelimit=0 ; journalctl --follow | grep audit'

# KDE
alias restart-plasma='plasmashell --replace &'
# remove any snap/multipass vm
alias nuke-multipass='multipass stop --all && multipass delete --all && multipass purge && sudo snap restart multipass'

# LXD
alias lxd-vm='echo "lxc launch ubuntu:24.04 vm-name --vm -c limits.cpu=8 -c limits.memory=8GiB -d root,size=40GiB"'
alias lxd-desktop-vm='echo "lxc launch images:ubuntu/22.04/desktop ubuntu --vm -c limits.cpu=4 -c limits.memory=8GiB -d root,size=40GiB --console=vga"'

# VSCode
alias code='code --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations'

# tmux
bindkey -s ^f "/usr/local/bin/tmux-sessionizer\n"

source ~/envconfig/ros_install.zsh
source ~/envconfig/beuzclone.zsh
source ~/envconfig/serial_monitor.zsh
source ~/envconfig/snapcraft.zsh
source ~/envconfig/super_cd.zsh
source ~/envconfig/ignore-man-in-the-middle.zsh
source ~/envconfig/remote_snapcraft.zsh

source ~/.custom.zsh

