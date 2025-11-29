To make the data sets (which, yes, are included here):

lunacy lunacyNFSGdata.lua | grep '2022:' | grep female | awk '
{print $6 " " $2}' | tr -d % > data1male.dat

lunacy lunacyNFSGdata.lua | grep '2022:' | grep women | awk '
{print $6 " " $2}' | tr -d % > data2female.dat

lunacy lunacyNFSGdata.lua | grep 'Monte' | grep female | awk '
{print $6 " " $2}' | tr -d % > data3montemale.dat

lunacy lunacyNFSGdata.lua | grep 'Monte' | grep women | awk '
{print $6 " " $2}' | tr -d % > data4montefemale.dat

To get lunacy (a Lua 5.1 variant with a different random number generator
and other security fixes):

git clone https://github.com/samboy/lunacy

Source code and Windows binaries are included.

In GNUplot:

set terminal pngcairo size 960,540 
set output 'data.png'
plot "data1male.dat" using 1:2 title "Men" with lines lw \
2 lc "blue", \
"data2female.dat" using 1:2 title "Women" with lines lw 2 lc "red"

To make the Monte Cairo simulation graph:

set terminal pngcairo size 960,540 
set output 'monte.png'
plot "data3montemale.dat" using 1:2 title "Men" with lines lw \
2 lc "blue", \
"data4montefemale.dat" using 1:2 title "Women" with lines lw 2 lc "red"

---------------------------------

Some more raw data from NSFG 2022:

We have some more raw data.

To see the age and number of reported sex partners with women, do this:

xzcat NSFG_2022_2023_FemRespPUFData.csv.xz | awk -F, '
	{print $2 " " $1461}' | less

Note that 50 is 50 or more, 998 is “refused to answer”, 
and 999 is “don’t know”.

Likewise with men:

xzcat NSFG_2022_2023_MaleRespPUFData.csv.xz | awk -F, '
	{print $2 " " $920}' | less

With the same note for values of 50/998/999.

