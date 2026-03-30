# Omarchy Hyprland Configuration for PRoot
# Generated for {{USER}}

# Monitor settings (may need adjustment for PRoot)
# monitor=,preferred,auto,1

# Input settings
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1
    sensitivity = 0
    accel_profile = flat
}

# Cursor settings
cursor {
    no_hardware_cursors = true  # Often needed in PRoot/VM
}

# General window settings
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(7aa2f7ff) rgba(bb9af7ff) 45deg
    col.inactive_border = rgba(414868ff)

    layout = dwindle
    resize_on_border = true
}

# Decoration settings
decoration {
    rounding = 8
    blur {
        enabled = false  # Disable blur in PRoot for performance
    }
    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a28ff)
    col.shadow_inactive = rgba(1a1a2866)
}

# Animation settings
animations {
    enabled = yes
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    bezier = overshot, 0.13, 0.99, 0.29, 1.1
    bezier = smoothOut, 0.36, 0, 0.66, -0.56
    bezier = smoothIn, 0.25, 1, 0.5, 1

    animation = windows, 1, 7, overshot, slide
    animation = windowsOut, 1, 7, smoothOut, slide
    animation = border, 1, 10, default
    animation = fade, 1, 7, smoothIn
    animation = fadeDim, 1, 7, smoothIn
    animation = workspaces, 1, 6, overshot
}

# Layout settings
dwindle {
    pseudotile = yes
    preserve_split = yes
    no_gaps_when_only = false
}

# Gestures (may not work in PRoot)
gestures {
    workspace_swipe = off  # Disable gestures in PRoot
}

# Environment variables
env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt5ct
env = QT_AUTO_SCREEN_SCALE_FACTOR,1
env = GDK_SCALE,1

# Keybinds
$mainMod = SUPER

bind = $mainMod, Q, exec, alacritty
bind = $mainMod, C, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, wofi --show drun
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,
bind = $mainMod, left, movewindow, l
bind = $mainMod, right, movewindow, r
bind = $mainMod, up, movewindow, u
bind = $mainMod, down, movewindow, d

# Screenshot
bind = , Print, exec, grim -g "$(slurp)" - | wl-copy

# Focus
bind = $mainMod, h, focus, l
bind = $mainMod, l, focus, r
bind = $mainMod, k, focus, u
bind = $mainMod, j, focus, d

# Move focus with mainMod + arrow keys
bind = $mainMod SHIFT, left, movewindow, l
bind = $mainMod SHIFT, right, movewindow, r
bind = $mainMod SHIFT, up, movewindow, u
bind = $mainMod SHIFT, down, movewindow, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Window rules
windowrule = float, ^(pavucontrol)$
windowrule = float, ^(blueman-manager)$
windowrule = float, ^(nm-connection-editor)$
windowrule = size 800 600, ^(pavucontrol)$
windowrulev2 = float, class: ^(org.PulseAudio.pavucontrol)$
windowrulev2 = tile, class: ^(kitty)$

# Hyprland ecosystem settings
plugin {
    hyprland Systematic {
        workspace_back_and_forth = true
    }
}
