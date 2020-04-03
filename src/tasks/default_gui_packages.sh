#!/usr/bin/env bash

is_default_gui_packages_installed() {
    # If you return true/1 here then it is already installed
    [ "$(which kupfer)" != "" ] 
}

install_default_gui_packages() {
    echo "Installing default_gui_packages now"
    sudo apt install -y gtk2-engines-murrine gtk2-engines-pixbuf fonts-roboto ninja-build meson sassc glogg meld synaptic menulibre kupfer remmina vim-gtk3 fonts-firacode
}

ask_install_default_gui_packages() {
    is_default_gui_packages_installed && return
    if ask "Install default GUI packages?"; then 
        type install_default_gui_packages | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_default_gui_packages

