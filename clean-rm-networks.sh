#!/bin/bash

# docker network ls -q --filter driver=overlay does not work on ucp/swarm, hence using good old grep & awk
for networkid in $(docker network ls | grep "overlay\s*global" | awk -F' ' '{ print $1 }') ; \
do
    for containerid in $(docker network inspect --format '{{json .Containers}}' $networkid | \
    	jq -r 'keys[] as $k | "\(.[$k] | .Name)"') ; \
    	do
    	       docker network disconnect -f $networkid $containerid ; \
    	done
    docker network rm $networkid
done
