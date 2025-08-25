#!/bin/sh

# This script is public domain.

echo \<h1\>Sam Trenholme’s blog\</h1\> > index.html
echo >> index.html
for a in embed/*embed ; do
  cat $a >> index.html
  echo $a
done

