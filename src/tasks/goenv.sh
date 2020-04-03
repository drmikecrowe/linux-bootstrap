#!/usr/bin/env bash
# <help>Install goenv</help>

setup

is_goenv_installed() {
    # If you return true/1 here then it is already installed
    [ -d ~/.goenv ]
}

install_goenv() {
    echo "Installing goenv now"
    cd ~
    wget -q https://github.com/drmikecrowe/goenv-installer/raw/master/bin/goenv-installer -O- | bash
}

ask_install_goenv() {
    is_goenv_installed && return
    if ask "Install goenv?"; then 
        type install_goenv | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_goenv

[ "$ALL" == "" ] && run_todo
