nordvpn_c(){
    sudo systemctl start nordvpnsd
    sleep 1
    nordvpn c $1
}
nordvpn_d(){
    nordvpn d
    sudo systemctl stop nordvpnsd
    sudo killall nordvpnud
}
