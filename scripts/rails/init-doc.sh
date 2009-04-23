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
echo "* Updating ruby doc"
unzip -u ~/doc/rubybrain*.zip -d ~/doc/rubybrain/ >/dev/null
change_root "$HOME/doc/rubybrain"

echo "* Updating rails doc"
unzip -u ~/doc/railsbrain*.zip -d ~/doc/railsbrain/ >/dev/null
change_root "$HOME/doc/railsbrain"
