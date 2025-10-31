#!/bin/bash

podman build --build-arg AHBOT=1 --build-arg PLAYERBOTS=1 -t mangos-wotlk:latest .
