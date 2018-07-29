#!/bin/bash

# Update the index
brew update

# Taps
brew tap discoteq/discoteq # for "flock"
brew tap johanhaleby/kubetail # for "kubetail"

# Std brew packages
brew tap homebrew/dupes
brew install ack
brew install boot2docker
brew install bzr
brew install collectd
brew install colordiff
brew install coreutils
brew install docker
brew install findutils
brew install fdupes
brew install flock
brew install fping
brew install fswatch
brew install fzf
brew install ghostscript
brew install hg
brew install go
brew install gnu-tar
brew install hub
brew install gist
brew install graphviz
brew install imagemagick
brew install kubectl
brew install kubetail
brew install leiningen
brew install libmagic
brew install mplayer
brew install mysql
brew install nmap
brew install nodejs
brew install openssh
brew install parallel
brew install pcre
brew install phantomjs
brew install pstree
brew install pwgen
brew install qt4
brew install rename
brew install selecta
brew install telnet
brew install tmux
brew install tnftp
brew install tree
brew install unrar
brew install weechat
brew install watch
brew install wget

###brew install openssl
###brew install optipng
###brew install redis
###brew install postgresql

# Install Cask
brew install caskroom/cask/brew-cask

# Install Casks
brew cask install alfred
brew cask install anvil
brew cask install adobe-air
brew cask install adobe-reader
brew cask install atom
brew cask install caffeine
brew cask install dropbox
brew cask install gimp
brew cask install google-chrome
brew cask install inkscape
brew cask install iterm2
brew cask install istat-menus
brew cask install java
brew cask install minikube
brew cask install pencil
brew cask install pgadmin3
brew cask install postgres
brew cask install rdio
brew cask install spectacle
brew cask install sublime-text
brew cask install transmit
brew cask install virtualbox
brew cask install vagrant #after virtualbox
