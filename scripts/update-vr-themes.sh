#!/bin/bash
# Update all theme VR configs with Omarchy apps

THEMES_DIR="/home/howie/Github/omarchy/themes"

# Update each theme's wayvr.yaml with Omarchy apps
for theme_dir in "$THEMES_DIR"/*; do
    if [[ -d "$theme_dir" ]]; then
        theme_name=$(basename "$theme_dir")
        wayvr_file="$theme_dir/wayvr.yaml"
        
        if [[ -f "$wayvr_file" ]]; then
            echo "Updating VR config for $theme_name..."
            
            # Replace the entire wayvr.yaml with clean template
            cp "/home/howie/Github/omarchy/templates/vr/wayvr-config.yaml" "$wayvr_file"
            
            # Copy VR keyboard template if it doesn't exist
            keyboard_file="$theme_dir/keyboard.yaml"
            if [[ ! -f "$keyboard_file" ]]; then
                cp "/home/howie/Github/omarchy/templates/vr/keyboard.yaml" "$keyboard_file"
                echo "Added VR keyboard config for $theme_name"
            fi
            
            # Copy VR UI templates if they don't exist
            for ui_template in omarchy-control.yaml system-monitor.yaml vr-menu.yaml; do
                ui_file="$theme_dir/$ui_template"
                if [[ ! -f "$ui_file" ]]; then
                    cp "/home/howie/Github/omarchy/templates/vr/$ui_template" "$ui_file"
                    echo "Added VR UI template $ui_template for $theme_name"
                fi
            done
        fi
    fi
done

echo "All theme VR configs updated with Omarchy apps!"
