#!/usr/bin/env bash
# <help>Install brave</help>

setup

is_brave_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which brave-browser)" != "" ]
    # [ -d /some/directory ]
}

install_brave() {
    echo "Installing brave now"
    sudo apt install apt-transport-https curl
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install -y brave-browser 
}

ask_install_brave() {
    is_brave_installed && return
    if ask "Install brave?"; then 
        type install_brave | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_brave

[ "$ALL" == "" ] && run_todo
