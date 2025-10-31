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

$ORCH exec -it cmangos-wotlk-docker_mangosd_1 /bin/netcat localhost 3443
