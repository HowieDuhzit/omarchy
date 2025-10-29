# Omarchy

Omarchy is a beautiful, modern & opinionated Linux distribution by DHH.

Read more at [omarchy.org](https://omarchy.org).

## Features

- **Modern Desktop**: Hyprland-based Wayland compositor with beautiful themes
- **VR Support**: Full VR integration with WiVRn and WayVR for wireless VR desktop
- **Developer Tools**: Comprehensive development environment with Docker, Git, and more
- **Theme System**: Multiple beautiful themes with automatic configuration
- **Hardware Support**: Optimized for various hardware configurations including Apple Silicon

## VR Support

Omarchy includes VR support with WiVRn and WayVR:

- **WiVRn Integration**: Wireless VR streaming to Quest, Pico, and other compatible headsets
- **WayVR Desktop**: Run desktop applications in VR with wlx-overlay-s
- **Theme Integration**: VR configurations that match your selected theme

### Quick VR Start

```bash
# Install VR support
omarchy-install-vr

# Detect VR hardware
omarchy-vr-detect

# Check game compatibility
omarchy-vr-compatibility

# Start VR
wivrn-dashboard
```

See [VR Documentation](docs/VR.md) for detailed setup and configuration.

## License

Omarchy is released under the [MIT License](https://opensource.org/licenses/MIT).
