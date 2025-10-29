#!/bin/bash
# VR packages migration - Pure WiVRn setup

# Install VR packages if not present
if ! pacman -Q wivrn-server >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm \
      openxr openvr wivrn-server wivrn-dashboard \
      monado-vulkan-layers-git xrizer xrizer-common \
      rust cargo cmake pkgconf libxkbcommon wayland \
      vulkan-headers dbus fontconfig freetype2 cage \
      firefox nautilus typora spotify obsidian
    
    # Install optional AUR packages
    yay -S --needed --noconfirm opencomposite steam steamvr slimevr-server
fi
