# This updates the current install


function install_base_packages() {
    # NOTE: Update this with the latest tool added to the list
    if [ "$(which augtool)" != "" ]; then
        sudo apt update
        sudo apt install -y apt-transport-https curl autojump bash-completion build-essential ca-certificates cifs-utils comprez \
        direnv dselect gawk gdebi git jq mc mysql-client net-tools p7zip-full sshfs tmux tmux-plugin-manager vim-nox virtualenv \
        vpnc-scripts yadm aptitude augeas-tools fonts-powerline libffi-dev
    fi
}
