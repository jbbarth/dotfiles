#!/bin/bash

if [ `whoami` != "root" ]; then
  echo "This script must be run as root user !"
  echo "you can use : sudo !!"
  exit 1
fi

wajig install bridge-utils iproute xen-tools xen-linux-system-2.6.26-1-xen-686
