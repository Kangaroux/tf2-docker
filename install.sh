#!/bin/bash

set -e

./steamcmd.sh +login anonymous +force_install_dir ./server +app_update 232250 +quit

mkdir -p ~/.steam/sdk32
ln -s server/bin/steamclient.so ~/.steam/sdk32/
