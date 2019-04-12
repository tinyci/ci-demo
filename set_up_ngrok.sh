#!/bin/bash

HAS_JQ=0
HAS_PYTHON=0
HAS_PYTHON3=0
URL=
TUNNEL_ENDPOINT_CONFIG=./tunnel-config.json
TUNNEL_ENDPOINT_RESULT=tunnel.json
PYTHON_JSON_DUMP_CODE="import sys, json; print(json.load(sys.stdin)['public_url'])"

jq
if [ "$?" -eq "0" ]; then
	HAS_JQ=1
fi

python -V
if [ "$?" -eq "0" ]; then
	HAS_PYTHON=1
fi

python3 -V
if [ "$?" -eq "0" ]; then
	HAS_PYTHON3=1
fi

if [ "$HAS_JQ" -eq "0" ] && [ "$HAS_PYTHON" -eq "0" ] && [ "$HAS_PYTHON3" -eq "0" ]; then
	echo "jq, python2 or python3 must be installed"
	exit 1
fi

set -euo pipefail

wget -O $TUNNEL_ENDPOINT_RESULT --post-file=$TUNNEL_ENDPOINT_CONFIG --header='Content-Type:application/json' http://127.0.0.1:4040/api/tunnels

if [ "$HAS_JQ" -eq "1" ]; then
	URL=$(cat $TUNNEL_ENDPOINT_RESULT | jq -r '.public_url')
elif [ "$HAS_PYTHON3" -eq "1" ]; then
	URL=$(cat $TUNNEL_ENDPOINT_RESULT | python3 -c "$PYTHON_JSON_DUMP_CODE")
elif [ "$HAS_PYTHON" -eq "1" ]; then
	URL=$(cat $TUNNEL_ENDPOINT_RESULT | python -c "$PYTHON_JSON_DUMP_CODE")
fi
echo $URL
