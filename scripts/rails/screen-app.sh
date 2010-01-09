#!/bin/bash


# Jean-Baptiste BARTH <jeanbaptiste.barth@gmail.com>
# This script aims at making a tiny dev env for my rails project
# It is adapted from the script provided in this article :
#   http://blog.lathi.net/articles/2008/09/13/scripting-screen

DEVEL_DIR=$([ -d $HOME/dev/rails ] && echo "$HOME/dev/rails" || echo "/home/app")
SCREEN_OPTS="-A -U"

OLD_PS3=$PS3
PS3="Which project to start a session for? "

#check if there are already running screen sessions
if [ "$(screen -list | grep 'No Socket' >/dev/null 2>&1; echo $?)" -ne "0" ]; then
  echo "There are already running screen sessions :"
  screen -list
  exit 1
fi

#select PROJECT in `ls -F $DEVEL_DIR | egrep /$ | sed 's/\///' `; do
select PROJECT in $(find $DEVEL_DIR -maxdepth 4 -name database.yml | fgrep config/database.yml | sed 's#/config/database.yml##' | sed "s#$DEVEL_DIR/##" | sort); do
  
  PS3=$OLD_PS3
  SPROJECT=$(echo $PROJECT | sed 's#/#_#g')
  SLEEP="sleep 1"
  SLEEP2=""

  cd $DEVEL_DIR/$PROJECT

  screen -d -m $SCREEN_OPTS -S $SPROJECT
  screen -X -S $SPROJECT -p 0 title SERVER
  eval $SLEEP
  screen -X -S $SPROJECT -p 0 stuff "ruby script/server -e production --debugger"
  screen -X -S $SPROJECT screen -t CONSOLE 1
  eval $SLEEP
  screen -X -S $SPROJECT -p 1 stuff "ruby script/console development"
  screen -X -S $SPROJECT screen -t DEV 2
  eval $SLEEP
  [ -d .git/ ] && screen -X -S $SPROJECT -p 2 stuff "git status"
  [ -d .svn/ ] && screen -X -S $SPROJECT -p 2 stuff "svn status"
  screen -X -S $SPROJECT screen -t AUTOTEST 3
  eval $SLEEP
  #screen -X -S $SPROJECT -p 3 stuff "rake db:test:load && autotest 2>&1 | \\more"
  i=3
  if [ -d lib/daemons ]; then
    eval $SLEEP
    screen -X -S $SPROJECT screen -t DAEMONS 4
    screen -X -S $SPROJECT -p 4 stuff "RAILS_ENV=development lib/daemons/*_ctl run"
    i=4
  fi
  for j in $(seq 0 $i); do
    eval $SLEEP2
    screen -X -S $SPROJECT -p $j stuff ""
  done
  screen -x $SPROJECT -p 2
  
  break

done

PS3=$OLD_PS3
