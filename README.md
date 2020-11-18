## motion-docker on Raspberry
This project is just a build for armhf (arm32v7) architecture, this is not a FORK !

## Work with
* docker
* docker-compose
* docker swarm

## Caveats
If you use /dev/video, locally attached cameras or the database features of Motion, this container won't work for you at this stage.
This is built directly from git master, if you want something more stable grab a prebuilt release from here and install manually.

## How to run

something like this;

```
docker run -d --name=motion \
    -p 7999:7999 \
    -p 8081:8081 \
    -p 8082:8082 \
    -p 8083:8083 \
    -p 8084:8084 \
    -p 8085:8085 \
    -p 8087:8087 \
    -e TZ="Australia/Brisbane" \
    -v /volume1/motion/config:/usr/local/etc/motion \
    -v /volume1/motion/storage:/var/lib/motion \
    --restart=always \
    motionproject/motion:latest
```

## What's different in this image ?

You can send email in this version : 

### docker-compose.yml

```
  version: '3'
  services:
    motion:
      image: juxo/motion-raspbian:4.3.2-1
      environment:
        - TZ=Europe/Paris
      ports:
        - 8081:8081
        - 8084:8084
        - 8085:8085
      volumes:
        - ./data/config:/etc/motion
        - ./data/images/cam/:/tmp/motion/cam/
        - ./data/msmtp/msmtprc:/etc/msmtprc
```

### Configure msmtprc

```
# Valeurs par défaut pour tous les comptes.
defaults
auth           on
tls            on
tls_starttls   on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        /var/log/msmtp.log

# Exemple pour un compte Gmail
account        mailu
auth           plain
host           mail.server
port           587
from           mailform
user           user
password       yourpass
```

### Script for use 

yourscriptname.sh
```
!/bin/bash
sleep 30

sendemail $(ls /tmp/motion/cam1/*.jpg | while read x; do echo "-a $x"; done) -S /usr/sbin/sendmail -f yourfrommail -u "Intrusion detected" -t yourfrommail -m "Intrusion detected"

sleep 360

rm -r /tmp/motion/cam1/*.jpg
rm -r /tmp/motion/cam1/*.mkv

# Définir le compte par défaut
account default : mailu
```

*Use this script in the motion conf : on_event_end /etc/motion/yourscriptname*

## How to Update
docker stop motion
docker rm motion
docker pull motionproject/motion:latest
- rerun above 'run' command

## Things you may need to change

name = a label for the container, should be motion or motion-project (but can be anything)
ports = each -p line denotes 1 camera and its stream port
TZ = the timezone the container will be running
volumes = /dockerserver/path/to/config = /dockerserver/path/to/storage