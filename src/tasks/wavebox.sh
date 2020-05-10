#!/usr/bin/env bash
# <help>Install wavebox</help>

setup $1
    
is_wavebox_installed() {
    # If you return true/1 here then it is already installed
    [ -f /opt/wavebox/Wavebox ]
}

install_wavebox() {
    echo "Installing wavebox now"
    sudo wget -qO - https://wavebox.io/dl/client/repo/archive.key | sudo apt-key add -
    echo "deb https://wavebox.io/dl/client/repo/ x86_64/" | sudo tee /etc/apt/sources.list.d/wavebox.list
    sudo apt update
    sudo apt install -y wavebox ttf-mscorefonts-installer
}

ask_install_wavebox() {
    is_wavebox_installed && return
    if ask "Install wavebox?"; then 
        type install_wavebox | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_wavebox

[ "$ALL" == "" ] && run_todo
