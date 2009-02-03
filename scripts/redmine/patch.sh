#!/bin/bash

if [ $# -ne 1 ]; then
	echo "USAGE: $0 <redmine_dir>"
	exit 1 
fi

cd "$1"
for i in `ls ../_patches`; do
	patch -p0 < "../_patches/$i"
done
