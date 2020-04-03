#!/usr/bin/env bash
# <help>Install opera</help>

setup

is_opera_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which opera)" != "" ]
}

install_opera() {
    echo "Installing opera now"
    sudo snap install opera
}

ask_install_opera() {
    is_opera_installed && return
    if ask "Install opera?"; then 
        type install_opera | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_opera

[ "$ALL" == "" ] && run_todo
