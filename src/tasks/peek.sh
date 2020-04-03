#!/usr/bin/env bash
# <help>Install peek</help>

setup
    
is_peek_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which peek)" != "" ]
}

install_peek() {
    echo "Installing peek now"
    sudo add-apt-repository -y ppa:peek-developers/stable
    sudo apt install -y peek
}

ask_install_peek() {
    is_peek_installed && return
    if ask "Install peek?"; then 
        type install_peek | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_peek

[ "$ALL" == "" ] && run_todo
