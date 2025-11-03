#!/bin/bash
source preamble.sh

$ORCH exec -it cmangos-wotlk-docker_mangosd_1 /bin/netcat localhost 3443
