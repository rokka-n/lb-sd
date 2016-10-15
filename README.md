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

### Todo
Add graphite metrics.
