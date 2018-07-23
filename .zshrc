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

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

setopt no_share_history
alias l='ls -ah'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias apti='sudo apt-get install'
alias aptr='sudo apt-get remove'
alias kinetic='source /opt/ros/kinetic/setup.zsh'
alias tf='cd /var/tmp && rosrun tf view_frames && evince frames.pdf &'
alias del='rm -rf'
alias internet='ping 8.8.8.8'

source /opt/ros/kinetic/setup.zsh
source ~/envconfig/ros_install.zsh
source ~/.custom.zsh

