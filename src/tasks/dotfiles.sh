#!/usr/bin/env bash
# <help>Install dotfiles</help>

setup
    
is_dotfiles_installed() {
    # If you return true/1 here then it is already installed
    [ -d ~/.dotfiles/ ]
}

install_dotfiles() {
    echo "Installing dotfiles now"
    cd "$HOME"
    
    if [ ! -d .dotfiles ]; then
        git clone --recursive https://github.com/drmikecrowe/dotphiles.git ~/.dotfiles
    fi
    
    set +e
    grep -q $HOSTNAME .dotfiles/dotsyncrc
    if [ "$?" == "1" ]; then
        sed -i "/\[hosts\]/ a $HOSTNAME" .dotfiles/dotsyncrc
    fi
    set -e

    ./.dotfiles/dotsync/bin/dotsync -L

    if [ -d $HOME/.bash_it ]; then 
        set +e
        grep -q 'dotfiles/bash_it' ~/.bashrc && echo "source ~/.dotfiles/bash_it/bash-it.sh" >> ~/.bashrc
        set -e
    fi 
}

ask_install_dotfiles() {
    is_dotfiles_installed && return
    if ask "Install dotfiles?"; then 
        type install_dotfiles | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_dotfiles

[ "$ALL" == "" ] && run_todo
