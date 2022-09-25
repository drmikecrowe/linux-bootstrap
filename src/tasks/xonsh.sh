#!/usr/bin/env bash
# <help>Install xonsh</help>

BIN="~/bin/xonsh-x86_64.AppImage"

setup $1

is_xonsh_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which xonsh)" != "" ]
}

install_xonsh() {
    echo "Installing xonsh now"
    wget -qnv -O- https://github.com/xonsh/xonsh/releases/latest/download/xonsh-x86_64.AppImage > $BIN
    chmod +x $BIN  
    ln -s $BIN ~/bin/xonsh
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
