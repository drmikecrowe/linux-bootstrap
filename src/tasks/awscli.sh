#!/usr/bin/env bash
# <help>Install awscli</help>

setup $1
    
is_awscli_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which aws)" != "" ]
}

install_awscli() {
    echo "Installing awscli now"
    sudo snap install aws-cli
}

ask_install_awscli() {
    is_awscli_installed && return
    if ask "Install awscli?"; then 
        type install_awscli | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_awscli

[ "$ALL" == "" ] && run_todo
