export BASH_COMP_DEBUG_FILE=/tmp/comp_debug
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
unsetopt pathdirs
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
add_to_path ~/bin
add_to_path ~/.local/bin
export SUDO_EDITOR=vi
export SVN_EDITOR=vi
export EDITOR=vi
export LANG=en_US.UTF-8

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

# Cargo env if any
test -d ~/.cargo && source ~/.cargo/env

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jean-baptiste.barth/admin/gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jean-baptiste.barth/admin/gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jean-baptiste.barth/admin/gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jean-baptiste.barth/admin/gcloud/google-cloud-sdk/completion.zsh.inc'; fi

# opencode
add_to_path ~/.opencode/bin:$PATH

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# bun completions
[ -s "/Users/jean-baptiste.barth/.bun/_bun" ] && source "/Users/jean-baptiste.barth/.bun/_bun"
