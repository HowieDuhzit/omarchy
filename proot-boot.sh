#!/bin/bash

# Set install mode to PRoot
export OMARCHY_PROOT_INSTALL=true

ansi_art='
  ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗██╗   ██╗███████╗
  ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██║   ██║██╔════╝
     ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║██║   ██║███████╗
     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██║   ██║╚════██║
     ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║╚██████╔╝███████║
     ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
'

clear
echo -e "\n$ansi_art\n"
gum style --foreground 6 "PRoot Installer"
echo

OMARCHY_REF="${OMARCHY_REF:-master}"

echo -e "Using branch: \e[32m$OMARCHY_REF\e[0m"
echo

if [[ -d ~/.local/share/omarchy ]]; then
  echo "Updating existing Omarchy installation..."
  cd ~/.local/share/omarchy
  git fetch origin "${OMARCHY_REF}" && git checkout "${OMARCHY_REF}"
  cd -
else
  OMARCHY_REPO="${OMARCHY_REPO:-basecamp/omarchy}"
  echo -e "Cloning Omarchy from: https://github.com/${OMARCHY_REPO}.git"
  git clone "https://github.com/${OMARCHY_REPO}.git" ~/.local/share/omarchy >/dev/null 2>&1
  cd ~/.local/share/omarchy
  git fetch origin "${OMARCHY_REF}" && git checkout "${OMARCHY_REF}"
  cd -
fi

echo
gum style --foreground 2 "Starting PRoot installation..."
echo

source ~/.local/share/omarchy/proot-install.sh
