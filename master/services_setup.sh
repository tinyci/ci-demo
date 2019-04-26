#!/bin/bash

set -euo pipefail

TINYCI_DIR=/var/tinyci
TINYCI_BIN_DIR=$TINYCI_DIR/bin
TINYCI_CONFIG_DIR=$TINYCI_BIN_DIR/.config
TINYCI_TEMPORARY_DIRECTORY=/home/vagrant/tinyci

SERVICES="assetsvc datasvc hooksvc logsvc uisvc-server queuesvc"

sudo mkdir -p $TINYCI_CONFIG_DIR
cd $TINYCI_BIN_DIR
sudo tar --strip-components=1 binaries -xpf /vagrant/release.tar.gz
sudo cp /vagrant/services.yaml $TINYCI_CONFIG_DIR/
sudo cp /vagrant/master/hooksvc.yaml.tmpl $TINYCI_CONFIG_DIR/hooksvc.yaml
sudo chown -R root:root $TINYCI_DIR
sudo mkdir $TINYCI_DIR/logs
sudo chown -R vagrant $TINYCI_DIR/logs
(
	mkdir $TINYCI_TEMPORARY_DIRECTORY || true
	cd $TINYCI_TEMPORARY_DIRECTORY
	tar -xpf /vagrant/release.tar.gz
	binaries/migrator -u tinyci -p tinyci migrations/tinyci
)

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
