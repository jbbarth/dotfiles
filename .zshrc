HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
#bindkey -v
bindkey '^[[3~' delete-char

# My own options (see man zshoptions)
setopt auto_cd
setopt auto_pushd
#setopt cdable_vars
CDPATH=$CDPATH:$HOME
PATH_DIRS=$PATH_DIRS:$HOME/scripts
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
PATH=$PATH:$HOME/scripts/rails:$HOME/scripts/linux:$HOME/bin
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
