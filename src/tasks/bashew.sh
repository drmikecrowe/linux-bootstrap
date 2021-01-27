#!/usr/bin/env bash
# <help>Install bashew</help>

setup

is_bashew_installed() {
    [ "$(which bashew)" != "" ]
}

install_bashew() {
    echo "Installing bashew (bash script / project creator) now"
    # INSTALL CODE HERE
}

ask_install_bashew() {
    is_bashew_installed && return
    if ask "Install bashew?"; then 
        type install_bashew | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_bashew

[ "$ALL" == "" ] && run_todo
