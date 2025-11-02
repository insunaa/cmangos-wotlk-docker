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

$ORCH build --build-arg AHBOT=0 --build-arg PLAYERBOTS=0 --build-arg INVALIDATE_CACHE="$(date)" -t mangos-wotlk:latest .

$ORCH rmi $($ORCH images --filter label=deleteme=true -q)
