setup: reset download
	bash make/setup.sh	

download:
	bash make/download.sh

reset:
	bash make/reset.sh

start:
	vagrant up

stop:
	vagrant destroy -f || :

restart: stop start

provision:
	vagrant provision
