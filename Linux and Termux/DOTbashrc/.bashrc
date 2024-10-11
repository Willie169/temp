##This is ~./bashrc

alias cptorcc='cp ~/.torrc_file/charging/torrc $PREFIX/etc/tor/torrc'
alias cptorncc='cp ~/.torrc_file/notcharging/torrc $PREFIX/etc/tor/torrc'

torch() {
    battery_status=$(termux-battery-status)
    is_charging=$(echo "$battery_status" | grep -o '"status": "CHARGING"')
    pkill -f "^tor$"
    echo -e "Is charging: $is_charging\n"
    
    if [[ $is_charging == *"CHARGING"* ]]; then
        cptorcc
    else
        cptorncc
    fi
}

torr() {
    if pgrep -x "tor" > /dev/null; then
        echo -e "Tor is already running.\n"
    else
        echo -e "Running torch and tor.\n"
        torch &
        tmux new-session -d -s tor_session "tor"
    fi
}

torc() {
    pkill -f "^tor$"
    cptorcc
    tmux new-session -d -s tor_session "tor"
}

alias tors='torsocks'

mvod() {
    mv "/data/data/com.termux/files/home/debian1/debian-fs/root/Desktop/$1" "/storage/emulated/0/Download/"
}

cpod() {
    cp "/data/data/com.termux/files/home/debian1/debian-fs/root/Desktop/$1" "/storage/emulated/0/Download/"
}

cprod() {
    cp -r "/data/data/com.termux/files/home/debian1/debian-fs/root/Desktop/$1" "/storage/emulated/0/Download/"
}

mvid() {
    mv "/storage/emulated/0/Download/$1" "/data/data/com.termux/files/home/debian1/debian-fs/root/Desktop/"
}

cpid() {
    cp "/storage/emulated/0/Download/$1" "/data/data/com.termux/files/home/debian1/debian-fs/root/Desktop/"
}

cprid() {
    cp -r "/storage/emulated/0/Download/$1" "/data/data/com.termux/files/home/debian1/debian-fs/root/Desktop/"
}

mvic() {
    mv "/storage/emulated/0/Download/$1" .
}

cpic() {
    cp "/storage/emulated/0/Download/$1" .
}

cpric() {
    cp -r "/storage/emulated/0/Download/$1" .
}

mvoc() {
    mv "$1" "/storage/emulated/0/Download"
}

cpoc() {
    cp "$1" "/storage/emulated/0/Download"
}

cproc() {
    cp -r "$1" "/storage/emulated/0/Download"
}
