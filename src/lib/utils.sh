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

install_github_release() {
    set +e
    OUT=$(mktemp)
    wget -qnv -O- https://api.github.com/repos/$1/releases/latest 2>/dev/null > $OUT
    URL="$(jq -r '.assets[] | select(.browser_download_url | contains("amd64.deb")) | .browser_download_url' $OUT)" 
    if [ "$URL" != "" ]; then 
        set -e
        wget $URL -O $OUT.deb
        sudo gdebi -n $OUT.deb 
    else 
        URL="$(jq -r '.assets[] | select(.browser_download_url | match("linux.*x86_64";"i")) | .browser_download_url' $OUT)" 
        if [ "$URL" != "" ]; then 
        set -e
            BASE="$(basename $URL)"
            BIN="$(echo $BASE | sed 's/_.*//')"
            wget -qnv $URL -O $OUT
            mv $OUT ~/.local/bin/$BIN 
            chmod +x ~/.local/bin/$BIN
        fi
    fi
    rm -f $OUT*
    set -e
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

    cat <<EOF >$RUNFILE
#!/usr/bin/env bash

# show a cyan `OK!`, or arg `1` message
function show_info()
{
  local msg="OK!"
  if [ ! -z "$1" ]; then
    msg="$1"
  fi
  echo -e "\033[0;36m${msg}\033[0m"
}

# show a magneta `OK!`, or arg `1` message
function show_info_alt()
{
  local msg="OK!"
  if [ ! -z "$1" ]; then
    msg="$1"
  fi
  echo -e "\033[0;35m${msg}\033[0m"
}

# show a green `Success!`, or arg `1` message
function show_success()
{
  local msg="Success!"
  if [ ! -z "$1" ]; then
    msg="$1"
  fi
  echo -e "\033[0;32m${msg}\033[0m"
}

# show a yellow `Warning!`, or arg `1` message
function show_warning()
{
  local msg="Warning!"
  if [ ! -z "$1" ]; then
    msg="$1"
  fi
  echo -e "\033[0;33m${msg}\033[0m"
}

# show a red `Error!`, or arg `1` message
function show_error()
{
  local msg="Error!"
  if [ ! -z "$1" ]; then
    msg="$1"
  fi
  echo -e "\033[0;31m${msg}\033[0m"
}

function show_install() 
{
  local msg
  printf -v msg %-40.40s "$1"
  echo -n "Installing: $msg"
}

EOF

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
