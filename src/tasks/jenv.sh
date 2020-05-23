#!/usr/bin/env bash
# <help>Install jenv</help>

setup $1

is_jenv_installed() {
    # If you return true/1 here then it is already installed
    [ -d ~/.jenv ]
}

install_jenv() {
    echo "Installing jenv now"
    cd ~
    git clone https://github.com/jenv/jenv.git ~/.jenv
}

ask_install_jenv() {
    is_jenv_installed && return
    if ask "Install jenv?"; then 
        type install_jenv | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_jenv

[ "$ALL" == "" ] && run_todo
