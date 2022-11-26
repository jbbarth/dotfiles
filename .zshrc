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
setopt interactivecomments
#setopt path_dirs
NULLCMD=:

# Environment variables
add_to_path() {
  if [[ ":$PATH:" != *":$1:"* ]]; then
    if [[ "$2" = "after" ]]; then
      PATH="${PATH}:$1"
    else
      PATH="$1:${PATH}"
    fi
  fi
}
add_to_path $HOME/bin
add_to_path $HOME/.local/bin
export SUDO_EDITOR=vi
export SVN_EDITOR=vi
export EDITOR=vi

# Zinit plugin system
#ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
##mkdir -p "$(dirname $ZINIT_HOME)"
##git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
#source "${ZINIT_HOME}/zinit.zsh"

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

# Added by the Heroku Toolbelt
add_to_path /usr/local/heroku/bin after

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



#alias beanstalk_connect=$HOME/tools/scripts/beanstalk_connect

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/jbbarth/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
