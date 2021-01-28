#!/usr/bin/env bash
# <help>Install terminus</help>

setup $1

is_terminus_installed() {
    if [ "$(which terminus)" != "" ]; then 
        CURRENT=$(dpkg -s terminus  | grep '^Version:' | awk '{ print $2 }')
        LATEST=$(curl --silent "https://api.github.com/repos/Eugeny/terminus/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
        VERSION=${LATEST:1:255}
        [ "$CURRENT" == "$VERSION" ]
    fi
}

install_terminus() {
    echo "Installing terminus now"
    LATEST=$(curl --silent "https://api.github.com/repos/Eugeny/terminus/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
    VERSION=${LATEST:1:255}
    DOWNLOAD="https://github.com/Eugeny/terminus/releases/download/$LATEST/terminus-$VERSION-linux.deb"
    DEB=$(basename $DOWNLOAD)
    rm -f /tmp/$DEB*
    wget -P /tmp $DOWNLOAD
    sudo gdebi -n /tmp/$DEB
}

ask_install_terminus() {
    is_terminus_installed && return
    if ask "Install terminus?"; then 
        type install_terminus | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_terminus

[ "$ALL" == "" ] && run_todo
