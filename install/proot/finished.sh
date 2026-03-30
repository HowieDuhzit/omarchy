#!/bin/bash

gum style --foreground 2 "
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║                    Omarchy PRoot Install Complete!              ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
"

echo
gum style --foreground 6 "What to do next:"
echo

if is_termux; then
  echo "1. Start X11 server:"
  echo "   termux-x11"
  echo
  echo "2. Set DISPLAY for graphical apps:"
  echo "   export DISPLAY=:0"
  echo
fi

echo "3. Configure your shell (optional):"
echo "   chsh -s \$(command -v zsh)"
echo

echo "4. Restart your shell or logout/login to apply changes"
echo

echo "5. For graphical applications, ensure you have:"
echo "   - X11 server (XSDL, Termux:X11, VNC)"
echo "   - Wayland compositor (if using Wayland)"
echo

if [[ -d "$HOME/.config/omarchy" ]]; then
  echo "Configuration saved to: $HOME/.config/omarchy/config.toml"
fi

echo
gum style --foreground 6 "Documentation: https://omarchy.org/docs/proot"
echo
