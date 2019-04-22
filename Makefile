
cleanup:
	bash ./clean_up_vms.sh

provision: cleanup
	bash ./provision_vms.sh
