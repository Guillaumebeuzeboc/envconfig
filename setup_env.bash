#!/bin/bash
YES_ALL=false
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ "$1" == "--yes-all" ]]
then
    YES_ALL=true
fi

yes_or_no () {
    echo "answer by [yY/nN]"
    if [[ $yes_all == true ]]
    then
        return 0
    fi
    read
    if [[ $REPLY == [yY] ]]
    then
        return 0
    elif [[ $REPLY == [nN] ]]
    then
        return 1
    else
        yes_or_no
        return $?
    fi
}

echo "Do you want to install zsh & oh my zsh?"
yes_or_no
if [ $? == 0 ]
then
    sudo apt install zsh curl
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    if [ -f ~/.zshrc ]; then
        mv ~/.zshrc ~/.zshrc.back
    fi
    ln -s "${DIR}/.zshrc" ~/.zshrc
    echo "zsh config: Done!"
fi

echo "Do you want to install tmux?"
yes_or_no
if [ $? == 0 ]
then
    sudo apt install tmux
    if [ -f ~/.tmux.conf ]; then
        mv ~/.tmux.conf ~/.tmux.conf.back
    fi
    ln -s "${DIR}/.tmux.conf" ~/.tmux.conf
    echo "tmux config: Done!"
fi

echo "Should we personalize FireFox?"
yes_or_no
if [ $? == 0 ]
then
    FFDIR=~/.mozilla/firefox/*.default/chrome
    if [ -f ${FFDIR}/userChrome.css ]; then
        mv ${FFDIR}/userChrome ${FFDIR}/userChrome.css.back
    fi
    cd ~/.mozilla/firefox/*.default
    mkdir chrome
    ln -s "${DIR}/.tmux.conf" ${FFDIR}/userChrome.css
fi

