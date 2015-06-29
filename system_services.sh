#!/bin/bash
set -e
source /tmp/buildconfig
set -x

## copy openttd start and stop files
mkdir -p /etc/service/openttd
cp /tmp/runit/start.sh /etc/service/openttd/run
