#!/bin/bash
if [ ! -z $INSIDE_CONTAINER ]; then
    echo 'Setup cannot be done from inside the container. Please build it regularly.'
    exit 1
fi

if [ "$#" -lt 1 ]; then
    echo 'Usage: ./handsfree_setup.sh /path/to/your/wow/client'
    exit 1
fi

if [[ ! -d "$1" ]]; then
    echo 'Target must be the `World of Warcraft` directory.'
    exit 1
fi

if [ "$1" = "/" ] || [ "$1" = "" ]; then
    echo 'Path cannot be root or be empty.'
    exit 1
fi

if [[ ! -d "$1/Data" ]] && [[ ! -d "$1/data" ]]; then
    echo 'Target must be the `World of Warcraft` directory.'
    exit 1
fi

if [ ! -d data ]; then
    mkdir data
fi

if [ ! -f .env ]; then
    echo "Please modify the '.env' file to select the desired expansion!"
    cp .env.dist .env
    exit 1
fi

bash build_bots.sh
bash update_dbs.sh
bash extract.sh $1

echo 'Setup finished! Edit `etc/playerbot.conf` to optionally disable playerbots.'
echo 'To create your account use `podman-compose up -d` or `docker compose up -d` to start the composition, then run `enter_console.sh` to log into the terminal.'
