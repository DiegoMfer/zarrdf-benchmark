#!/bin/bash

if [ $# -lt 3 ]; then
  echo "Usage: $0 <query> <config_json> <repeat_count>"
  exit 1
fi

query=$1
config_json=$2
repeat_count=$3

docker stop benchmark_server
docker rm benchmark_server

docker run -d --name benchmark_server -v "$(pwd)/data:/app" -p 5000:5000 tpf-benchmark sh -c "ldf-server $config_json 5000 4"

sleep 5

for i in $(seq 1 $repeat_count)
do
  time comunica-sparql http://localhost:5000/myhdt "$query"
done

docker stop benchmark_server
docker rm benchmark_server
