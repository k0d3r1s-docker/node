#!/bin/bash

shopt -s extglob
cd /usr/local/include/node/openssl
rm -rf archs/!(linux-x86_64)/
