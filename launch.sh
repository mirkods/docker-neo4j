#!/bin/bash
killall neo4j
NEO4J_HOME=/var/lib/neo4j
IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')

sed -i "s|#org.neo4j.server.webserver.address|org.neo4j.server.webserver.address|g" $NEO4J_HOME/conf/neo4j-server.properties
sed -i -r 's/(\b[0-9]{1,3}\.){3}[0-9]{1,3}\b'/$IPADDR/ $NEO4J_HOME/conf/neo4j-server.properties

ulimit -n 65536 ; .$NEO4J_HOME/bin/neo4j console