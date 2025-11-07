#!/bin/bash
source preamble.sh

$COMPOSE_COMMAND exec mangosd /bin/netcat localhost 3443
