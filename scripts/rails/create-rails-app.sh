#!/bin/bash

# Jean-Baptiste BARTH <jeanbaptiste.barth@gmail.com>
# This script creates a rails app versionned with git

if [ -z "$1" ]; then
  echo "USAGE: $0 APP_NAME"
  exit 1
fi

if [ -e ~/dev/$1 ]; then
  echo "ERROR: ~/dev/$1 already exists !"
  exit 1
fi

mkdir -p ~/dev/
cd ~/dev/

echo "* Creating new rails app ($(rails -v))..."
rails -q $1

echo "* Migrating database (empty)..."
cd $1
rake db:migrate >/dev/null

echo "* Git-ing it..."
cat <<EOF > .gitignore
#config/database.yml
log/*.log
tmp/**/*
db/*.sqlite3
db/*.db
doc/api
doc/app
nbproject/*
EOF
touch log/.gitignore tmp/.gitignore
git init >/dev/null

echo "* Creating first commit..."
git add . >/dev/null
git commit -m "Initial commit for $1" >/dev/null

echo "=> OK. Just cd ~/dev/$1 and code now !"
