#!/bin/bash

if [ $# -ne 1 ]; then
	echo "USAGE: $0 <new_redmine_dir>"
	exit 1 
fi

svn co http://redmine.rubyforge.org/svn/trunk $1 
