#!/bin/zsh

rosi() {

    sudo apt install "ros-melodic-$1"

}

_rosi() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local repositories=$(sed -n 's/Package: ros-melodic-\([a-z_0-9-]*\)$/\1/p' /var/lib/apt/lists/packages.ros.org_*|sort|uniq)
    COMPREPLY=($(compgen -W "${repositories}" -- ${cur}))
    return 0
}
complete -F _rosi rosi
