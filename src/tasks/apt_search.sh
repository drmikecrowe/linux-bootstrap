#!/usr/bin/env bash
# <help>Install apt_search</help>

setup

is_apt_search_installed() {
    # If you return true/1 here then it is already installed
    # [ "$(which apt_search)" != "" ]
    [ -f /etc/apt/apt.conf.d/99search ]
}

install_apt_search() {
    echo "Setting apt search to 1 line"
    echo 'Binary::apt::APT::Cache::Search::Version "1";' | sudo tee -a /etc/apt/apt.conf.d/99search
}

ask_install_apt_search() {
    is_apt_search_installed && return
    if ask "Update 'apt search' to only return results on a single line?"; then 
        type install_apt_search | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_apt_search

[ "$ALL" == "" ] && run_todo
