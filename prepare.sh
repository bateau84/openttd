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
apt-get update -qq

## Install things we need
$minimal_apt_get_install dumb-init wget xz-utils unzip ca-certificates libfontconfig1 libfreetype6 libfluidsynth3 libicu-dev libpng16-16t64 liblzma-dev liblzo2-2 libsdl1.2debian libsdl2-2.0-0 # > /dev/null 2>&1

## Download and install openttd
wget -q -O openttd.tar.xz "${OPENTTD_DOWNLOAD_LINK}"
mkdir -p /usr/share/games/openttd
tar -xf openttd.tar.xz -C /usr/share/games/openttd --strip-components=1
rm openttd.tar.xz
test -x /usr/share/games/openttd/openttd || { echo "openttd binary missing after extract" >&2; exit 1; }

## Download GFX and install
mkdir -p /usr/share/games/openttd/baseset/
cd /usr/share/games/openttd/baseset/
wget -q -O opengfx-${OPENGFX_VERSION}.zip https://cdn.openttd.org/opengfx-releases/${OPENGFX_VERSION}/opengfx-${OPENGFX_VERSION}-all.zip

unzip opengfx-${OPENGFX_VERSION}.zip
tar -xf opengfx-${OPENGFX_VERSION}.tar
rm -rf opengfx-*.tar opengfx-*.zip

## Create user
# adduser --disabled-password --uid 1000 --shell /bin/bash --gecos "" openttd
# addgroup openttd users
useradd --uid 1001 --shell /bin/bash --comment "" --create-home --user-group openttd
usermod -a -G users openttd

## Set entrypoint script to right user
chmod +x /openttd.sh
