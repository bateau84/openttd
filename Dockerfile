############################################################
# Dockerfile to build OpenTTD container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Bateau

# Update the repository sources list
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install wget libfontconfig1 libfreetype6 libicu52 liblzo2-2 libsdl1.2debian -yq
################## BEGIN INSTALLATION ######################

# Download openttd installer 
WORKDIR /tmp/
RUN wget -q http://binaries.openttd.org/releases/1.4.4/openttd-1.4.4-linux-ubuntu-trusty-amd64.deb 

# Install openttd 
RUN dpkg -i /tmp/openttd-1.4.4-linux-ubuntu-trusty-amd64.deb
RUN rm -rf /tmp/openttd-*.*

# Add files
ADD files/start.sh /home/openttd/
ADD files/pre_dedicated.scr /usr/share/games/openttd/scripts/

RUN chmod +x /home/openttd/start.sh

#create user
RUN useradd -U -c openttd -d /home/openttd openttd
RUN mkdir /home/openttd/.openttd
RUN chown openttd:openttd /home/openttd -R

USER openttd
WORKDIR /home/openttd/.openttd/
##################### INSTALLATION END #####################

# Expose the default port
EXPOSE 3979

# Set default container command
CMD ["/bin/sh", "../start.sh"]
