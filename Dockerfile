LABEL version="4.3.1"
LABEL maintainer="baimard@41m4rd.ovh"
LABEL description="Motion is a highly configurable program that monitors video signals from many types of cameras. https://motion-project.github.io/index.html"

FROM debian

RUN apt-get update && apt-get upgrade -y --no-install-recommends
RUN apt-get install -y autoconf automake autopoint build-essential pkgconf libtool libzip-dev libjpeg-dev git libavformat-dev libavcodec-dev libavutil-dev libswscale-dev libavdevice-dev libwebp-dev gettext libmicrohttpd-dev
RUN apt-get install -y mailutils msmtp msmtp-mta sendemail
RUN git clone https://github.com/Motion-Project/motion.git
RUN cd motion 
RUN autoreconf -fiv
RUN ./configure 
RUN make 
RUN make install
CMD ["motion"]
