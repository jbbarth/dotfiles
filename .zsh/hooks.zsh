# run commands after any "cd"
on_cd() {
  # autoload kubernetes zsh file if not loaded yet
  if echo $PWD | grep -v /dev/kubernetes | grep -q /kube && test -z $ZSH_AUTO_K8S_LOADED; then
    #echo "sourcing ~/.zsh/kubernetes.zsh.auto"
    source ~/.zsh/kubernetes.zsh.auto
  fi

  # autoload nvm zsh file if local directory has a .nvmrc
  #if [[ -e $(pwd)/.nvmrc && -z $ZSH_AUTO_NVM_LOADED ]]; then
  #  #echo "sourcing ~/.zsh/nvm.zsh.auto"
  #  source ~/.zsh/nvm.zsh.auto
  #  nvm use --silent
  #  ZSH_AUTO_NVM_LOADED=yes
  #fi

  # autoload pyenv zsh file if local directory has a .python-version
  if [[ -e $(pwd)/.python-version && -z $ZSH_AUTO_PYENV_LOADED ]]; then
    #echo "sourcing ~/.zsh/pyenv.zsh.auto"
    source ~/.zsh/pyenv.zsh.auto
  fi

  # re-evaluate available binaries
  if [[ -d node_modules/.bin ]]; then
    path=$(echo $PATH | perl -pe 's#(^|:)[^:]*/node_modules/.bin(:|$)#$1$2#')
    add_to_path $(pwd)/node_modules/.bin
  fi
}
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd(){ on_cd; }
on_cd
