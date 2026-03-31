# Omarchy PRoot

Omarchy installer for PRoot environments (Android/Termux, Debian PRoot, etc.)

## Requirements

- Linux environment (PRoot, Termux, or native)
- `git` and `curl` (auto-installed if missing)

## Quick Install

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/HowieDuhzit/omarchy/proot/proot-boot.sh)"
```

## Termux (Android)

```bash
pkg update && pkg install git curl -y
export OMARCHY_REF=proot
bash -c "$(curl -fsSL https://raw.githubusercontent.com/HowieDuhzit/omarchy/proot/proot-boot.sh)"
```

## Custom Repository

```bash
export OMARCHY_REPO=your-username/omarchy
export OMARCHY_REF=proot
bash -c "$(curl -fsSL https://raw.githubusercontent.com/your-username/omarchy/proot/proot-boot.sh)"
```

## What Gets Installed

- Shell configurations (zsh, fish)
- Hyprland/Wayland setup (if available)
- CLI tools (fzf, zoxide, starship, eza, bat, etc.)
- Desktop environment (if display server is available)

## Limitations

| Feature | Native | PRoot |
|---------|--------|-------|
| Systemd services | Yes | No |
| Bootloader config | Yes | No |
| Kernel modules | Yes | No |
| Hardware detection | Yes | Limited |
| Package manager | pacman | apt/pkg/pacman |

## Post-Install

After installation, restart your shell or run:

```bash
exec zsh
```

For graphical applications, ensure you have:
- **Termux**: `termux-x11` package + X11 server
- **PRoot**: Set `DISPLAY=:0` pointing to your X server

## Uninstall

```bash
rm -rf ~/.local/share/omarchy ~/.config/omarchy ~/.config/hypr ~/.config/waybar ~/.config/wofi
```
