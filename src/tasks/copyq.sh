#!/usr/bin/env bash
# <help>Install copyq</help>

setup
    
is_copyq_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which copyq)" != "" ]
}

install_copyq() {
    echo "Installing copyq now"
    sudo add-apt-repository -y  ppa:hluk/copyq
    sudo apt install -y copyq
}

ask_install_copyq() {
    is_copyq_installed && return
    if ask "Install copyq?"; then 
        type install_copyq | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_copyq

[ "$ALL" == "" ] && run_todo

