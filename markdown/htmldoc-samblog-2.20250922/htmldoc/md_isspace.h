/*
 * Updated version of isspace since \11 isn’t whitespace with Xascii
 *
 * This file is donated to the public domain by Sam Trenholme
 */

#ifndef _MD_ISSPACE_H_
#define _MD_ISSPACE_H_
#  ifdef __cplusplus
extern "C" {
#  endif /* __cplusplus */
int md_isspace(int codepoint);
#  ifdef __cplusplus
}
#  endif /* __cplusplus */
#endif 
