#!/bin/bash
echo 'Updating the core.'
sleep 3s
bash build_bots.sh

read -p "Also update the Databases? [y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

if [ ! -d databases ]; then
    echo 'No databases to update found'
    exit 1
fi

if [ -d databases_old ]; then
    echo '`databases_old` directory found. Please rename or delete it.'
    exit 1
fi

echo 'Updating all Databases. If errors occur, delete the `databases` directory and rename `databases_old` to `databases`'
sleep 3s
bash db_backup.sh
mv databases databases_old
bash update_dbs.sh
bash db_restore.sh
