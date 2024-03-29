docker-cleanup() {
  echo "* Running docker prun system --volumes"
  docker prune system --volumes --force
  return
  # previous version in case it's useful
  echo "* Removing old containers"
  docker ps -qa | xargs --no-run-if-empty -n 1 docker rm
  echo "* Removing test (untagged) images"
  docker images |grep '<none>' |awk '{print $3}' | xargs --no-run-if-empty -n 1 docker rmi
  #TODO: replace with: docker rmi $(docker images -q) ? ; not sure it won't delete more images
  echo "* Removing dangling volumes"
  docker volume rm $(docker volume ls -qf dangling=true)
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
docker-last() { docker ps -q|head -n 1 }
docker-last-image() { docker images -q|head -n 1 }
docker-images-tree() { curl -s ${DOCKER_HOST/tcp/http}/images/json?all=1 | dockviz images --tree }
docker-images-viz() { curl -s ${DOCKER_HOST/tcp/http}/images/json?all=1 | dockviz images --dot | dot -Tpng -o /tmp/docker-tree.png; open /tmp/docker-tree.png }
docker-images-shortlist() { docker images | tail -n +2 | awk '{print $1}' | sort -u }
docker-ipaddress() { docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1 }
docker-pgrep() { docker ps | awk "\$2 ~ /$1/" | awk '{print $1}' }
docker-enter() {
  container="$1"
  [ -z "$container" ] && container=$(docker ps -q -n 1)
  if which dvm >/dev/null; then
    dvm ssh -- -q -t "
      which nsenter >/dev/null || docker run -v /usr/local/bin:/target jpetazzo/nsenter;
      sudo docker-enter $container /bin/bash
    "
  else
    echo "not implemented" >&2
  fi
}

docker-create-repo() {
  name=${1/docker-}
  [ "$name" = "" ] && echo "Missing repo name!" >&2 && return
  username=$(git config --get github.user)
  [ "$username" = "" ] && echo "Missing username!" >&2 && return
  echo "* Creating local directory ~/Projects/docker-$name"
  mkdir ~/Projects/docker-$name
  cd ~/Projects/docker-$name
  git init
  git remote add origin git@github.com:$username/docker-$name
  echo "* Creating the github.com repo $username/docker-$name"
  curl https://api.github.com/user/repos \
       -u "$username" \
       -w "%{http_code} %{url_effective}\n" \
       -d "{
           \"name\": \"docker-$name\",
           \"description\": \"Docker repository for $username/$name\"
          }"
  echo "* Creating the hub.docker.com repo $username/$name"
  echo "ERROR: you need to do this manually until the Hub has a complete/official API"
###  curl https://hub.docker.com/v1/repositories/$username/$name \
###       -X PUT \
###       -u "$username" \
###       -H "Content-Type: application/json" # \
###       #-w "%{http_code} %{url_effective}\n"
}

de() {
  docker exec -it $(docker-last) env TERM=xterm bash
}
