#!/bin/bash

podman build --build-arg AHBOT=0 --build-arg PLAYERBOTS=0 -t mangos-wotlk:latest .
