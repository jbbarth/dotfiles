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
setopt extended_glob
NULLCMD=:

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
[ -e /etc/redhat-release ] && alias rm='rm -i' || alias rm='rm -I'
alias mv='mv -i'
alias zmv='rsync --recursive --remove-source-files --progress'
alias emptydirs='find . -type d -empty -print'
zunrar() {
  rar=$1
  retval=1
  nb=$(unrar l -p- $1 2>/dev/null|tail -n 2|head -n 1|grep -v UNRAR|ruby -ne 'puts $_.match(/\d/) ? $_.split.first.to_i : 15')
  [ "$nb" != "" ] && [ "$nb" -lt "10" ] && opts="e"
  [ "$opts" == "e" ] || opts="x"
  echo "$nb files ; extracting with unrar $opts"
  for i in $(echo - -; tac passwd.txt | ruby -ne 'puts $_.strip.gsub(" ","BLANK")'); do
    echo "Trying password: $i"
    #if [ "$i" == "-" ]; then
    #  pass="-p-"
    #else
    #  pass="-p\"${i//BLANK/ }\""
    #fi
    #echo unrar $opts $pass $rar
    unrar $opts -p$i $rar && eval rm -f $(echo $rar | sed -e 's/part1.rar/part*.rar/' -e 's/part01.rar/part*.rar/')
    retval=$?
    [ "$retval" == "0" ] && break
  done
  rm -f [A-Z]*(txt|url) Thumbs.db*
  return $retval
}
zrmlocaldup() {
  dir=$1
  for i in *(.); do
    size=$(stat -c "%s" $i)
    size2=$(stat -c "%s" $dir/$i 2>/dev/null || echo 0)
    test "$size" -eq "$size2" && echo "Removing duplicate: $size $size2 $i" && rm -f "$i"
  done
}
alias wmvjoin='mencoder -oac copy -ovc copy -o'
joinsplitted() {
  cat $1.00* > $1 && rm -f $1.00*
}
alias cp='cp -i'
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -CF'
function llr {
  ls -la | sort -k 5 -n | ruby -ne 'a=$_.split;puts "#{a[4]} #{a[7..-1].join(" ")}" unless a[7].nil?'
}
vi() {
  if [ -w $1 ]; then
    command vim $*
  elif [ ! -e $1 ] && [ -w $(dirname $1) ]; then
    command vim $*
  else
    command sudo -e $*
  fi
}
alias more='less'
alias rs='ruby script/server -e development --debugger'
alias gc='git add . && git commit -a -m'
alias gs='git status'
gp() {
  if grep "remote = origin" .git/config >/dev/null; then
    git push --all origin
  elif [ -r .git/FETCH_HEAD ]; then
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
alias wupdate='sudo aptitude update && sudo aptitude safe-upgrade'
alias iptables-list='command sudo iptables -nvL --line-numbers'
alias iptables-clear='iptables -P INPUT ACCEPT'
#alias man='man -a'
alias sudo='command sudo '
alias ssudo='command sudo sh -c '
#alias gem='command sudo gem'
function ssh() {
  if ip addr show eth0 | grep "inet 161.48" >/dev/null; then
    command ssh -F ~/.ssh/config.work $*
  else
    command ssh $*
  fi
}
alias go='gnome-open'
if hostname|grep pegasus>/dev/null; then
  alias mp='mplayer -fs -ao alsa,oss,'
else
  alias mp='mplayer -ao alsa,oss,'
fi
alias -g M=' 2>&1 | more'
alias luksopen='sudo cryptsetup luksOpen'
alias luksclose='sudo cryptsetup luksClose'

# Environment variables
PATH=$PATH:/var/lib/gems/1.8/bin:$HOME/scripts/rails:$HOME/scripts/linux
#PROMPT=$(grep setra /etc/hosts >/dev/null && echo '%n@%m%# ' || echo '%m%# ')
PROMPT='%# '
export RAILS_ENV=production
GEM_HOME=/var/lib/gems/1.8/
GEM_PATH=$GEM_HOME
export GIT_EDITOR=vi
export SUDO_EDITOR=vi
if ip addr show eth0 | grep -v "161.48.8" | grep -v "161.48.111" | grep "inet 161.48" >/dev/null; then
  export http_proxy=http://proxy:8080
  export https_proxy=http://proxy:8080
  export ftp_proxy=http://proxy:8080
fi

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

#RVM ( http://rvm.beginrescueend.com/install/ )
[[ -s /home/salvor/.rvm/scripts/rvm ]] && source /home/salvor/.rvm/scripts/rvm
