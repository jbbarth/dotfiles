#!/bin/bash

export RAILS_ENV="production"

if [ $# -ne 1 ]; then
	echo "USAGE: $0 <new_redmine_dir>"
	exit 1 
fi

rm -f "$1/config/database.yml.example"
cp -rp $HOME/scripts/redmine/database.yml "$1/config/"
cd "$1"

rake db:migrate
rake redmine:load_default_data
mkdir -p tmp
sudo chown -R salvor:salvor files log tmp
sudo chmod -R 755 files log tmp

sudo chmod g+w .
