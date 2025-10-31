# Dockerized CMaNGOS WotLK

This repository assumes that you are using rootless [Podman](https://github.com/containers/podman)

## If you insist on using docker instead of podman
By default `podman` is used. If `podman` is not present on your system, `docker` will be used.
If you want to override which container orchestrator to use set the environment variable `CONTAINER_ORCHESTRATOR` to `podman` or `docker` or any other that is command-compatible.

### Getting started

To get started first run `./build_default.sh` if you don't want to play with Playerbots or `./build_bots.sh` if you want to play with bots.
This will build the server components and extractors. It also allows you to update the CMaNGOS core to the latest version.

Next run `./update_dbs.sh` to download and install the SQLite Databases

Finally run `./extract.sh /path/to/your/World of Warcraft` to extract the data required to run the server.

***Duplicate all config files in the `etc` directory and remove the `.dist` file extension on the duplicated files. Do not delete or edit the original `.dist` files unless you want git to complain***

Once all of this has finished you can start the server with `podman-compose up -d` and check the status with `podman-compose logs`

To create a user run `./enter_console.sh` to connect to the `mangosd` process. Log in with `ADMINISTRATOR` as user and `ADMINISTRATOR` as password.

To update the core simply run `./build_default.sh` or `./build_bots.sh` again.
To update the database simply run `./update_dbs.sh` again

## Experimental
If an update of the realmd and/or characters database is required there is an ***EXPERIMENTAL*** feature that allows backing up these databases and restoring them.

To do this you *first* run `./db_backup.sh` which will create 2 files: `realmd_backup.sql` and `characters_backup.sql`. Open them with a text editor to confirm that they are not empty.
If they are not empty in the next step *rename* your `databases` directory to `databases_old`, then run `update_dbs.sh` again. When this is done run `db_restore.sh`.

*IMPORTANT*: `db_restore.sh` works by first emptying the entire database and then adding the data from the 2 backup files. If these backups are not up-to-date or contain invalid SQL, this will
make the `realmd` and `characters` dbs unusable. So be *absolutely sure* that you have renamed the folder with the original databases to avoid data loss.

Carelessness in this process can and will delete all of your account data in these containers.

There are also the `handsfree_setup.sh` and the `handsfree_update.sh` scripts, which *should* do the full setup without user intervention and do a full update with only a minor intervention.
Especially the hands free update is dangerous, so only do it if you're sure.
