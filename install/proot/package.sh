#!/bin/bash

source $OMARCHY_INSTALL/helpers/proot.sh

gum style --foreground 6 "Installing packages..."

case $(proot_package_manager) in
  pkg)
    pkg update -y
    pkg install \
      git \
      curl \
      wget \
      zsh \
      vim \
      neovim \
      fish \
      stow \
      tmux \
      nodejs \
      npm \
      python \
      pipewire \
      wireplumber \
      hyprland \
      waybar \
      wofi \
      dunst \
      kitty \
      alacritty \
      foot \
      eza \
      fzf \
      ripgrep \
      fd \
      bat \
      exa \
      zoxide \
      starship \
      gum \
      brightnessctl \
      pamixer \
      playerctl \
      NetworkManager \
      -y
    ;;
  apt)
    sudo apt update
    sudo apt install -y \
      git \
      curl \
      wget \
      zsh \
      vim \
      neovim \
      fish \
      stow \
      tmux \
      nodejs \
      npm \
      python3 \
      pipewire \
      wireplumber \
      wayland-session \
      -y
    ;;
  pacman)
    sudo pacman -S --noconfirm \
      git \
      curl \
      wget \
      zsh \
      vim \
      neovim \
      fish \
      stow \
      tmux \
      nodejs \
      npm \
      python \
      pipewire \
      wireplumber \
      hyprland \
      waybar \
      wofi \
      dunst \
      kitty \
      alacritty \
      foot \
      eza \
      fzf \
      ripgrep \
      fd \
      bat \
      zoxide \
      starship \
      gum \
      brightnessctl \
      pamixer \
      playerctl \
      networkmanager \
      -y
    ;;
  *)
    gum style --foreground 1 "Unknown package manager: $(proot_package_manager)"
    exit 1
    ;;
esac

gum style --foreground 2 "Packages installed successfully"
