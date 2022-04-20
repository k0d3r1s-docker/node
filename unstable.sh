#!/bin/sh

VER=${1:-"18.x"}

cd ./source || exit
git reset --hard
git pull
VERSION=`git rev-parse --short HEAD`

cd .. || exit

rm -rf src ubuntu-jammy-oci-amd64-root.tar.gz
cp -r source src

rm -rf src/.git src/.github
wget https://partner-images.canonical.com/oci/jammy/current/ubuntu-jammy-oci-amd64-root.tar.gz

docker build --tag k0d3r1s/node:${VERSION} --tag k0d3r1s/node:unstable --tag k0d3r1s/node:${VER} --squash --compress --no-cache -f Dockerfile.debian . || exit

rm -rf src

old=`cat latest`
hub-tool tag rm k0d3r1s/node:$old -f
echo -n $VERSION > latest

docker push k0d3r1s/node:${VERSION}
docker push k0d3r1s/node:${VER}
docker push k0d3r1s/node:unstable
