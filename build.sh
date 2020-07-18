#!/bin/bash
# file: build.sh

# Validate input.
if [[ (-n $1 && $1 != "-v") || $# -gt 1 ]]; then
	echo "Usage: ./build.sh [-v]"
	exit 1
elif [[ -z $1 ]]; then
	OUT="> /dev/null 2>&1"
fi

HELP="Run with -v for more info."

# Build image (and agbcc compiler/tools).
# Docker caches this, so it's not a big deal to run every time.
eval "docker build -t pokefirered . $OUT"
if [[ $? -ne 0 ]]; then
	echo "Failed to build image. $HELP"
	exit 1
fi

# Build ROM inside container.
eval "docker run --name pokefirered pokefirered make -j$(nproc) firered_rev1 $OUT"
if [[ $? -ne 0 ]]; then
	echo "Failed to build ROM. $HELP"
	exit 1
fi

# Find container name using StackOverflow.
CONTAINER=$(docker ps -a | sed -n '2 p' | cut -d' ' -f1)

# Export ROM from container.
eval "docker cp $CONTAINER:/usr/src/pokefirered/pokefirered_rev1.gba . $OUT"
if [[ $? -ne 0 ]]; then
	echo "Failed to export ROM. $HELP"
	docker container rm $CONTAINER
	exit 1
fi

# Change ROM permissions from root. 
eval "chown $USER pokefirered_rev1.gba $OUT"
if [[ $? -ne 0 ]]; then
	echo "Failed to set ROM permissions. $HELP"
	docker container rm $CONTAINER
	exit 1
fi

# Remove container.
eval "docker container rm $CONTAINER $OUT"
if [[ $? -ne 0 ]]; then
	echo "Failed to remove container. $HELP"
	exit 1
fi

echo "Build succeeded! :D"
