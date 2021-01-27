#!/usr/bin/env bash
# <help>Install delta</help>

setup

is_delta_installed() {
    [ "$(which delta)" != "" ]
}

install_delta() {
    echo "Installing delta now"
    OUT=$(mktemp)
    wget -qnv -qO- https://api.github.com/repos/dandavison/delta/releases/latest 2>/dev/null > $OUT
    URL="$(jq -r '.assets[] | select(.browser_download_url | match("delta_.*amd64.deb")) | .browser_download_url' $OUT)" 
    wget -qnv $URL -O $OUT.deb
    sudo gdebi -n $OUT.deb
    rm -rf $OUT* 
}

ask_install_delta() {
    is_delta_installed && return
    if ask "Install delta (git diff tool)?"; then 
        type install_delta | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_delta

[ "$ALL" == "" ] && run_todo
