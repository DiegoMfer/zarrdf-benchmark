#!/bin/bash

# Query to run for all .hdt files
QUERY="? ? ?"

# Output file to save results
RESULT_FILE="query_results.txt"

# Clear the results file if it exists
> "$RESULT_FILE"

# Iterate over all .hdt files in the `data/` directory
for FILE in data/*.hdt; do
  # Check if the file exists (in case no .hdt files are found)
  if [[ -f "$FILE" ]]; then
    echo "Processing $FILE with query '$QUERY' in the background..."
    
    # Run the command and save the last line of the output
    ./execute_hdt_query.sh "$FILE" "$QUERY" | tail -n 1 >> "$RESULT_FILE" &
  else
    echo "No .hdt files found in the data/ directory."
    exit 1
  fi
done

# Wait for all background processes to complete
wait
echo "All background processes have finished. Results saved to $RESULT_FILE."
