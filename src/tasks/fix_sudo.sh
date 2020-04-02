#!/usr/bin/env bash
# <help>Fix sudo so user so password isn't required?</help>

setup
    
is_fix_sudo_installed() {
    [ "$(sudo augtool match /files/etc/sudoers/*/user $USER)" != "" ]
}

install_fix_sudo() {
    echo "Adding $USER to sudoers with no password\n"
    sudo usermod -aG sudo $USER
    cat <<EOF >/tmp/sudoers.aug
set /files/etc/sudoers/spec[last()]/user "$USER"
set /files/etc/sudoers/spec[last()]/host_group/host "ALL"
set /files/etc/sudoers/spec[last()]/host_group/command "ALL"
set /files/etc/sudoers/spec[last()]/host_group/command/runas_user "ALL"
set /files/etc/sudoers/spec[last()]/host_group/command/tag "NOPASSWD"
save
EOF
    sudo augtool -f /tmp/sudoers.aug
}

ask_install_fix_sudo() {
    is_fix_sudo_installed && return
    if ask "Fix sudo so user so password isn't required?" Y; then 
        type install_fix_sudo | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_fix_sudo

[ "$ALL" == "" ] && run_todo
