#!/usr/bin/env bash
# <help>Install default gui pages like meld, glogg etc.</help>

is_default_gui_packages_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which synaptic)" != "" ] 
}

install_default_gui_packages() {
    echo "Installing default_gui_packages now"
    sudo apt install -y synaptic
}

ask_install_default_gui_packages() {
    is_default_gui_packages_installed && return
    if ask "Install default GUI packages?"; then 
        type install_default_gui_packages | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_default_gui_packages

