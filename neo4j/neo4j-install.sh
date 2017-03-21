#!/bin/bash

# Install Neo4j from repository

wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.org/repo stable/' | sudo tee /etc/apt/sources.list.d/neo4j.list
apt-get update
apt-get install -y neo4j

ip r

echo "Modify /etc/neo4j/neo4j.conf"
