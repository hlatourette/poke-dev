FROM devkitpro/devkitarm:latest as builder
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev && \
    apt-get autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./agbcc /usr/src/agbcc
COPY ./pokefirered /usr/src/pokefirered
RUN cd /usr/src/agbcc && \
    sh build.sh && \
    sh install.sh ../pokefirered && \
    cd /usr/src/pokefirered && \
    make -j$(nproc) firered_rev1
