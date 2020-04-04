# This updates the current install


function install_base_packages() {
    # NOTE: Update this with the latest tool added to the list
    if [ "$(which augtool)" != "" ]; then
        sudo apt update
        sudo apt install -y apt-transport-https curl autojump bash-completion build-essential 
    fi
}
