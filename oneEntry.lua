#!/bin/sh
_rem=--[=[

LUNACY=""
if command -v lunacy64 >/dev/null 2>&1 ; then
  LUNACY=lunacy64
elif command -v lua5.1 >/dev/null 2>&1 ; then
  LUNACY=lua5.1
elif command -v lua-5.1 >/dev/null 2>&1 ; then
  LUNACY=lua-5.1
elif command -v lunacy >/dev/null 2>&1 ; then
  LUNACY=lunacy
elif command -v luajit >/dev/null 2>&1 ; then
  LUNACY=luajit # I assume luajit will remain frozen at Lua 5.1
fi
if [ -z "$LUNACY" ] ; then
  echo Please install Lunacy or Lua 5.1
  echo https://github.com/samboy/lunacy
  exit 1
fi

exec $LUNACY $0 "$@"

# ]=]1
-- This script is written in Lua 5.1

-- This script has been donated to the public domain in 2026 by Sam Trenholme
-- If, for some reason, a public domain declation is not acceptable, it
-- may be licensed under the following terms:

-- Copyright 2026 Sam Trenholme
-- Permission to use, copy, modify, and/or distribute this software for
-- any purpose with or without fee is hereby granted.
-- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
-- WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES
-- OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
-- ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
-- WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
-- ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
-- OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

-- Utility functions --
-- Since Lunacy doesn't have split(), we make
-- it ourselves.  Like Perl’s split(), this can
-- split on regular expressions
-- Input is string, regex, output is an array with the string parts
function split(s, splitOn)
  if not splitOn then splitOn = "," end
  local place = true
  local out = {}
  local mark
  local last = 1
  while place do
    place, mark = string.find(s, splitOn, last, false)
    if place then
      table.insert(out,string.sub(s, last, place - 1))
      last = mark + 1
    end
  end
  table.insert(out,string.sub(s, last, -1))
  return out
end

-- We need to go through tables in sorted order sometimes
-- Like pairs() but sorted
-- This assumes all keys are of the same type
function sPairs(inputTable,sFunc)
  if not sFunc then
    sFunc = function(a, b)
      local ta = type(a)
      local tb = type(b)
      if(ta == tb)
        then return a < b
      end
      return ta < tb
    end
  end
  local keyList = {}
  local index = 1
  for k,_ in pairs(inputTable) do
    table.insert(keyList,k)
  end
  table.sort(keyList,sFunc)
  return function()
    rvalue = keyList[index]
    index = index + 1
    return rvalue, inputTable[rvalue]
  end
end

blogTop = [[
@font-palette-values --dark {
 font-family: "ChessCancunColor";
 override-colors: 0 rgb(0 0 0), 1 rgb(205 192 180); }
.widepic { box-shadow: 0 0 4px #888;
border-radius: 8px; width: 99%; height: auto; }
@media screen and (max-width: 640px) { 
.nomobile { display: none; } }
body { max-width: 95vw; overflow-x: hidden; } 
a { color: #067610; } 
.GitBlogNav { display: table; width: 95vw; 
font-family: Kilroy8, GeorgiaF, Georgia, serif;
font-size: 16px;
text-align: center;
border-top: 2px solid #aaa;
margin: 5px; padding: 2px;
margin-left: auto;
margin-right: auto;
border-bottom: 2px solid #aaa; }
@media (min-width: 640px) {.GitBlogNav {width:640px;}}
@media (max-width: 640px) {.blogPre {overflow-x:scroll;}}
@media (max-width: 640px) {.blog {overflow-x:scroll;}}
body { color: #333; background-color: #fff; }
.blog { display: table; max-width: 640px;
color: #333; background-color: #fff;
font-family: Kilroy8, GeorgiaF, Georgia, serif;
font-size: 16px;
margin-left: auto;
margin-right: auto; }
@media (max-width: 640px) {
.blog pre {max-width: 90vw; overflow-x: scroll;}} 
.blog pre { font-size: 14px; }
.blog li pre {max-width: 80vw; overflow-x: scroll; }
.blog table {max-width: 90vw; overflow-x: scroll; }
.blog tt {max-width: 90vw; overflow-x: scroll; }
.blogtable {max-width: 90vw; overflow-x: scroll; }
@media (max-width: 640px) {.pc {display: none;}}
.moyet { display: none; }
.blog h1 { font-size: 28px; }
.blog b { font-size: 18px; }
.blog strong { font-size: 18px; }
.s { font-size: 18px; }
.blogtitle { font-size: 24px; }
h3 { font-size: 24px; margin-bottom: 0; }
.blogpicx { text-align: left !important; }
.blogpicx img { 
border-radius: 8px; box-shadow: 0 0 4px #888; }
a { color: #067610; }
.blog a { color: #067610; }

.chessDiagram8 { font-family: ChessCancunColor; font-size: 31.7px; 
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

.chessDiagram10x8 { font-family: ChessCancunColor; font-size: 31.7px; 
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
.chessDiagram4 { font-family: ChessCancunColor; font-size: 31.7px; 
display: grid;
    grid-template-columns: repeat(8, 1fr);
    grid-template-rows: repeat(4, 1fr);
    width: 300px;
    height: 150px;
    border: 2px solid #333;
    border-top: 1px dotted #333;
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
.chessDiagram8 { border: 2px solid #ddd; font-palette: --dark; }
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
.chessDiagram10x8 { border: 2px solid #ddd; font-palette: --dark; }
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
.chessDiagram4 { border: 2px solid #ddd; 
                 border-top: 1px dotted #ddd; font-palette: --dark; }
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
                 page-break-inside: avoid; border-top: 1px dotted #333; }
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
<script src="../chess/jquery-1.12.4.min.js"></script>
<script>$.ajaxSetup({contents: {script: false}})</script>
<script 
 src="../chess/chessboard-0.3.0.min.js" type="text/javascript"></script>
<script src="../chess/chess.js"></script>
<link href="../chess/chessboard-0.3.0.min.css" rel="stylesheet"></link>
<script src="../chess/chessgame.js"></script>
<meta name=viewport 
content=width=device-width,initial-scale=1.0,minimum-scale=0.8 >
</head>
]] -- blogTop

fileName = arg[1]
if not fileName or fileName:match("[hH%?]") or 
   not fileName:match("embed/%d%d%d%d%-?%d%d%-?%d%d.embed") then
  print("Usage: oneEntry {filename}")
  print("{filename} is in form embed/2025-11-10.embed")
  os.exit(0)
end

outFile = fileName:gsub("embed/","entries/")
outFile = outFile:gsub(".embed",".html")

date = outFile
date = date:gsub("entries/","")
date = date:gsub(".html","")

thisFileHandle = io.open(fileName,"rb")
if not thisFileHandle then
  print("Fatal error reading " .. fileName)
  os.exit(1)
end

gOutHandle = io.open(outFile,"wb")
if not gOutHandle then
  print("Fatal error opening " .. outFile .. " for writing")
  os.exit(1)
end

function fo(line)
  gOutHandle:write(line .. "\n")
end

-- This script is public domain.
U='<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'
fo('<html><head><title>' .. date .. '</title>')
fo(U) 
fo('<style>')

-- Widepic CSS
fo('@import url("../fonts.css");') -- OFL license in CSS file

-- Thanks to https://screenspan.net/fallback for this CSS
-- Georgia has mostly the same metrics so this is a 99% metric
-- compatible local replacment
fo('@font-face { font-family: "GeorgiaF"; src: local(Georgia);')
fo('size-adjust: 118%; }')
fo(blogTop)

fo("<body>")

fo('<a name="GitBlogTop"> </a>')
fo('<div class=blog>')
fo('<a href="../index.html#GitBlogIndex">Blog Index</a></i>')
fo('</div><div class=blog>')
fo('<h1>Sam Trenholme’s blog</h1>')
fo('')


-- Grab title from file.  This is ugly because of the ugly HTML
-- htmldoc makes
title=nil
inTitle = false
for line in thisFileHandle:lines() do
  line = line:gsub("\r","")
  if inTitle then
    local here = line:gsub("%<%/[^>]+%>","") -- Remove ugly closing tags
    title = title .. here
    inTitle = false
    break
  end 
  if line:match("%<[hH]1%>") then
    -- make <h1>Some blog title</h1> “Some blog title”
    if not inTitle then
      title = line:gsub(".*%<[hH]1%>([^<]*)%<%/[hH]1%>.*","%1")
    end
    inTitle = true
    if title:match("%<[hH]1%>") then
      title = title:gsub("%<[hH]1%>","") 
      title = title:gsub("%<%/[^>]+%>","") -- Remove ugly closing tags
    else
      break
    end
  end
end
thisFileHandle:close()
if not title then title="Blog entry" end

year = date:sub(1,4)
link = "BlogEntry-" .. date
fo('<!-- `ENTRY: ' .. date .. ' ' .. year .. ' ` -->')
fo('<a name="' .. link .. '"> </a>')

thisFileHandle = io.open(fileName,"rb")
if not thisFileHandle then
  print("Fatal error: Second open of " .. fileName .. " failed")
  os.exit(3)
end
 
for l in thisFileHandle:lines() do
  l = l:gsub("\r","")
  -- Convert blog:entry links in to his correct form
  if globalWebpageBlog then
    l = l:gsub('<[aA]%s+[Hh][Rr][Ee][Ff]=%"[bB][lL][oO][gG]%:([^"#]+)',
               '<a href="%1.html')
  else
    l = l:gsub('<[aA]%s+[Hh][Rr][Ee][Ff]=%"[bB][lL][oO][gG]%:([^"]+)',
               '<a href="../index.html#BlogEntry-%1')
    -- We have to handle things like "blog:20120907#20120907-slashdot"
    l = l:gsub('<a href="../index.html#BlogEntry-[0-9-]+(#[^"]+)',
               '<a href="../index.html%1')
  end
  -- Convert image links
  l = l:gsub('src="pics/','src="../pics/')
  l = l:gsub('src=pics/','src=../pics/')
  -- Convert relative links
  relativeLink = true
  isIndex = false
  if l:match('https?%:%/%/') then
    relativeLink = false
  end
  if l:match('index%.html') then
    isIndex = true
  end
  if relativeLink and not isIndex and l:match('href="') then
    l = l:gsub('href="([^%#%/])','href="../%1')
  elseif relativeLink and not isIndex and l:match('href=[^"]') then
    l = l:gsub('href=([^%"%#%/])','href=../%1')
  end
  fo(l)
end
thisFileHandle:close()
-- fo('<hr class=pc>')
fo('<div class=GitBlogNav><i>Go to: ')
fo('<a href="../index.html#GitBlogTop">All entries</a>')
fo('<a href="../index.html#GitBlogIndex">Index</a></i></div>')
-- fo('<hr class=pc>')

fo('<!-- `FOOTER` -->')
fo('</body></html>')
print(outFile .. " written")
