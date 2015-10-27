#!/bin/bash
set -e
source /tmp/buildconfig
set -x

## copy startupscript
cp /tmp/init/10_useradd.sh /etc/my_init.d/10_useradd.sh
chmod +x /etc/my_init.d/10_useradd.sh

## copy openttd start and stop files
mkdir -p /etc/service/openttd/control
cp /tmp/runit/start.sh /etc/service/openttd/run
cp /tmp/runit/control/* /etc/service/openttd/control/
