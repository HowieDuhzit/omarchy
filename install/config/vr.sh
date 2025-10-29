# VR theme integration - link VR config to current theme
if [[ -f ~/.config/omarchy/current/theme/wayvr.yaml ]]; then
    mkdir -p ~/.config/wlxoverlay
    ln -snf ~/.config/omarchy/current/theme/wayvr.yaml ~/.config/wlxoverlay/wayvr.yaml
fi
