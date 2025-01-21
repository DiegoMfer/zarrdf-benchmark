docker build -t tpf-benchmark .


#!/bin/bash

# Folder where the .hdt files are located
HDT_FOLDER="./data"  # Modify this to your directory containing .hdt files

# Delete all .json files in the specified folder
rm -f "$HDT_FOLDER"/*.json

# Print a message indicating the files have been deleted
echo "All .json files in '$HDT_FOLDER' have been deleted."




# Loop over each .hdt file in the specified folder
for hdt_file in "$HDT_FOLDER"/*.hdt; do
  # Extract the dataset name (filename without extension)
  dataset_name=$(basename "$hdt_file" .hdt)

  # Generate the config file name in the same directory as the .hdt file
  config_file="$HDT_FOLDER/config-${dataset_name}.json"

  # Create the JSON config content
  cat <<EOF > "$config_file"
{
  "@context": "https://linkedsoftwaredependencies.org/bundles/npm/@ldf/server/^3.0.0/components/context.jsonld",
  "@id": "urn:ldf-server:my",
  "import": "preset-qpf:config-defaults.json",

  "datasources": [
    {
      "@id": "urn:ldf-server:myHdtDatasource",
      "@type": "HdtDatasource",
      "datasourceTitle": "My HDT file",
      "description": "My dataset with an HDT back-end",
      "datasourcePath": "myhdt",
      "hdtFile": "$dataset_name.hdt"
    }
  ]
}
EOF

  # Print a message indicating the config file has been created
  echo "Config file created: $config_file"
done
