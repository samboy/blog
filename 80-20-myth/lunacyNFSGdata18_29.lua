#!/usr/bin/env lunacy

women = {}
women[0] = 411 women[1] = 332 women[2] = 179 women[3] = 139 women[4] = 103
women[5] = 109 women[6] = 62  women[7] = 49  women[8] = 35  women[9] = 31
women[10] = 48 women[11] = 13 women[12] = 22 women[13] = 8  women[14] = 10
women[15] = 28 women[16] = 4  women[17] = 4  women[18] = 4  women[20] = 19
women[21] = 4  women[22] = 3  women[23] = 2  women[25] = 8  women[26] = 1
women[27] = 4  women[28] = 2  women[30] = 8  women[32] = 1  women[36] = 1
women[37] = 1  women[38] = 1  women[40] = 1  women[44] = 1  women[45] = 1
women[50] = 19

men = {}
men[0] = 399 men[1] = 259 men[2] = 115 men[3] = 98 men[4] = 75
men[5] = 66  men[6] = 40  men[7] = 37  men[8] = 31 men[9] = 16
men[10] = 37 men[11] = 2  men[12] = 13 men[13] = 8 men[14] = 5
men[15] = 18 men[16] = 5  men[17] = 2  men[18] = 6 men[20] = 19
men[21] = 2  men[22] = 3  men[23] = 4  men[24] = 1 men[25] = 13
men[27] = 3  men[30] = 9  men[32] = 2  men[34] = 2 men[35] = 5 
men[40] = 5  men[45] = 4  men[46] = 1  men[50] = 21

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

report(men,50,10,
"18-29: %.2f%% of men have %.1f%% of lifetime female sex partners (%d %.1f %.1f)")
report(women,50,5,
"18-29: %.2f%% of women have %.1f%% of lifetime male sex partners (%d %.1f %.1f)")
