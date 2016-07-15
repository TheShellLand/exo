#!/usr/bin/env bash

#
# Java download and install, Version 8 Update 91
#
mkdir -p /opt/java && \
cd /opt/java && \
wget -O java.tgz http://javadl.oracle.com/webapps/download/AutoDL?BundleId=207765 && \
tar -zxf java.tgz && \
rm -f /usr/local/bin/java && \
ln -s /opt/java/jre1.8.0_91/bin/java /usr/local/bin/java && \
java -version && \
echo "Done"


#
# Elasticsearch download and install, Elasticsearch 2.3.4
#
mkdir -p /opt/elasticsearch && \
cd /opt/elasticsearch && \
wget -O elasticsearch.tgz https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.4/elasticsearch-2.3.4.tar.gz && \
tar -zxf elasticsearch.tgz && \
rm -f /usr/local/bin/elasticsearch && \
ln -s /opt/elasticsearch/elasticsearch-5.0.0-alpha4/bin/elasticsearch /usr/local/bin/elasticsearch && \
echo "Done"


#
# Elasticsearch download and install, Elasticsearch 5.0.0-alpha4
#
mkdir -p /opt/elasticsearch && \
cd /opt/elasticsearch && \
wget -O elasticsearch.tgz https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/5.0.0-alpha4/elasticsearch-5.0.0-alpha4.tar.gz && \
tar -zxf elasticsearch.tgz && \
rm -f /usr/local/bin/elasticsearch && \
ln -s /opt/elasticsearch/elasticsearch-5.0.0-alpha4/bin/elasticsearch /usr/local/bin/elasticsearch && \
echo "Done"
