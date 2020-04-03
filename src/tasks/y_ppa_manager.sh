#!/usr/bin/env bash
# <help>Install y_ppa_manager</help>

setup
    
is_y_ppa_manager_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which y-ppa-manager)" != "" ]
}

install_y_ppa_manager() {
    echo "Installing y_ppa_manager now"
    sudo add-apt-repository -y ppa:webupd8team/y-ppa-manager
    sudo apt install -y y-ppa-manager
}

ask_install_y_ppa_manager() {
    is_y_ppa_manager_installed && return
    if ask "Install y_ppa_manager?"; then 
        type install_y_ppa_manager | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_y_ppa_manager

[ "$ALL" == "" ] && run_todo
