#!/usr/bin/env bash
# <help>Install etckeeper</help>

setup $1
    
is_etckeeper_installed() {
    # If you return true/1 here then it is already installed
    [ -d /etc/etckeeper ]
}

install_etckeeper() {
    echo "Installing etckeeper now"

    sudo apt install -y etckeeper
    sudo sed -i 's/^VCS=/#VCS/' /etc/etckeeper/etckeeper.conf
    sudo sed -i 's/^#?VCS=.*git.*/VCS="git"/' /etc/etckeeper/etckeeper.conf
    cd /etc
    set +e
    sudo etckeeper init
    set -e
    sudo etckeeper commit "Initial checkin"
}

ask_install_etckeeper() {
    is_etckeeper_installed && return
    if ask "Install etckeeper?"; then 
        type install_etckeeper | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_etckeeper

[ "$ALL" == "" ] && run_todo
