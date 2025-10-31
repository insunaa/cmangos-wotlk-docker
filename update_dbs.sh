#!/bin/bash

wget --quiet -O dbs.zip https://github.com/cmangos/wotlk-db/releases/download/latest/wotlk-sqlite-db.zip

if [ ! -f dbs.zip ]; then
    echo "Failed to download Databases"
    exit 1
fi

if [ ! -d databases ]; then
    mkdir databases
fi

if [ ! -f databases/wotlkmangos.sqlite ]; then
    unzip dbs.zip -d databases
    if [ -f databases/wotlkrealmd.sqlite ]; then
        sqlite3 databases/wotlkrealmd.sqlite "UPDATE account SET locked=1 WHERE id<5;" ".exit"
    fi
else
    unzip -o dbs.zip wotlkmangos.sqlite -d databases
fi

rm dbs.zip

if [ -f custom.sql ]; then
    sqlite3 databases/wotlkmangos.sqlite < custom.sql
fi

if [ -f realm.sql ]; then
    sqlite3 databases/wotlkrealmd.sqlite < realm.sql
fi
