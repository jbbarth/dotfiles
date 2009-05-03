#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get install -y wajig screen vim openssh-server bash-completion \
                   ruby1.8 ruby1.8-dev ri1.8 irb rubygems git-core \
                   libopenssl-ruby libsqlite3-ruby1.8
gem update
gem install rails rake ZenTest ruby-debug

#after that and other things (install/uninstall of insserv)
#my netbook doesn't restart... is it really safe ? ...
sed -i 's/^CONCURRENCY=none/CONCURRENCY=shell/' /etc/init.d/rc
