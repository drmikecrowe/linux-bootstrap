#!/usr/bin/env bash
# <help>Install pyenv</help>

setup $1
    
is_pyenv_installed() {
    # If you return true/1 here then it is already installed
    [ -d $HOME/.pyenv ]
}

install_pyenv() {
    echo "Installing pyenv now"
    cd ~
    wget -O- https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
}

ask_install_pyenv() {
    is_pyenv_installed && return
    if ask "Install pyenv?"; then 
        type install_pyenv | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_pyenv

[ "$ALL" == "" ] && run_todo
