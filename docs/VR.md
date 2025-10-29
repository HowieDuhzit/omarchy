# VR Support in Omarchy

Omarchy includes VR support using WiVRn and WayVR for wireless VR desktop functionality.

## Quick Start

### 1. Install VR Support

```bash
omarchy-install-vr
```

### 2. Start VR

```bash
wivrn-dashboard
```

### 3. Connect Your Headset

1. Install WiVRn client on your VR headset
2. Connect to the same network as your PC
3. Launch WiVRn client and connect to your PC

## Configuration

### WiVRn Configuration

Located at `~/.config/wivrn/config.json`:

```json
{
  "application": ["/usr/local/bin/wlx-overlay-s"],
  "bitrate": 50000000,
  "openvr-compat-path": "/opt/xrizer",
  "use-steamvr-lh": false
}
```

### WayVR Configuration

Located at `~/.config/wlxoverlay/wayvr.yaml`:

- **blit_method**: Rendering method (`software` for AMD, `dmabuf` for NVIDIA)
- **displays**: Virtual display configurations
- **catalogs**: Application launcher catalog

### Theme Integration

VR configurations automatically match your selected Omarchy theme through the theme system.

## GPU-Specific Settings

### NVIDIA GPUs

```yaml
# In ~/.config/wlxoverlay/wayvr.yaml
blit_method: "dmabuf"
```

### AMD RDNA3 GPUs

```yaml
# In ~/.config/wlxoverlay/wayvr.yaml
blit_method: "software"
```

## Troubleshooting

### Common Issues

1. **Apps render incorrectly**: Switch rendering mode in wayvr.yaml
2. **No overlay appears**: Check wlx-overlay-s path in WiVRn config
3. **High latency**: Reduce bitrate in WiVRn config

### Performance Tuning

Adjust bitrate in `~/.config/wivrn/config.json`:

- WiFi 5: 30-50 Mbps
- WiFi 6: 50-100 Mbps
- WiFi 6E: 100-150 Mbps

## Applications

Pre-configured apps include Terminal, Firefox, File Manager, VS Code, and htop on watch overlay.

## Environment Variables

```bash
export WAYVR_DISPLAY="wayland-20"
alias vr-app='DISPLAY= WAYLAND_DISPLAY=$WAYVR_DISPLAY'
```

## Package Versions

**Working Versions (as of Oct 2025):**

- wivrn-server: 25.9-3
- wivrn-dashboard: 25.9-1
- xrizer: 0.3-3
- openxr: 1.1.53-1
- openvr: 2.12.14-1
- wlx-overlay-s: Built from git main branch

## Community Resources

### Linux VR Community
- **[Linux VR Adventures Wiki](https://lvra.gitlab.io/)**: Comprehensive VR guides and resources
- **[VR Game Compatibility Database](https://db.vronlinux.org)**: Check which VR games work on Linux
- **Linux VR Discord**: Join thousands of Linux VR enthusiasts

### Additional VR Software
- **Envision**: WMR controller tracking for Arch Linux
- **OpenComposite**: Drop-in SteamVR replacement for better performance
- **ALVR**: Alternative wireless VR streaming solution
- **SlimeVR**: Full-body tracking without base stations

### Hardware Detection
```bash
# Detect your VR hardware and get recommendations
omarchy-vr-detect

# Check VR game compatibility
omarchy-vr-compatibility
```

### Performance Tips
- Use OpenComposite instead of SteamVR when possible
- Enable hardware acceleration in Steam
- Set CPU governor to performance mode
- Close unnecessary background applications
- Use wired connection for best latency