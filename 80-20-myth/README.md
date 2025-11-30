# Software needed

* A standard Posix-compatible *NIX environment (Linux, Cygwin on 
  Windows, MacOS, etc.)
* GNUplot, available with most Linux distributions (as well as
  Cygwin), as well as at this page: 
  https://sourceforge.net/projects/gnuplot/files/gnuplot/
* Lunacy, which is simply Lua 5.1 with a “rg32” random number
  generator (for high quality random numbers in the Monte Carlo
  simulation we run) library.  The Lunacy source code is available
  here in this directory (as a symlink to the Lunacy source in 
  the “markdown” directory for this repo).

For people who do not wish to compile Lunacy, there is a Lua compatible
(including Lua 5.1 compatible) polyfill library which implements the
rg32 random number generator in pure Lua.  While lunacyNSFGdata.lua
will run fine with Lua 5.1, Lua 5.4, and LuaJIT, generating the same Monte
Carlo output, it is a lot slower (it’s a fraction of a second to run
in Lunacy, 7.5 seconds in LuaJIT, nearly a minute in Lua 5.4, and about
90 seconds in Lua 5.1)

# Making the data sets

To make the data sets (which, yes, are included here), do this after
compiling Lunacy:

```
lunacy lunacyNFSGdata.lua | grep '2022:' | grep female | awk '
    {print $6 " " $2}' | tr -d % > data1male.dat

lunacy lunacyNFSGdata.lua | grep '2022:' | grep women | awk '
    {print $6 " " $2}' | tr -d % > data2female.dat

lunacy lunacyNFSGdata.lua | grep 'Monte' | grep female | awk '
    {print $6 " " $2}' | tr -d % > data3montemale.dat

lunacy lunacyNFSGdata.lua | grep 'Monte' | grep women | awk '
    {print $6 " " $2}' | tr -d % > data4montefemale.dat

lunacy lunacyNFSGdata18_29.lua | grep female | awk '
    {print $6 " " $2}' | tr -d % > data5male18_29.dat

lunacy lunacyNFSGdata18_29.lua | grep women | awk '
    {print $6 " " $2}' | tr -d % > data6female18_29.dat
```

If you do not wish to compile Lunacy, running `lua` (or `luajit`) will 
work and even generate the same Monte Carlo output, but will be a lot
slower.

# Making the graphs in GNUplot

To make the 2022 NSFG data graph:

```
set terminal pngcairo size 960,540 
set output 'data.png'
plot "data1male.dat" using 1:2 title "Men" with lines lw \
2 lc "blue", \
"data2female.dat" using 1:2 title "Women" with lines lw 2 lc "red"
```

To make the Monte Cairo simulation graph:

```
set terminal pngcairo size 960,540 
set output 'monte.png'
plot "data3montemale.dat" using 1:2 title "Men" with lines lw \
2 lc "blue", \
"data4montefemale.dat" using 1:2 title "Women" with lines lw 2 lc "red"
```

The 18-29 graph:

```
set terminal pngcairo size 960,540 
set output 'data18_29.png'
plot "data5male18_29.dat" using 1:2 title "Men (18-29)" with lines lw \
2 lc "blue", \
"data6female18_29.dat" using 1:2 title "Women (18-29)" with lines lw 2 \
lc "red", \
"data1male.dat" using 1:2 title "Men (all ages)" with lines lw \
2 lc "dark-spring-green", \
"data2female.dat" using 1:2 title "Women (all ages)" with lines lw 2 \
lc "orange"
```

# Some more raw data from NSFG 2022

We have some more raw data.

To see the age and number of reported sex partners with women, do this:

```
xzcat NSFG_2022_2023_FemRespPUFData.csv.xz | awk -F, '
	{print $2 " " $1461}' | less
```

Note that 50 is 50 or more, 998 is “refused to answer”, 
and 999 is “don’t know”.

Likewise with men:

```
xzcat NSFG_2022_2023_MaleRespPUFData.csv.xz | awk -F, '
	{print $2 " " $920}' | less
```

With the same note for values of 50/998/999.

To make snippets of Lua code:

```
xzcat NSFG_2022_2023_FemRespPUFData.csv.xz | awk -F, '
        {partnercount=$1461;if(partnercount == ""){partnercount = 0}
        if($2 >= 18 && $2 <= 29 && partnercount <= 50){a[partnercount]++}}
        END{for(b in a){print "women[" b "] = " a[b]}}' > women18_29
xzcat NSFG_2022_2023_MaleRespPUFData.csv.xz | awk -F, '
        {partnercount=$920;if(partnercount == ""){partnercount = 0}
        if($2 >= 18 && $2 <= 29 && partnercount <= 50){a[partnercount]++}}
        END{for(b in a){print "men[" b "] = " a[b]}}' > men18_29
```

