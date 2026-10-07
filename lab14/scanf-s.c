/* scanf-s.c - example of string pointer arguments */
#include <stdio.h>

int length(char *str) {
  int len = 0;
  while (*str != '\0'){
    len++;
    str++;
  }
  return len;
}

int main() {
  char buff[100];
  printf("Enter a string: ");
  scanf("%s", buff);
  
  printf("The length of the string %s is %d\n", buff, length(buff));
  return 0;
}
