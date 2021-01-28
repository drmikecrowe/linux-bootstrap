#!/usr/bin/env bash
# <help>Install xonsh</help>

setup $1

is_xonsh_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which xonsh)" != "" ]
}

install_xonsh() {
    echo "Installing xonsh now"
    pipx install xonsh
    pipx inject xonsh xontrib-ssh_agent xonsh-apt-tabcomplete xonsh-docker-tabcomplete xonsh-direnv xontrib-powerline2
    grep -q xonsh /etc/shells || echo "$(which xonsh)" | sudo tee -a /etc/shells > /dev/null
    chsh -s $(which xonsh)
}

ask_install_xonsh() {
    is_xonsh_installed && return
    if ask "Install xonsh?"; then 
        type install_xonsh | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_xonsh

[ "$ALL" == "" ] && run_todo
