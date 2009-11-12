#!/bin/bash

if [ "`whoami`" != "root" ]; then
  echo "This script should be run as root user!"
  exit 1
fi

apt-get update
apt-get upgrade -y
apt-get install -y wajig screen vim openssh-server bash-completion \
                   ruby1.8 ruby1.8-dev ri1.8 rake irb rubygems1.8 git-core \
                   libopenssl-ruby libsqlite3-ruby1.8 sqlite3 zsh vim make \
                   lynx subversion sysv-rc-conf wicd sysklogd libxslt
[ -e /usr/bin/ruby ] || ln -s `which ruby1.8` /usr/bin/ruby
[ -e /usr/bin/ri ] || ln -s `which ri1.8` /usr/bin/ri
[ -e /usr/bin/rdoc ] || ln -s `which rdoc1.8` /usr/bin/rdoc
[ -e /usr/bin/gem ] || ln -s `which gem1.8` /usr/bin/gem

echo "Desktop machine ? (y/n) "
read desktop
if [ "$desktop" == "y" ]; then
  apt-get install conky gstreamer0.10-ffmpeg gstreamer0.10-plugins-bad \
    msttcorefonts libgsf-bin imagemagick colordiff xchm mplayer mplayerthumbs
  #medibuntu (codecs)
  wget http://www.medibuntu.org/sources.list.d/`lsb_release -cs`.list \
    --output-document=/etc/apt/sources.list.d/medibuntu.list && apt-get \
    -q update && sudo apt-get --yes -q --allow-unauthenticated install \
    medibuntu-keyring && apt-get -q update
  apt-get install w32codecs
fi

echo "Home machine ? (y/n) "
read home
if [ "$home" == "y" ]; then
  if [ $(grep 80.10.246.2 /etc/dhcp3/dhclient.conf | wc -l | awk '{print $1}') == "0" ]; then
    echo "supersede domain-name-servers 80.10.246.2, 80.10.246.129;" >> /etc/dhcp3/dhclient.conf
    /etc/init.d/networking restart
  fi
  wajig install xfce4-terminal
  mkdir -p .config/Terminal
  grep "BindingBackspace" .config/Terminal/terminalrc 1>/dev/null 2>&1 || \
    echo "BindingBackspace=TERMINAL_ERASE_BINDING_ASCII_DELETE" >> .config/Terminal/terminalrc
  #disable touchpad when typing ; see: http://ghantoos.org/2009/04/07/disable-touchpad-while-typing-on-keyboard/
  echo "/usr/bin/syndaemon -i 1 -d -S" >> ~/.xsession
fi

echo "Git machine ? (y/n) "
read git
if [ "$git" == "y" ]; then
  git config --global user.name jbbarth
  git config --global user.email jeanbaptiste.barth@gmail.com
fi

gem update
gem install rails rake ZenTest ruby-debug wirble hpricot nokigiri webrat \
            rspec-rails rspec cucumber

#after that and other things (install/uninstall of insserv)
#my netbook doesn't restart... is it really safe ? ...
###sed -i 's/^CONCURRENCY=none/CONCURRENCY=shell/' /etc/init.d/rc

#disable multi consoles
for i in 2 3 4 5 6; do
  sed -i 's/^start on runlevel 2/#start on runlevel 2/g' /etc/event.d/tty$i
done
