# Omarchy Zsh Configuration for PRoot
# Generated for {{USER}}

# Enable Powerline and plugins
export POWERLINE_HIDE_USER_NAME=0
export POWERLINE_HIDE_DATE=0

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# Enable color support
export CLICOLOR=1

# Prefer usr binaries
export PATH="$HOME/.local/bin:$HOME/.local/share/omarchy/bin:$PATH"

# XDG Base Directory
export XDG_CONFIG_HOME="{{XDG_CONFIG_HOME}}"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# omarchy
export OMARCHY_PATH="$HOME/.local/share/omarchy"
export OMARCHY_CONFIG="$HOME/.config/omarchy"

# PRoot-specific
if [[ -n ${OMARCHY_PROOT_INSTALL:-} ]] || [[ -d /data/data/com.termux/files ]]; then
  export OMARCHY_PROOT=1
fi

# Starship prompt
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# zoxide
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# fzf
if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'
  source <(fzf --zsh)
fi

# Aliases
alias ll='eza -la --icons'
alias la='eza -a --icons'
alias lt='eza --tree --level=2 --icons'
alias cat='bat --style=numbers,changes,header'

# PRoot-specific aliases
if is_proot; then
  alias update='pkg update && pkg upgrade'  # Termux
fi
