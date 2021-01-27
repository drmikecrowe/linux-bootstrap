#!/usr/bin/env bash
# <help>Install basher</help>

setup

is_basher_installed() {
    # If you return true/1 here then it is already installed
    # [ "$(which basher)" != "" ]
    [ -d ~/.basher ]
}

install_basher() {
    echo "Installing basher now"
    git clone https://github.com/basherpm/basher.git ~/.basher
}

ask_install_basher() {
    is_basher_installed && return
    if ask "Install basher?"; then 
        type install_basher | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_basher

[ "$ALL" == "" ] && run_todo
