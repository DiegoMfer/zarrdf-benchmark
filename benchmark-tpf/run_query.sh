#!/bin/bash

if [ $# -lt 3 ]; then
  echo "Usage: $0 <query> <config_json> <repeat_count>"
  exit 1
fi

query=$1
config_json=$2
repeat_count=$3

# Define dataset type (e.g., "json")
dataset="config_json"

# Stop and remove any existing benchmark_server container
docker stop benchmark_server
docker rm benchmark_server

# Start a new Docker container for benchmarking
docker run -d --name benchmark_server -v "$(pwd)/data:/app" -p 5000:5000 tpf-benchmark sh -c "ldf-server $config_json 5000 4"

# Allow time for the server to start
sleep 5

# Create a results file to store the output
output_file="tpf-benchmark_results.txt"

# Run the benchmark and capture the results
for i in $(seq 1 $repeat_count)
do
  # Capture the time command output
  result=$(time (comunica-sparql http://localhost:5000/myhdt "$query") 2>&1)

  # Extract real time from the result
  real_time=$(echo "$result" | grep real | awk '{print $2}')

  # Append the result in the desired format to the output file
  echo "query=\"$query\", dataset=\"$dataset\", result=\"$real_time\"" >> "$output_file"
done

# Stop and remove the Docker container after benchmarking
docker stop benchmark_server
docker rm benchmark_server

echo "Benchmark results saved to $output_file"
