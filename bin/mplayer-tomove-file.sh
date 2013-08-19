#!/bin/sh
file=$(ls -l /proc/$(pgrep -n mplayer)/fd/3 | cut -d">" -f 2 | sed -e 's/^ //')
tomovedir=$(dirname "$(echo $file|sed -e 's#/keep/#/move/#' -e 's#/new/#/move/#')")
mkdir -p $tomovedir
mv -t $tomovedir "$file"
