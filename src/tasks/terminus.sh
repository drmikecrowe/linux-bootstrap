#!/usr/bin/env bash
# <help>Install terminus</help>

setup $1

is_terminus_installed() {
    [ "$(which terminus)" != "" ]
}

install_terminus() {
    echo "Installing terminus now"
    wget -qO- "https://mc-installer.herokuapp.com/Eugeny/terminus!?type=script" | bash
}

ask_install_terminus() {
    is_terminus_installed && return
    if ask "Install terminus?"; then 
        type install_terminus | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_terminus

[ "$ALL" == "" ] && run_todo
