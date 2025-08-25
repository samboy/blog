#!/bin/sh

# This script is public domain.

echo \<html\>\<head\>\<title\>Sam Trenholme’s Blog\</title\> > index.html
echo \<style\> >> index.html
echo '@import url('fonts.css');' >> index.html # OFL license in CSS file
echo .blog { display: table\; max-width: 640px\; >> index.html
echo 'font-family: Kilroy8; font-size: 16px;' >> index.html
echo margin-left: auto\; >> index.html
echo margin-right: auto\; } >> index.html
echo '.moyet { display: none; }' >> index.html
echo '.blog h1 { font-size: 28px; }' >> index.html
echo '.s { font-size: 18px; }' >> index.html
echo '.blogtitle { font-size: 24px; }' >> index.html
# The HTML for the blog got weird over the years
echo '.blogpicx { text-align: left !important; }' >> index.html
echo \</style\> >> index.html
# This is just going to be a long line
echo \<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" \> >> index.html
echo \</head\>\<body\>\<div class=blog\> >> index.html
echo \<h1\>Sam Trenholme’s blog\</h1\> >> index.html
echo >> index.html
for a in $( ls embed/*embed | sort -r ) ; do
  cat $a >> index.html
  echo \<div class=blog\> >> index.html # An old bug I never correctly fixed
  echo $a
done
echo \</div\>\</body\>\</html\> >> index.html
