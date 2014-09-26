FROM dockerfile/java
MAINTAINER Mirko Di Serafino "mirko.diserafino@gmail.com"

RUN wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add - 
RUN echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
RUN apt-get -q update && apt-get install neo4j=2.1.2 -y -q

ADD launch.sh /
ADD authentication-extension-2.1.2.jar /var/lib/neo4j/plugins/
ADD neo4j-server.properties /var/lib/neo4j/conf/

ENV $USERNAME INSERT_HERE
ENV $PASSWORD INSERT_HERE

RUN chmod +x /launch.sh

## clean sources
RUN apt-get clean

## turn on indexing: http://chrislarson.me/blog/install-neo4j-graph-database-ubuntu
## enable neo4j indexing, and set indexable keys to name,age
RUN sed -i "s|#node_auto_indexing|node_auto_indexing|g" /var/lib/neo4j/conf/neo4j.properties
RUN sed -i "s|#node_keys_indexable|node_keys_indexable|g" /var/lib/neo4j/conf/neo4j.properties

workdir /

EXPOSE 7474

## entrypoint
CMD ["/bin/bash", "-c", "/launch.sh"]
