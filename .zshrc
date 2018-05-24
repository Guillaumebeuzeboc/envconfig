# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="afowler"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

setopt no_share_history
alias l='ls -ah'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias apti='sudo apt-get install'
alias aptr='sudo apt-get remove'
alias kinetic='source /opt/ros/kinetic/setup.zsh'
alias tf='cd /var/tmp && rosrun tf view_frames && evince frames.pdf &'
source /opt/ros/kinetic/setup.zsh

case $- in *i*)
  if [ -z "$TMUX" ]; then exec tmux; fi;;
esac
