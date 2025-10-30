FROM debian:trixie

RUN \
    mkdir /mangos && \
    apt update && \
    apt upgrade && \
    apt install -y \
    netcat-traditional \
    git \
    build-essential \
    g++ \
    gcc \
    automake \
    sqlite3 \
    libsqlite3-dev \
    libtool \
    libssl-dev \
    binutils \
    libbz2-dev \
    cmake \
    libboost-all-dev \
    zlib1g-dev \
    ninja-build \
    && \
    git clone --recursive https://github.com/cmangos/mangos-wotlk.git && \
    mkdir -p mangos-wotlk/build && \
    cmake -Bmangos-wotlk/build -Smangos-wotlk -DPCH=1 -DDEBUG=0 -DUSE_ANTICHEAT=0 -DSQLITE=1 -DCMAKE_INSTALL_PREFIX=/mangos -DCMAKE_BUILD_TYPE=Release -GNinja -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_CXX_STANDARD=20 && \
    cd mangos-wotlk/build && \
    ninja install
WORKDIR /mangos/bin
