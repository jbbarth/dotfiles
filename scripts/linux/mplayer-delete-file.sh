#!/bin/sh
rm "$(ls -l /proc/$(pgrep -n mplayer)/fd/4 | cut -d">" -f 2 | sed -e 's/^ //')"
