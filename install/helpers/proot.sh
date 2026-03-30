# PRoot environment detection helpers

is_proot() {
  [[ -n ${OMARCHY_PROOT_INSTALL:-} ]]
}

is_termux() {
  [[ -d /data/data/com.termux/files/usr ]] || [[ -n ${TERMUX_VERSION:-} ]]
}

is_android() {
  [[ -f /system/build.prop ]] || is_termux
}

proot_detect() {
  if [[ -n ${OMARCHY_PROOT_INSTALL:-} ]]; then
    echo "proot"
  elif is_termux; then
    echo "termux"
  elif [[ -n ${ANDROID_ROOT:-} ]] || [[ -n ${ANDROID_DATA:-} ]]; then
    echo "android-chroot"
  else
    echo "native"
  fi
}

proot_uses_sudo() {
  if is_proot || is_termux; then
    return 1
  fi
  return 0
}

proot_has_systemd() {
  if is_proot || is_termux; then
    return 1
  fi
  command -v systemctl &>/dev/null
}

proot_package_manager() {
  if is_termux; then
    echo "pkg"
  elif command -v apt &>/dev/null; then
    echo "apt"
  elif command -v pacman &>/dev/null; then
    echo "pacman"
  else
    echo "unknown"
  fi
}

safe_sudo() {
  if proot_uses_sudo; then
    sudo "$@"
  else
    "$@"
  fi
}

safe_chroot_systemctl() {
  if proot_has_systemd; then
    sudo systemctl "$@"
  else
    echo "systemd not available in PRoot environment, skipping: systemctl $*"
  fi
}
