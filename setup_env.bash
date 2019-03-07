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

#the first args is where is the current one
#and the second one is the name of it in envconfig
sym_link() {
    if [ -f $1 ]; then
        mv $1 $1.back
    fi
    ln -s "${DIR}/$2" $1
}

sudo apt update
sudo apt upgrade -y
sudo apt install vim

echo "Do you want to install and configure GIT?"
yes_or_no
if [ $? == 0 ]
then
    sudo apt install -y git
    sym_link ~/.gitconfig .gitconfig
fi

echo "Do you want to install zsh & oh my zsh?"
yes_or_no
if [ $? == 0 ]
then
    sudo apt install -y zsh curl
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed '/\s*env\s\s*zsh\s*/d')"
    sym_link ~/.zshrc .zshrc
    touch ~/.custom.zsh
    echo "zsh config: Done!"
fi

echo "Do you want to install tmux?"
yes_or_no
if [ $? == 0 ]
then
    sudo apt install -y tmux xclip
    sym_link ~/.tmux.conf .tmux.conf
    echo "tmux config: Done!"
fi

echo "Should we personalize userChrome of FireFox?"
yes_or_no
if [ $? == 0 ]
then
    sudo apt install -y firefox
    echo "Please enter the absolute path of the FF user (~/.mozilla/firefox/SOMETHING.default):"
    read
    FFDIR=$REPLY/chrome
    mkdir $FFDIR
    sym_link $FFDIR/userChrome.css userChrome.css
fi

echo "Do you want to install translate-shell?"
yes_or_no
if [ $? == 0 ]
then
    sudo apt install -y wget gawk
    mkdir ${DIR}/install
    wget git.io/trans -P ${DIR}/install
    chmod +x ${DIR}/install/trans
fi

echo "Do you want to install ag?"
yes_or_no
if [ $? == 0 ]
then
    sudo apt install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev autotools-dev clang-format
    pushd /tmp; git clone https://github.com/ggreer/the_silver_searcher.git; cd the_silver_searcher
    ./build.sh
    sudo make install
    popd
fi

echo "Do you want to install some fancy desktop tools?"
yes_or_no
if [ $? == 0 ]
then
    TO_INSTALL=`cat tools_to_install`
    sudo apt install -y $TO_INSTALL
fi
