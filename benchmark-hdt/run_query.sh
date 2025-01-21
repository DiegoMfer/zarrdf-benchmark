#!/bin/bash

if [ $# -lt 3 ]; then
  echo "Usage: $0 <query> <file_name> <repeat_count>"
  exit 1
fi

QUERY=$1
FILE_NAME=$2

REPEAT_COUNT=$3

for i in $(seq 1 $REPEAT_COUNT)
do
  docker run -it --rm -v "$(pwd)/data":/data rfdhdt/hdt-cpp hdtSearch /data/"$FILE_NAME" -q "$QUERY"
done
