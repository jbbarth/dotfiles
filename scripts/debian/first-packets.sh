#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get install -y wajig screen vim openssh-server bash-completion \
                   ruby1.8 ruby1.8-dev ri1.8 irb rake rubygems libopenssl-ruby
gem update
gem install rails ZenTest
