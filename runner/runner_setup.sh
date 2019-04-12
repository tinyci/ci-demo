#!/bin/bash

set -euo pipefail

TINYCI_DIR=/var/tinyci
TINYCI_BIN_DIR=$TINYCI_DIR/bin
TINYCI_CONFIG_DIR=/etc/tinyci

mkdir -p $TINYCI_CONFIG_DIR
mkdir -p $TINYCI_BIN_DIR
tar -xpf /vagrant/release.tar.gz --strip-components=1 -C $TINYCI_BIN_DIR/ binaries/overlay-runner
cp /vagrant/runner/runner.yml.template $TINYCI_CONFIG_DIR/runner.yml
chown -R root:root $TINYCI_DIR

cat <<EOF > /etc/systemd/system/overlay-runner.service
[Unit]
Description=overlay-runner
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=vagrant
ExecStart=/var/tinyci/bin/overlay-runner -config /etc/tinyci/runner.yml
WorkingDirectory=/var/tinyci/bin/

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

systemctl enable overlay-runner
systemctl start overlay-runner
