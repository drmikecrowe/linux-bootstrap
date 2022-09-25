#!/usr/bin/env bash
# <help>Fix sudo so user so password isn't required?</help>

setup $1
    
is_fix_sudo_installed() {
    [ ! -f $FILE ]
}

install_fix_sudo() {
    echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-$USER-for-sudo-password
}

ask_install_fix_sudo() {
    is_fix_sudo_installed && return
    if ask "Fix sudo so user so password isn't required?"; then 
        type install_fix_sudo | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_fix_sudo

[ "$ALL" == "" ] && run_todo
