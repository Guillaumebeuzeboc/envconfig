#!/bin/zsh

beuzclone() {
    git clone git@github.com:Guillaumebeuzeboc/$1.git

}

_beuzclone() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local repo=$(curl "https://api.github.com/users/Guillaumebeuzeboc/repos?per_page=100" 2>/dev/null | awk ' /'git@'/ {print $2}' | sed -e 's/.*[/]\(.*\)[.]git.*/\1/')
    COMPREPLY=($(compgen -W "${repo}" -- ${cur}))
    return 0
}
complete -F _beuzclone beuzclone
