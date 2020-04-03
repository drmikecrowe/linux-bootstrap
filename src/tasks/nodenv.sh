#!/usr/bin/env bash
# <help>Install nodenv</help>

setup
    
is_nodenv_installed() {
    # If you return true/1 here then it is already installed
    [ -d ~/.nodenv ]
}

install_nodenv() {
    echo "Installing nodenv now"
    cd ~
    wget -q https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer -O- | bash
}

ask_install_nodenv() {
    is_nodenv_installed && return
    if ask "Install nodenv?"; then 
        type install_nodenv | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_nodenv

[ "$ALL" == "" ] && run_todo
