#!/usr/bin/env lua

-- Fix long links text so they have appropriate line breaks on a phone
-- sized screen

ch = ''
queue = {}
place = 1
addQueue = true
inLink = false
while ch do
  ch = io.stdin:read(1)
  if ch == '<' or ch == ' ' or ch == '\r' or ch == '\n' then
    inLink = false
  end
  if not ch then break end
  if ch == '<' and addQueue then addQueue = false end
  if ch == '>' and not addQueue then addQueue = true end
  if addQueue then queue[place] = ch place = place + 1 end
  if place > 100 then place = 1 end
  if addQueue then
  look = place - 1 if look < 1 then look = look + 100 end 
  if queue[look] == '/' then
    look = look - 1 if look < 1 then look = look + 100 end 
    if queue[look] == '/' then 
      look = look - 1 if look < 1 then look = look + 100 end 
      if queue[look] == ':' then
      look = look - 1 if look < 1 then look = look + 100 end 
      if queue[look] == 's' or queue[look] == 'S' then 
        look = look - 1 if look < 1 then look = look + 100 end
      end
      if queue[look] == 'p' or queue[look] == 'P' then
        look = look - 1 if look < 1 then look = look + 100 end
        if queue[look] == 't' or queue[look] == 'T' then
          look = look - 1 if look < 1 then look = look + 100 end
          if queue[look] == 't' or queue[look] == 'T' then
            look = look - 1 if look < 1 then look = look + 100 end
            if queue[look] == 'h' or queue[look] == 'H' then
	      inLink = true
            end
          end
        end
      end
      end
    end 
  end
  look = place - 1 if look < 1 then look = look + 100 end 
  if inLink and (queue[look] == '.' or queue[look] == '/' or
     queue[look] == '-') then
    io.stdout:write("<![if gt IE 6]>&#8203;<![endif]><wbr>")
  end
  end -- if addQueue
  io.stdout:write(ch)
end

