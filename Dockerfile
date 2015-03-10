############################################################
# Dockerfile to build OpenTTD container images
# Based on debian:jessie
############################################################

# Set the base image to debian:jessie
FROM debian:jessie

# File Author / Maintainer
MAINTAINER Mats Bergmann <bateau@sea-shell.org>

# Update the repository sources list
ENV DEBIAN_FRONTEND noninteractive
ENV loadgame false
ENV savename save/autosave/exit.sav

RUN apt-get update -qq && apt-get install wget unzip libfontconfig1 libfreetype6 libicu52 liblzo2-2 libsdl1.2debian -y -qq

# Download and install openttd
WORKDIR /tmp/
RUN wget -q http://binaries.openttd.org/releases/1.5.0-beta1/openttd-1.5.0-beta1-linux-ubuntu-trusty-amd64.deb && dpkg -i /tmp/openttd-1.5.0-beta1-linux-ubuntu-trusty-amd64.deb

# Get GFX and unzip the files
WORKDIR /usr/share/games/openttd/baseset/
RUN wget -q http://binaries.openttd.org/extra/opengfx/0.5.0/opengfx-0.5.0-all.zip && unzip opengfx-0.5.0-all.zip && rm opengfx-0.5.0-all.zip && tar -xf opengfx-0.5.0.tar

# Add startup file and cleanup file
ADD files/start.sh /root/
ADD files/cleanup.sh /root/

#Clean up the mess
RUN /root/cleanup.sh

# Expose the default ports
EXPOSE 3979/tcp
EXPOSE 3979/udp

ENTRYPOINT ["/bin/sh"]
CMD ["/root/start.sh"]
