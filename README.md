# Motion on docker

Motion compiled for Raspberry pi : ARMHF

## RUN IN DOCKER SWARM CONTEXT

Git : https://github.com/Motion-Project/
Ref : https://motion-project.github.io/

## docker-compose.yml example

	version: '3'
	services:
	  motion:
		container_name: motion
		build: < Your path to Dokerfile >
		ports:
		  - 8080:8080
		  - 8082:8082
		  - 8083:8083
		  - 8084:8084
		  - 8085:8085
		  - < any port you need >
		volumes:
		  - < your configuration file >:/usr/local/etc/motion/

## Recommandation

In motion.conf do not start in demon mode for DOCKER !
