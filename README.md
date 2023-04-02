# Tailscale relay container

Tailscale relay container for a simple containerized Tailscale node instance in relay mode and exit node. Optional you can use the container as Sidecar container to serve a single container in Tailscale or public with Funnel (see `./example`).

## Tailscale Funnel Sidecar

See `./example/funnel`.

## Tailscale Relay Node

Create a separate docker network to share with Tailscale:

```bash
docker network create -d bridge <network name>
```

Share the docker network inside Tailscale with:

```bash
docker run -d \
    -v /tailscale \
    --cap-add=NET_ADMIN \
    --network=<docker_net> \
    -e "ROUTES=auto" \
    -e "AUTHKEY=<your_auth_key>" \
    ghcr.io/niki-on-github/tailscale-relay:dev
```

All container you want to be accessible from Tailscale must use the specified docker network.
