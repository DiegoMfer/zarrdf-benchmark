docker run --rm -v "$(pwd)/data/1-lubm.ttl":/tmp/file.ttl --volumes-from fuseki stain/jena-fuseki
docker run -d -p 3030:3030 --name fuseki -v /path/to/your/data:/data stain/jena-fuseki
