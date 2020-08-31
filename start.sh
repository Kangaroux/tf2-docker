#!/bin/bash

set -e

if [[ -z "$(ls -A server)" ]]; then
	./install.sh
fi

opts="-console -game tf -secured -timeout 3"

opts="$opts -port {PORT:-27015}"
opts="$opts +map ${START_MAP:-ctf_2fort}"
opts="$opts +maxplayers ${MAX_PLAYERS:-16}"
opts="$opts +sv_setsteamaccount ${SERVER_TOKEN}"

if [[ "$DEBUG" == 1 ]]; then
    opts="$opts -debug"
fi

./srcds_run $opts
