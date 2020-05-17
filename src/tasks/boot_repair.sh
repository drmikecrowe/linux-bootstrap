#!/usr/bin/env bash
# <help>Install boot_repair</help>

setup

is_boot_repair_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which boot-repair)" != "" ]
    # [ -d /some/diraectory ]
    false
}

install_boot_repair() {
    echo "Installing boot_repair now"
    sudo add-apt-repository ppa:yannubuntu/boot-repair
    sudo apt-get update
    sudo apt-get install -y boot-repair 
}

ask_install_boot_repair() {
    is_boot_repair_installed && return
    if ask "Install boot_repair?"; then 
        type install_boot_repair | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_boot_repair

[ "$ALL" == "" ] && run_todo
