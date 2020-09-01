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

function dock() {
    docker-compose -p tf2-docker -f docker/docker-compose.base.yml "$@"
}

function dock_daemon() {
    dock -f docker/docker-compose.daemon.yml "$@"
}

function console() {
    echo "To leave the console press CTRL-A then D."
    echo "CTRL-C will shutdown the server."
    echo
    echo "If you accidentally shutdown the server, run '$0 restart'"
    echo
    echo "Press [Enter] to continue..."
    read
    dock_daemon exec tf2 screen -x tf2
}

function daemon() {
    create_data_dir
    dock_daemon up -d --build
}

function restart() {
    # The container must be explicitly stopped to prevent an issue with the screen
    # process staying alive.
    stop
    daemon
}

function start() {
    create_data_dir
    dock up --build
}

function stop() {
    dock_daemon stop
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
}

case "$1" in
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
