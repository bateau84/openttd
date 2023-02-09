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
$minimal_apt_get_install dumb-init wget unzip ca-certificates libfontconfig1 libfreetype6 libfluidsynth3 libicu-dev libpng16-16 liblzma-dev liblzo2-2 libsdl1.2debian libsdl2-2.0-0 xz-utils > /dev/null 2>&1

## Create user
adduser --disabled-password --uid 1000 --shell /bin/bash --gecos "" openttd
addgroup openttd users

#Install OpenTTD (Make better`er in future)
mkdir -p /home/openttd/gamefiles
wget "https://cdn.openttd.org/openttd-releases/13.0/openttd-13.0-linux-generic-amd64.tar.xz" -P /home/openttd/
tar -xvf /home/openttd/openttd-13.0-linux-generic-amd64.tar.xz --directory /home/openttd/gamefiles/

#Install GFX
mkdir -p /home/openttd/gamefiles/baseset
wget -q -O opengfx-${OPENGFX_VERSION}.zip https://cdn.openttd.org/opengfx-releases/${OPENGFX_VERSION}/opengfx-${OPENGFX_VERSION}-all.zip
unzip opengfx-${OPENGFX_VERSION}.zip -d /home/openttd/gamefiles/baseset/

## Set entrypoint script to right user
chmod +x /openttd.sh
