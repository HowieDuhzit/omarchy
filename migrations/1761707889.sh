#!/bin/bash
# VR packages migration

# Install VR packages if not present
if ! pacman -Q wivrn-server >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm \
      openxr openvr wivrn-server wivrn-dashboard \
      monado-vulkan-layers-git xrizer xrizer-common \
      rust cargo cmake pkgconf libxkbcommon wayland \
      vulkan-headers dbus fontconfig freetype2 cage
    
    yay -S --needed --noconfirm alvr-bin
fi
