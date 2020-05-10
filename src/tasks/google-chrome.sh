#!/usr/bin/env bash
# <help>Install google-chrome</help>

setup $1
    
is_google-chrome_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which google-chrome-beta)" != "" ]
}

install_google-chrome() {
    echo "Installing google-chrome now"
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo rm -f /etc/apt/sources.list.d/google-chrome*
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update
    sudo apt install -y google-chrome-beta chrome-gnome-shell
}

ask_install_google-chrome() {
    is_google-chrome_installed && return
    if ask "Install google-chrome?"; then 
        type install_google-chrome | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_google-chrome

[ "$ALL" == "" ] && run_todo
