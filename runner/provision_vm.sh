#!/bin/bash

set -euo pipefail

vagrant up
vagrant ssh -c "/vagrant/set_up_docker.sh"
vagrant ssh -c "sudo /vagrant/runner/runner_setup.sh"
