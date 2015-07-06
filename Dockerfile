############################################################
# Dockerfile to build OpenTTD container images
# Based on debian:jessie
############################################################

# Set the base image to debian:jessie
FROM phusion/baseimage

# File Author / Maintainer
MAINTAINER Mats Bergmann <bateau@sea-shell.org>

# Update the repository sources list
ENV DEBIAN_FRONTEND noninteractive
ENV loadgame false
ENV savename autosave/exit.sav

WORKDIR /tmp/
ADD . /tmp/
RUN /tmp/prepare.sh && \
    /tmp/system_services.sh && \
    /tmp/cleanup.sh

# Expose the default ports
EXPOSE 3979/tcp
EXPOSE 3979/udp

CMD ["/sbin/my_init"]
