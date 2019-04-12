#!/bin/bash

set -euo pipefail
cat <<EOF > /etc/systemd/system/$1.service
[Unit]
Description=$1
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=vagrant
ExecStart=/var/tinyci/bin/$1
WorkingDirectory=/var/tinyci/bin/

[Install]
WantedBy=multi-user.target
EOF
