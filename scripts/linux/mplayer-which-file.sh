#!/bin/sh
echo $(ls -l /proc/$(pgrep -o mplayer)/fd/3 | cut -d">" -f 2 | sed -e 's/^ //')
