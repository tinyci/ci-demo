### tinyCI ci-demo

The scripts in this repo can be used to bring up a tinyCI demo environment.

##### Requirements

Vagrant and VirtualBox are both required for the demo environment.


The following need to be placed in the top level directory of this repo before getting started:

**tinyci.tar.gz** - a tarball with the tinyci release


The services.yaml file also needs to be placed at the top level.
The following template can be used:
```
---
auth:
  session_crypt_key: 1234567123456712345671234567123456712345671234567888888812345678
  token_crypt_key: 1234567123456712345671234567123456712345671234567888888812345678
oauth:
  # see https://github.com/settings/developers to set up oauth credentials
  client_id: "client id"
  client_secret: "client secret"
  redirect_url: "http://192.168.50.5:3000/uisvc/login"
clients:
  datasvc: 'localhost:6000'
  queuesvc: 'localhost:6001'
  logsvc: 'localhost:6002'
  uisvc: 'localhost:6010'
services:
  last_scanned_wait: 1m
websockets:
  insecure_websockets: true
db: 'host=localhost database=tinyci user=tinyci password=tinyci'
hook_url: 'http://fqdn-address:3000/hook'
url: 'http://192.168.50.5:3000'
log_requests: true
```


A tool such as ngrok should be used to have an URL which points to http://192.168.50.5:3000.

The URL http://192.168.50.5:3000 can be used to access tinyCI once the VMs are up.

The bundled set_up_ngrok.sh shell script can be used to configure ngrok to point to the internal
IP and port. This will be used for hook delivery.

The URL provided by ngrok should be put in the `url` field of the config.

The internal URL (http://192.168.50.5:3000) should be used when accessing tinyCI.

##### Starting

Once all the dependencies are in place, run the following script:
```
./provision_vms.sh
```

tinyCI should be up and accessible via the URL defined in services.yaml.
