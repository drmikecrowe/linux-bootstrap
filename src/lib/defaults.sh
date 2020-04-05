# This updates the current install


function install_base_packages() {
    # NOTE: Update this with the latest tool added to the list
    if [ "$(which augtool)" == "" ]; then
        sudo apt update
        sudo apt install -y apt-transport-https curl autojump bash-completion build-essential augeas-tools
    fi

    set +e
    python --version 2>&1 | grep -q 'Python 2'
    if [ "$?" == "0" ]; then 
        set -e
        sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 20
        sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10
        sudo update-alternatives --set python /usr/bin/python3
    fi
    set -e

    if [ "$(which pip)" == "" ]; then 
        sudo apt install -y python3-pip
    fi
}
