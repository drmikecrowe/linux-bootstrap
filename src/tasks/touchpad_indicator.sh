#!/usr/bin/env bash
# <help>Install touchpad_indicator</help>

setup
    
is_touchpad_indicator_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which touchpad_indicator)" != "" ]
}

install_touchpad_indicator() {
    echo "Installing touchpad-indicator now"
    sudo add-apt-repository -y  ppa:atareao/atareao
    sudo apt install -y touchpad-indicator
}

ask_install_touchpad_indicator() {
    is_touchpad_indicator_installed && return
    if ask "Install touchpad-indicator?" Y; then 
        type install_touchpad_indicator | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_touchpad_indicator

[ "$ALL" == "" ] && run_todo
