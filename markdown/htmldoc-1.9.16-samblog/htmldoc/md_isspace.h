/*
 * Updated version of isspace since \11 isn’t whitespace with Xascii
 *
 * This file is donated to the public domain by Sam Trenholme
 */

#ifndef _MD_ISSPACE_H_
#define _MD_ISSPACE_H_
int md_isspace(char codepoint) {
        if(codepoint == 32 || codepoint == 9 || codepoint == 10 ||
           codepoint == 12 || codepoint == 13) return 1;
        return 0;
}
#endif 
