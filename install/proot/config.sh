#!/bin/bash

source $OMARCHY_INSTALL/helpers/proot.sh

gum style --foreground 6 "Configuring Omarchy for PRoot..."

mkdir -p "$OMARCHY_CONFIG"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"

OMARCHY_CONFIG_FILE="$OMARCHY_CONFIG/config.toml"

cat > "$OMARCHY_CONFIG_FILE" << 'EOF'
[general]
environment = "proot"
install_date = ""

[paths]
omarchy_path = ""
config_path = ""
cache_path = ""

[features]
systemd = false
sudo = false
bootloader = false
kernel_modules = false

[desktop]
wayland = true
gui_optional = true

[android]
termux = false
display_server = "none"
EOF

if is_termux; then
  sed -i 's/termux = false/termux = true/' "$OMARCHY_CONFIG_FILE"

  cat >> "$OMARCHY_CONFIG_FILE" << 'EOF'

[termux]
home_prefix = "/data/data/com.termux/files/home"
usr_prefix = "/data/data/com.termux/files/usr"
EOF
fi

if [[ -d "$OMARCHY_PATH/default" ]]; then
  gum style --foreground 6 "Copying default configurations..."

  for config_dir in "$OMARCHY_PATH/default"/*/; do
    config_name=$(basename "$config_dir")
    target_dir="$HOME/.config/$config_name"

    if [[ -d "$target_dir" ]]; then
      gum style --foreground 3 "Skipping existing: $config_name"
      continue
    fi

    mkdir -p "$target_dir"

    for template in "$config_dir"/*.tpl; do
      if [[ -f "$template" ]]; then
        template_name=$(basename "$template" .tpl)
        output_file="$target_dir/$template_name"

        sed -e "s|{{HOME}}|$HOME|g" \
            -e "s|{{USER}}|$USER|g" \
            -e "s|{{XDG_CONFIG_HOME}}|$HOME/.config|g" \
            "$template" > "$output_file"

        gum style --foreground 2 "Created: $output_file"
      fi
    done

    for regular_file in "$config_dir"/*.*; do
      if [[ -f "$regular_file" ]] && [[ ! "$regular_file" == *.tpl ]]; then
        cp "$regular_file" "$target_dir/"
        gum style --foreground 2 "Copied: $(basename "$regular_file")"
      fi
    done
  done
fi

gum style --foreground 2 "Configuration complete"
