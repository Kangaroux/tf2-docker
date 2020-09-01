#!/bin/bash

set -e

cd ${0%/*}

function create_data_dir() {
    # Create a writable directory for the docker volume.
    if [[ ! -e "data/" ]]; then
        echo "Creating 'data/'"
        mkdir data
        chmod 777 data/
    fi
}

function console() {
    dock exec tf2 "screen -x -r tf2"
}

function daemon() {
    dock -f docker/docker-compose.daemon.yml up -d
}

function dock() {
    docker-compose -f docker/docker-compose.base.yml $@
}

function logs() {
    dock logs -f
}

function restart() {
    dock restart
}

function start() {
    create_data_dir
    dock up --build "$@"
}

function stop() {
    dock stop
}

function usage() {
    echo "usage: $0 [command]"
    echo
    echo "Commands"
    echo "    s, start        Starts the server"
    echo "    d, daemon       Starts the server as a daemon (in the background)"
    echo "    r, restart      Restarts the server (daemon only)"
    echo "    c, console      Attaches to the server console for entering commands (daemon only)"
    echo "    stop            Stops the server (daemon only)"
    echo "    logs            Shows the server log (daemon only)"
}

case "$1" in
"logs")
    logs
    ;;
"r" | "restart")
    restart
    ;;
"" | "s" | "start")
    start
    ;;
"d" | "daemon")
    daemon
    ;;
"c" | "console")
    console
    ;;
"stop")
    stop
    ;;
"-h" | "--help" | "help")
    usage
    ;;
*)
    echo "ERROR: Unknown command '$1'"
    echo
    usage
    exit 1
    ;;
esac
