#!/usr/bin/env bash
# <help>Install everything (after asking if you want to)</help>

export ALL=1

setup $1

echo " "
echo " "

# Start Commands
if [ -n "$DISPLAY" ]; then
  $0 default_gui_packages
  $0 vscode
  $0 opera
  $0 spotify
  $0 terraform
  $0 peek
  $0 google-chrome
  $0 touchpad_indicator
  $0 copyq
  $0 wavebox
  $0 y_ppa_manager
fi

$0 bash_it
$0 dotbare
$0 baredotfiles
$0 basher
$0 bashew
$0 delta
$0 nodenv
$0 goenv
$0 pyenv
# $0 xonsh
$0 docker
$0 awscli
$0 etckeeper
$0 fix_max_user_watches
$0 fix_sudo
$0 terminus
$0 boot_repair
$0 apt_search
# End Commands

run_todo
