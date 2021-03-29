FROM debian:stretch-slim

MAINTAINER Ulrich Hoffmann <uho@xlerb.de>

# Make sure apt is up to date
RUN cat /etc/apt/sources.list
RUN \
   echo "deb http://http.debian.net/debian/ stretch main contrib non-free" > /etc/apt/sources.list && \
   echo "deb http://http.debian.net/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list && \
   echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list && \
   apt-get -y update && \
   apt-get -y upgrade

# Not essential, but wise to set the lang
RUN \
   apt-get -qq install locales && \
   echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
   echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
   echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
   locale-gen en_US.UTF-8

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# dosemu itself
RUN apt-get -y install dosemu

# use our config file
ADD dosemu.conf /etc/dosemu/dosemu.conf
ADD autoexec.bat /etc/dosemu/freedos/autoexec.bat
ADD config.sys /etc/dosemu/freedos/config.sys


# run as user dosemu
RUN useradd -ms /bin/bash dosemu
USER dosemu
WORKDIR /home/dosemu

ENTRYPOINT ["/usr/bin/dosemu"]

# run: docker run -t -i --rm -v $(pwd):/home/dosemu -v $(pwd)/cdrom:/media/cdrom dosemu args ...
