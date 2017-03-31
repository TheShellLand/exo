#!/bin/bash

# Install Neo4j from repository

max_java_mem="512m"

wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.org/repo stable/' | sudo tee /etc/apt/sources.list.d/neo4j.list
apt-get update
apt-get install -y neo4j

ip r

echo "dbms.connectors.default_listen_address=0.0.0.0"  >> /etc/neo4j/neo4j.conf
echo "dbms.memory.heap.max_size="$max_java_mem"" >> /etc/neo4j/neo4j.conf

service neo4j restart

watch "netstat -ant | grep LISTEN"
