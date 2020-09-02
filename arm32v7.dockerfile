FROM debian AS builder

# Download QEMU, see https://github.com/docker/hub-feedback/issues/1261
ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-arm.tar.gz
RUN apt update
RUN apt install curl -y && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

FROM arm32v7/debian:buster-slim

LABEL version="4.2.2"
LABEL maintainer="baimard@41m4rd.ovh"
LABEL description="Motion is a highly configurable program that monitors video signals from many types of cameras."

COPY --from=builder qemu-arm-static /usr/bin
RUN apt-get update && apt-get upgrade -y --no-install-recommends
RUN apt-get install -y mailutils msmtp msmtp-mta sendemail gdebi-core wget
RUN wget https://github.com/Motion-Project/motion/releases/download/release-4.2.2/pi_buster_motion_4.2.2-1_armhf.deb
RUN dpkg -i ./pi_buster_motion_4.2.2-1_armhf.deb
RUN apt install -f -y

CMD ["motion"]
