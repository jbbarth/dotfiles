#!/bin/sh

service='sudo /etc/init.d/'
bricks='chef-client stompserver couchdb chef-indexer chef-server'

. /lib/lsb/init-functions

status() {
  ${service}chef-client status
  ${service}stompserver status
  log_daemon_msg "Checking status of couchdb"
  pgrep couchdb >/dev/null && log_end_msg 0 || log_end_msg 1
  log_daemon_msg "Checking status of masquerade"
  pgrep -f script/server >/dev/null && log_end_msg 0 || log_end_msg 1
  ${service}chef-indexer status
  ${service}chef-server status
}

start() {
  cd ~/dev/confmgmt/masquerade && nohup ruby script/server -e production &
  for i in $bricks; do
    ${service}$i start
  done
}

stop() {
  pkill -9 -f "script/server"
  for i in $bricks; do
    ${service}$i stop
  done
}

eval $1
