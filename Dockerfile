FROM devkitpro/toolchain-base:latest

RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev

RUN dkp-pacman -S gba-dev --noconfirm

ENV DEVKITPRO=/opt/devkitpro

ENV DEVKITARM=$DEVKITPRO/devkitARM

COPY ./agbcc /usr/src/agbcc

COPY ./pokefirered /usr/src/pokefirered

WORKDIR /usr/src/agbcc

RUN sh build.sh

RUN sh install.sh ../pokefirered

WORKDIR /usr/src/pokefirered
