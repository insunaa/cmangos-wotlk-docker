#!/bin/bash
source preamble.sh

$ORCH exec -it $($ORCH ps --filter 'name=mangosd' --format '{{.Names}}') /bin/netcat localhost 3443
