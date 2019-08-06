#!/bin/bash
set -xeuo pipefail

# Update the index
brew update

# Taps
brew tap discoteq/discoteq # for "flock"
brew tap johanhaleby/kubetail # for "kubetail"

# Std brew packages
brew install ack
brew install bzr
brew install colordiff
brew install coreutils
brew install crystal
brew install crystal-icr
brew install elixir
brew install findutils
brew install fd
brew install fdupes
brew install flock
brew install fping
brew install fswatch
brew install fzf
brew install hg
brew install go
brew install gnu-tar
brew install hub
brew install gist
brew install glances
brew install gpg
brew install graphviz
brew install imagemagick
brew install jq
brew install kubectl
brew install kubetail
brew install leiningen
brew install lftp
brew install libmagic
brew install lua@5.1
brew install luarocks
brew install mplayer
brew install mysql
brew install ncdu
brew install nmap
brew install nodejs
brew install nvm
brew install openssh
brew install overmind
brew install parallel
brew install pcre
brew install pstree
brew install pwgen
brew install pyenv
brew install rename
brew install selecta
brew install s3cmd
brew install telnet
brew install tmux
brew install tnftp
brew install tree
brew install unrar
brew install watch
brew install wget

###brew install openssl
###brew install optipng
###brew install redis
###brew install postgresql

# Install Cask
brew install caskroom/cask/brew-cask

# Install Casks
brew cask install 1password
brew cask install adobe-air
brew cask install adobe-acrobat-reader
brew cask install alfred
brew cask install amazon-chime
brew cask install basecamp
brew cask install contexts
brew cask install dash
brew cask install docker
brew cask install dropbox
brew cask install firefox
brew cask install gimp
brew cask install goland
brew cask install google-chrome
brew cask install google-cloud-sdk
brew cask install google-drive-file-stream
brew cask install hma-pro-vpn
brew cask install iterm2
brew cask install istat-menus
brew cask install little-snitch
brew cask install java
brew cask install minikube
brew cask install mplayerx
brew cask install pencil
brew cask install pgadmin4
brew cask install postgres
brew cask install postman
brew cask install pycharm
brew cask install redis-app
brew cask install rubymine
brew cask install skitch
# the standard "Slack.app" is too slow/memory hog
brew cask install homebrew/cask-versions/slack-beta
brew cask install sketch
brew cask install sip
brew cask install sourcetree
brew cask install spectacle
brew cask install spotify
brew cask install transmit
brew cask install virtualbox
brew cask install vagrant #after virtualbox
brew cask install visual-studio-code
brew cask install zoomus

# post-install for some packages
$(brew --prefix)/opt/fzf/install

