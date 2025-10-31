#!/bin/bash
checkpodman(){
    echo $(command -v podman)
}
checkdocker(){
    echo $(command -v docker)
}

ORCH=podman

if [ ! -z "${CONTAINER_ORCHESTRATOR}" ]; then
    ORCH="${CONTAINER_ORCHESTRATOR}"
else
    if [ ! $(checkpodman) ]; then
        if [ ! $(checkdocker) ]; then
            echo "No Container-Orchestrator found."
            exit 1
        else
            ORCH=docker
        fi
    fi
fi

if [ "$#" -lt 1 ]; then
    echo 'Usage: ./extract.sh /path/to/your/wow/client'
    exit 1
fi

if [[ ! -d "$1" ]]; then
    echo 'Target must be the `World of Warcraft` directory.'
    exit 1
fi

if [ "$1" = "/" ] || [ "$1" = "" ]; then
    echo 'Path cannot be root or be empty.'
    exit 1
fi

if [[ ! -d "$1/Data" ]] && [[ ! -d "$1/data" ]]; then
    echo 'Target must be the `World of Warcraft` directory.'
    exit 1
fi

if [ ! -d data ]; then
    mkdir data
fi

$ORCH run --rm -w '/mangos/bin/tools/' -v "$1:/client" -v './data:/output' cmangos-wotlk:latest /bin/bash "/mangos/bin/tools/ExtractResources.sh" "a" "/client" "/output"
