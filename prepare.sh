#!/bin/bash
set -e
source /tmp/buildconfig
source /etc/os-release
set -x

## Temporarily disable dpkg fsync to make building faster.
if [[ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]]; then
	echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup
fi

echo "deb http://security.ubuntu.com/ubuntu xenial-security main" >> /etc/apt/sources.list

## Update pkg repos
apt-get update

## Install things we need
$minimal_apt_get_install wget unzip ca-certificates libfontconfig1 libfreetype6 libicu-dev libpng12-0 liblzma-dev liblzo2-2 libsdl1.2debian

### Install dumb-init
wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64
chmod +x /usr/local/bin/dumb-init

## Download and install openttd
wget -q https://proxy.binaries.openttd.org/openttd-releases/${OPENTTD_VERSION}/openttd-${OPENTTD_VERSION}-linux-${ID}-${UBUNTU_CODENAME}-amd64.deb
dpkg -i openttd-${OPENTTD_VERSION}-linux-${ID}-${UBUNTU_CODENAME}-amd64.deb

## Download GFX and install
mkdir -p /usr/share/games/openttd/baseset/
cd /usr/share/games/openttd/baseset/
wget -q http://bundles.openttdcoop.org/opengfx/releases/${OPENGFX_VERSION}/opengfx-${OPENGFX_VERSION}.zip
unzip opengfx-${OPENGFX_VERSION}.zip
tar -xf opengfx-${OPENGFX_VERSION}.tar
rm -rf opengfx-*.tar opengfx-*.zip
