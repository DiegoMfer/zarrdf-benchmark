#!/bin/bash

if [ $# -lt 3 ]; then
  echo "Usage: $0 <query> <file_name> <repeat_count>"
  exit 1
fi

QUERY=$1
FILE_NAME=$2
REPEAT_COUNT=$3

# Create or empty the results file
RESULTS_FILE="results.txt"
> "$RESULTS_FILE"

for i in $(seq 1 $REPEAT_COUNT)
do
  # Run the docker command and capture the output, removing the newline character
  RESULT=$(docker run -it --rm -v "$(pwd)/data":/data rfdhdt/hdt-cpp hdtSearch /data/"$FILE_NAME" -q "$QUERY" | tail -n 1 | awk '{$1=$1;print}')

  # Save the result in the desired format
  echo "query=\"$QUERY\", dataset=\"$FILE_NAME\", result=\"$RESULT\"" >> "$RESULTS_FILE"
done

echo "Results saved to $RESULTS_FILE"
