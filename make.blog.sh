#!/bin/sh

./makeBlog.lua
chmod 644 index.html
chmod 644 archive.html
for a in embed/2026*embed ; do 
  ./oneEntry.lua $a
done 
./makeMaraDNSBlog.lua
chmod 644 entries/*html

exit 0
