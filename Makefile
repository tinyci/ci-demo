setup: reset
	bash make/setup.sh	

reset:
	bash make/reset.sh

start:
	vagrant up

stop:
	vagrant destroy -f || :

restart: stop start

provision:
	vagrant provision
