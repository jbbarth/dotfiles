#!/bin/bash

if [ "`whoami`" != "root" ]; then
  echo "This script should be run as root user!"
  exit 1
fi

apt-get update
apt-get upgrade -y
apt-get install -y wajig screen vim openssh-server bash-completion \
                   ruby1.8 ruby1.8-dev ri1.8 rake irb rubygems1.8 git-core \
                   libopenssl-ruby libsqlite3-ruby1.8 sqlite3 zsh vim
[ -e /usr/bin/ruby ] || ln -s `which ruby1.8` /usr/bin/ruby
[ -e /usr/bin/ri ] || ln -s `which ri1.8` /usr/bin/ri
[ -e /usr/bin/rdoc ] || ln -s `which rdoc1.8` /usr/bin/rdoc
[ -e /usr/bin/gem ] || ln -s `which gem1.8` /usr/bin/gem

echo "Desktop machine ? (y/n) "
read desktop
if [ "$desktop" == "y" ]; then
  apt-get install conky gstreamer0.10-ffmpeg gstreamer0.10-plugins-bad
fi

gem update
gem install rails rake ZenTest ruby-debug

#after that and other things (install/uninstall of insserv)
#my netbook doesn't restart... is it really safe ? ...
###sed -i 's/^CONCURRENCY=none/CONCURRENCY=shell/' /etc/init.d/rc

#disable multi consoles
for i in 2 3 4 5 6; do
  sed -i 's/^start on runlevel 2/#start on runlevel 2/g' /etc/event.d/tty$i
done