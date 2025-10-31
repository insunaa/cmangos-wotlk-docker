#!/bin/bash

if [ ! -f realmd_backup.sql ] || [ ! -s realmd_backup.sql ]; then
    "No Realmd Backup detected. Aborting"
    exit 1
fi

echo "Deleting the realmd Database"
for t in $(sqlite3 databases/wotlkrealmd.sqlite ".mode list" "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';"); do
  echo "-- $t"
  sqlite3 databases/wotlkrealmd.sqlite "DELETE FROM \"$t\";"
done
echo "Restoring the realmd Database"
sqlite3 databases/wotlkrealmd.sqlite < realmd_backup.sql

if [ ! -f characters_backup.sql ] || [ ! -s characters_backup.sql ]; then
    "No Characters Backup detected. Aborting"
    exit 1
fi

echo "Deleting the characters Database"
for t in $(sqlite3 databases/wotlkcharacters.sqlite ".mode list" "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';"); do
  echo "-- $t"
  sqlite3 databases/wotlkcharacters.sqlite "DELETE FROM \"$t\";"
done
echo "Restoring the characters Database"
sqlite3 databases/wotlkcharacters.sqlite < characters_backup.sql
