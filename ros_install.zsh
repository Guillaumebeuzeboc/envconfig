#!/bin/zsh

rosi() {

    sudo apt install "ros-kinetic-$1"

}

_rosi() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local repositories=$(sed -n 's/Package: ros-kinetic-\([a-z_0-9-]*\)$/\1/p' /var/lib/apt/lists/packages.ros.org.*|sort|uniq)
    COMPREPLY=($(compgen -W "${repositories}" -- ${cur}))
    return 0
}
complete -F _rosi rosi
