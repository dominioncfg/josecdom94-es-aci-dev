# syntax=docker/dockerfile:1
FROM docker.elastic.co/elasticsearch/elasticsearch:7.9.2
Env discovery.type=single-node
CMD ["eswrapper"]

