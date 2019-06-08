#!/usr/bin/env bash

set -euo pipefail

git submodule update --init --recursive
cd ci-deploy
bash make-certificates.sh 192.168.${SUBNET:-42}.2
cd ..
mkdir -p ci-deploy/roles/release/files
cp -v release.tar.gz ci-deploy/roles/release/files

echo
echo "Ready to go!"
echo
