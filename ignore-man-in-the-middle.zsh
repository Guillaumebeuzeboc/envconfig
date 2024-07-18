#!/bin/zsh

function ignore_man_in_the_middle {
 LAST_CMD=$(fc -ln -1)
 IS_SSH=$(echo $LAST_CMD | awk '{print $1}')
 if [[ "$IS_SSH" != "ssh" ]]; then
   echo "not an ssh command, bye..."
   return 1
 fi
 IP=$(echo $LAST_CMD | awk -F"@" '{print $2}')
 echo $IP
 ssh-keygen -f "/home/$USER/.ssh/known_hosts" -R "$IP"
}
