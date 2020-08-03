FROM debian:buster-slim

LABEL version="4.3.1"
LABEL maintainer="baimard@41m4rd.ovh"
LABEL description="Motion is a highly configurable program that monitors video signals from many types of cameras."

RUN apt-get update && apt-get upgrade -y --no-install-recommends
RUN apt-get install -y mailutils msmtp msmtp-mta sendemail gdebi-core wget
RUN wget https://github.com/Motion-Project/motion/releases/download/release-4.3.1/buster_motion_4.3.1-1_armhf.deb
RUN apt install -y ./buster_motion_4.3.1-1_armhf.deb
RUN apt install -f -y

CMD ["motion"]
