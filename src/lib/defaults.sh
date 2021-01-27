# This updates the current install


function install_base_packages() {
    # NOTE: Update this with the latest tool added to the list
    case "$OSTYPE" in
        solaris*)  
            ;;
        darwin*) 
            ;;
        linux*)
            if [ "$(which fzf)" == "" ]; then
                sudo apt update
                sudo apt install -y apt-transport-https curl autojump bash-completion build-essential ca-certificates cifs-utils comprez \
                direnv dselect gawk gdebi git jq mc mysql-client net-tools p7zip-full sshfs tmux tmux-plugin-manager vim-nox virtualenv \
                htop vpnc-scripts yadm aptitude fonts-powerline libffi-dev augeas-tools tree bat ripgrep gnome-tweaks fzf
                set +e
                sudo apt install libssl-dev libbz2-dev libreadline-dev
            fi

            set +e
            if [ "$(which python)" == "" ]; then 
                if [ "$(which python3)" != "" ]; then 
                    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10
                    sudo update-alternatives --set python /usr/bin/python3
                fi
            fi

            python --version 2>&1 | grep -q 'Python 2'
            if [ "$?" == "0" ]; then 
                set -e
                sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 20
                sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10
                sudo update-alternatives --set python /usr/bin/python3
            fi
            set -e

            if [ "$(which pip)" == "" ]; then 
                sudo apt install -y python3-pip python3-venv
            fi

            if [ "$(which bin)" == "" ]; then 
                install_github_release marcosnils/bin
                mkdir -p ~/.bin
                cat <<EOF > ~/.bin/config.json
{
    "default_path": "$HOME/.local/bin",
    "bins": {}
}
EOF
            fi
            ;;
        bsd*)     
            ;;
        msys*)
            ;;
        *)
            ;;
    esac
 
}
