#!/usr/bin/env bash
# <help>Install dotbare</help>

setup

is_dotbare_installed() {
    [ -d ~/.dotbare ]
}

install_dotbare() {
    echo "Installing dotbare now"
    git clone https://github.com/kazhala/dotbare.git ~/.dotbare
    source ~/.dotbare/dotbare.plugin.bash
    dotbare finit -u https://github.com/drmikecrowe/baredotfiles.git
}

ask_install_dotbare() {
    is_dotbare_installed && return
    if ask "Install dotbare?"; then 
        type install_dotbare | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_dotbare

[ "$ALL" == "" ] && run_todo
