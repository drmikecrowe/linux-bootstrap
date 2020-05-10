# This is a general-purpose function to ask Yes/No questions in Bash, either
# with or without a default answer. It keeps repeating the question until it
# gets a valid answer.


# if ask "Do you want to do such-and-such?"; then
# Default to Yes if the user presses enter without giving an answer:
# if ask "Do you want to do such-and-such?" Y; then
# Default to No if the user presses enter without giving an answer:
# if ask "Do you want to do such-and-such?" N; then
# Only do something if you say Yes
# if ask "Do you want to do such-and-such?"; then
# if ! ask "Do you want to do such-and-such?"; then said_no
# ask "Do you want to do such-and-such?" && said_yes
# ask "Do you want to do such-and-such?" || said_no

ask() {
    # https://djm.me/ask
    local prompt default reply

    if [ "$FORCE" == "1" ]; then 
        return 0
    fi

    if [ "${2:-}" = "Y" ]; then
        prompt="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        prompt="y/N"
        default=N
    else
        prompt="y/n"
        default=
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

# ------------- Utility Functions ------------- #

install_deb_from_url() {
    FILE="$2"
    URL="$1/$FILE"
    wget $URL -O $FILE
    sudo gdebi $FILE
    rm $FILE
}

get_download_url() {
    wget -q -nv -O- https://api.github.com/repos/$1/releases/latest 2>/dev/null |	jq -r '.assets[] | select(.browser_download_url | contains("linux-amd64|\.deb")) | .browser_download_url'
}

setup() {
    [ "$RUNFILE" != "" ] && return 

    if [ "$1" == "-y" ]; then 
        FORCE=1
        shift 
    fi

    install_base_packages
    echo " "
    
    export RUNFILE="$HOME/_todo.sh"

    echo "#!/usr/bin/env bash" >$RUNFILE
    echo "set -x" >>$RUNFILE
    echo "set -e" >>$RUNFILE
    echo 'echo "Staring bootstrap"' >>$RUNFILE
}

run_todo() {
    # Run the bootstrapped code
    LINES=$(cat $RUNFILE | wc -l)
    if [ $LINES -gt 4 ]; then 
        # clear
        cat $RUNFILE
        echo " "
        if ask "Run these commands?" Y; then 
            bash $RUNFILE 
        fi
    else
        echo "All things good..."
    fi
}
