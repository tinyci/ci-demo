#!/bin/bash

set -euo pipefail

POSTGRES_VERSION="9.6"

curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo 'deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main' | sudo tee -a /etc/apt/sources.list.d/postgresql.list

sudo apt-get update -qq
sudo apt-get install -y postgresql-$POSTGRES_VERSION -y -qq
sudo su postgres -c "bash -c 'createuser -s tinyci -P < <(echo -e \"tinyci\ntinyci\n\")'"
sudo su postgres -c "bash -c 'createdb -O tinyci tinyci'"

