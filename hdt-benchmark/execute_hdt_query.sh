#!/bin/bash

FILE_NAME=$1
QUERY=$2

docker run -it --rm -v "$(pwd)":/data rfdhdt/hdt-cpp hdtSearch /data/"$FILE_NAME" -q "$QUERY"
