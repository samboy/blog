![blogpic](pics/2024-05-01.jpg)
# Title
## DATE

SUMMARY

### Sub-section title
![widepic](pics/PICTURE.png)
_Picture caption_

Text@[^1 Footnote *italics* @https://www.example.com link@](fn:1)
Two footnotes together:@[^2 Footnote 2](fn:2)@,[^3 Footnote 3](fn:3)

The limit is two footnotes together. Footnotes should be numeric,
with footnotes in ascending order.  There can be as many footnotes as
needed. We do not support footnotes where footnotes themselves have
footnotes, nor footnotes without a reference in the main text.

*italics* [link](https://example.com) 
@*italics* also works (sometimes you need the @ after another punctuation
characer, like —@*italics* here—)

Some rules to deal with htmldoc buggyness:

@~{ becomes [ and @~} becomes ]

@~/ becomes a line feed

@[link](https://example.com) removes the leading @.

If you want an italic link, be sure the link ends the sentence, and
make sure the setence ends with a period in italics, like this:
_Get an italic link [like this](https://italic.link.foo)._

Note that the character “'” (ASCII single quote) is not allowed in links, 
if needed use %27 every time the link has “'” in it.

Superscripts: 17^th 18^th 20^th 4^th etc.

* List item
* Another bullet item

We also have support for Chess diagrams in FEN format, like this:

@~:b2r3r/k3qp1p/p4np1/Np1P4/3p1Q2/P4PPB/1PP4P/1K6:
_White to move and deliver mate_


