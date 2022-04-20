#!/bin/sh

VER=${1:-"17"}

rm -rf src ubuntu-jammy-oci-amd64-root.tar.gz
cp -r source17 src

rm -rf src/.git src/.github
wget https://partner-images.canonical.com/oci/jammy/current/ubuntu-jammy-oci-amd64-root.tar.gz

docker build --tag k0d3r1s/node:${VER} --squash --compress --no-cache -f Dockerfile.debian . || exit

rm -rf src

docker push k0d3r1s/node:${VER}
