#aliases for docker
alias dkr-add-zsh-completion="curl https://raw.github.com/felixr/docker-zsh-completion/master/_docker |sudo tee /usr/share/zsh/functions/Completion/Linux/_docker; source ~/.zshrc"
alias dkr-remove-test-images="docker images |grep '<none>' |awk '{print \$3}' |xargs --no-run-if-empty echo docker rmi"
