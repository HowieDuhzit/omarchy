proot_guard_abort() {
  echo -e "\e[33mPRoot install warning: $1\e[0m"
}

proot_guard_skip() {
  echo -e "\e[90m  [SKIPPED] $1\e[0m"
}

proot_guard_info() {
  echo -e "\e[36m  [PROOT] $1\e[0m"
}

proot_check_environment() {
  echo
  gum style --foreground 6 "Detecting PRoot environment..."

  local env_type=$(proot_detect)
  proot_guard_info "Environment: $env_type"

  if is_proot; then
    proot_guard_info "Running in PRoot mode"
  fi

  if is_termux; then
    proot_guard_info "Running in Termux"
  fi

  if is_android; then
    proot_guard_info "Detected Android environment"
  fi

  if ! proot_uses_sudo; then
    proot_guard_skip "sudo not available - commands will run directly"
  fi

  if ! proot_has_systemd; then
    proot_guard_skip "systemd not available - services will not be enabled"
  fi

  local pkg_mgr=$(proot_package_manager)
  proot_guard_info "Package manager: $pkg_mgr"

  echo
  gum style --foreground 2 "PRoot guards: OK"
  echo
}

proot_check_dependencies() {
  echo
  gum style --foreground 6 "Checking PRoot dependencies..."

  local missing_deps=()

  if [[ $(proot_package_manager) == "pkg" ]]; then
    command -v pkg &>/dev/null || missing_deps+=("pkg")
  elif [[ $(proot_package_manager) == "apt" ]]; then
    command -v apt &>/dev/null || missing_deps+=("apt")
  fi

  command -v git &>/dev/null || missing_deps+=("git")
  command -v bash &>/dev/null || missing_deps+=("bash")

  if ((${#missing_deps[@]} > 0)); then
    echo -e "\e[31mMissing dependencies: ${missing_deps[*]}\e[0m"
    return 1
  fi

  echo
  gum style --foreground 2 "Dependencies: OK"
  echo
}

proot_guard() {
  source $OMARCHY_INSTALL/helpers/proot.sh

  if ! is_proot && ! is_termux; then
    echo "Not in PRoot environment, skipping PRoot guards"
    return 0
  fi

  proot_check_environment
  proot_check_dependencies
}
