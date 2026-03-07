#!/bin/sh
_rem=--[=[
# This script splits index.html to help debug issues with the content
# being too wide for a phone screen.
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

handle=io.open("index.html","rb")
if not handle then
  error("Can not open index.html for reading")
  os.exit(1)
end
-- Get header and footer
header = ""
footer = ""
inHeader = true
inFooter = false
for line in handle:lines() do
  if line:match("%`ENTRY") then
    inHeader = false
  end
  if inHeader then header = header .. line .. "\n" end
  if inFooter then footer = footer .. line .. "\n" end
  if line:match("%`FOOTER") then
    inFooter = true
  end
end
handle:close()
-- Now that we have the header and footer, split based on the arg
splitDate = "2025-99-99" 
if #arg >= 1 then
  splitDate = arg[1]
else
  print("Split date not set, using end of 2025")
  print("For help, splitBlog.lua --help")
end
if splitDate:match("?") or splitDate:match("^%-") or splitDate:match("h") then
  print("This script places files in the split/ folder")
  print("Usage: splitBlog.lua {date}, where date is 2014-01-01")
  print("or later (or 20131231 or sooner, the date format changed in 2014)")
  os.exit(0)
end

handle=io.open("index.html","rb")
out=io.open("split/after-" .. splitDate .. ".html","wb")
if not out then
  print("Cannot open split/after-" .. splitDate .. ".html for writing")
  os.exit(1)
end

out:write(header)
inFirstFile = true
for line in handle:lines() do
  if line:match("%`ENTRY") and inFirstFile then
    local fields = split(line,"%s+")
    local date = fields[3]
    if date < splitDate then
      out:write(footer)
      out:close()
      print("split/after-" .. splitDate .. ".html written")
      inFirstFile = false
      out = io.open("split/before-" .. splitDate .. ".html","wb")
      if not out then
        print("Cannot write split/before-" ..splitDate.. ".html for writing")
        os.exit(1)
      end
      out:write(header)
    end
  end
  out:write(line .. "\n")
end
out:write("footer")
out:close()
print("split/before-" .. splitDate .. ".html written")
handle:close()
