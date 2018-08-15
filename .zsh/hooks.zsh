# run commands after any "cd"
on_cd() {
  # autoload kubernetes zsh file if not loaded yet
  if [[ $(pwd) = *kubernetes* && -z $ZSH_AUTO_K8S_LOADED ]]; then
    echo "sourcing ~/.zsh/kubernetes.zsh.auto"
    source ~/.zsh/kubernetes.zsh.auto
  fi

  # autoload nvm zsh file if local directory has a .nvmrc
  if [[ -e $(pwd)/.nvmrc && -z $ZSH_AUTO_NVM_LOADED ]]; then
    echo "sourcing ~/.zsh/nvm.zsh.auto"
    source ~/.zsh/nvm.zsh.auto
  fi

  # re-evaluate available binaries
  if [[ -d node_modules/.bin ]]; then
    path=$(echo $PATH | perl -pe 's#(^|:)[^:]*/node_modules/.bin(:|$)#$1$2#')
    export PATH=$(pwd)/node_modules/.bin:$PATH
  fi
}
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd(){ on_cd; }
on_cd
