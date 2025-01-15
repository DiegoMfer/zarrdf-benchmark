#!/bin/bash

# Set the source and destination directories as variables
source_dir="./data"  # Change this to your source directory
dest_dir="./hdt-benchmark/data"  # Change this to your destination directory

# Check if the source directory exists
if [ ! -d "$source_dir" ]; then
  echo "Source directory does not exist. Exiting."
  exit 1
fi

# Create the destination directory if it doesn't exist
mkdir -p "$dest_dir"

# Compress all .ttl files from the source directory and save them to the destination directory
find "$source_dir" -type f -name "*.ttl" -exec sh -c '
  for file; do
    # Get the base filename and the new destination path
    base_name=$(basename "$file")
    dest_path="$1/$base_name.gz"
    
    # Compress the file and save it to the destination
    gzip -c "$file" > "$dest_path"
  done
' sh "$dest_dir" {} +

rm "$dest_dir"/data.gz

# Process each .ttl.gz file in the destination directory using Docker
for FILE in "$dest_dir"/*.ttl.gz; do
  if [[ -f "$FILE" ]]; then
    # Extract the filename without extension for the output
    OUTPUT_FILE="${FILE%.ttl.gz}.hdt"

    echo "Processing $FILE..."

    # Run the Docker command
    docker run -it --rm --name hdt \
      -v "$dest_dir":/data \
      aammar/hdt-java rdf2hdt.sh "/data/$(basename "$FILE")" "/data/$(basename "$OUTPUT_FILE")"

    echo "Finished processing $FILE. Output: $OUTPUT_FILE"
  else
    echo "No .ttl.gz files found in $dest_dir"
  fi
done

rm "$dest_dir"/*.gz

echo "All files processed."
