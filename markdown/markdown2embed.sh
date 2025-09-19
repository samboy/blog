#!/bin/sh

cat > /dev/null <<EOF
This converts Markdown in to the .embed HTML format my blog uses.

This massages the output of htmldoc to make it suitable for my web
pages.

The argument is the filename to convert, e.g. foo.md

Output is on standard output.

This script assumes htmldoc 1.9.14.

lunacy64 is a compile of lunacy (Lua 5.1 variant)

The markdown needs to have as its headers lines like this:

EOF

if [ -z "$1" ] ; then
    echo Usage: $0 filename.md
    echo Output is on standard output
    exit 1
fi

FILENAME="$(/bin/pwd)/$1"
SCRIPTPATH="$0"
SCRIPTPATH=${SCRIPTPATH%/*}
BASE=${1##*/}
BASE=${BASE%.md}
if [ ! -z "$SCRIPTPATH" ] ; then
	cd $SCRIPTPATH
fi

# Sometimes htmldoc crashes if there’s too much whitespace at the end of
# a line
cat $FILENAME | awk '{sub(/ +$/," ");print}' > foo.md
cat foo.md | ./utf8toXascii > foo
mv foo foo.md
htmldoc-1.9.16-samblog foo.md 2>/dev/null | \
	./lunacyBlogFilter ${BASE}
rm -f foo.md

