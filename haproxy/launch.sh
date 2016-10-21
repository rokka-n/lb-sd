#!/bin/bash

set -e

# Put 1024 into consul KV at service/haproxy/maxconn
# This value is used in haproxy template (template/haproxy.tmpl)

# And since there is no service discovery before consul starts,
# lets do a little bit of manual one here :)
while :
 do
    (echo > /dev/tcp/consul/8500) >/dev/null 2>&1
    result=$?
    if [[ $result -eq 0 ]]; then
        echo "consul:8500 is available after"
        break
    fi
    sleep 1
done

# Post some data in KV which haproxy can pick up for its config
curl -s -X PUT -d '1024' http://consul:8500/v1/kv/service/haproxy/maxconn

# Run consul-template for continious sync with consul
# As soon as new services are registered, consul-template will generate 
# new haproxy.cfg and will reload haproxy server
consul-template -consul=consul:8500 -config=/consul-template/template.d/haproxy.json &

echo "starting syslog-ng..."
# This will print logs from haproxy to stdout
syslog-ng -F --no-caps 
