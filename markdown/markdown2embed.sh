#!/bin/sh

cat > /dev/null <<EOF
This converts Markdown in to the .embed HTML format my blog uses.

This massages the output of htmldoc to make it suitable for my web
pages.

The argument is the filename to convert, e.g. foo.md

Output is on standard output.

This script assumes htmldoc 1.9.14.

The markdown needs to have as its headers lines like this:

EOF

if [ -z "$1" ] ; then
    echo Usage: $0 filename.md
    echo Output is on standard output
    exit 1
fi

FILENAME="$1"

htmldoc --charset utf-8 $FILENAME 2>/dev/null | awk '
		{if(a==2){print}if(/HR NOSHADE/){a++}}
	' | awk '{if(/img alt="blogpic"/) { # Fix top image
		pic = $3
 		sub(/^[^"]*"/,"",pic)
 		sub(/"[^"]*$/,"",pic)
		print "<div class=blogpicx style=\"text-align: right\">"
		print "<img src=\"" pic "\" width=224 height=126>"
		print "</div>" } else {print}}' | awk '{ # Other images
		  if(/img alt="widepic"/) {
		pic = $3
		caption = $4 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10 " " $11
 		sub(/^[^"]*"/,"",pic)
 		sub(/"[^"]*$/,"",pic)
		print "<img class=widepic src=\"" pic "\" alt=\"\">"
		print "<br class=nomobile>"
		inwidepic = 1
		} else if(inwidepic) {
			print caption
			print
			inwidepic = 0
		} else {print}}' | awk ' # Footer
		{print} END {
		print ""
		print "<p>"
		print ""
		print "<A href=/blog/>Blog index</A>"
		print ""
		print "</div>"
		print ""
		}' | perl -pe ' # This perl mess removes <a id> tags
        s/<a id[^>]+>([^<]+)<\/a>/\1/;s/<a id[^>]+>//;s|</a>(</h\d>)|\1|'
