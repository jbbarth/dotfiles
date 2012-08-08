# Colors in commands
# adapted from http://chm.duquesne.free.fr/blog/?p=61
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    #[ -x /usr/bin/colordiff ] && alias diff='colordiff'
    alias less='less -R'
# MacOSX version with coreutils packages
elif [ -x /usr/local/bin/gdircolors ]; then
    eval "$(gdircolors -b)"
    alias ls='gls --color=auto'
    alias dir='gdir --color=auto'
    alias vdir='gvdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    #[ -x /usr/bin/colordiff ] && alias diff='colordiff'
    alias less='less -R'
fi

# Personal aliases
[ -e /etc/debian_version ] && alias rm='rm -I' || alias rm='rm -i'
[ -e /usr/local/bin/grm ] && alias rm='grm -I'
[ -e /usr/local/bin/gmv ] && alias mv='gmv -i' || alias mv='mv -i'
alias df='df -hP'
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
    unrar $opts -p$i $rar && eval rm -f "$(echo $rar | sed -e 's/part1.rar/part*.rar/' -e 's/part01.rar/part*.rar/')"
    retval=$?
    [ "$retval" == "0" ] && break
  done
  rm -f [A-Z]*.txt Thumbs.db* *.url
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
alias l='ls -CF'
function llr {
  ls -la | sort -k 5 -n | ruby -ne 'a=$_.split;puts "#{a[4]} #{a[7..-1].join(" ")}" unless a[7].nil?'
}
px() {
  ps aux|grep $*
}
vi() {
  #ensure we're not on a binary file
  if [ -e $1 ]; then
    filetype=$(file $1|grep -e ' text' -e ' data' -e ' empty' >/dev/null && echo 'text' || echo 'other') 
    [ "$filetype" != "text" ] && echo "Non text file: $(file $1)\nContinue ?" && read
  fi
  #then only edit it
  if [ -w $1 ]; then
    command vim $*
  elif [ ! -e $1 ] && [ -w $(dirname $1) ]; then
    command vim $*
  else
    command sudo -e $*
  fi
}
alias more='less'
alias rs='rspec spec'
alias rake='bundle exec rake'
alias rt='RAILS_ENV=test ruby -Itest'
alias vds='ssh salvor@vds171.sivit.org'
alias setra-redmine='ssh dsi.setra -L8889:localhost:80'
alias week='ruby -e "require \"date\"; puts Date.commercial( Time.now.year, ARGV[0].to_i|1, 1 ).strftime( \"%d-%m-%Y\")"'
alias ppa-key='command sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys'
alias wupdate='sudo aptitude update && sudo aptitude safe-upgrade'
alias iptables-list='command sudo iptables -nvL --line-numbers'
alias iptables-clear='iptables -P INPUT ACCEPT'
alias sudo='command sudo '
alias ssudo='command sudo sh -c '
function ssh() {
  if ip addr show | grep -e "inet 10.166" -e "inet 10.167" -e "inet 172.22" >/dev/null; then
  #if ip addr show | grep "eth0" |grep " UP" >/dev/null; then
    command ssh -F ~/.ssh/config.work $*
  else
    command ssh $*
  fi
}
function scp() {
  if ip addr show | grep -e "inet 10.166" -e "inet 10.167" -e "inet 172.22" >/dev/null; then
  #if ip addr show | grep "eth0" |grep " UP" >/dev/null; then
    command scp -F ~/.ssh/config.work $*
  else
    command scp $*
  fi
}
alias go='gnome-open'
if laptop-detect 2>/dev/null; then
  alias mp='mplayer -fs -ao alsa,oss, -idx -af pan=2:0.5:0.5:0.5:0.5'
else
  alias mp='mplayer -ao alsa,oss,'
fi
alias -g M=' 2>&1 | more'
alias luksopen='sudo cryptsetup luksOpen'
alias luksclose='sudo cryptsetup luksClose'
alias pru="rvm 1.9.2 exec pru"
alias osxhostname="sudo scutil --set HostName "
