#!/usr/bin/env bash
# <help>Install everything (after asking if you want to)</help>

export ALL=1

setup

echo " "
echo " "

# Start Commands
if [ -n "$DISPLAY" ]; then
  $0 default_gui_packages
fi

# End Commands

run_todo
