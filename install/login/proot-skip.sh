#!/bin/bash

source $OMARCHY_INSTALL/helpers/proot.sh

proot_guard_login() {
  if is_proot || is_termux; then
    echo "[PRoot] Skipping login manager setup (systemd not available)"
    return 0
  fi
  return 1
}

if proot_guard_login; then
  echo "Skipping login setup in PRoot mode"
  exit 0
fi
