#!/bin/bash
source preamble.sh

$ORCH build --build-arg AHBOT=1 --build-arg PLAYERBOTS=1 --build-arg INVALIDATE_CACHE="$(date)" -t cmangos-wotlk:latest .

$ORCH rmi $($ORCH images --filter label=deleteme=true -q)
