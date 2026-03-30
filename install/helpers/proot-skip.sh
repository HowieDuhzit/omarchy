#!/bin/bash

source $OMARCHY_INSTALL/helpers/proot.sh

skip_in_proot() {
  if is_proot || is_termux; then
    echo "[PRoot] Skipping: $1"
    return 0
  fi
  return 1
}

proot_skip_hardware_fix() {
  local fix_name="$1"

  if is_proot || is_termux; then
    gum style --foreground 3 "[PRoot] Skipping hardware fix: $fix_name"
    gum style --foreground 3 "  Hardware-specific fixes require kernel/system access"
    return 0
  fi
  return 1
}

proot_skip_kernel_fix() {
  local fix_name="$1"

  if is_proot || is_termux; then
    gum style --foreground 3 "[PRoot] Skipping kernel fix: $fix_name"
    gum style --foreground 3 "  Kernel fixes require real root access"
    return 0
  fi
  return 1
}

proot_skip_bootloader_fix() {
  local fix_name="$1"

  if is_proot || is_termux; then
    gum style --foreground 3 "[PRoot] Skipping bootloader fix: $fix_name"
    gum style --foreground 3 "  Bootloader modifications are not possible in PRoot"
    return 0
  fi
  return 1
}
