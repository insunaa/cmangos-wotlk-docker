#!/bin/bash
source preamble.sh

$ORCH build --build-arg AHBOT=0 --build-arg PLAYERBOTS=0 --build-arg INVALIDATE_CACHE="$(date)" -t mangos-wotlk:latest .

$ORCH rmi $($ORCH images --filter label=deleteme=true -q)
