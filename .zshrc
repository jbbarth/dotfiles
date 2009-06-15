# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
#bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/salvor/.zshrc'

autoload -Uz compinit
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
#setopt path_dirs
setopt correct

# Personal aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'
alias vi='vim'
alias rs='ruby script/server -e development --debugger'
alias gc='git add . && git commit -a -m'
alias gs='git status'
alias gp='git push'
alias vds='ssh salvor@vds171.sivit.org'
alias setra-careless='ssh supervision2.setra -L8888:localhost:80'
alias setra-redmine='ssh dsi.setra -L8889:localhost:80'

# Environment variables
PATH=$PATH:/var/lib/gems/1.8/bin:$HOME/scripts/rails
