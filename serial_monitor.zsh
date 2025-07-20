serial_monitor(){
    #socat stdio $(/dev/$1) | grep -v $("$2")
    if [ "$#" -eq 2 ]; then
      socat stdio $1,b115200,raw | grep -v "$2"
    else
      socat stdio $1,b115200,raw
    fi
}
