#!/usr/bin/env bash
# <help>Install spotify</help>

setup $1
    
is_spotify_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which spotify)" != "" ]
}

install_spotify() {
    echo "Installing spotify now"
    sudo snap install spotify
}

ask_install_spotify() {
    is_spotify_installed && return
    if ask "Install spotify?"; then 
        type install_spotify | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_spotify

[ "$ALL" == "" ] && run_todo
