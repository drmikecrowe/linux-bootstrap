#!/usr/bin/env bash
# <help>Install nodenv</help>

setup
    
is_nodenv_installed() {
    # If you return true/1 here then it is already installed
    [ -d ~/.nodenv ]
}

install_nodenv() {
    echo "Installing nodenv now"
    cd ~
    git clone https://github.com/nodenv/nodenv.git ~/.nodenv
    cd ~/.nodenv && src/configure && make -C src
    mkdir -p "$(nodenv root)"/plugins
    git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
    nodenv package-hooks install --all
    git clone https://github.com/nodenv/nodenv-package-rehash.git "$(nodenv root)"/plugins/nodenv-package-rehash
    nodenv install 10.18.0
    nodenv global 10.18.0
    npm-setup-global-packages.sh
}

ask_install_nodenv() {
    is_nodenv_installed && return
    if ask "Install nodenv?" Y; then 
        type install_nodenv | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_nodenv

[ "$ALL" == "" ] && run_todo
