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
`docker-compose scale backend-app=5`

Fabio loadbalancer automatically starts sending requests to new backend servers, balancing them.

## Traefik

Configuring enother loadbalancer is almost the same. There is a minimalistic config file in traefik.

A consul service catalog is used to populate backend, so registrator and consul would work without changes.

Traefik integrates with many other registries and service discovery tools (Consul KV, Mesos, Etcd and even oh no - Zookeeper. See the docs at https://docs.traefik.io/)

Set up HOSTNAME env variable, same as for Fabio.

```
export HOSTNAME=$(hostname)
```

Change dir to traefik folder and run `docker-compose up -d`.

Open Traefik UI daashboard at `http://localhost:8080`, there should be one active (default) front-end. 

For the sake of consitency, front-end (or as Traefik developers call it "entry point") is the same: `http://localhost:9999/`

Scale app and watch how instances get registred in consul, traefik and start responding to request - so in browser different container IDs for each request will be displayed.


### Todo
Add graphite metrics.
