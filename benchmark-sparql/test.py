import rdflib
from rdflib import Graph

# Initialize a graph
g = Graph()

# Parse the Turtle file
g.parse('data/books.ttl', format='ttl')

# Define the Fuseki server endpoint
fuseki_url = 'http://localhost:3030/ds/data'

# Upload the graph to the Fuseki server
g.serialize(destination=fuseki_url, format='ttl')
