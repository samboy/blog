#!/bin/sh

# This script is public domain.

echo \<html\>\<head\>\<title\>Sam Trenholme’s Blog\</title\> > index.html
echo \<style\> >> index.html
echo '@import url('fonts.css');' >> index.html # OFL license in CSS file
# A lot of the blog was made in an era before phone screens were mainstream
echo 'body { max-width: 95vw; overflow-x: hidden; }' >> index.html

# Nav after blog entries
echo '.GitBlogNav { display: table; width: 95vw; ' >> index.html
echo 'text-align: center;' >> index.html
echo 'border-top: 1px solid black;' >> index.html
echo 'margin: 3px; padding: 2px;' >> index.html
echo margin-left: auto\; >> index.html
echo margin-right: auto\; >> index.html
echo 'border-bottom: 1px solid black; }' >> index.html
echo '@media (min-width: 640px) {.GitBlogNav {width:640px;}}' >> index.html

echo .blog { display: table\; max-width: 640px\; >> index.html
echo 'font-family: Kilroy8; font-size: 16px;' >> index.html
echo margin-left: auto\; >> index.html
echo margin-right: auto\; } >> index.html

# Again, phone screen workarounds
echo '.blog pre {max-width: 90vw; overflow: scroll; }' >> index.html
echo '.blog li pre {max-width: 80vw; overflow: scroll; }' >> index.html
echo '.blog table {max-width: 90vw; overflow: scroll; }' >> index.html
echo '.blog tt {max-width: 90vw; overflow: scroll; }' >> index.html
echo '.blogtable {max-width: 90vw; overflow: scroll; }' >> index.html
echo '@media (max-width: 640px) {.pc {display: none;}}' >> index.html

echo '.moyet { display: none; }' >> index.html
echo '.blog h1 { font-size: 28px; }' >> index.html
echo '.s { font-size: 18px; }' >> index.html
echo '.blogtitle { font-size: 24px; }' >> index.html
# The HTML for the blog got weird over the years
echo '.blogpicx { text-align: left !important; }' >> index.html
echo \</style\> >> index.html
# This is just going to be a long line
echo \<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" \> >> index.html
echo \</head\>\<body\> >> index.html
echo \<a name="GitBlogTop"\> \</a\> >> index.html
echo \<div class=blog\> >> index.html
echo '<i>Please be aware that this is an archive of my currently' >> index.html
echo 'active blog at <a ' >> index.html
echo 'href=https://samiam.org/blog>samiam.org</a>.' >> index.html
echo 'Many links in the blog are broken.' >> index.html
echo '<a href="#GitBlogIndex">Click/tap here for a functional' >> index.html
echo 'blog index.</a></i>' >> index.html
echo '</div><div class=blog>' >> index.html
echo \<h1\>Sam Trenholme’s blog\</h1\> >> index.html
echo >> index.html
echo > foo.html
for a in $( ls embed/*embed | sort -r ) ; do
  NAME=$( grep -i h1 $a | head -1 | tr '<>' ':' | awk -F: '{print $3}' )
  LINK=$( echo $NAME | awk '{gsub(/[^A-Za-z0-9]/,"");print}' )
  DATE=${a#embed/}
  DATE=${DATE%.embed}
  echo '<a name='$LINK'> </a>' >> index.html
  echo '<a href="#'$LINK'">'$NAME' ('$DATE')</a></br>' >> foo.html
  cat $a >> index.html
  #echo '<hr class=pc>' >> index.html
  echo '<div class=GitBlogNav><i>Go to: ' >> index.html
  echo '<a href="#GitBlogTop">Top</a>' >> index.html
  echo '<a href="#GitBlogIndex">Index</a></i></div>' >> index.html
  #echo '<hr class=pc>' >> index.html
  echo \<div class=blog\> >> index.html # An old bug I never correctly fixed
  echo $a
done
echo '<a name="GitBlogIndex"> </a><h1>Blog index</h1>' >> index.html
cat foo.html >> index.html
echo \</div\> >> index.html
rm -f foo.html
echo \</body\>\</html\> >> index.html
