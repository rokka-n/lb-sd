# lb-sd
Fabio, traefik and other contemporary load-balancers in docker-compose for easy tests

## Fabio

To run fabio with service discovery, make sure that HOSTNAME env variable is set.

It should resolve to your local computer IP, e.g:
```
export HOSTNAME=$(hostname)
```

Change folder to fabio and run `docker-compose up -d`.

Open fabio's loadbalancer at `http://localhost:9999/` and see backends responding.

Fabio has an admin panel at `http://localhost:9998`, where you can find all routes and backeds.

Consul UI is available at `http://localhost:8500/ui/`

Scale app by multiple number of backend servers:
` docker-compose scale nginx=5`

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

### Todo
Add graphite metrics.
