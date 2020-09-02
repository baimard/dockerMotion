FROM arm32v7/debian:buster-slim

LABEL version="4.2.2"
LABEL maintainer="baimard@41m4rd.ovh"
LABEL description="Motion is a highly configurable program that monitors video signals from many types of cameras."

RUN apt-get update && apt-get upgrade -y --no-install-recommends
RUN apt-get install -y mailutils msmtp msmtp-mta sendemail gdebi-core wget
RUN wget https://github.com/Motion-Project/motion/releases/download/release-4.2.2/pi_buster_motion_4.2.2-1_armhf.deb
RUN dpkg -i ./pi_buster_motion_4.2.2-1_armhf.deb
RUN apt install -f -y

CMD ["motion"]
