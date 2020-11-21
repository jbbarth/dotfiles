#!/bin/bash
set -xeuo pipefail

# Update the index
brew update

# Taps
brew tap discoteq/discoteq # for "flock"
brew tap johanhaleby/kubetail # for "kubetail"
brew tap heroku/brew # for "heroku"

# Std brew packages
brew install ack \
  awscli \
  bash \
  bzr \
  colordiff \
  coreutils \
  crystal \
  crystal-icr \
  derailed/k9s/k9s \
  elixir \
  findutils \
  fd \
  flock \
  fping \
  fswatch \
  fzf \
  go \
  gnu-tar \
  heroku \
  hg \
  hub \
  gist \
  github/gh/gh \
  glances \
  gpg \
  graphviz \
  imagemagick \
  jdupes \
  jq \
  kubectl \
  kubetail \
  leiningen \
  lftp \
  libmagic \
  lua@5.1 \
  luarocks \
  moreutils \
  mysql \
  ncdu \
  nmap \
  nodejs \
  nvm \
  openssh \
  overmind \
  pcre \
  pinentry-mac \
  pstree \
  pwgen \
  pyenv \
  rbenv \
  rbenv-gemset \
  rename \
  selecta \
  s3cmd \
  teleport \
  telnet \
  tmux \
  tnftp \
  tree \
  unrar \
  watch \
  wget

###brew install openssl
###brew install optipng
###brew install redis
###brew install postgresql

# Install Cask
brew install homebrew/cask-cask

# Install Casks
brew cask install 1password
brew cask install adobe-air
brew cask install adobe-acrobat-reader
brew cask install alfred
brew cask install amazon-chime
brew cask install aws-vault
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
brew cask install redis
brew cask install rubymine
brew cask install skitch
brew cask install slack
brew cask install sketch
brew cask install sip
brew cask install sourcetree
brew cask install spectacle
brew cask install spotify
brew cask install textual
brew cask install textmate
brew cask install transmit
brew cask install tunnelblick
brew cask install virtualbox
brew cask install vagrant #after virtualbox
brew cask install visual-studio-code
brew cask install xquartz
brew cask install zoomus

# depend on xquartz
brew install mplayer

# post-install for some packages
$(brew --prefix)/opt/fzf/install
