./convert_ttl_to_hdt.sh
./prepare_files.sh


# First benchmark
cd benchmark-hdt

./run_query.sh '? ? ?' 1-lubm.hdt 5

cd ..

# Second benchmark
cd benchmark-tpf
./build_and_prepare.sh # Creates a new config for each dataset, that is how you tell the Triple pattern fragment where to find the hdt file

./run_query.sh 'SELECT * WHERE { ?s ?p ?o }' config-1-lubm.json 5

cd ..