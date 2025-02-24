FROM devkitpro/devkitarm:latest AS build
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev && \
    apt-get autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*
COPY ./agbcc /usr/local/src/agbcc
COPY ./pokefirered /usr/local/src/pokefirered
RUN cd /usr/local/src/agbcc && \
    sh build.sh && \
    sh install.sh ../pokefirered && \
    cd /usr/local/src/pokefirered && \
    make -j$(nproc)

FROM scratch AS build-export
COPY --from=build /usr/local/src/pokefirered/pokefirered.gba /
WORKDIR /
