#!/bin/bash
set -e
source /tmp/buildconfig
source /etc/os-release
set -x

## Temporarily disable dpkg fsync to make building faster.
if [[ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]]; then
	echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup
fi

## Enable Ubuntu Universe and Multiverse.
apt-get update
apt-get dist-upgrade -y -qq

## Install things we need
$minimal_apt_get_install wget unzip libfontconfig1 libfreetype6 libicu55 liblzo2-2 libpng12-0 libsdl1.2debian

## Create user
mkdir -p /home/openttd/.openttd
useradd -M -d /home/openttd -u 911 -U -s /bin/false openttd
usermod -G users openttd
chown openttd:openttd /home/openttd -R

## Download and install openttd
wget -q https://proxy.binaries.openttd.org/openttd-releases/${OPENTTD_VERSION}/openttd-${OPENTTD_VERSION}-linux-${ID}-${UBUNTU_CODENAME}-amd64.deb
dpkg -i openttd-${OPENTTD_VERSION}-linux-${ID}-${UBUNTU_CODENAME}-amd64.deb
mkdir -p /etc/service/openttd/

## Download GFX and install
mkdir -p /usr/share/games/openttd/baseset/
cd /usr/share/games/openttd/baseset/
wget -q http://bundles.openttdcoop.org/opengfx/releases/${OPENGFX_VERSION}/opengfx-${OPENGFX_VERSION}.zip
unzip opengfx-${OPENGFX_VERSION}.zip
tar -xf opengfx-${OPENGFX_VERSION}.tar
rm -rf opengfx-*.tar opengfx-*.zip
