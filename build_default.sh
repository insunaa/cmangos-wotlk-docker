#!/bin/bash
source preamble.sh
source .env

$ORCH build --build-arg AHBOT=0 --build-arg PLAYERBOTS=0 --build-arg INVALIDATE_CACHE="$(date)" --build-arg CMANGOS_EXPANSION=$CMANGOS_EXPANSION -t mangos-$CMANGOS_EXPANSION:latest .

$ORCH rmi $($ORCH images --filter label=deleteme=true -q)
