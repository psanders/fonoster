#!/bin/bash

#This removes untagged images from Docker
docker rmi $(docker images | grep "^<none>" | awk '{print $3}')

#This removes intermediates images from docker cache
docker rmi $(docker images -f "dangling=true" -q)

#This removes stopped containers
docker rm -v $(docker ps -a -q -f status=exited)