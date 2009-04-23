#!/bin/bash


# Jean-Baptiste BARTH <jeanbaptiste.barth@gmail.com>
# This script aims at making a tiny dev env for my rails project
# It is adapted from the script provided in this article :
#   http://blog.lathi.net/articles/2008/09/13/scripting-screen

DEVEL_DIR=$HOME/dev
SCREEN_OPTS="-A -U"

OLD_PS3=$PS3
PS3="Which project to start a session for? "

select PROJECT in `ls -F $DEVEL_DIR | egrep /$ | sed 's/\///' `; do
  
  PS3=$OLD_PS3
  cd $DEVEL_DIR/$PROJECT
  screen -d -m $SCREEN_OPTS -S $PROJECT
  screen -X -S $PROJECT -p 0 title SERVER
  sleep 1
  screen -X -S $PROJECT -p 0 stuff "ruby script/server -e development --debugger"
  screen -X -S $PROJECT screen -t CONSOLE 1
###  sleep 1
  screen -X -S $PROJECT -p 1 stuff "ruby script/console development"
  screen -X -S $PROJECT screen -t DEV 2
###  sleep 1
  screen -X -S $PROJECT -p 2 stuff "git status"
###  screen -X -S $PROJECT screen -t AUTOTEST 3
###  sleep 1
###  screen -X -S $PROJECT -p 3 stuff "rake db:test:load && autotest 2>&1 |more"

  sleep 1
  
  firefox http://localhost:3000/
  firefox file://$HOME/doc/railsbrain/index.html
  firefox file://$HOME/doc/rubybrain/index.html

  screen -x $PROJECT -p 2
  
  break

done

PS3=$OLD_PS3
