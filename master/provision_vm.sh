#!/bin/bash

set -euo pipefail

vagrant up
vagrant ssh -c "/vagrant/set_up_docker.sh"
vagrant ssh -c "sudo su vagrant -c /vagrant/master/ci-ui_setup.sh"
vagrant ssh -c "sudo su vagrant -c /vagrant/master/postgres_setup.sh"
vagrant ssh -c "sudo su vagrant -c /vagrant/master/services_setup.sh"
