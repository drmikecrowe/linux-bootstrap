#!/usr/bin/env bash
# <help>Install docker</help>

setup $1
    
is_docker_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which docker)" != "" ]
}

install_docker() {
    echo "Installing docker now"
    sudo snap install docker
    sudo addgroup --system docker
    sudo usermod -aG docker $USER
}

ask_install_docker() {
    is_docker_installed && return
    if ask "Install docker?"; then 
        type install_docker | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_docker

[ "$ALL" == "" ] && run_todo
