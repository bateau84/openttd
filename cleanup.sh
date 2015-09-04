#!/bin/bash
set -e
set -x

apt-get remove -y unzip wget
apt-get autoremove -y
apt-get autoclean -y

rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
rm -f /etc/ssh/ssh_host_*
