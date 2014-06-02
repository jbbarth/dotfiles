docker-cleanup() {
  echo "* Removing old containers"
  docker ps -qa | xargs --no-run-if-empty -n 1 docker rm
  echo "* Removing test (untagged) images"
  docker images |grep '<none>' |awk '{print $3}' | xargs --no-run-if-empty -n 1 docker rmi
  #TODO: replace with: docker rmi $(docker images -q) ? ; not sure it won't delete more images
}
docker-install() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "* Installign docker through Homebrew"
    brew install docker
    echo "* Installing dockviz (darwin)"
    curl -L http://gobuild.io/github.com/justone/dockviz/master/darwin/amd64 -o /tmp/dockviz.zip
    cd ~/bin
    unzip /tmp/dockviz.zip dockviz
    rm /tmp/dockviz.zip
  else
    echo "* Installign docker through APT packages"
    sudo apt-get update
    sudo apt-get install linux-image-extra-\$(uname -r)
    curl http://get.docker.io/gpg | sudo apt-key add -
    echo deb https://get.docker.io/ubuntu docker main |sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get update
    sudo apt-get install lxc-docker
    echo "* Installing dockviz (darwin)"
    curl -L http://gobuild.io/github.com/justone/dockviz/master/linux/amd64 -o /tmp/dockviz.zip
    cd ~/bin
    unzip /tmp/dockviz.zip dockviz
    rm /tmp/dockviz.zip
  fi
}
docker-run() { docker run $* }
docker-irun() { docker run -it $* }
docker-last() { docker ps -ql $* }
docker-images-tree() { curl -s ${DOCKER_HOST/tcp/http}/images/json?all=1 | dockviz images --tree }
docker-images-viz() { curl -s ${DOCKER_HOST/tcp/http}/images/json?all=1 | dockviz images --dot | dot -Tpng -o /tmp/docker-tree.png; open /tmp/docker-tree.png }
docker-ipaddress() { docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1 }
