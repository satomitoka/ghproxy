#!/bin/bash

APPLICATON=ghproxy

if [ ! -f /data/caddy/config/Caddyfile ]; then
    cp /data/caddy/Caddyfile /data/caddy/config/Caddyfile
fi

if [ ! -f /data/${APPLICATON}/config/blacklist.json ]; then
    cp /data/${APPLICATON}/blacklist.json /data/${APPLICATON}/config/blacklist.json
fi

if [ ! -f /data/${APPLICATON}/config/whitelist.json ]; then
    cp /data/${APPLICATON}/whitelist.json /data/${APPLICATON}/config/whitelist.json
fi

if [ ! -f /data/${APPLICATON}/config/config.yaml ]; then
    cp /data/${APPLICATON}/config.yaml /data/${APPLICATON}/config/config.yaml
fi

/data/caddy/caddy run --config /data/caddy/config/Caddyfile > /data/${APPLICATON}/log/caddy.log 2>&1 &

/data/${APPLICATON}/${APPLICATON} > /data/${APPLICATON}/log/run.log 2>&1 &

sleep 30

while [[ true ]]; do
    curl -f http://localhost:8080/api/healthcheck || exit 1
    sleep 120
done    

