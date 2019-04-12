#!/bin/bash

set -euo pipefail

(
	cd master
	../vm_cleanup.sh
	./provision_vm.sh
)

(
	cd runner
	../vm_cleanup.sh
	./provision_vm.sh
)
