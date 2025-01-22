docker stop fuseki
docker rm fuseki

docker run -d \
  --name fuseki \
  -p 3030:3030 \
  -e ADMIN_PASSWORD=bench \
  stain/jena-fuseki
