#!/bin/sh
echo $(ls -l /proc/$(pgrep -o mplayer)/fd/4 | cut -d">" -f 2 | sed -e 's/^ //')
