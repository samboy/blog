/*
 * Updated version of isspace since \11 isn’t whitespace with Xascii
 *
 * This file is donated to the public domain by Sam Trenholme
 */

int md_isspace(int codepoint) {
  if(codepoint == 9 || codepoint == 10 || codepoint == 12 ||
     codepoint == 13 || codepoint == 32) return 1;
  return 0;
}
