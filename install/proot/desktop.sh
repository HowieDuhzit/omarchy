#!/bin/bash

source $OMARCHY_INSTALL/helpers/proot.sh

gum style --foreground 6 "Setting up desktop environment..."

if is_proot || is_termux; then
  gum style --foreground 3 "Desktop setup limited in PRoot environment"
  gum style --foreground 3 "Some features require X11/Wayland display server"
  echo
  echo "To enable graphical applications:"
  echo "  - Termux: Install Termux:X11 package and use termux-x11"
  echo "  - PRoot: Set DISPLAY variable to your X server"
  echo

  gum style --foreground 6 "Configuring shell environment..."

  setup_shell() {
    local shell_path=$1
    local shell_name=$(basename "$shell_path")

    if [[ -f "$shell_path" ]] && command -v "$shell_name" &>/dev/null; then
      if [[ ":$(getent passwd $USER | cut -d: -f7):" != *":$shell_path:"* ]]; then
        echo "Consider changing your shell to $shell_path:"
        echo "  chsh -s $shell_path"
      fi

      if [[ ! -f "$HOME/.${shell_name}rc" ]]; then
        touch "$HOME/.${shell_name}rc"
      fi
    fi
  }

  setup_shell "$(command -v zsh)"
  setup_shell "$(command -v fish)"
  setup_shell "$(command -v bash)"

  if [[ -f "$OMARCHY_PATH/default/shell/zshrc" ]]; then
    cat "$OMARCHY_PATH/default/shell/zshrc" >> "$HOME/.zshrc" 2>/dev/null || true
  fi

  if [[ -f "$OMARCHY_PATH/default/shell/fishrc" ]]; then
    cat "$OMARCHY_PATH/default/shell/fishrc" >> "$HOME/.config/fish/config.fish" 2>/dev/null || true
  fi
fi

gum style --foreground 2 "Desktop setup complete"
