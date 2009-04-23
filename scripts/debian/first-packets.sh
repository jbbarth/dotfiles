#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get install -y wajig screen vim openssh-server bash-completion \
                   ruby1.8 ruby1.8-dev ri1.8 irb rubygems \
                   libopenssl-ruby libsqlite3-ruby1.8
gem update
gem install rails rake ZenTest ruby-debug
