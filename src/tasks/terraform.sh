#!/usr/bin/env bash
# <help>Install terraform</help>

setup $1
    
is_terraform_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which terraform)" != "" ]
}

install_terraform() {
    echo "Installing terraform now"
    sudo snap install terraform
}

ask_install_terraform() {
    is_terraform_installed && return
    if ask "Install terraform?"; then 
        type install_terraform | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_terraform

[ "$ALL" == "" ] && run_todo
