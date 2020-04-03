#!/usr/bin/env bash

if [ "$1" == "" ]; then 
    echo "usage: $0 identifier"
    echo " "
    echo "ex: $0 zsh"
    exit 1
fi
if [ ! -d src/tasks ]; then 
    echo "Must be run from the root directory"
    exit 1
fi

TASK="$1"
NEW="src/tasks/$TASK.sh"

cat <<EOF >$NEW
#!/usr/bin/env bash
# <help>Install ${TASK}</help>

setup

is_${TASK}_installed() {
    # If you return true/1 here then it is already installed
    # [ "\$(which ${TASK})" != "" ]
    # [ -d /some/diraectory ]
    false
}

install_${TASK}() {
    echo "Installing ${TASK} now"
    # INSTALL CODE HERE
}

ask_install_${TASK}() {
    is_${TASK}_installed && return
    if ask "Install ${TASK}?"; then 
        type install_${TASK} | sed '1,3d;\$d' | sed 's/^\s*//g' >> \$RUNFILE
        echo " " >> \$RUNFILE
    fi
}

ask_install_${TASK}

[ "\$ALL" == "" ] && run_todo
EOF

# Add it to 'all.sh' 
grep -q "\$0 $1" src/tasks/all.sh 
if [ "$?" != "0" ]; then 
  sed -i "/^# End Commands/i \$0 $1" src/tasks/all.sh
fi 
