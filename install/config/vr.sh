# VR theme integration - link VR configs to current theme
if [[ -f ~/.config/omarchy/current/theme/wayvr.yaml ]]; then
    mkdir -p ~/.config/wlxoverlay
    ln -snf ~/.config/omarchy/current/theme/wayvr.yaml ~/.config/wlxoverlay/wayvr.yaml
fi

# Link VR keyboard config if available
if [[ -f ~/.config/omarchy/current/theme/keyboard.yaml ]]; then
    mkdir -p ~/.config/wlxoverlay
    ln -snf ~/.config/omarchy/current/theme/keyboard.yaml ~/.config/wlxoverlay/keyboard.yaml
fi

# Link VR UI panels if available
for ui_file in omarchy-control.yaml system-monitor.yaml vr-menu.yaml; do
    if [[ -f ~/.config/omarchy/current/theme/$ui_file ]]; then
        mkdir -p ~/.config/wlxoverlay
        ln -snf ~/.config/omarchy/current/theme/$ui_file ~/.config/wlxoverlay/$ui_file
    fi
done
