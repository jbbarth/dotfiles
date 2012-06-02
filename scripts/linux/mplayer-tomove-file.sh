#!/bin/sh
file=$(ls -l /proc/$(pgrep -n mplayer)/fd/4 | cut -d">" -f 2 | sed -e 's/^ //')
tomovedir=$(dirname "$(echo $file|sed 's/keep/move/')")
mkdir -p $tomovedir
mv -t $tomovedir "$file"
