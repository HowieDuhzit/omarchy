LiveKit — Local Setup with Omarchy

This guide shows how to install and run the LiveKit Server locally from the Omarchy menu, plus quick checks and tips to use it with your apps.

Install via Menu

- Open Omarchy menu: Install → Service → LiveKit Server
- Pick deployment:
  - Binary (systemd): installs the native `livekit-server` binary and can auto-start it as a user service
  - Docker Compose: writes `~/.local/share/omarchy/services/livekit/docker-compose.yml` and starts the stack
- For each method you can opt to bind only to localhost or expose on LAN (0.0.0.0)

What It Installs

- Binary path: `/usr/local/bin/livekit-server` (when using the binary method)
- Service (optional): user systemd unit `livekit-dev.service`
- Docker stack (optional): Compose project `omarchy-livekit` with ports 7880/7881 + UDP 7882-7999
- Dev credentials: API key `devkey`, API secret `secret`

Start/Stop

- Binary manual: `livekit-server --dev`
- Binary + LAN: `livekit-server --dev --bind 0.0.0.0`
- Service control: `systemctl --user start|stop|status livekit-dev.service`
- Docker up/down: `docker compose -f ~/.local/share/omarchy/services/livekit/docker-compose.yml up|down` (or `docker-compose`)

Uninstall

- Menu: Remove → Service → LiveKit
- CLI: omarchy-remove-livekit
- Script stops and deletes the user service, then removes /usr/local/bin/livekit-server

Verify Locally

- Default bind: 127.0.0.1:7880 (LAN if you chose 0.0.0.0)
- Quick probe: `curl -sSf http://127.0.0.1:7880/rtc || true` (404 is expected)
- Docker status: `docker compose -f ~/.local/share/omarchy/services/livekit/docker-compose.yml ps`
- Firewall: open TCP 7880/7881 + UDP 7882-7999 if exposed to LAN

Use in Development

- Tokens: in dev mode, use API key devkey and secret secret to sign access tokens
- SDKs: use LiveKit client SDKs to connect to ws://127.0.0.1:7880 (or your LAN IP)
- Agents: point your Agents/voice apps at your local server using the dev credentials

References

- Running LiveKit locally: https://docs.livekit.io/home/self-hosting/local/
- SDKs overview: https://docs.livekit.io/home/client.md
- Agents overview: https://docs.livekit.io/agents.md
