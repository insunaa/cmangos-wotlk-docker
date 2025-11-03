#!/bin/bash
echo "Backing up realmd Database"
for t in $(sqlite3 -batch databases/wotlkrealmd.sqlite ".mode list" "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'character_db_version';"); do
  echo "-- $t"
  sqlite3 -batch databases/wotlkrealmd.sqlite ".mode insert $t" ".headers on" "SELECT * FROM \"$t\";"
done > realmd_backup.sql

echo "Backing up characters Database"
for t in $(sqlite3 -batch databases/wotlkcharacters.sqlite ".mode list" "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'realmd_db_version';"); do
  echo "-- $t"
  sqlite3 -batch databases/wotlkcharacters.sqlite ".mode insert $t" ".headers on" "SELECT * FROM \"$t\";"
done > characters_backup.sql
