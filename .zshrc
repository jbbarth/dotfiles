# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
#bindkey -v
bindkey '^[[3~' delete-char
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
#autoload -Uz compinit
autoload -U compinit
compinit
# End of lines added by compinstall

# My own options (see man zshoptions)
setopt auto_cd
setopt auto_pushd
setopt cdable_vars
CDPATH=$CDPATH:$HOME
PATH_DIRS=$PATH_DIRS:$HOME/scripts
setopt pushd_ignore_dups
setopt hist_ignore_dups
setopt inc_append_history
setopt extended_history
#setopt path_dirs
setopt correct
setopt nonomatch
NULLCMD=echo

# Shell colors ; adapted from
# http://chm.duquesne.free.fr/blog/?p=61
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    [ -x /usr/bin/colordiff ] && alias diff='colordiff'
    alias less='less -R'
fi

# Personal aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'
vi() {
  if [ -w $1 ]; then
    command vim $*
  elif [ ! -e $1 ] && [ -w $(dirname $1) ]; then
    command vim $*
  else
    command sudo vim -u $HOME/.vimrc $*
  fi
}
alias more='less'
alias rs='ruby script/server -e development --debugger'
alias gc='git add . && git commit -a -m'
alias gs='git status'
gp() {
  if [ -r .git/FETCH_HEAD ]; then
    git push --all $(ruby -ne "puts split.pop" < .git/FETCH_HEAD).git
  else
    echo -n "Repo: "
    read repo
    git push --all $repo
  fi  
}
alias vds='ssh salvor@vds171.sivit.org'
alias setra-careless='ssh supervision2.setra -L8888:localhost:80'
alias setra-redmine='ssh dsi.setra -L8889:localhost:80'
alias week='ruby -e "require \"date\"; puts Date.commercial( Time.now.year, ARGV[0].to_i|1, 1 ).strftime( \"%d-%m-%Y\")"'
alias ppa-key='command sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys'
alias wupdate='wajig update && wajig dist-upgrade'
alias iptables='command sudo iptables'
alias iptablist='command sudo iptables -nvL --line-numbers'
alias man='man -a'
alias sudo='command sudo '
alias ssudo='command sudo sh -c '
alias gem='sudo gem'
function ssh() {
  ip addr show eth0 | grep "inet 161.48" >/dev/null
  if [ "$?" -eq "0" ]; then
    command ssh -F .ssh/config.work $*
  else
    command ssh $*
  fi
}
# Environment variables
PATH=$PATH:/var/lib/gems/1.8/bin:$HOME/scripts/rails
PROMPT=$(grep setra /etc/hosts >/dev/null && echo '%n@%m%# ' || echo '%m%# ')
RAILS_ENV=development

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

# Completion development lines
# => be as verbose as possible
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
