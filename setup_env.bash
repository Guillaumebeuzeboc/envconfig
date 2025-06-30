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
    sym_link ~/.git-clone-init .git-clone-init
    mkdir -p ~/.git-templates/hooks
    sym_link ~/.git-templates/hooks/post-checkout post-checkout
fi

echo "Do you want to install zsh & oh my zsh?"
USE_ZSH=0
yes_or_no
if [ $? == 0 ]
then
    USE_ZSH=1
    sudo apt install -y zsh curl git-lfs
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

echo "Do you want to install some fancy desktop tools?"
yes_or_no
if [ $? == 0 ]
then
    ## install regular debian pkgs
    TO_INSTALL=`cat tools_to_install`
    sudo apt install -y build-essential
    sudo apt install -y $TO_INSTALL

    echo "source ~/envconfig/.graphic.zsh" >> ~/.custom.zsh

    if [ ${USE_ZSH} == 1 ]
    then
        ## install gif_recorder
	# TODO adapt that to Wayland
        pushd utils ; make
        popd
    fi
fi
