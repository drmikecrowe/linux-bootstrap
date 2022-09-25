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
    sudo snap install brave
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
