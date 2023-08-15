#!/bin/bash
set -e
source /tmp/buildconfig
source /etc/os-release
set -x

## Temporarily disable dpkg fsync to make building faster.
if [[ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]]; then
	echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup
fi

echo "deb http://security.ubuntu.com/ubuntu jammy-security main" >> /etc/apt/sources.list

## Update pkg repos
apt update -qq

## Install things we need
$minimal_apt_get_install dumb-init wget xz-utils unzip ca-certificates libfontconfig1 libfreetype6 libfluidsynth3 libicu-dev libpng16-16 liblzma-dev liblzo2-2 libsdl1.2debian libsdl2-2.0-0 > /dev/null 2>&1

## Download and install openttd
wget -q https://cdn.openttd.org/openttd-releases/${OPENTTD_VERSION}/openttd-${OPENTTD_VERSION}-linux-generic-amd64.tar.xz
tar -xf openttd-${OPENTTD_VERSION}-linux-generic-amd64.tar.xz
mkdir -p /usr/share/games/
mv openttd-${OPENTTD_VERSION}-linux-generic-amd64 /usr/share/games/openttd
rm openttd-${OPENTTD_VERSION}-linux-generic-amd64.tar.xz

## Download GFX and install
mkdir -p /usr/share/games/openttd/baseset/
cd /usr/share/games/openttd/baseset/
wget -q -O opengfx-${OPENGFX_VERSION}.zip https://cdn.openttd.org/opengfx-releases/${OPENGFX_VERSION}/opengfx-${OPENGFX_VERSION}-all.zip

unzip opengfx-${OPENGFX_VERSION}.zip
tar -xf opengfx-${OPENGFX_VERSION}.tar
rm -rf opengfx-*.tar opengfx-*.zip

## Create user
adduser --disabled-password --uid 1000 --shell /bin/bash --gecos "" openttd
addgroup openttd users

## Set entrypoint script to right user
chmod +x /openttd.sh
