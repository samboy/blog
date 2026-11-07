#!/bin/sh

for a in *txt ; do
	if [ ! -e ${a%.txt}.html ] ; then
		echo $a
	fi
done
