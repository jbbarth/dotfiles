#!/bin/sh
file=$(ls -l /proc/$(pgrep -n mplayer)/fd/3 | cut -d">" -f 2 | sed -e 's/^ //')
tomovedir=$(dirname "$(echo $file|sed 's#/mnt/models#/home/jbbarth/dev/.mdlz/galleries/planetsuzy/models#')")
mkdir -p $tomovedir
cp -t $tomovedir "$file"
