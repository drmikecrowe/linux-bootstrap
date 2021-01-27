#!/usr/bin/env bash
# <help>Install bash_it</help>

setup $1
     
is_bash_it_installed() {
    # If you return true/1 here then it is already installed
    # [ -d ~/.bash_it/ ]
    false
}

install_bash_it() {
    echo "Installing bash_it now"
    cd "$HOME"
    
    if [ ! -d ~/.bash_it ]; then
        git clone --depth 1 https://github.com/Bash-it/bash-it.git .bash_it
    fi

    # Install and update bashrc if necessary
    set +e
    if [ -f ~/.bash/bash-it.bash ]; then 
        # This is my personal setup -- see ~/.dotfiles/bash_it/bash-it.sh
        set -e
        bash ~/.bash_it/install.sh --no-modify-config
        set +e
        grep -q 'bash/setup.bash' ~/.bashrc || echo "source ~/.bash/setup.bash" >> ~/.bashrc
        set -e
    else
        set -e
        bash ~/.bash_it/install.sh 
        grep -E '^export|^source' ~/.bashrc > /tmp/setup.sh
        source /tmp/setup.sh 
    fi
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
