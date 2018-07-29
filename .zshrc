HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
#bindkey -v
bindkey -e
#bindkey -s '\el' 'ls\n'                             # [Esc-l] - run command: ls
#bindkey -s '\e.' '..\n'                             # [Esc-.] - run command: .. (up directory)
bindkey '^[[3~' delete-char
bindkey '^R' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^[[1;9C' forward-word                       # [Alt-RightArrow] - move forward one word
bindkey '^[[1;9D' backward-word                      # [Alt-LeftArrow] - move backward one word

# My own options (see man zshoptions)
#setopt auto_cd
setopt auto_pushd
#setopt cdable_vars
CDPATH=$CDPATH:$HOME
setopt pushd_ignore_dups
setopt hist_ignore_dups
setopt inc_append_history
setopt extended_history
#setopt path_dirs
NULLCMD=:

# Environment variables
PATH=$HOME/bin:$PATH
export SUDO_EDITOR=vi
export SVN_EDITOR=vi
export EDITOR=vi

# Load files under .zsh/
for config_file ($HOME/.zsh/*.zsh); do
  #echo "loading $config_file"
  source $config_file
done

# Add ssh keys to agent if needed (MacOSX for instance)
ssh-add -L |grep "^ssh" >/dev/null || ssh-add

# Automatic files handling
autoload zsh-mime-setup
zsh-mime-setup 2>/dev/null

# Auto-rehash to avoid problems after package installs
# http://www.zsh.org/mla/users/2011/msg00531.html
zstyle ':completion:*' rehash true

# Easy colors in ZSH scripting
autoload -U colors && colors

# precmd() for rvm prompt + no hist dirs
function __precmd() {
  if ! test -z "$SIMPLE_PROMPT"; then
    PROMPT="$SIMPLE_PROMPT"
  else
    dir=$(pwd|perl -pe 's#^/(Users|home)/jbbarth#~#,s#^~/(botify|dev/botify|Projects/botify)#[B]#')
    if which ec2metadata >/dev/null; then
      #AWS machines
      env=$(ec2metadata --security-groups|head -n 1|cut -d. -f4|sed 's#%2F#/#')
      [ "$env" == "prod" ] && env="%{$fg[red]%}prod"
      [ "$env" == "staging" ] && env="%{$fg[cyan]%}staging"
      userhost="$env%{$reset_color%}|%n@%m"
    elif test -e /usr/local/rtm/bin/rtm; then
      #OVH machines
      env="%{$fg[blue]%}ovh"
      userhost="$env%{$reset_color%}|%n@%m"
    elif ! test -z "$SSH_CONNECTION"; then
      #other ssh-accessed machines
      userhost="%n@%m"
    else
      userhost="%n@local"
    fi
    if [ "$VIRTUAL_ENV" != "" ]; then
      virtualenv="($(basename $VIRTUAL_ENV))"
    else
      virtualenv=""
    fi
    if test -e "$(pwd)/.ruby-version"; then
      rvm_env="{$(current_rvm_env)}"
    else
      rvm_env=""
    fi
    PROMPT="$rvm_env$virtualenv$userhost:$dir%# "
  fi
  PROMPT='$(kube_ps1)'$PROMPT
}
# switch between simple and normal prompt
function sp() {
  if [ "$SIMPLE_PROMPT" ]; then
    unset SIMPLE_PROMPT
  else
    export SIMPLE_PROMPT="%# "
  fi
}
export SIMPLE_PROMPT="%# "

### Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
