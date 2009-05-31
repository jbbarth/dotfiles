#!/bin/bash

change_root() {
  for f in $(find $1/ -name index.html |head -n 1); do
    olddir=$(echo $f | sed 's/\/index\.html$//g')
    newdir="$1/"
    if [ "$olddir" != "$newdir" ]; then
      cp -ru $olddir/* $newdir
      echo -e "\tSuppression de $olddir :"
      rm -rI $olddir
    fi
  done
}

cd
echo "* Downloading ruby doc"
wget -P doc http://www.rubybrain.com/api/ruby-1.8.7/rubybrain_ruby-1.8.7.zip
echo "* Updating ruby doc"
unzip -u ~/doc/rubybrain*.zip -d ~/doc/rubybrain/ >/dev/null
change_root "$HOME/doc/rubybrain"

echo "* Downloading rails doc"
wget -P doc http://www.railsbrain.com/api/rails-2.3.2/railsbrain_rails-2.3.2.zip
echo "* Updating rails doc"
unzip -u ~/doc/railsbrain*.zip -d ~/doc/railsbrain/ >/dev/null
change_root "$HOME/doc/railsbrain"
