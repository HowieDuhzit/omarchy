#!/bin/bash

set -eEo pipefail

export OMARCHY_PROOT_INSTALL=1

export OMARCHY_PATH="${OMARCHY_PATH:-$HOME/.local/share/omarchy}"
export OMARCHY_INSTALL="$OMARCHY_PATH/install"
export OMARCHY_CONFIG="$HOME/.config/omarchy"
export PATH="$OMARCHY_PATH/bin:$PATH"

mkdir -p "$OMARCHY_CONFIG"

source "$OMARCHY_INSTALL/helpers/all.sh"

ansi_art='
  ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗██╗   ██╗███████╗
  ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██║   ██║██╔════╝
     ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║██║   ██║███████╗
     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██║   ██║╚════██║
     ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║╚██████╔╝███████║
     ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
'

clear
echo -e "\n$ansi_art"
gum style --foreground 6 "Omarchy PRoot Installer"
echo

if ! command -v gum &>/dev/null; then
  echo "Installing gum..."
  if [[ $(proot_package_manager) == "pkg" ]]; then
    pkg install gum -y
  elif [[ $(proot_package_manager) == "apt" ]]; then
    sudo apt install gum -y
  fi
fi

setup_terminal_display

gum style --foreground 2 "Detected environment:"
echo "  - Type: $(proot_detect)"
echo "  - Package manager: $(proot_package_manager)"
echo "  - Systemd available: $(proot_has_systemd && echo 'Yes' || echo 'No')"
echo

gum style --foreground 6 "Starting PRoot installation..."
echo

proot_guard

run_logged $OMARCHY_INSTALL/proot/package.sh
run_logged $OMARCHY_INSTALL/proot/config.sh
run_logged $OMARCHY_INSTALL/proot/desktop.sh
run_logged $OMARCHY_INSTALL/proot/finished.sh
