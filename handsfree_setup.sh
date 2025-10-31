#!/bin/bash
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

cp etc/aiplayerbot.conf.dist etc/aiplayerbot.conf
cp etc/anticheat.conf.dist etc/anticheat.conf
cp etc/mangosd.conf.dist etc/mangosd.conf
cp etc/realmd.conf.dist etc/realmd.conf
cp etc/ahbot.conf.dist etc/ahbot.conf

bash build_bots.sh
bash update_dbs.sh
bash extract.sh $1

echo 'Setup finished! Edit `etc/playerbot.conf` to optionally disable playerbots.'
echo 'To create your account use `podman-compose up -d` or `docker compose up -d` to start the composition, then run `enter_console.sh` to log into the terminal.'
