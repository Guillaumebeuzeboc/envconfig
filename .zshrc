# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

autoload bashcompinit
bashcompinit

export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="afowler"

plugins=(git)

source $ZSH/oh-my-zsh.sh

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
alias del='rm -rf'
alias fixsshtmux='export $(tmux showenv SSH_AUTH_SOCK)' # Need this first: ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
alias szsh='source ~/.zshrc'
#ROS
alias tf='cd /var/tmp && rosrun tf view_frames && okular frames.pdf &'
#translate shell
alias trans='~/envconfig/install/trans'
#gif_recorder
alias gif_recorder='~/envconfig/utils/gif_recorder'

source ~/envconfig/ros_install.zsh
source ~/envconfig/beuzclone.zsh
source ~/envconfig/nordvpn.zsh
source ~/envconfig/serial_monitor.zsh

source ~/.custom.zsh

