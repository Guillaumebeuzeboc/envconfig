#!/bin/zsh

snapcraft_here() {
    local startdir
    local go
    local count
    local end
    startdir=$(pwd)
    go=1
    while [ $go == 1 ]
    do
        count=$(pwd | grep -c '/snap/')
        end=$(pwd | grep -c /snap$)
        if [ $count == 0 ] && [ $end == 0 ]
        then
            go=0
        else
            cd ..
        fi
    done
    snapcraft
    cd $startdir
}

