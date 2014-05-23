#aliases for docker
alias docker-add-zsh-completion="curl https://raw.github.com/felixr/docker-zsh-completion/master/_docker |sudo tee /usr/share/zsh/functions/Completion/Linux/_docker; source ~/.zshrc"
alias docker-remove-test-images="docker images |grep '<none>' |awk '{print \$3}' |xargs --no-run-if-empty -n 1 docker rmi"
docker-install() {
  sudo apt-get update
  sudo apt-get install linux-image-extra-\$(uname -r)
  curl http://get.docker.io/gpg | sudo apt-key add -
  echo deb https://get.docker.io/ubuntu docker main |sudo tee /etc/apt/sources.list.d/docker.list
  sudo apt-get update
  sudo apt-get install lxc-docker
}
alias docker-run="docker run"
alias docker-irun="docker run -it"
alias docker-last="docker ps -ql"
