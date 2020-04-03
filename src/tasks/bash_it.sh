#!/usr/bin/env bash
# <help>Install bash_it</help>

setup
     
is_bash_it_installed() {
    # If you return true/1 here then it is already installed
    [ -d ~/.bash_it/ ]
}

install_bash_it() {
    echo "Installing bash_it now"
    cd "$HOME"
    
    if [ ! -d ~/.bash_it ]; then
        git clone --depth 1 https://github.com/Bash-it/bash-it.git .bash_it
    fi

    # Install and update bashrc if necessary
    set +e
    if [ -d ~/.dotfiles/bash_it ]; then 
        # This is my personal setup -- see ~/.dotfiles/bash_it/bash-it.sh
        set -e
        echo "Installing dotfiles too.  Won't modify .bashrc"
        bash ~/.bash_it/install.sh --no-modify-config
        set +e
        grep -q 'dotfiles/bash_it' ~/.bashrc || echo "source ~/.dotfiles/bash_it/bash-it.sh" >> ~/.bashrc
        set +x
        source ~/.dotfiles/bash_it/bash-it.sh
        set -x
        set -e
    else
        set -e
        bash ~/.bash_it/install.sh 
        grep -E '^export|^source' ~/.bashrc > /tmp/setup.sh
        source /tmp/setup.sh 
    fi

    set +x

    #$ bash-it-config.sh  -- a la https://github.com/Bash-it/bash-it/issues/1350#issuecomment-549949179
    # Bash-it Enabled-Component Backup
    # Date: Wed 18 Dec 2019 02:46:07 PM EST
    # Folder: /home/mcrowe/.bash_it
    # Components: alias plugin completion

    # alias

    #bash-it disable alias all

    bash-it enable alias docker
    bash-it enable alias docker-compose
    bash-it enable alias general
    bash-it enable alias npm

    # plugin

    #bash-it disable plugin all

    bash-it enable plugin autojump
    bash-it enable plugin aws
    bash-it enable plugin base
    bash-it enable plugin direnv
    bash-it enable plugin docker
    bash-it enable plugin docker-compose
    bash-it enable plugin git
    bash-it enable plugin history
    bash-it enable plugin ssh
    bash-it enable plugin tmux

    # completion

    #bash-it disable completion all

    bash-it enable completion awscli
    bash-it enable completion bash-it
    bash-it enable completion docker
    bash-it enable completion docker-compose
    bash-it enable completion git
    bash-it enable completion git_flow
    bash-it enable completion npm
    bash-it enable completion pip
    bash-it enable completion pip3
    bash-it enable completion ssh
    bash-it enable completion system
    bash-it enable completion tmux
    bash-it enable completion vuejs

    set -x    
}

ask_install_bash_it() {
    is_bash_it_installed && return
    if ask "Install bash_it?"; then 
        type install_bash_it | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_bash_it

[ "$ALL" == "" ] && run_todo
