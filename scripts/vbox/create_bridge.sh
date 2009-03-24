#!/bin/bash

#See: http://samiux.wordpress.com/2008/07/30/bridging-virtualbox-162-on-ubuntu-8041/

if [ "$1" == "" ]; then
  echo "Usage: $0 <virtual_machine>"
  exit 1
fi

hello=$(grep hello /etc/network/interfaces |tr -d '\n\r')
if [ "$hello" != "bridge_hello 2" ]; then
  echo "auto eth0
iface eth0 inet manual

auto br0
iface br0 inet dhcp
bridge_ports eth0
bridge_fd 9
bridge_hello 2
bridge_maxage 12
bridge_stp off" >> /etc/network/interfaces

  echo "vbox0 `whoami` br0" >> /etc/vbox/interfaces

  /etc/init.d/networking restart

  echo "Don't forget to attach your host interface to 'vbox0' in your GUI panel"
fi

VBoxAddIF vbox0 `whoami` br0
VBoxManage modifyvm "$1" -hostifdev1 vbox0
usermod -a -G vboxusers `whoami`

echo "Host config ok !"
