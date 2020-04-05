#!/usr/bin/env bash
# <help>Install xonsh</help>

setup

is_xonsh_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which xonsh)" != "" ]
}

install_xonsh() {
    echo "Installing xonsh now"
    pip install xonsh
    sudo chsh -s $(which xonsh) $USER
}

ask_install_xonsh() {
    is_xonsh_installed && return
    if ask "Install xonsh?"; then 
        type install_xonsh | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_xonsh

[ "$ALL" == "" ] && run_todo
