# lb-sd
Fabio, traefik and other contemporary load-balancers in docker-compose for easy tests

## Fabio

To run fabio with service discovery, make sure that HOSTNAME env variable is set.

It should resolve to your local computer IP or in case if you have read dns server in your network - to fqdn, e.g:
```
export HOSTNAME=$(hostname)
or
export HOSTNAME=$(ipconfig getifaddr en0)
```

If no network interfaces are configured, run following commands so docker process can use IP alias on lo0 (localhost) interface for communication:

```
export HOSTNAME=10.200.10.1
sudo ifconfig lo0 alias $HOSTNAME
```

This is required so consul can perform healthchecks on external (compare to itself) interface, since all services registered with random ports.

Change folder to fabio and run `docker-compose up -d`.

Open fabio's loadbalancer at `http://localhost:9999/` and see backends responding.

Fabio has an admin panel at `http://localhost:9998`, where you can find all routes and backeds.

Consul UI is available at `http://localhost:8500/ui/`

Scale app by multiple number of backend servers:
`docker-compose scale backend-app=5`

Fabio loadbalancer automatically starts sending requests to new backend servers, balancing them.

## Haproxy

Change folder to haproxy and run `docker-compose up -d`.

When all container started, there are two apps available via haproxy:

```
http://localhost:9999/v1/whoami
http://localhost:9999/v1/hello
```

Haproxy stats available at `http://localhost:1936/`

### Metrics

Run this container to scrape metrics periodically:
```
docker run -d -p 9101:9101 prom/haproxy-exporter -haproxy.scrape-uri="http://$HOSTNAME:1936/;csv"
```

Scale app servers up and down and observe how haproxy registers and derigesters backends.

``` 
watch -n 1 'curl -s http://localhost:9101/metrics | grep haproxy_backend_weight '
```

## Traefik

Configuring enother loadbalancer is almost the same. There is a minimalistic config file in traefik.

A consul service catalog is used to populate backend, so registrator and consul would work without changes.

Traefik integrates with many other registries and service discovery tools (Consul KV, Mesos, Etcd and even oh no - Zookeeper. See the docs at https://docs.traefik.io/)

Set up HOSTNAME env variable, same as for Fabio.

```
export HOSTNAME=$(hostname)
or
export HOSTNAME=$(ipconfig getifaddr en0)
```

Change dir to traefik folder and run `docker-compose up -d`.

Open Traefik UI daashboard at `http://localhost:8080`, there should be one active (default) front-end. 

For the sake of consitency, front-end (or as Traefik developers call it "entry point") is the same: `http://localhost:9999/`

Scale app and watch how instances get registred in consul, traefik and start responding to request - so in browser different container IDs for each request will be displayed.

## Nginx

Pretty much the same instructions apply to nginx server (cd to nginx folder). Nginx offers dashboard only in paid version, so there is not much to see  `¯\_(ツ)_/¯` - except services working (http://localhost:9999/v1/whoami).

TODO: filter only services with tag == nginx.


### Todo
Add graphite metrics.
