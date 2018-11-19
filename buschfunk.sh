#!/bin/sh

touch ./stage3/SKIP ./stage4/SKIP
touch ./stage4/SKIP_IMAGES

git submodule update --remote

PRESERVE_CONTAINER=1 CONTINUE=1 ./build-docker.sh
