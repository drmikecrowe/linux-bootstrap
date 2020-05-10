#!/usr/bin/env bash
# <help>Fix max_user_watches by increasing to 524288?</help>

setup $1
    
is_fix_max_user_watches_installed() {
    # If you return true/1 here then it is already installed
    [[ "$(sudo augtool match /files/etc/sysctl.conf/fs.inotify.max_user_watches)" =~ "524288" ]]
}

install_fix_max_user_watches() {
    echo "Setting sysctl.conf fs.inotify.max_user_watches=524288\n"
    cat <<EOF >/tmp/sysctl.aug
set /files/etc/sysctl.conf/fs.inotify.max_user_watches 524288
save
EOF
    sudo augtool -f /tmp/sysctl.aug
    sudo sysctl -p
}

ask_install_fix_max_user_watches() {
    is_fix_max_user_watches_installed && return
    if ask "Fix max_user_watches by increasing to 524288?"; then 
        type install_fix_max_user_watches | sed '1,3d;$d' | sed 's/^\s*//g' >> $RUNFILE
        echo " " >> $RUNFILE
    fi
}

ask_install_fix_max_user_watches

[ "$ALL" == "" ] && run_todo
