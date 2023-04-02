# Tailscale Funnel Example

1. Generate an Auth key on https://login.tailscale.com/admin/authkeys
2. Set Auth key in `./docker-compose.yml`
3. Follow the instruction on https://tailscale.com/kb/1223/tailscale-funnel/ to enable the Funnel
   - Add `nodeAttrs` and `group:can-funnel` to https://login.tailscale.com/admin/acls
4. Start Container stack with `docker compose up -d`
5. Open shell in `tailscale-relay` container with: `docker compose exec tailscale-relay /bin/sh` and enable funnel with:
   1. `tailscale serve https / http://127.0.0.1:80`
   2. `tailscale funnel 443 on`
   3. Wait a few seconds
   4. Use `tailscale funnel status`to get the public accessible URL.
