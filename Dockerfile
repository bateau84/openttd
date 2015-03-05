############################################################
# Dockerfile to build OpenTTD container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Mats Bergmann <bateau@sea-shell.org>

# Update the repository sources list
ENV DEBIAN_FRONTEND noninteractive
ENV loadgame false
ENV savename save/autosave/exit.sav

RUN apt-get update -qq
RUN apt-get install wget unzip libfontconfig1 libfreetype6 libicu52 liblzo2-2 libsdl1.2debian -y -qq
################## BEGIN INSTALLATION ######################

# Download openttd installer 
WORKDIR /tmp/
RUN wget -q http://binaries.openttd.org/releases/1.5.0-beta1/openttd-1.5.0-beta1-linux-ubuntu-trusty-amd64.deb 

# Install openttd 
RUN dpkg -i /tmp/openttd-1.5.0-beta1-linux-ubuntu-trusty-amd64.deb
RUN rm -rf /tmp/openttd-*.*

# Get GFX files
WORKDIR /usr/share/games/openttd/baseset/
RUN wget -q http://binaries.openttd.org/extra/opengfx/0.5.0/opengfx-0.5.0-all.zip
RUN unzip opengfx-0.5.0-all.zip

# Add files
ADD files/start.sh /root/

##################### INSTALLATION END #####################

# Expose the default port
EXPOSE 3979/tcp
EXPOSE 3979/udp

ENTRYPOINT ["/bin/sh"]
# Set default container command
CMD ["/root/start.sh"]
