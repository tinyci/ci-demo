#!/bin/bash

set -euo pipefail

TINYCI_DIR=/var/tinyci
TINYCI_BIN_DIR=$TINYCI_DIR/bin
TINYCI_CONFIG_DIR=$TINYCI_BIN_DIR/.config
SERVICES="assetsvc datasvc hooksvc logsvc uisvc-server queuesvc"

sudo mkdir -p $TINYCI_CONFIG_DIR
cd $TINYCI_BIN_DIR
sudo tar --strip-components=1 binaries -xpf /vagrant/release.tar.gz
sudo cp /vagrant/services.yaml $TINYCI_CONFIG_DIR/
sudo chown -R root:root $TINYCI_DIR

for service in $SERVICES; do
	echo creating unit for service: $service
	sudo /vagrant/master/generate_unit.sh $service
done

sudo systemctl daemon-reload

for service in $SERVICES; do
	echo enabling and starting service: $service
	sudo systemctl enable $service
	sudo systemctl start $service
done
