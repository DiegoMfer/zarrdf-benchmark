#!/bin/bash

# Ensure that CONFIG_FILE and QUERY_FILE are passed as arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <CONFIG_FILE> <QUERY>"
  exit 1
fi

# Set configuration and query file variables
CONFIG_FILE=$1
QUERY=$2

# Run the Docker container with the provided config and query files
docker run -it --rm -v "$(pwd)/config:/app/config" -v "$(pwd)/data:/app/data" tpf-benchmark sh -c \
  "ldf-server /app/config/$CONFIG_FILE 5000 4 && time comunica-sparql http://localhost:5000/myhdt $QUERY"

