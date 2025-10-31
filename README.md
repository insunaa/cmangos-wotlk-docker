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

Once all of this has finished you can start the server with `podman-compose up -d` and check the status with `podman-compose logs`

To create a user run `./enter_console.sh` to connect to the `mangosd` process. Log in with `ADMINISTRATOR` as user and `ADMINISTRATOR` as password.

To update the core simply run `./build_default.sh` or `./build_bots.sh` again.
To update the database simply run `./update_dbs.sh` again
