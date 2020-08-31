#!/bin/bash 

# Create a writable directory for the docker volume.
if [[ ! -e "data/" ]]; then
    mkdir data
    chmod 777 data/
fi

docker-compose -f docker/docker-compose.yml up --build