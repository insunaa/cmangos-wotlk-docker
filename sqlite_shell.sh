#!/bin/bash
source preamble.sh

if [ ! -z $INSIDE_CONTAINER ]; then
    echo "Already inside container"
    exit 1
fi

$ORCH run --rm -it -w '/repo' -v ".:/repo" cmangos-wotlk:latest /bin/bash
