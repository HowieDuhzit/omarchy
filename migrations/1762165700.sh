echo "Update all theme screensaver.conf files to include all available hyprshade shaders for random selection"

THEMES_DIR="$HOME/.config/omarchy/themes"

# Get all available shaders from hyprshade
if ! command -v hyprshade &>/dev/null; then
  echo "Warning: hyprshade not found. Using default shader list."
  SHADERS=("blue-light-filter" "vibrance" "sepia" "grayscale" "vintage")
else
  # Get shader list and convert to bash array, removing empty lines
  SHADERS=($(hyprshade ls 2>/dev/null | grep -v '^$' | tr '\n' ' '))
fi

# Create the shaders array string for the config file
SHADERS_STRING="SCREENSAVER_SHADERS=("
for shader in "${SHADERS[@]}"; do
  SHADERS_STRING+="\"$shader\" "
done
SHADERS_STRING+=")"

# Update screensaver.conf for each theme
for theme_dir in "$THEMES_DIR"/*; do
  if [[ -d "$theme_dir" ]]; then
    screensaver_conf="$theme_dir/screensaver.conf"
    
    # Create file if it doesn't exist
    if [[ ! -f "$screensaver_conf" ]]; then
      cat > "$screensaver_conf" << 'EOF'
#!/bin/bash

# Screensaver shader configuration
# Set to a hyprshade shader name or leave empty to disable
# Examples: "blue-light-filter", "vibrance", or full path to .glsl file
SCREENSAVER_SHADER=""

# Optional: Uncomment to randomly select from multiple shaders
# SCREENSAVER_SHADERS=("blue-light-filter" "vibrance")
EOF
    fi
    
    # Remove any existing SCREENSAVER_SHADERS line (commented or not)
    grep -v "SCREENSAVER_SHADERS=" "$screensaver_conf" > "$screensaver_conf.tmp" 2>/dev/null || cat "$screensaver_conf" > "$screensaver_conf.tmp"
    mv "$screensaver_conf.tmp" "$screensaver_conf"
    
    # Ensure SCREENSAVER_SHADER is set to empty (disabled)
    sed -i 's/^SCREENSAVER_SHADER=.*/SCREENSAVER_SHADER="" # Disabled: using random shader selection/' "$screensaver_conf" 2>/dev/null || true
    
    # Add the shaders array at the end of the file
    cat >> "$screensaver_conf" << EOF

# Randomly select from all available hyprshade shaders
$SHADERS_STRING
EOF
    
    echo "Updated $screensaver_conf with all shaders"
  fi
done

