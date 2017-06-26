#!/bin/bash

set -e

# Put 1024 into consul KV at service/haproxy/maxconn
# This value is used in haproxy template (template/haproxy.tmpl)
#curl -X PUT -d '1024' http://consul:8500/v1/kv/service/haproxy/maxconn

# Run consul-template for continious sync with consul
# As soon as new services are registered, consul-template will generate 
# new haproxy.cfg and will reload haproxy server

/usr/sbin/nginx -g 'pid /tmp/nginx.pid;'
consul-template -config=/consul-template/template.d/nginx.json 
