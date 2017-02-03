# Remove Docker Overlay Networks
---
Sometimes, when applications are brought down abnormally (like without running a `docker-compose down` or when upgrading the docker engine), overlay networks can get orphaned. The terminated & now non-existent containers remain in the `Containers` attribute of the networks. This prevents the network from being removed and cleaned up.
```
$ docker network rm newnet29_default
Error response from daemon: Error response from daemon: network newnet29_default has active endpoints
```

The script in this repo is a workaround for the issue above. It forcefully disconnects all the containers from all overlay networks and then removes the network.

## Steps to run:

1. Requires `jq` - get it from https://stedolan.github.io/jq/download/ and put it in your path.
2. Connect to a UCP (DDC) or swarm cluster using an admin client bundle or by changing the `DOCKER_HOST` environment variable.
3. Run the script in this repo: `./clean-rm-networks.sh`
