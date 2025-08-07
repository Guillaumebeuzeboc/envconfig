#!/usr/bin/zsh

remote_snapcraft() {
    local start_path
    local start_dir
    start_path=$(pwd)
    start_dir=$(basename ${start_path})
    cd ../
    rsync -rz --hard-links --perms --executability --delete --force --links "./${start_dir}" titan@titan.local:/home/titan/snapcraft_runs/
    cd -
    ssh -t titan@titan.local "cd ~/snapcraft_runs/${start_dir}; SNAPCRAFT_ENABLE_EXPERIMENTAL_EXTENSIONS=1 snapcraft --use-lxd --verbose --debug"
    scp "titan@titan.local:/home/titan/snapcraft_runs/${start_dir}/*.snap" .
}

remote_snapcraft_clean() {
    local start_path
    local start_dir
    start_path=$(pwd)
    start_dir=$(basename ${start_path})
    ssh -t titan@titan.local "cd ~/snapcraft_runs/${start_dir}; SNAPCRAFT_ENABLE_EXPERIMENTAL_EXTENSIONS=1 snapcraft clean --use-lxd --verbose" 
    ssh -t titan@titan.local "cd ~/snapcraft_runs/${start_dir}; rm -Rf *" 
}

remote_charmcraft() {
    local start_path
    local start_dir
    start_path=$(pwd)
    start_dir=$(basename ${start_path})
    cd ../
    rsync -rz --hard-links --perms --executability --delete --force --links "./${start_dir}" titan@titan.local:/home/titan/charmcraft_runs/
    cd -
    ssh -t titan@titan.local "cd ~/charmcraft_runs/${start_dir}; charmcraft pack --verbose --debug"
    scp "titan@titan.local:/home/titan/charmcraft_runs/${start_dir}/*.charm" .
}

remote_charmcraft_clean() {
    local start_path
    local start_dir
    start_path=$(pwd)
    start_dir=$(basename ${start_path})
    ssh -t titan@titan.local "cd ~/charmcraft_runs/${start_dir}; charmcraft clean --verbose"
    ssh -t titan@titan.local "cd ~/charmcraft_runs/; rm -Rf ${start_dir}"
}

poweroff_titan() {
    ssh -t titan@titan.local "sudo poweroff" 
}

