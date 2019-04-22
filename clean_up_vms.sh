#!/bin/bash

set -euo pipefail

(
	cd master
	../vm_cleanup.sh
)

(
	cd runner
	../vm_cleanup.sh
)
