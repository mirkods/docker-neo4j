Docker image for Neo4j Graph Database
=====

Neo4j is a highly scalable, robust (fully ACID) native graph database. Neo4j is used in mission-critical apps by thousands of leading, startups, enterprises, and governments around the world.

With the Dockerfile on repository you've a docker neo4j community edition image ready to go.

### Configuration
1. Clone the repo `git clone https://github.com/mirkods/docker-neo4j.git`
2. Substitute in the Dockerfile the `{{INSERT_HERE}}` tag with your username and password to create secure access on neo4j

### Setup
1. Build your Docker image
	`cd docker-neo4j && docker build -t neo4j .`

2. Create a data container
	`docker create -v /data --name neo4j_data ubuntu`

3. Execute this command:
	`docker run -d -i -p 7474:7474 --volumes-from neo4j_data --name neo4j neo4j`

4. Access to http://localhost:7474 with your browser.

### Start a stopped docker container
To retrieve the container id:
	`docker ps -a`

To start a stopped container:
	`docker start|stop <containerId>`

### Data container
You can also use a data container 

1. Create  data container
```
	docker run -d -v /var/lib/neo4j/data --name neo4j_data ubuntu echo Neo4j data
```

2. Create a neo4j container and attach the data container to itself
```
	docker run -d -i -p 7474:7474 --volumes-from neo4j_data --name neo4j neo4j
```

3.Backup from data contenier
```
	docker run --volumes-from neo4j_data -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /var/lib/neo4j/data/
```
