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
alias l='ls -CF'
function llr {
  ls -la | sort -k 5 -n | ruby -ne 'a=$_.split;puts "#{a[4]} #{a[7..-1].join(" ")}" unless a[7].nil?'
}
px() {
  ps aux|grep $*
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
alias rs='rspec spec'
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
  if ip addr show eth0 | grep "inet 161.48" >/dev/null; then
    command ssh -F ~/.ssh/config.work $*
  else
    command ssh $*
  fi
}
alias go='gnome-open'
if laptop-detect 2>/dev/null; then
  alias mp='mplayer -fs -ao alsa,oss, -idx'
else
  alias mp='mplayer -ao alsa,oss,'
fi
alias -g M=' 2>&1 | more'
alias luksopen='sudo cryptsetup luksOpen'
alias luksclose='sudo cryptsetup luksClose'
