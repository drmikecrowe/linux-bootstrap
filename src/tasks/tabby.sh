#!/usr/bin/env bash
# <help>Install tabby</help>

setup $1

is_tabby_installed() {
    if [ "$(which tabby)" != "" ]; then 
        CURRENT=$(dpkg -s tabby  | grep '^Version:' | awk '{ print $2 }')
        LATEST=$(curl --silent "https://api.github.com/repos/Eugeny/tabby/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
        VERSION=${LATEST:1:255}
        [ "$CURRENT" == "$VERSION" ]
    fi
}

install_tabby() {
    echo "Installing tabby now"
    LATEST=$(curl --silent "https://api.github.com/repos/Eugeny/tabby/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
    VERSION=${LATEST:1:255}
    DOWNLOAD="https://github.com/Eugeny/tabby/releases/download/$LATEST/tabby-$VERSION-linux.deb"
    DEB=$(basename $DOWNLOAD)
    rm -f /tmp/$DEB*
    wget -P /tmp $DOWNLOAD
    sudo gdebi -n /tmp/$DEB
}

ask_install_tabby() {
    is_tabby_installed && return
    if ask "Install tabby?"; then 
        type install_tabby | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_tabby

[ "$ALL" == "" ] && run_todo
