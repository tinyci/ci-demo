#!/bin/bash

set -euo pipefail

TINYCI_DIR=/home/vagrant/tinyci
export URL_HOST="192.168.50.5:3000"
API_URL="http://${URL_HOST}"
WS_URL="ws://${URL_HOST}"

mkdir $TINYCI_DIR
cd $TINYCI_DIR
tar -xpf /vagrant/release.tar.gz
cd $TINYCI_DIR/ci-ui

sudo apt-get install -y make nginx
sudo rm -rf /var/www/html/*
sudo cp -Rfp $TINYCI_DIR/ci-ui/* /var/www/html/
sudo cp /vagrant/master/nginx.conf /etc/nginx/nginx.conf
sudo systemctl restart nginx
