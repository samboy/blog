#!/usr/bin/env lunacy64

-- rg32 is at https://github.com/samboy/LUAlibs
-- If you don’t want to compile a lib or install lunacy, do this:
-- rg32 = math
if not rg32 then require("rg32") end

-- Let’s get the real 2011 numbers for lifetime sex partners
-- This is NSFG2011Men[#female partners] = #men with that many female partners
NSFG2011Men = {}
NSFG2011Men[0] = 628
NSFG2011Men[1] = 565
NSFG2011Men[2] = 337
NSFG2011Men[3] = 317
NSFG2011Men[4] = 313
NSFG2011Men[5] = 328
NSFG2011Men[6] = 272
NSFG2011Men[7] = 202
NSFG2011Men[8] = 112
NSFG2011Men[9] = 105
NSFG2011Men[10] = 205
NSFG2011Men[11] = 48
NSFG2011Men[12] = 123
NSFG2011Men[13] = 48
NSFG2011Men[14] = 44
NSFG2011Men[15] = 175
NSFG2011Men[16] = 24
NSFG2011Men[17] = 24
NSFG2011Men[18] = 20
NSFG2011Men[19] = 9
NSFG2011Men[20] = 168
NSFG2011Men[21] = 6
NSFG2011Men[22] = 16
NSFG2011Men[23] = 13
NSFG2011Men[24] = 10
NSFG2011Men[25] = 85
NSFG2011Men[26] = 8
NSFG2011Men[27] = 17
NSFG2011Men[28] = 13
NSFG2011Men[29] = 4
NSFG2011Men[30] = 89
NSFG2011Men[31] = 5
NSFG2011Men[32] = 10
NSFG2011Men[33] = 6
NSFG2011Men[34] = 1
NSFG2011Men[35] = 33
NSFG2011Men[36] = 2
NSFG2011Men[37] = 3
NSFG2011Men[38] = 5
NSFG2011Men[40] = 40
NSFG2011Men[42] = 2
NSFG2011Men[43] = 2
NSFG2011Men[44] = 2
NSFG2011Men[45] = 12
NSFG2011Men[46] = 1
NSFG2011Men[47] = 2
NSFG2011Men[48] = 1
NSFG2011Men[49] = 1
NSFG2011Men[50] = 240 -- 50 or more

-- Likewise for women
NSFG2011Women = {}
NSFG2011Women[0] = 585
NSFG2011Women[1] = 983
NSFG2011Women[2] = 519
NSFG2011Women[3] = 494
NSFG2011Women[4] = 466
NSFG2011Women[5] = 502
NSFG2011Women[6] = 289
NSFG2011Women[7] = 241
NSFG2011Women[8] = 209
NSFG2011Women[9] = 112
NSFG2011Women[10] = 249
NSFG2011Women[11] = 52
NSFG2011Women[12] = 80
NSFG2011Women[13] = 49
NSFG2011Women[14] = 29
NSFG2011Women[15] = 129
NSFG2011Women[16] = 17
NSFG2011Women[17] = 18
NSFG2011Women[18] = 16
NSFG2011Women[19] = 12
NSFG2011Women[20] = 104
NSFG2011Women[21] = 7
NSFG2011Women[22] = 8
NSFG2011Women[23] = 7
NSFG2011Women[24] = 10
NSFG2011Women[25] = 40
NSFG2011Women[26] = 9
NSFG2011Women[27] = 7
NSFG2011Women[28] = 9
NSFG2011Women[29] = 4
NSFG2011Women[30] = 50
NSFG2011Women[31] = 2
NSFG2011Women[32] = 5
NSFG2011Women[33] = 3
NSFG2011Women[34] = 4
NSFG2011Women[35] = 20
NSFG2011Women[36] = 4
NSFG2011Women[37] = 1
NSFG2011Women[38] = 1
NSFG2011Women[39] = 1
NSFG2011Women[40] = 20
NSFG2011Women[41] = 1
NSFG2011Women[43] = 2
NSFG2011Women[45] = 4
NSFG2011Women[47] = 1
NSFG2011Women[50] = 96

-- Also the 2022 figures
NSFG2022Men = {}
NSFG2022Men[0] = 920
NSFG2022Men[1] = 693
NSFG2022Men[2] = 320
NSFG2022Men[3] = 301
NSFG2022Men[4] = 227
NSFG2022Men[5] = 258
NSFG2022Men[6] = 147
NSFG2022Men[7] = 119
NSFG2022Men[8] = 105
NSFG2022Men[9] = 47
NSFG2022Men[10] = 188
NSFG2022Men[11] = 25
NSFG2022Men[12] = 76
NSFG2022Men[13] = 35
NSFG2022Men[14] = 26
NSFG2022Men[15] = 93
NSFG2022Men[16] = 21
NSFG2022Men[17] = 11
NSFG2022Men[18] = 12
NSFG2022Men[19] = 3
NSFG2022Men[20] = 98
NSFG2022Men[21] = 6
NSFG2022Men[22] = 12
NSFG2022Men[23] = 9
NSFG2022Men[24] = 4
NSFG2022Men[25] = 55
NSFG2022Men[26] = 6
NSFG2022Men[27] = 6
NSFG2022Men[28] = 5
NSFG2022Men[30] = 51
NSFG2022Men[31] = 1
NSFG2022Men[32] = 3
NSFG2022Men[33] = 2
NSFG2022Men[34] = 3
NSFG2022Men[35] = 21
NSFG2022Men[36] = 3
NSFG2022Men[37] = 3
NSFG2022Men[38] = 2
NSFG2022Men[40] = 31
NSFG2022Men[42] = 2
NSFG2022Men[45] = 12
NSFG2022Men[46] = 1
NSFG2022Men[47] = 2
NSFG2022Men[48] = 1
NSFG2022Men[49] = 2
NSFG2022Men[50] = 160

-- And the 2022 women
NSFG2022Women = {}
NSFG2022Women[0] = 934
NSFG2022Women[1] = 1008
NSFG2022Women[2] = 484
NSFG2022Women[3] = 432
NSFG2022Women[4] = 323
NSFG2022Women[5] = 399
NSFG2022Women[6] = 234
NSFG2022Women[7] = 187
NSFG2022Women[8] = 146
NSFG2022Women[9] = 103
NSFG2022Women[10] = 245
NSFG2022Women[11] = 58
NSFG2022Women[12] = 74
NSFG2022Women[13] = 36
NSFG2022Women[14] = 26
NSFG2022Women[15] = 118
NSFG2022Women[16] = 16
NSFG2022Women[17] = 14
NSFG2022Women[18] = 17
NSFG2022Women[19] = 11
NSFG2022Women[20] = 109
NSFG2022Women[21] = 9
NSFG2022Women[22] = 14
NSFG2022Women[23] = 12
NSFG2022Women[24] = 2
NSFG2022Women[25] = 48
NSFG2022Women[26] = 5
NSFG2022Women[27] = 10
NSFG2022Women[28] = 7
NSFG2022Women[29] = 1
NSFG2022Women[30] = 49
NSFG2022Women[31] = 2
NSFG2022Women[32] = 3
NSFG2022Women[33] = 7
NSFG2022Women[34] = 2
NSFG2022Women[35] = 13
NSFG2022Women[36] = 3
NSFG2022Women[37] = 2
NSFG2022Women[38] = 3
NSFG2022Women[40] = 16
NSFG2022Women[41] = 1
NSFG2022Women[43] = 2
NSFG2022Women[44] = 1
NSFG2022Women[45] = 5
NSFG2022Women[47] = 2
NSFG2022Women[50] = 86

-- Initialize the Monte carlo simulation
rg32.randomseed(1233212)
monteMen = {}
monteWomen = {}
for a=0,50 do
  monteMen[a] = 0
  monteWomen[a] = 0
end
pMen = {}
pWomen = {}
for a=0,10000 do
  pMen[a] = 0
  pWomen[a] = 0
end

function chadFunction(x,y) 
  return x^y
end

-- Run the monte carlo simulation
for a=1,61000 do
  local woman = rg32.random(1,10000)
  local y = 1
  local x = 0
  local count = 0
  local men = 10000
  local women = 10000
  local degree = 6
  local man = 0
  while(chadFunction(x,degree) < y and count < 100) do
    count = count + 1
    x = math.random()
    y = math.random()
  end
  man = math.floor(x * men + 0.5) 
  x = math.random() -- Randomly sleep with any woman
  woman = math.floor(x * women + 0.5)
  pMen[man] = pMen[man] + 1
  pWomen[woman] = pWomen[woman] + 1
end

-- Tally the monte carlo results
for a=0,10000 do
  if pMen[a] < 50 then
    monteMen[pMen[a]] = monteMen[pMen[a]] + 1
  else
    monteMen[50] = monteMen[50] + 1
  end
  if pWomen[a] < 50 then
    monteWomen[pWomen[a]] = monteWomen[pWomen[a]] + 1
  else
    monteWomen[50] = monteWomen[50] + 1
  end
end

function report(data,size,fudge,formatString) 
  local subjects = 0
  local partners = 0
  for a=0,size do
    if not data[a] then data[a] = 0 end
    partners = partners + data[a] * a
    subjects = subjects + data[a]
    -- Since partner count peaks at 50, fudge factor
    if a == size then partners = partners + data[a] * fudge end
  end
  print("Population size: " .. subjects)
  print("Mean partners: " .. partners/subjects)
  local totalSubjects = 0
  local totalPartners = 0
  for a=size,1,-1 do
  --for a=0,size do
    totalPartners = totalPartners + a * data[a]
    totalSubjects = totalSubjects + data[a]
    -- fudge factor again since data peaks at 50 partners
    if a == size then totalPartners = totalPartners + fudge * data[a] end
    print(string.format(formatString,totalSubjects/subjects * 100,
                        totalPartners/partners * 100,a,(data[a] * 100)/
                        subjects,totalSubjects/subjects))
  end
end

function monteReport(data,size,fudge)
  local subjects = 0
  local partners = 0
  for a=0,size do
    if not data[a] then data[a] = 0 end
    partners = partners + data[a] * a
    subjects = subjects + data[a]
    -- Since partner count peaks at 50, fudge factor
    if a == size then partners = partners + data[a] * fudge end
  end
  print("Population size: " .. subjects)
  local totalSubjects = 0
  local totalPartners = 0
  local thisPercent = 0
  for a=0,size do
    totalSubjects = totalSubjects + data[a]
    totalPartners = totalPartners + a * data[a]
    thisPercent = thisPercent + (data[a] / subjects)
    if a % 10 == 0 then
       print(string.format("%d-%d lifetime partners: %.1f%%",
          a-9,a,thisPercent * 100))
       thisPercent = 0
    end
  end
end

report(NSFG2011Men,50,10,
"2011: %.2f%% of men have %.1f%% of lifetime female sex partners (%d %.1f %.1f)")
report(NSFG2011Women,50,5,
"2011: %.2f%% of women have %.1f%% of lifetime male sex partners (%d %.1f %.1f)")
report(NSFG2022Men,50,10,
"2022: %.2f%% of men have %.1f%% of lifetime female sex partners (%d %.1f %.1f)")
report(NSFG2022Women,50,5,
"2022: %.2f%% of women have %.1f%% of lifetime male sex partners (%d %.1f %.1f)")
print("----------------------------")
monteReport(NSFG2022Men,50,10) 
print("----------------------------")
monteReport(NSFG2022Women,50,10) 
print("----------------------------")
report(monteMen,50,10,
"Monte: %.2f%% of men have %.1f%% of lifetime female sex partners (%d %.1f)")
report(monteWomen,50,10,
"Monte: %.2f%% of women have %.1f%% of lifetime male sex partners (%d %.1f)")
