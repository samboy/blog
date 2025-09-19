# Running

```
markdown2embed.sh foo.md > foo.embed
```

Where `foo` is something like `2001-09-04.md`

# Compiling htmldoc-1.9.16-samblog

Because stock htmldoc segfaults with some inputs, and because
versions of htmldoc more recent than 1.9.16 do not compile in
cygwin (because cygwin doesn’t include CUPS), I now maintain my 
own fork of htmldoc 1.9.16 to process blog entries.

To compile this fork of htmldoc:

```
cd htmldoc-1.9.16-samblog
./configure
make
sudo cp htmldoc/htmldoc /usr/local/bin/htmldoc-1.9.16-samblog
```

