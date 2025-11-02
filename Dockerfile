FROM debian:trixie as build

ARG PLAYERBOTS=0
ARG AHBOT=0

RUN \
    mkdir /mangos && \
    apt update && \
    apt install -y \
    git \
    build-essential \
    g++ \
    gcc \
    automake \
    libsqlite3-dev \
    libtool \
    libssl-dev \
    binutils \
    libbz2-dev \
    cmake \
    libboost-all-dev \
    zlib1g-dev \
    ninja-build

FROM build as build2
ARG INVALIDATE_CACHE
RUN git clone --recursive https://github.com/cmangos/mangos-wotlk.git && \
    mkdir -p mangos-wotlk/build && \
    cmake -Bmangos-wotlk/build -Smangos-wotlk -DPCH=1 -DDEBUG=0 -DUSE_ANTICHEAT=0 -DSQLITE=1 -DBUILD_EXTRACTORS=1 -DBUILD_AHBOT=$AHBOT -DBUILD_PLAYERBOTS=$PLAYERBOTS -DCMAKE_INSTALL_PREFIX=/mangos -DCMAKE_BUILD_TYPE=Release -GNinja -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_CXX_STANDARD=20 && \
    cd mangos-wotlk/build && \
    ninja install

FROM debian:trixie-slim
COPY --from=build2 /mangos /mangos

RUN apt update && \
    apt upgrade && \
    apt install -y netcat-traditional && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /mangos/bin
