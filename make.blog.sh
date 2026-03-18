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
echo 'a { color: #258723; }' >> index.html
echo '.blog a { color: #258723; }' >> index.html
cat >> index.html << EOF

.chessDiagram8 { font-family: ChessCancunColor; font-size: 32px; 
display: grid;
    grid-template-columns: repeat(8, 1fr);
    grid-template-rows: repeat(8, 1fr);
    width: 300px;
    height: 300px;
    border: 2px solid #333;
}

.chessDiagram8 div {
    text-align: center;
    background-color: #fff; /* Light square */
}

/* Alternating colors using nth-child */
.chessDiagram8 div:nth-child(-n+8):nth-child(even),
.chessDiagram8 div:nth-child(n+9):nth-child(-n+16):nth-child(odd),
.chessDiagram8 div:nth-child(n+17):nth-child(-n+24):nth-child(even),
.chessDiagram8 div:nth-child(n+25):nth-child(-n+32):nth-child(odd),
.chessDiagram8 div:nth-child(n+33):nth-child(-n+40):nth-child(even),
.chessDiagram8 div:nth-child(n+41):nth-child(-n+48):nth-child(odd),
.chessDiagram8 div:nth-child(n+49):nth-child(-n+56):nth-child(even),
.chessDiagram8 div:nth-child(n+57):nth-child(-n+64):nth-child(odd) {
    background-color: #ccc; /* Dark square */
}

.chessDiagram10x8 { font-family: ChessCancunColor; font-size: 32px; 
display: grid;
    grid-template-columns: repeat(10, 1fr);
    grid-template-rows: repeat(8, 1fr);
    width: 375px;
    height: 300px;
    border: 2px solid #333;
}

.chessDiagram10x8 div {
    text-align: center;
    background-color: #fff; /* Light square */
}

/* Alternating colors using nth-child */
.chessDiagram10x8 div:nth-child(-n+10):nth-child(even),
.chessDiagram10x8 div:nth-child(n+11):nth-child(-n+20):nth-child(odd),
.chessDiagram10x8 div:nth-child(n+21):nth-child(-n+30):nth-child(even),
.chessDiagram10x8 div:nth-child(n+31):nth-child(-n+40):nth-child(odd),
.chessDiagram10x8 div:nth-child(n+41):nth-child(-n+50):nth-child(even),
.chessDiagram10x8 div:nth-child(n+51):nth-child(-n+60):nth-child(odd),
.chessDiagram10x8 div:nth-child(n+61):nth-child(-n+70):nth-child(even),
.chessDiagram10x8 div:nth-child(n+71):nth-child(-n+80):nth-child(odd) {
    background-color: #ccc; /* Dark square */
}

/* 4x8 diagram for showing opening patterns */
.chessDiagram4 { font-family: ChessCancunColor; font-size: 32px; 
display: grid;
    grid-template-columns: repeat(8, 1fr);
    grid-template-rows: repeat(4, 1fr);
    width: 300px;
    height: 150px;
    border: 2px solid #333;
    border-top: 0;
}

.chessDiagram4 div {
    text-align: center;
    background-color: #fff; /* Light square */
}

/* Alternating colors using nth-child */
.chessDiagram4 div:nth-child(-n+8):nth-child(even),
.chessDiagram4 div:nth-child(n+9):nth-child(-n+16):nth-child(odd),
.chessDiagram4 div:nth-child(n+17):nth-child(-n+24):nth-child(even),
.chessDiagram4 div:nth-child(n+25):nth-child(-n+32):nth-child(odd) {
    background-color: #ccc; /* Dark square */
}

@media (prefers-color-scheme: dark) { 
body { background-color: #131516; color: #d8d4cf; }
.blog { background-color: #131516; color: #d8d4cf; }
a { color: #78dc78; }
.blog a { color: #78dc78; }
.chessDiagram8 { border: 2px solid #ddd; }
.chessDiagram8 div { background-color: #aaa; }
.chessDiagram8 div:nth-child(-n+8):nth-child(even),
.chessDiagram8 div:nth-child(n+9):nth-child(-n+16):nth-child(odd),
.chessDiagram8 div:nth-child(n+17):nth-child(-n+24):nth-child(even),
.chessDiagram8 div:nth-child(n+25):nth-child(-n+32):nth-child(odd),
.chessDiagram8 div:nth-child(n+33):nth-child(-n+40):nth-child(even),
.chessDiagram8 div:nth-child(n+41):nth-child(-n+48):nth-child(odd),
.chessDiagram8 div:nth-child(n+49):nth-child(-n+56):nth-child(even),
.chessDiagram8 div:nth-child(n+57):nth-child(-n+64):nth-child(odd) {
background-color: #888; } 
.chessDiagram10x8 { border: 2px solid #ddd; }
.chessDiagram10x8 div { background-color: #aaa; }
.chessDiagram10x8 div:nth-child(-n+10):nth-child(even),
.chessDiagram10x8 div:nth-child(n+11):nth-child(-n+20):nth-child(odd),
.chessDiagram10x8 div:nth-child(n+21):nth-child(-n+30):nth-child(even),
.chessDiagram10x8 div:nth-child(n+31):nth-child(-n+40):nth-child(odd),
.chessDiagram10x8 div:nth-child(n+41):nth-child(-n+50):nth-child(even),
.chessDiagram10x8 div:nth-child(n+51):nth-child(-n+60):nth-child(odd),
.chessDiagram10x8 div:nth-child(n+61):nth-child(-n+70):nth-child(even),
.chessDiagram10x8 div:nth-child(n+71):nth-child(-n+80):nth-child(odd) {
    background-color: #888; /* Dark square */
}
.chessDiagram4 { border: 2px solid #ddd; border-top: 0; }
.chessDiagram4 div { background-color: #aaa; }
.chessDiagram4 div:nth-child(-n+8):nth-child(even),
.chessDiagram4 div:nth-child(n+9):nth-child(-n+16):nth-child(odd),
.chessDiagram4 div:nth-child(n+17):nth-child(-n+24):nth-child(even),
.chessDiagram4 div:nth-child(n+25):nth-child(-n+32):nth-child(odd) {
  background-color: #888; } 
} /* End Dark mode theme */
@media print {
.chessDiagram8 { border: 2px solid #333; break-inside: avoid;
                 page-break-inside: avoid; }
.chessDiagram8 div { background-color: #fff; }
.chessDiagram8 div:nth-child(-n+8):nth-child(even),
.chessDiagram8 div:nth-child(n+9):nth-child(-n+16):nth-child(odd),
.chessDiagram8 div:nth-child(n+17):nth-child(-n+24):nth-child(even),
.chessDiagram8 div:nth-child(n+25):nth-child(-n+32):nth-child(odd),
.chessDiagram8 div:nth-child(n+33):nth-child(-n+40):nth-child(even),
.chessDiagram8 div:nth-child(n+41):nth-child(-n+48):nth-child(odd),
.chessDiagram8 div:nth-child(n+49):nth-child(-n+56):nth-child(even),
.chessDiagram8 div:nth-child(n+57):nth-child(-n+64):nth-child(odd) {
background-color: #ddd; } 
.chessDiagram10x8 { border: 2px solid #333; break-inside: avoid;
                    page-break-inside: avoid;}
.chessDiagram10x8 div { background-color: #fff; }
.chessDiagram10x8 div:nth-child(-n+10):nth-child(even),
.chessDiagram10x8 div:nth-child(n+11):nth-child(-n+20):nth-child(odd),
.chessDiagram10x8 div:nth-child(n+21):nth-child(-n+30):nth-child(even),
.chessDiagram10x8 div:nth-child(n+31):nth-child(-n+40):nth-child(odd),
.chessDiagram10x8 div:nth-child(n+41):nth-child(-n+50):nth-child(even),
.chessDiagram10x8 div:nth-child(n+51):nth-child(-n+60):nth-child(odd),
.chessDiagram10x8 div:nth-child(n+61):nth-child(-n+70):nth-child(even),
.chessDiagram10x8 div:nth-child(n+71):nth-child(-n+80):nth-child(odd) {
    background-color: #ddd; /* Dark square */
}
.chessDiagram4 { border: 2px solid #333; break-inside: avoid;
                 page-break-inside: avoid; border-top: 0; }
.chessDiagram4 div { background-color: #fff; }
.chessDiagram4 div:nth-child(-n+8):nth-child(even),
.chessDiagram4 div:nth-child(n+9):nth-child(-n+16):nth-child(odd),
.chessDiagram4 div:nth-child(n+17):nth-child(-n+24):nth-child(even),
.chessDiagram4 div:nth-child(n+25):nth-child(-n+32):nth-child(odd) {
background-color: #ddd; } 
} /* End print colors */
</style>
<script>
maxWidth = screen.width;
maxWidth *= .95;
if(maxWidth < 480) {
  boardSize = maxWidth - 5;
  pieceWidth = (boardSize / 10) * (16/15);
  capaPieceWidth = (boardSize / 12.5) * (16/15);
  capaHeight = boardSize * .8;
}
</script>
<script src="chess/jquery-1.12.4.min.js"></script>
<script>$.ajaxSetup({contents: {script: false}})</script>
<script src="chess/chessboard-0.3.0.min.js" type="text/javascript"></script>
<script src="chess/chess.js"></script>
<link href="chess/chessboard-0.3.0.min.css" rel="stylesheet"></link>
<script src="chess/chessgame.js"></script>
EOF
#echo \</style\> >> index.html
# This is just going to be a long line
echo \<meta name=viewport content=width=device-width,initial-scale=1.0,minimum-scale=0.8 \> >> index.html
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
  YEAR=$( echo $DATE | awk '{print substr($0,1,4)}' )
  FILE=index
  echo '<!-- `ENTRY: '$DATE $YEAR' ` -->' >> $FILE.html
  echo '<a name='$LINK'> </a>' >> $FILE.html
  echo '<a href="#'$LINK'">'$NAME' ('$DATE')</a></br>' >> foo.html
  cat $a | ./BlogLinks.lua >> $FILE.html
  #echo '<hr class=pc>' >> $FILE.html
  echo '<div class=GitBlogNav><i>Go to: ' >> $FILE.html
  echo '<a href="#GitBlogTop">Top</a>' >> $FILE.html
  echo '<a href="#GitBlogIndex">Index</a></i></div>' >> $FILE.html
  #echo '<hr class=pc>' >> $FILE.html
  echo \<div class=blog\> >> $FILE.html # An old bug I never correctly fixed
  echo $a
done
echo '<!-- `FOOTER` -->' >> index.html
echo '<a name="GitBlogIndex"> </a><h1>Blog index</h1>' >> index.html
cat foo.html >> index.html
echo \</div\> >> index.html
rm -f foo.html
echo \</body\>\</html\> >> index.html
