nordvpn_c(){
    sudo systemctl start nordvpnd
    sleep 1
    nordvpn c $1
}
nordvpn_d(){
    nordvpn d
    sudo systemctl stop nordvpnd
}
