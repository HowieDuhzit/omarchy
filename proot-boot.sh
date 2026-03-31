#!/bin/bash

set -eEo pipefail

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

detect_pkg_manager() {
  if command -v pkg &>/dev/null; then
    echo "pkg"
  elif command -v apt &>/dev/null; then
    echo "apt"
  elif command -v pacman &>/dev/null; then
    echo "pacman"
  else
    echo "unknown"
  fi
}

install_deps() {
  local pkg_mgr=$(detect_pkg_manager)
  local missing=()

  command -v git &>/dev/null || missing+=(git)
  command -v curl &>/dev/null || missing+=(curl)

  if ((${#missing[@]} > 0)); then
    echo "Installing dependencies: ${missing[*]}"
    case $pkg_mgr in
      pkg)
        pkg update -y && pkg install -y "${missing[@]}"
        ;;
      apt)
        sudo apt update && sudo apt install -y "${missing[@]}"
        ;;
      pacman)
        sudo pacman -S --noconfirm "${missing[@]}"
        ;;
      *)
        echo "Cannot install dependencies automatically. Please install: ${missing[*]}"
        exit 1
        ;;
    esac
  fi
}

try_gum() {
  if command -v gum &>/dev/null; then
    gum "$@"
  else
    return 1
  fi
}

install_gum() {
  if command -v gum &>/dev/null; then
    return 0
  fi

  local pkg_mgr=$(detect_pkg_manager)
  echo "Installing gum..."

  case $pkg_mgr in
    pkg)
      pkg install gum -y
      ;;
    apt)
      sudo apt install gum -y
      ;;
    pacman)
      sudo pacman -S --noconfirm gum
      ;;
    *)
      echo "gum not available for your package manager"
      return 1
      ;;
  esac
}

echo -e "\e[36mPRoot Installer\e[0m"
echo

install_deps

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

if ! command -v gum &>/dev/null; then
  install_gum || true
fi

echo
if try_gum style --foreground 2 "Starting PRoot installation..."; then
  :
else
  echo -e "\e[32mStarting PRoot installation...\e[0m"
fi
echo

source ~/.local/share/omarchy/proot-install.sh
