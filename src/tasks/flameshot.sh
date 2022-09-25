#!/usr/bin/env bash
# <help>Install flameshot</help>

setup

is_flameshot_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which flameshot)" != "" ]
}

install_flameshot() {
    echo "Installing flameshot now"
    sudo snap install flameshot
}

ask_install_flameshot() {
    is_flameshot_installed && return
    if ask "Install flameshot?"; then 
        type install_flameshot | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_flameshot

[ "$ALL" == "" ] && run_todo
