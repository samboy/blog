#!/bin/sh

# This script is public domain.
U='<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'
echo \<html\>\<head\>\<title\>Sam Trenholme’s Blog\</title\> > index.html
echo $U >> index.html 
echo \<style\> >> index.html

# Widepic CSS
echo '@import url('fonts.css');' >> index.html # OFL license in CSS file

# Thanks to https://screenspan.net/fallback for this CSS
# Georgia has mostly the same metrics so this is a 99% metric
# compatible local replacment
echo '@font-face { font-family: 'GeorgiaF'; src: local(Georgia);' >> index.html
echo 'size-adjust: 118%; }' >> index.html

echo '.widepic { box-shadow: 0 0 4px #888;' >> index.html
echo 'border-radius: 8px; width: 99%; height: auto; }' >> index.html
echo '@media screen and (max-width: 640px) { ' >> index.html
echo '.nomobile { display: none; } }' >> index.html

# A lot of the blog was made in an era before phone screens were mainstream
echo 'body { max-width: 95vw; overflow-x: hidden; } ' >> index.html

echo 'a { color: #258723; } ' >> index.html

# Nav after blog entries
echo '.GitBlogNav { display: table; width: 95vw; ' >> index.html
echo 'font-family: Kilroy8, GeorgiaF, Georgia, serif;' >> index.html
echo 'font-size: 16px;' >> index.html
echo 'text-align: center;' >> index.html
echo 'border-top: 2px solid #aaa;' >> index.html
echo 'margin: 5px; padding: 2px;' >> index.html
echo margin-left: auto\; >> index.html
echo margin-right: auto\; >> index.html
echo 'border-bottom: 2px solid #aaa; }' >> index.html
echo '@media (min-width: 640px) {.GitBlogNav {width:640px;}}' >> index.html
echo '@media (max-width: 640px) {.blogPre {overflow-x:scroll;}}' >> index.html
echo '@media (max-width: 640px) {.blog {overflow-x:scroll;}}' >> index.html
echo 'body { color: #333; background-color: #fff; }' >> index.html
echo '@media (prefers-color-scheme: dark) { ' >> index.html
echo 'body { background-color: #131516; color: #d8d4cf; }' >> index.html
echo '.blog { background-color: #131516; color: #d8d4cf; }' >> index.html
echo 'a { color: #78dc78; }' >> index.html
echo '.blog a { color: #78dc78; }' >> index.html
echo '}' >> index.html
echo '.blog { display: table; max-width: 640px;' >> index.html
# too much
#echo 'word-break: break-all;' >> index.html
# This didn't fix it
#echo 'overflow-wrap: break-word;' >> index.html
echo 'color: #333; background-color: #fff;' >> index.html # Blog colors
echo 'font-family: Kilroy8, GeorgiaF, Georgia, serif;' >> index.html
echo 'font-size: 16px;' >> index.html
echo margin-left: auto\; >> index.html
echo margin-right: auto\; } >> index.html

# Again, phone screen workarounds
echo '@media (max-width: 640px) {' >> index.html
echo '.blog pre {max-width: 90vw; overflow-x: scroll;}} ' >> index.html
echo '.blog pre { font-size: 14px; }' >> index.html
echo '.blog li pre {max-width: 80vw; overflow-x: scroll; }' >> index.html
echo '.blog table {max-width: 90vw; overflow-x: scroll; }' >> index.html
echo '.blog tt {max-width: 90vw; overflow-x: scroll; }' >> index.html
echo '.blogtable {max-width: 90vw; overflow-x: scroll; }' >> index.html
echo '@media (max-width: 640px) {.pc {display: none;}}' >> index.html

echo '.moyet { display: none; }' >> index.html
echo '.blog h1 { font-size: 28px; }' >> index.html
echo '.s { font-size: 18px; }' >> index.html
echo '.blogtitle { font-size: 24px; }' >> index.html
echo 'h3 { font-size: 24px; margin-bottom: 0; }' >> index.html
# The HTML for the blog got weird over the years
echo '.blogpicx { text-align: left !important; }' >> index.html 
echo '.blogpicx img { ' >> index.html
echo 'border-radius: 8px; box-shadow: 0 0 4px #888; }' >> index.html
echo \</style\> >> index.html
# This is just going to be a long line
echo \<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" \> >> index.html
echo \</head\>\<body\> >> index.html
echo \<a name="GitBlogTop"\> \</a\> >> index.html
echo \<div class=blog\> >> index.html
echo '<a href="#GitBlogIndex">Blog Index</a></i>' >> index.html
echo '</div><div class=blog>' >> index.html
echo \<h1\>Sam Trenholme’s blog\</h1\> >> index.html
echo >> index.html
echo > foo.html
for a in $( ls embed/*embed | sort -r ) ; do
  NAME=$( grep -i h1 $a | head -1 | tr '<>' ':' | awk -F: '{print $3}' )
  LINK=${a#*/}
  LINK=BlogEntry-${LINK%.embed}
  #LINK=$( echo $NAME | awk '{gsub(/[^A-Za-z0-9]/,"");print}' )
  DATE=${a#embed/}
  DATE=${DATE%.embed}
  #YEAR=$( echo $DATE | awk '{print substr($0,1,4)}' )
  YEAR=index
  echo '<a name='$LINK'> </a>' >> $YEAR.html
  echo '<a href="#'$LINK'">'$NAME' ('$DATE')</a></br>' >> foo.html
  cat $a | ./BlogLinks.lua >> $YEAR.html
  #echo '<hr class=pc>' >> $YEAR.html
  echo '<div class=GitBlogNav><i>Go to: ' >> $YEAR.html
  echo '<a href="#GitBlogTop">Top</a>' >> $YEAR.html
  echo '<a href="#GitBlogIndex">Index</a></i></div>' >> $YEAR.html
  #echo '<hr class=pc>' >> $YEAR.html
  echo \<div class=blog\> >> $YEAR.html # An old bug I never correctly fixed
  echo $a
done
echo '<a name="GitBlogIndex"> </a><h1>Blog index</h1>' >> index.html
cat foo.html >> index.html
echo \</div\> >> index.html
rm -f foo.html
echo \</body\>\</html\> >> index.html
