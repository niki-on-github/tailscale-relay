#!/bin/sh

# Setup iptables
iptables -t nat -A POSTROUTING -o tailscale0 -j MASQUERADE

if [ ! -d /dev/net ]; then mkdir /dev/net; fi
if [ ! -e /dev/net/tun ]; then  mknod /dev/net/tun c 10 200; fi

if [ "$ROUTES" = "auto" ]; then
    ROUTES="$(ip -o -f inet addr show | grep -v tailscale | awk '/scope global/ {print $4}' | head -n1)"
fi

if [ -z "$ROUTES" ]; then
    /bin/sh -c "sleep 5; tailscale up --advertise-exit-node=true --login-server ${LOGINSERVER} --authkey ${AUTHKEY}" &
else
    /bin/sh -c "sleep 5; tailscale up --advertise-exit-node=true --advertise-routes ${ROUTES} --login-server ${LOGINSERVER} --authkey ${AUTHKEY}" &
fi

if [ -d /certs ]; then
    /bin/sh -c "sleep 20; cd /certs && tailscale cert \$(tailscale cert 2>&1 | sed -n 2p | awk -F \\\" '{print \$2}')" &
fi

exec /usr/bin/tailscaled --state=/tailscale/tailscaled.state
