# Motion on docker
Motion compiled for raspberry pi 3

Original project : https://github.com/Motion-Project/

# Docker compose

	version: '2'
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

# Recommandation

In motion.conf do not start in demon mode for DOCKER !
