#!/bin/sh
docker run --privileged -v $1:$2 -d -P --name $3 $4
docker port $3 22
