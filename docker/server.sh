#!/bin/bash

set -e

# Download the game assets if needed.
if [[ -z "$(ls -A server/)" ]]; then
    echo ">> Downloading server..."
    ./steamcmd.sh +login anonymous +force_install_dir ./server +app_update 232250 +quit
fi

opts="-console -game tf -timeout 3"

opts="$opts +ip ${IP:-0.0.0.0}"
opts="$opts -port ${PORT:-27015}"
opts="$opts +map ${START_MAP:-ctf_2fort}"
opts="$opts +maxplayers ${MAX_PLAYERS:-16}"

if [[ "${VAC:-1}" == "1" ]]; then
    opts="$opts -secured"
fi

# NOTE: Uncomment out the debugging section in the Dockerfile, otherwise
# the debugger won't be installed. 
if [[ "$DEBUG" == "1" ]]; then
    opts="$opts -debug"
fi

if [[ -n "$EXTRA" ]]; then
    opts="$opts $EXTRA"
fi

echo ">> Server command line options:"
echo ">> $opts"

opts="$opts +sv_setsteamaccount ${SERVER_TOKEN}"

# Make sure steamclient.so is linked before starting the server.
if [[ ! -e "~/.steam/sdk32/steamclient.so" ]]; then
    mkdir -p ~/.steam/sdk32
    ln -s ~/server/bin/steamclient.so ~/.steam/sdk32/
fi

echo ">> Starting server..."

./server/srcds_run $opts
