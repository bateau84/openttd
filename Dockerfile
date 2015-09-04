############################################################
# Dockerfile to build OpenTTD container images
# Based on phusion:baseimage (from ubuntu)
############################################################

FROM phusion/baseimage

MAINTAINER Mats Bergmann <bateau@sea-shell.org>

WORKDIR /tmp/
ADD . /tmp/
RUN /tmp/prepare.sh && \
    /tmp/system_services.sh && \
    /tmp/cleanup.sh

VOLUME /home/openttd/.openttd

EXPOSE 3979/tcp
EXPOSE 3979/udp

CMD ["/sbin/my_init"]
