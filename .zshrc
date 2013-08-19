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

# My own options (see man zshoptions)
setopt auto_cd
setopt auto_pushd
#setopt cdable_vars
CDPATH=$CDPATH:$HOME
setopt pushd_ignore_dups
setopt hist_ignore_dups
setopt inc_append_history
setopt extended_history
#setopt path_dirs
NULLCMD=:

# Load files under .zsh/
for config_file ($HOME/.zsh/*.zsh) source $config_file

# Add ssh keys to agent if needed (MacOSX for instance)
ssh-add -L |grep "^ssh" >/dev/null || ssh-add

# Environment variables
PATH=$PATH:$HOME/bin
export SUDO_EDITOR=vi

# Automatic files handling
autoload zsh-mime-setup
zsh-mime-setup 2>/dev/null

# Version control system
###autoload -Uz vcs_info
###zstyle ':vcs_info:*' actionformats \
###  '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
###zstyle ':vcs_info:*' formats \
###  '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
###zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
###precmd () { vcs_info }
###PS1='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_}'"%f%# "

# precmd() for rvm prompt + no hist dirs
function precmd() {
  #RVM
  if [[ -z "$SSH_CONNECTION" ]]; then
    #PROMPT="$(printf '\u263A'):$(current_rvm_env)%# "
    PROMPT="local:$(current_rvm_env)%# "
  else
    PROMPT="%m:$(current_rvm_env)%# "
  fi
  #No history directories
  if test -e ~/.nohistdirs && pwd | grep -F -f ~/.nohistdirs >/dev/null; then
    fc -W
    unset HISTFILE
  else
    #fc -W
    export HISTFILE=~/.zsh_history
  fi
}

PATH=$PATH:/usr/local/rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
